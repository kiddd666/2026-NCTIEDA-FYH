# E05 实验结果记录

## 运行记录

| 日期 | 内容 | 结果 | 证据 |
| --- | --- | --- | --- |
| 2026-09-05（先前） | 首次建立 tiny_core 插链 + shift/capture/shift-out，Yosys 综合提交 | PASS | 提交 `bf4c007` |
| 2026-09-05 | 复跑基线（改动前 testbench），与提交结果一致 | PASS | 会话日志（未存档，随后被扩展版覆盖） |
| 2026-09-05 | testbench 扩展：新增 `scan_en=0` 功能模式四拍校验 + 移出后回功能校验；首版期望值 F3/F4 算错，仿真抓出后修正 | FAIL → 修正 → PASS | 失败输出见下 |
| 2026-09-05 | 目录重构（src/ tb/ waves/）后全量重跑仿真 | PASS，0 errors | [build/sim_e05.log](build/sim_e05.log) |
| 2026-09-05 | 重跑 Yosys 综合（经 `environment.bat`），刷新 build 综合产物 | 无 ERROR | [build/yosys.log](build/yosys.log) |

## 失败证据（保留）

testbench FUNC 阶段首版期望值错误（DUT 无误，黄金模型把 `d2=q[1]^q[0]` 算错）：

```
[FUNC] t=46000  in=111  q=1011 (expect 1111)
[FAIL] func q expected=1111 actual=1011
[FUNC] t=56000  in=000  q=0001 (expect 1001)
[FAIL] func q expected=1001 actual=0001
========== E05 FAIL: 2 errors ==========
```

修正：q=0111 时 `d2=1^1=0`，F3 正确下一态为 `1011`；F4 连带为 `0001`。

## 5 项验证要求对照

| # | 要求 | 结果 |
| --- | --- | --- |
| 1 | `scan_en=0` 功能正常 | ✅ 四拍 q/y 全对 |
| 2 | `scan_en=1` 构成移位链 | ✅ 装载 q=1010 |
| 3 | scan_in 逐拍经过各 FF | ✅ q=0011→0110→1101→1010 |
| 4 | capture 捕获组合响应 | ✅ q=0100，手算一致 |
| 5 | 响应从 scan_out 移出 | ✅ 0,1,0,0 逐位 PASS，链清空 |

## 工具与环境

- Icarus Verilog 12.0（iverilog/vvp）、GTKWave —— `C:\iverilog`
- Yosys 0.68+136 —— `D:\Tools\oss-cad-suite`（Git Bash 直调 exit 127，必须 `call environment.bat`）

## 产物清单

| 产物 | 说明 |
| --- | --- |
| [build/sim_e05.log](build/sim_e05.log) | 最终仿真日志（PASS） |
| [waves/wave.vcd](waves/wave.vcd) | 波形（GTKWave 打开） |
| [build/tiny_core_scan_synth.v](build/tiny_core_scan_synth.v) / [.json](build/tiny_core_scan.json) / [yosys.log](build/yosys.log) | 本次重跑的综合产物 |
| [build/e05_sim.vvp](build/e05_sim.vvp) | 仿真编译产物 |

## 结论

E05 验收标准达成：只看 README + 代码 + 波形，可在 5 分钟内向普通研究生讲清 Shift/Capture。实验停止，等待确认后进入 E06。
