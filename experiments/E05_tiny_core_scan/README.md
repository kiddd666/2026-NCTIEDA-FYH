# E05：可扫描小型时序 Core（tiny_core_scan）

> **状态：PASS（2026-09-05）。** 4 个触发器的迷你时序 Core，把教材 Fig.2.9 / Fig.2.13 / Fig.2.14 变成可运行、可看波形的代码。实验结果记录见 [results.md](results.md)。
>
> 交付结构：`src/`（设计）· `tb/`（测试平台）· `build/`（日志与综合产物）· `waves/`（VCD 波形）· `scripts/`（Yosys 脚本）。

# 1 实验要回答什么问题

一个普通时序电路插上扫描链之后，到底怎么工作？具体拆成 5 个小问题，也是本实验的 5 项验证要求：

1. `scan_en=0` 时，Core 是否保持正常功能？
2. `scan_en=1` 时，4 个 Scan FF 是否真的构成一条移位链？
3. Shift 过程中，`scan_in` 的数据是否逐拍经过各个 Scan FF？
4. `scan_en` 切回 0 后打一拍，组合逻辑的响应是否被触发器捕获？
5. 捕获之后再次 Shift，内部响应是否能从 `scan_out` 逐位移出？

**答案：五问全部成立**，日志证据见 [build/sim_e05.log](build/sim_e05.log)（`E05 PASS, 0 errors`）。

# 2 对应教材知识

| 教材出处 | 知识点 | 在实验中的体现 |
| --- | --- | --- |
| 2.4.1 | Muxed-D Scan Cell（Fig.2.9） | `scan_en` 选择功能/扫描数据源 |
| 2.3.2 / 表 2.6 | normal / shift / capture 三种操作 | testbench 的三个阶段 |
| 2.5.1 | Full-Scan：替换 + stitching，PI/PPI/PO/PPO | prescan 与 scan 两版 diff |
| 2.7.2 | scan replacement + stitching（流程视角） | 手工插链 = 这两步的展开 |

边界：本实验全部是**教材口径**，不涉及广立微 DFTR 规则。

# 3 对应教材图

四张图全部是教材原图（复制在 [../../docs/学习笔记/assets/](../../docs/学习笔记/assets/)，讲解版笔记每图附"读图块"）：

| 教材图 | 讲什么 | 重点观察 | 实验对应 | 代码对应 |
| --- | --- | --- | --- | --- |
| [Fig.2.9(a)](../../docs/学习笔记/assets/fig2_09a_muxed_d_scan_cell.jpg) | DFF 前加 MUX，SE 选 DI/SI | SE、DI、SI、Q/SO | Scan FF 单元行为 | `src/tiny_core_scan.v` 的 `if (scan_en)` 分支 |
| [Fig.2.9(b)](../../docs/学习笔记/assets/fig2_09b_muxed_d_scan_cell_waveforms.jpg) | SE 低捕获 D 流、SE 高移位 T 流 | SE 在时钟无效区切换 | 波形 20–56ns 与 60–96ns 两段 | `tb/tiny_core_scan_tb.v` 全部在 negedge 改信号 |
| [Fig.2.13](../../docs/学习笔记/assets/fig2_13_sequential_circuit_example.jpg) | 插链前：组合逻辑 + 普通 DFF | FF 的 D 全来自组合逻辑 | `tiny_core_prescan.v` | `always` 块只有功能分支 |
| [Fig.2.14(a)(b)](../../docs/学习笔记/assets/fig2_14a_muxed_d_full_scan_circuit.jpg) | 插链后结构 + S/H/C 测试节奏 | Q→SI 串接；SE 与 H 拍 | 整条链与 testbench 阶段 | 移位语句与阶段时间窗（§7） |

# 4 电路结构

```
             in_a in_b in_c                    y
               |    |    |                    ^
               v    v    v                    |
   scan_in -->[组合逻辑: d0~d3]------------>[q3]-[XOR]--> y
                 ^    ^    ^    ^             |
                 |    |    |    |            q3.q
                 +----+----+----+         (链尾 → scan_out)
                 q0.q q1.q q2.q q3.q
                  ^    ^    ^    ^
     scan_en=1:   SI -> Q -> Q -> Q -> scan_out   （移位链）
     scan_en=0:   d0 -> q0, d1 -> q1, ...          （捕获）
```

- 链方向：`scan_in → q[0] → q[1] → q[2] → q[3] → scan_out`。**先移入的位 4 拍后位于链尾，最先移出。**
- 组合逻辑（两版完全相同，插链不改功能）：`d0=in_a^q[3]`，`d1=q[0]&in_b`，`d2=q[1]^q[0]`，`d3=q[2]|in_c`，输出 `y=q[3]^q[1]`。
- `rst_n` 由外部引脚直接控制（教材表 2.7 异步复位规则的合规解，见笔记第 4 节）。

# 5 关键代码

设计侧（[src/tiny_core_scan.v](src/tiny_core_scan.v)）——MUX-D 的行为级等价：

```verilog
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)       q <= 4'b0000;
    else if (scan_en) begin            // Shift mode：链上移位
        q[0] <= scan_in;  q[1] <= q[0];
        q[2] <= q[1];     q[3] <= q[2];
    end
    else begin                         // Capture mode：抓组合逻辑响应
        q[0] <= d0;  q[1] <= d1;  q[2] <= d2;  q[3] <= d3;
    end
end
assign scan_out = q[3];
```

测试平台侧（[tb/tiny_core_scan_tb.v](tb/tiny_core_scan_tb.v)）：`func_cycle` 任务（功能拍，同时查 q 和 y）、`shift_in_bit`（移一位）、`check_shift_out`（查一位再移一位）。所有激励都在 negedge 施加——对应 Fig.2.9(b)"SE 必须在时钟无效区间切换"。

# 6 怎么运行

```bash
cd FYH/experiments/E05_tiny_core_scan

# 仿真（打印日志 + 生成 waves/wave.vcd）
iverilog -g2012 -o build/e05_sim.vvp src/tiny_core_scan.v tb/tiny_core_scan_tb.v
vvp build/e05_sim.vvp | tee build/sim_e05.log

# 看波形
gtkwave waves/wave.vcd

# 综合（build/ 内已有产物，重跑需 oss-cad-suite 环境）
cmd //c "call D:\Tools\oss-cad-suite\environment.bat && yosys -s scripts\synth.ys -l build\yosys.log"
```

工具：Icarus Verilog 12.0（`C:\iverilog`）、GTKWave、Yosys 0.68+136（`D:\Tools\oss-cad-suite`，Git Bash 直调会 exit 127，必须走 `environment.bat`）。

# 7 波形怎么看

打开 [waves/wave.vcd](waves/wave.vcd)，添加信号：`clk、rst_n、scan_en、scan_in、scan_out、dut.q[3:0]、in_a/in_b/in_c、dut.d0~d3、y`。

| 时间窗 | 阶段 | 看什么 |
| --- | --- | --- |
| 20–56 ns | FUNCTIONAL | `scan_en` 恒 0，q 逐拍等于 {d3,d2,d1,d0}，y 随 q 组合变化——电路不知道自己有扫描链 |
| 60–96 ns | SHIFT-IN | `scan_in` 上 `1,0,1,0` 逐拍流过 q[0]→q[3]；**第一拍 q=0011：功能阶段残留的 q=0001 正被移位流冲出** |
| 100–106 ns | CAPTURE | negedge 100 拉低 `scan_en` 并施加 in=110；posedge 105 单拍捕获，q 从 1010 变 0100 |
| 110–145 ns | SHIFT-OUT | `scan_out` 依次出现 0,1,0,0——**链尾先出** |
| 146–156 ns | BACK TO FUNCTIONAL | `scan_en=0`，Core 继续正常工作（q=0001） |

# 8 正确结果是什么

[build/sim_e05.log](build/sim_e05.log) 应当（且已经）出现：

```
========== FUNCTIONAL (scan_en=0) ==========
[FUNC] t=26000  in=101  q=1001 (expect 1001)
...（四拍全对）...
[PASS] Shift-In loaded q=1010
Captured q = 0100
[PASS] scan_out=0 / 1 / 0 / 0     ← 逐位移出 0100
[PASS] chain empty, q=0000
========== E05 PASS ==========     ← 0 errors
```

Capture 手算复核（q=1010，in_a=1, in_b=1, in_c=0）：`d0=1^1=0, d1=0&1=0, d2=1^0=1, d3=0|0=0` → 新 q={d3,d2,d1,d0}=**0100**，与仿真一致。判据：日志出现 `E05 PASS` 且 0 errors。

# 9 这个结果说明什么

1. **Shift 和 Capture 靠同一个时钟协作，唯一开关是 `scan_en`**：Shift 摆状态、收上一题答卷；Capture 让组合逻辑答一拍题——这正是全扫描能把时序测试变成组合测试的原因。
2. **插链不动功能**：prescan/scan 两版 diff 只有三处差异（端口、`scan_en` 分支、链移动语句），功能方程一字未动。
3. **移位重组整条链**：旧状态会被新移入的数据冲走（q=0001→0011 现象），所以 ATPG 从不需要"先清链"。
4. **诚实的失败记录**：FUNC 阶段首版期望值 F3/F4 算错（`d2=q[1]^q[0]` 项），被仿真抓出后修正——DUT 无误，是黄金模型笔误。这条留着提醒：期望值和 DUT 谁都不能盲信。

# 10 它和比赛 Scan Insertion 有什么关系

- 比赛任务一要读懂/生成插链后的网表：本实验的 prescan↔scan diff 就是"插链到底改了什么"的最小样本；
- 工具 scan chain 报告里的链序、移位方向（链尾先出）、`scan_en` 极性，都能在波形里找到对应直觉；
- 5 项验证要求对应工具流程里 scan verification 的位置（结构改对 ≠ 行为正确，见笔记第 5.5 节）。
- 边界：以上是教材原理层面；广立微工具的规则条目与报告格式以工具为准，不在此冒充。

# 11 给队友的 3 分钟讲解稿

> "左边是普通时序电路：4 个触发器的状态只能通过组合逻辑间接到达，想设状态要绕路，想看状态只能盯一个输出 y（Fig.2.13 的困难）。右边是插链后（Fig.2.14a）：每个触发器的 D 端前加了选择器，`scan_en` 就是选择信号（Fig.2.9a）。
> 测试是一个两拍节奏（Fig.2.14b）。**Shift**：`scan_en=1`，触发器串成移位寄存器，4 拍把想要的状态从 `scan_in` 摆进链——波形 60–96 ns，能看到数据一位一位推进，连功能阶段的旧状态都被冲出去了。**Capture**：`scan_en=0`，只打一个时钟脉冲，组合逻辑面对'摆好的状态+外部输入'算出的答案被同时抓回所有触发器——105 ns 这一带，q 从 1010 变 0100。最后再 Shift，把答案从 `scan_out` 串行读出来比对——0,1,0,0，链尾先出。
> 所以一句话：Shift 管'摆状态、收答卷'，Capture 管'让组合逻辑答一拍题'，同一个时钟、唯一开关是 `scan_en`。这就是全扫描把时序 ATPG 变成组合 ATPG 的全部秘密。"
