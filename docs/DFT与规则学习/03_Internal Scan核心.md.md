[[学习材料/DFT与设计知识学习地图及学习大纲.md#4.3 第三层：Internal Scan 核心|↩ 返回学习地图：4.3 第三层：Internal Scan 核心]]

# 03. Internal Scan 核心：把“记忆单元”临时排成一条链

Internal Scan 解决的是芯片内部时序单元难以直接访问的问题。最直观的理解是：正常工作时，每个触发器各司其职；测试时，把它们接成一条或多条“行李传送带”，先把测试数据装进去，再让组合逻辑计算，最后把结果一格一格搬出来。

## 1. 三种常见 Scan Cell

### 1.1 Muxed-D Scan Cell

在普通 DFF 的数据输入前加一个 MUX，用 `Scan Enable (SE)` 选择：

- `SE=0`：`DI`（功能数据）进入触发器，保持正常功能；
- `SE=1`：`SI`（扫描输入）进入触发器，执行移位。

优点是结构简单、适合现代单时钟 DFF，也容易被自动化工具支持；代价是在功能路径上增加 MUX 延迟。[英文 DFT 教材第 2.4.1 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

### 1.2 Clocked-Scan Cell

Clocked-Scan 把扫描数据的采样放在专用扫描时钟或两相时钟控制下，减少功能数据路径上的 MUX 影响，但对时钟产生和时序配合要求更高。

### 1.3 LSSD Scan Cell

LSSD（Level-Sensitive Scan Design）使用电平敏感锁存器和两相非重叠时钟。它能把移位和功能捕获分得更清楚，适合特定工艺和高可靠测试，但单元和时钟体系更复杂。三种单元的电路细节以教材为准；赛题工具实际支持哪些库单元，则必须以提供的 Liberty 和工具手册核对。[英文 DFT 教材第 2.4.2～2.4.3 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 2. Shift、Capture 与初始化

一次典型 Scan 测试通常按下面的顺序进行：

1. **初始化**：让复位、置位和测试控制进入已知状态；
2. **Shift（移位）**：`SE=1`，按扫描时钟把一串比特送入链；
3. **Capture（捕获）**：`SE=0`，让组合逻辑运行一个或多个功能时钟，把响应装入 Scan Cell；
4. **Shift out（移出）**：再次 `SE=1`，把响应从 `scan_out` 逐位读出。

如果有多个捕获时钟域，还要规定时钟顺序和间隔，避免捕获顺序不确定。后续[第 04 篇](<04_时钟边沿与Lockup.md.md>)专门讲这些风险。[英文 DFT 教材第 2.7.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 3. Full Scan、Almost Full Scan、Partial Scan

| 架构 | 做法 | 优势 | 代价/限制 |
| --- | --- | --- | --- |
| Full Scan | 几乎所有可扫描存储单元都替换为 Scan Cell | 组合逻辑输入可控、输出可观，ATPG 最简单 | 面积、布线、功耗和功能时序开销最大 |
| Almost Full Scan | 只留下极少数单元不扫描 | 避开关键路径或特殊小域 | 未扫描单元可能降低覆盖率，需初始化或旁路 |
| Partial Scan | 只替换一部分单元 | 开销较小，可针对难点优化 | 测试生成仍要处理部分时序状态，验证更复杂 |

“全扫描”不是越多越好，而是要结合目标覆盖率、性能和工具支持来决定。教材给出的架构定义是通用原理；本赛题的链数和参与单元范围仍以任务说明书为准。[英文 DFT 教材第 2.5 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 4. 从原始网表到扫描链：四个动作

工具通常把 Scan Synthesis 拆成四类动作。即使命令名称因工具而异，也可以用这四个概念检查 Dofile 是否完整：

| 动作 | 用大白话解释 | 要核对的证据 |
| --- | --- | --- |
| Scan Configuration | 声明扫描模式、链数、时钟、边沿、Lockup 等目标 | 配置报告是否记录期望值 |
| Scan Replacement | 把普通 DFF/DLATCH 替换为库中的 Scan Cell | Scan Element 报告、Post-scan 网表单元类型 |
| Scan Reordering | 为了链长、时钟域或布线，调整单元先后 | Scan Chain Cell 顺序 |
| Scan Stitching | 真正连接 `SI→Q→SI`，接入 `scan_in/out` | SCANDEF/链报告与网表连线一致 |

英文教材第 2.7.2 节按这四步描述扫描综合；在竞赛中不要把“预生成链”误当成“已经完成插链”，最终必须检查 Post-scan 结果。[英文 DFT 教材第 2.7.2 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 5. Scan Signal 的角色

- `Scan In (SI)`：测试数据进入链的入口；
- `Scan Out (SO)`：链中最后一个单元的数据出口；
- `Scan Enable (SE)`：在功能路径和扫描路径之间切换；
- `Scan Clock`：驱动移位，可能与功能时钟相同或不同；
- 测试复位/置位：在初始化或测试期间把状态置于可预测值。

这些信号不是“名字相似就能替代”。极性、边沿、时钟域和端口归属都要从任务书和网表中核对，并在 Scan Signal/Configuration 报告里找到证据。[赛题指南第 4.2.1 节](<../赛题二-基于大语言模型的Scan Insertion智能体系统设计.md>)

## 6. 链数、链长与测试时间

假设有 `N` 个 Scan Cell、`K` 条链，最长链长度约为 `Lmax`。串行测试的移位时间大致由 `Lmax` 决定，而不是所有链长度的总和；因此把链尽量平衡可以减少等待。链太多会增加 `scan_in/out`、时钟和控制布线，也可能增加测试仪通道需求；链太少则最长链过长、测试时间增加。

一个简单分配例子：100 个单元分成 4 条链，理想情况下每条约 25 个；若实际变成 10、20、30、40，测试时间要按 40 个单元的链估算。真正的平衡还要同时考虑时钟域、边沿、物理位置和 Lockup 约束，不能只做整数平均。[英文 DFT 教材第 2.7.5 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 7. 手工练习：四个 DFF 组成两条链

给定 `FF0、FF1` 属于 `clk_a`，`FF2、FF3` 属于 `clk_b`，任务要求 2 条链且跨域要加 Lockup。一个合理草图是：

```text
链 0：scan_in0 → FF0 → FF1 → lockup → FF2 → scan_out0
链 1：scan_in1 → FF3 →（若无跨域则直接）…
```

这只是练习思路，不是固定答案。你需要先决定是否把不同域分开，再根据边沿和链长判断 Lockup 位置，并在报告中说明理由。工具最终如何排序，仍需以 Dofile 配置和 Scan Chain Cell 报告为准。


## 参考资料

- [《VLSI Test Principles and Architectures》：第 2.4～2.7 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)
- [《VLSI测试方法学和可测性设计》：第 6 章扫描路径法](<../../学习材料/DFT补强/VLSI测试方法学和可测性设计.md>)
- [赛题二官方指南整理版：任务一输入、配置与输出](<../赛题二-基于大语言模型的Scan Insertion智能体系统设计.md>)
