---
title: "Scan Insertion 比赛基础知识清单（下周日讲解版）"
type: "个人学习清单"
tags:
  - DFT
  - Scan-Insertion
  - 基础知识
  - 宣讲准备
source_type: "个人任务说明与团队赛题文档整理"
date: 2026-08-31
status: "进行中"
---
# Scan Insertion 比赛基础知识清单（下周日讲解版）

**一句话结论：**下周日要讲清比赛，最低目标不是背工具命令，而是能把“任务要求—网表结构—DFT 配置—报告证据—问题根因”连成一条可解释的链路。

按当前日期（2026-08-31），本文中的“下周日”指 2026-09-06；若赛程日期另有调整，以实际通知为准。

## 1. 讲解目标与掌握层级

把每个知识点掌握到下面三种层级之一：

| 层级 | 你需要做到什么 | 适合讲解的结果 |
| --- | --- | --- |
| L1 解释 | 能用自己的话说清概念、输入、输出和目的 | 听众知道“它是什么、为什么需要” |
| L2 判断 | 给一个小网表或任务要求，能判断适用规则和风险 | 听众知道“什么时候这样配置” |
| L3 取证 | 能指出应查看的报告字段，并说明通过/失败 | 听众知道“怎样证明做对了” |

下表中的“掌握标准”默认至少达到 L2；标为“讲解必备”的项目还要达到 L3。

## 2. 必须先补齐的数字设计与门级网表基础

| 知识点 | 需要掌握的内容 | 掌握标准 |
| --- | --- | --- |
| 组合逻辑与时序逻辑 | 组合路径、状态保存、D/Q、反馈、MUX；组合逻辑不能保存状态，时序单元可以 | 能解释为什么 Scan 链必须经过时序单元 |
| DFF 与 Latch | `DFF`、`DLATCH`、Q/非 Q、透明窗口、触发沿；正沿/负沿的区别 | 能从门级实例和引脚判断单元类型与触发沿 |
| 时序概念 | setup/hold、clock-to-Q、shift 与 capture 的时序目的 | 能解释跨时钟或跨边沿为什么会有 shift timing 风险 |
| Clock | 主时钟、派生时钟、gated clock、反相时钟、clock mux、clock domain | 能列出网表中的 clock、来源、极性和所属域 |
| Reset/Set | synchronous 与 asynchronous reset/set、有效高/低、复位锥可控性 | 能判断复位是否可能在 scan mode 下不可控 |
| 网表结构 | top module、层次、实例/网络、端口方向、常量 tie、black box、RAM | 能从结构而非实例名猜测功能，并记录证据 |
| Liberty 基础 | cell、pin、direction、function、clock 属性、`ff`/`latch` 描述 | 能把网表单元和 `.lib` 中的时序定义对应起来 |

### 2.1 网表分析最小输出

拿到 `pre_scan.v` 或 JSON 网表后，至少整理出：

```json
{
  "top_module": "",
  "ports": [],
  "clocks": [],
  "resets": [],
  "sequential_cells": [],
  "clock_domains": [],
  "gated_clocks": [],
  "async_controls": [],
  "latches": [],
  "ram_or_blackboxes": []
}
```

## 3. Scan/DFT 的核心概念

| 知识点 | 需要掌握的内容 | 掌握标准 |
| --- | --- | --- |
| 可测性 | controllability、observability、为什么普通功能模式难以控制/观察内部状态 | 能说明 Scan 如何改善两者 |
| Scan Cell | 普通 FF 加 Scan MUX，`SE=0` 走功能数据、`SE=1` 走 scan data | 能画出一个 Scan Cell 的数据路径 |
| Shift/Capture | shift 装载测试模式，capture 捕获响应；二者的时钟和控制条件不同 | 能解释一条链如何移入、捕获、移出 |
| Scan In/Out | 链的串行输入、串行输出、链首和链尾 | 能根据链连接判断方向和边界 |
| Scan Enable (SE) | 测试模式选择信号；功能模式与移位模式的切换条件 | 能判断 SE 是否接到正确对象且可控 |
| Scan Clock | 移位/捕获使用的测试时钟、有效沿和时钟域 | 能区分功能 clock 与 scan clock 的职责 |
| Test Mode/Reset | 测试模式、测试复位、异步控制在 scan mode 下的可控性 | 能列出进入 scan mode 所需控制信号 |
| Full/Partial Scan | 全部或部分时序单元替换；不可扫描单元的原因及影响 | 能说明哪些单元应排除以及如何验收 |
| 链数与链长 | chain count、长度均衡、最长链、空链/漏链 | 能由需求计算并核对预期链规模 |
| Stitching/Ordering | 链的拼接顺序、同域优先、跨域边界处理 | 能给出简单双时钟设计的分链建议 |

## 4. 多时钟、混合边沿与 Lockup

这是最容易在讲解中被追问、也最能体现 DFT 判断力的一组知识。

- **Clock domain：**由时钟源、有效沿和相关约束共同定义；不能只按信号名分组。
- **混合边沿：**`posedge` 与 `negedge` 单元相邻时，需考虑半周期/相位关系和 shift 时序。
- **跨时钟域：**不同频率、相位或独立控制的时钟之间直接串接可能导致数据竞争或不可控移位。
- **Lockup latch/FF：**放在高风险边界，吸收时钟偏斜或相位差；要能解释放置位置、透明窗口/触发沿和对链长的影响。
- **Gated/derived clock：**要判断 scan shift 时是否能被打开、是否需要 test override，不能只把门控信号当普通数据。

**讲解关口：**给出“时钟域 A 的正沿 FF → 时钟域 B 的负沿 FF”的例子时，你能说明风险、是否需要 Lockup、还要查看哪份链/DRC 报告。

## 5. Wrapper Scan 与相关交付物

| 知识点 | 需要掌握的内容 | 掌握标准 |
| --- | --- | --- |
| Wrapper Cell | 位于 core boundary 的可控/可观测单元，隔离 core 与外部逻辑 | 能说清它与 internal scan cell 的位置和目的差异 |
| Wrapper Chain | wrapper cell 的串接、链首尾、长度和控制信号 | 能根据指定端口/层次判断纳入范围 |
| Wrapper Control | wrapper enable、shift/capture 控制及与 SE/test mode 的关系 | 能指出控制信号的来源和验收字段 |
| Internal vs Wrapper | Internal Scan 面向 core 内部时序单元；Wrapper 面向边界/接口 | 能在需求矩阵中分到正确配置类别 |
| CTL | 测试协议/接口描述（具体字段以工具手册确认） | 知道何时需要写出、如何检查来源和一致性 |
| SCANDEF | 链结构/物理实现交付描述（具体格式以工具手册确认） | 能把它作为链结构证据，而非单纯日志附件 |

## 6. Dofile/Tcl 与 Scan Insertion 流程基础

先掌握流程和对象，再学习具体工具命令；工具手册到位前不要臆测参数名。

典型闭环是：

```text
加载门级网表与 Liberty
  → 识别/配置 DFT Signal
  → 配置 Internal Scan、时钟域与 Lockup
  → 配置 Wrapper（若任务要求）
  → DRC/预检查
  → 预览或生成链
  → 执行 Scan Insertion
  → 生成报告、CTL、SCANDEF、Post-scan 网表
  → 按需求矩阵逐项验收
```

还需具备这些 Tcl/Dofile 通用能力：变量与列表、命令顺序、对象查询、文件路径、错误码与日志定位、最小可复现脚本。重点理解“命令作用于什么设计对象、前置条件是什么、输出证据在哪里”。

## 7. DRC 根因诊断基础

建立“现象 → 检查对象 → 根因假设 → 允许修复 → 验证证据”的思路，至少覆盖：

| 类别 | 要会检查的对象 | 常见根因方向 |
| --- | --- | --- |
| Clock | clock port、clock cone、gating、派生/反相时钟、domain | 时钟未声明、不可控、门控未旁路、域/边沿不一致 |
| Reset/Set | 异步控制 pin、reset cone、test mode 控制 | scan mode 下不可控、有效电平配置错误、控制未覆盖 |
| Scan Enable | SE port/net、Scan MUX select、控制来源 | 未连接、极性反、作用范围错误 |
| Scan Cell | 可替换单元、排除单元、非标准时序单元 | cell 不支持、替换遗漏、功能路径被破坏 |
| Latch/Lockup | latch 类型、透明窗口、链边界 | 应加未加、位置/极性错误、跨域时序风险未处理 |
| Gated Clock | clock gate enable、test override、时钟传播 | shift 时钟被关断或工具无法追踪 |
| RAM/Black Box | 宏单元边界、scan 支持、模型完整性 | 无可扫描模型、黑盒导致链/DRC 不完整 |
| Tie/常量 | tie cell、常量网络、悬空端口 | 控制信号被绑死、端口悬空或不可测试 |

必须区分三类问题：

1. **Dofile 执行错误**：命令、参数、路径、加载顺序或对象引用不合法。
2. **DFT 配置错误**：工具能运行，但 Signal、链数、域、Wrapper 等不符合要求。
3. **网表根因**：设计本身存在门控、异步控制、Latch/RAM 或不可观测结构，需要判断能否在任务二工作副本中修复。

## 8. 报告验收与等价性基础

“工具退出码为 0”不是完成标准。你需要会从报告中取证：

- DFT Signal：名称、方向、极性、作用对象、可控性。
- Scan configuration：链数、链长策略、时钟域/边沿、Lockup 策略。
- Scan chain：实际链数量、每条链长度、首尾、跨域边界、异常/空链。
- Scan chain cell：每条链中的 cell 顺序、替换结果、Lockup 单元。
- Wrapper 报告：纳入的端口/层次、wrapper cell 和 wrapper chain。
- Post-scan 网表、CTL、SCANDEF：是否生成、路径是否正确、内容是否与配置一致。
- DRC/日志：错误编号、对象、严重级别、复跑后是否消失。

任务二若修改工作副本网表，还要理解 **EQY/LEC 等价性检查**：

- “等价通过”才能证明修复没有改变功能语义；
- 环境/模型配置失败不等于真实不等价；
- 任务一的输入 Pre-scan 网表保持只读，不能用修改网表掩盖配置问题。

## 9. 比赛语义与协作接口

你至少要能把一条自然语言要求写成下面的需求矩阵：

```text
原始要求
→ 规范化 DFT 语义
→ 设计对象/网表证据
→ Dofile 配置对象
→ 预期报告字段
→ 验收断言
→ 失败后的根因与最小修复
```

讲解时要明确：

- 你负责定义 DFT 语义、规则和“做对”的判据；
- Agent 负责人负责规划、调用工具和反馈循环；
- 工具与质量负责人负责稳定执行、报告解析和自动化断言；
- 规则事实分为“教材原理、团队决定、工具手册确认、待确认”，不能把猜测写成正式工具规则。

## 10. 到下周日的学习优先级

| 优先级 | 先掌握的内容 | 建议验收方式 |
| --- | --- | --- |
| P0 | 数字设计、DFF/Latch、Clock/Reset、网表阅读 | 手工标注一个小门级网表 |
| P0 | Scan Cell、Shift/Capture、SE、链数/链长 | 画出一条 Scan 链并口头演示数据流 |
| P0 | 时钟域、边沿、Lockup、gated clock | 解释双时钟/混合边沿案例 |
| P0 | DFT Signal、Internal Scan、Wrapper 的边界 | 把模拟 task spec 填入需求矩阵 |
| P0 | DRC 三层分类与报告验收 | 对一个错误案例写“现象—根因—证据” |
| P1 | Tcl/Dofile 流程、CTL/SCANDEF、EQY | 阅读一份正确脚本并标出每步输入输出 |
| P1 | 具体工具命令、参数和 DFTR 编号 | 等工具手册/Public case 到位后校准 |

## 11. 讲解前自测清单

- [ ] 我能用 3 分钟解释 Scan Insertion 的目的、输入、输出和基本流程。
- [ ] 我能从门级网表找出 top、端口、DFF/Latch、clock、reset 和 clock domain。
- [ ] 我能画出 Scan Cell，并解释 `SE=0/1` 时的数据路径。
- [ ] 我能解释 shift/capture、链数/链长、扫描顺序和 Full/Partial Scan。
- [ ] 我能判断双时钟、混合边沿、gated clock 何时产生 Lockup/DRC 风险。
- [ ] 我能区分 Internal Scan、Wrapper Scan、CTL 和 SCANDEF。
- [ ] 我能把自然语言要求映射到 Dofile 对象、报告字段和验收断言。
- [ ] 我能区分 Dofile 执行错误、DFT 配置错误和网表根因。
- [ ] 我能指出“工具成功但任务仍失败”的具体例子。
- [ ] 我能说明任务一网表只读、任务二修复为何需要 EQY/LEC 证据。

## 12. 当前不必优先掌握的内容

在比赛材料尚未到位前，暂不把时间花在复杂 Multi-Agent 框架、完整 JTAG/边界扫描、与当前 case 无关的 RAM 测试细节、具体工具私有命令的猜记，以及没有真实报告支撑的 DFTR 编号背诵上。先把通用原理、网表判断和证据链讲清楚，材料到位后再补工具特定规则。

## 参考资料

- [个人任务说明](任务.md)
- [DFT 与规则负责人项目学习路线](DFT与规则负责人项目学习路线.md)
- [02-任务边界与评分规则](../../../docs/比赛入门文档/02-任务边界与评分规则.md)
- [03-技术路线与系统拆解](../../../docs/比赛入门文档/03-技术路线与系统拆解.md)
- [04-团队角色与近期行动](../../../docs/比赛入门文档/04-团队角色与近期行动.md)
- [赛题指南整理版](<../../../docs/赛题二-基于大语言模型的Scan%20Insertion智能体系统设计.md>)
- [DFT 与设计知识学习地图及学习大纲](../../../学习材料/DFT与设计知识学习地图及学习大纲.md)
- [DFT 与设计知识学习缺口报告](../../../学习材料/DFT与设计知识学习缺口报告.md)
- [Yosys EQY 官方文档](https://yosyshq.readthedocs.io/projects/eqy/en/latest/)
