[[学习材料/DFT与设计知识学习地图及学习大纲.md#4.4 第四层：时钟、边沿与 Lockup|↩ 返回学习地图：4.4 第四层：时钟、边沿与 Lockup]]

# 04. 时钟、边沿与 Lockup：避免扫描数据“来得太快”

这一层的核心不是背诵 Lockup 的名字，而是理解一个时序事实：**扫描移位时，前一个单元推出数据、后一个单元接收数据，若两者的时钟关系不合适，数据可能在接收窗口关闭前就变化，造成 hold 违例。**

## 1. 单时钟域与多时钟域

- **单时钟域**：链中单元由同一时钟、相同边沿驱动，时序关系最简单，但仍要检查时钟树偏移和物理距离。
- **多时钟域**：不同单元由 `clk_a/clk_b` 等时钟驱动。移位时通常需要人为规定域的先后；捕获时还要规定哪些时钟可以同时打、哪些必须错开。

把时钟域想成不同车站：同一车站的班车时刻表容易协调，不同车站之间交接就需要缓冲站。Lockup 单元就是扫描链上的缓冲站，而不是功能逻辑中的普通数据寄存器。[英文 DFT 教材第 2.6～2.7 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 2. 正沿、负沿与链排序

正沿单元在 `0→1` 时更新，负沿单元在 `1→0` 时更新。若相邻单元由同一时钟驱动，边沿组合会影响数据是否有足够保持时间。一个实用的初始规则是：

1. 先按时钟域分组；
2. 再按触发边沿分组；
3. 在跨域或边沿交界处评估是否需要 Lockup；
4. 最后才做长度平衡和物理距离优化。

“正沿一定要放在负沿前面”不是普适真理，真正依据是工具支持的时钟相位、扫描方向和 hold 分析。若任务书指定了边沿排序，必须按任务要求验证，而不是套用经验口诀。[英文 DFT 教材第 2.7.2～2.7.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 3. Lockup Latch 与 Lockup Flip-Flop 的作用

### 3.1 Lockup Latch

Lockup latch 在扫描移位路径上提供一个电平透明窗口：当前一级数据准备好后，锁存器在合适的相位暂存数据，等下一级采样窗口安全时再放行。它常用于跨时钟域或相反边沿的链组织。

### 3.2 Lockup Flip-Flop

Lockup FF 用一个额外的边沿触发存储单元提供更明确的时序隔离，代价通常是面积和移位周期结构更复杂。究竟选 latch 还是 FF，要看库里可用的单元、工具语义、占空比和任务要求，不能仅凭名称决定。

### 3.3 位置判断

Lockup 通常放在“容易产生 hold 风险的交界处”，而不是每个单元之间都插。验证时要同时看：

- Scan Chain Cell 报告中 Lockup 的位置；
- Post-scan 网表中实际的锁存器/触发器实例；
- 移位仿真或 flush test 是否按预期周期输出数据。

教材明确把跨时钟域的扫描保持问题与缺少 Lockup 联系起来，并建议通过全时序移位验证定位。[英文 DFT 教材第 2.7.4.1 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 4. Gated Clock 与 Derived Clock

### 4.1 门控时钟（Gated Clock）

门控时钟通过 `enable` 关闭不需要翻转的寄存器，以降低功耗；但在 Shift 时，如果门控条件没有打开，链中的单元就收不到时钟，表现为“链不动”。常见做法是在测试模式或 `SE=1` 时旁路/强制打开门控，同时保留 Capture 阶段对门控逻辑的可测试性。[英文 DFT 教材第 2.6.3 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

### 4.2 派生时钟（Derived Clock）

PLL、分频器、脉冲发生器或内部寄存器产生的时钟不能像顶层输入那样直接控制。若扫描链依赖这种时钟，测试可能无法可靠地 Shift 或 Capture。典型策略是在整个测试期间用 MUX 旁路到一个可由顶层控制的测试时钟；是否允许局部保留派生时钟，要由工具规则和任务书明确。[英文 DFT 教材第 2.6.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 5. Capture 阶段的 One-hot、Staggered Clocking 与分组

多个时钟在 Capture 同时跳变，可能让不同域的响应互相影响，也可能造成电源瞬时峰值。常见的组织思路是：

- **One-hot 时钟选择**：同一时刻只允许一个捕获时钟组有效；
- **Staggered clocking（交错时钟）**：让不同组按有间隔的时刻依次捕获；
- **Clock grouping（时钟分组）**：把有共同相位、频率或测试约束的时钟放入同组。

这些名称描述的是组织原则，不替代具体工具命令。实践中要在任务矩阵里记录每组的时钟、边沿、启动顺序、间隔和预期报告字段，并用 Capture 波形或工具报告确认。[英文 DFT 教材第 2.7.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 6. 三种典型情形的“风险—动作—验证”

| 情形 | 主要风险 | 初始组织动作 | 验证证据 |
| --- | --- | --- | --- |
| 同一域、同一正沿 | 时钟偏移导致相邻单元 hold 失败 | 保持合理物理顺序，必要时加缓冲/Lockup | 全时序 flush test、hold 报告 |
| 同一域、正沿→负沿 | 两种边沿的采样窗口相邻或重叠 | 按工具规则排序，评估交界处 Lockup | Scan Chain Cell、时序波形 |
| `clk_a`→`clk_b` 跨域 | 两个时钟相位未知，数据过早到达 | 分组并在交界处放 Lockup；规定移位时钟顺序 | Lockup 实例、移位仿真、跨域 DRC |

表中的“初始”很重要：最终方案必须以实际库、工具版本和任务说明书为准，不能把教材中的示意电路直接当作比赛配置。

## 7. 一个可执行的检查顺序

1. 从网表和 Liberty 列出每个候选 Scan Cell 的时钟引脚和边沿；
2. 按时钟域、边沿、门控/派生属性分组；
3. 标出每条候选链的交界处；
4. 为每个交界处写下“是否需要 Lockup、为什么”；
5. 配置后检查 Scan Chain/Lockup 报告和 Post-scan 网表；
6. 做包含 `0→1、1→0、0→0、1→1` 变化的 flush test，观察是否提前或延迟输出。

## 参考资料

- [《VLSI Test Principles and Architectures》：第 2.6～2.7.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)
- [《数字设计和计算机体系结构（原书第 2 版）》：第 3.5 节时序逻辑的时序](<../../学习材料/DFT补强/数字设计和计算机体系结构原书第2版.md>)
- [学习地图第四层原文](<../../学习材料/DFT与设计知识学习地图及学习大纲.md>)
