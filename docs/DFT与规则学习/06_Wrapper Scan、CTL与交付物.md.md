[[学习材料/DFT与设计知识学习地图及学习大纲.md#4.6 第六层：Wrapper Scan、CTL 与交付物|↩ 返回学习地图：4.6 第六层：Wrapper Scan、CTL 与交付物]]

# 06. Wrapper Scan、CTL 与交付物：给可复用核装上“标准外壳”

如果把一个 IP 核看成工厂里的机器，Wrapper 就像机器四周的标准接口箱：外部测试设备不必了解机器内部每根线，只需通过统一端口和控制协议完成装载、运行、捕获和读出。IEEE 1500 规定了这种核级测试访问的总体思路；本赛题还会把 Wrapper 范围、链数和报告字段写进任务要求。

## 1. IEEE 1500 的总体结构

一个 1500 Wrapper 至少围绕核的 I/O 边界组织以下概念：

| 名称 | 通俗解释 |
| --- | --- |
| WSP | Wrapper Serial Port，串行测试入口/出口及控制端子 |
| WSI/WSO | Wrapper Serial Input/Output，串行移入和移出数据 |
| WSC | Wrapper Serial Control，选择、捕获、移位、更新等控制 |
| WIR | Wrapper Instruction Register，保存当前 Wrapper 指令 |
| WBR | Wrapper Boundary Register，靠近核边界的测试数据寄存器 |
| WBC | Wrapper Boundary Cell，包在输入/输出边界上的单元 |
| WBY | Wrapper Bypass，绕过大段测试寄存器的快速路径 |

教材指出，1500 的串行端口是核心接口，WIR 负责选择测试指令，WBR/WBC 负责边界数据；并行 TAM 端口可以作为可选扩展。[英文 DFT 教材第 10.4.2～10.4.3 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)；[IEEE 1500 标准入口](https://standards.ieee.org/ieee/1500/)

## 2. Wrapper 的几个常见模式

- **Bypass**：通过 WBY 快速穿过 Wrapper，不访问完整边界寄存器；
- **EXTEST**：把边界单元用于核间互连或核外部逻辑测试；
- **INTEST_RING**：主要测试核内部，测试数据在 WBR 中循环；
- **INTEST_SCAN**：把核内部 Scan Chain 与 WBR 串接，获得更深的内部访问；
- **PRELOAD/CLAMP/SAFE**：在切换模式前预装安全值、钳住输出或进入安全状态。

模式名和是否强制由标准版本、工具实现与任务书共同决定。学习时先理解“数据经过哪条路径、何时捕获、何时更新”，不要把某个模式名当成工具命令的固定拼写。[英文 DFT 教材第 10.4.4 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)

## 3. Shared 与 Dedicated Wrapper Cell

- **Dedicated Wrapper Cell**：为测试专门放置，功能路径与测试路径边界清楚，资源开销更直观；
- **Shared Wrapper Cell**：复用原有功能寄存器或 I/O 结构，面积和引脚可能更省，但要确认功能模式、测试模式和控制信号不会互相干扰。

“Shared/Dedicated”在比赛中的准确语义可能由广立微工具手册和任务说明进一步限定。若任务要求“对 `io_*` 端口采用 Dedicated”，不能仅凭报告中出现了 Wrapper 单元就判定满足；要核对目标端口集合、单元类型和 Wrapper Implementation 报告。

## 4. 端口范围、链数和长度

Wrapper 不是“把所有顶层端口都包起来”。先把自然语言范围转为可枚举集合，例如：

```text
wrapper_scope = io_*
exclude = {scan_in*, scan_out*, test_mode}
wrapper_chain_count = 2
max_length = 64
```

然后逐项核对：

1. 通配符实际匹配了哪些输入、输出、双向端口？
2. 是否误把 DFT 专用端口再次包入？
3. 每个 Wrapper Chain 的数量和长度是否满足要求？
4. Shared/Dedicated 选择是否与题目一致？
5. Wrapper Configuration 与 Implementation 报告是否能指向这些对象？

赛题评分强调输出和配置必须与任务书一致，不能用“工具成功退出”替代端口范围核验。[比赛入门文档 02：任务边界与评分规则](<../比赛入门文档/02-任务边界与评分规则.md>)

## 5. CTL 是什么，不是什么

CTL（Core Test Language）用于描述可复用核的测试相关信息。它可以表达：

- 核的测试信号及其边界属性；
- 测试模式和模式切换协议；
- ScanInternal 链及其关系；
- 测试图案、时序、外部连接和资源约束。

CTL 的价值是让核提供者把“怎样测试这个核”交给系统集成者或工具，而不必暴露全部内部实现。CTL 是 IEEE 1450 STIL 的扩展，具体语法和工具支持应以标准与手册为准。[英文 DFT 教材第 10.4.5 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)；[IEEE 1450 标准入口](https://standards.ieee.org/ieee/1450/)

CTL **不是** Post-scan 网表的替代品，也不是“生成出来就代表 Wrapper 正确”。它描述测试信息；真正的单元连接仍需由网表、Wrapper/Scan 报告和必要的仿真共同证明。

## 6. SCANDEF 的位置

SCANDEF 用来记录扫描链的连接/顺序信息，常用于后续物理设计、布局布线或链一致性检查。初学者只需记住三件事：

1. 它应描述最终实际生成的链，而不是计划中的链；
2. 链中单元顺序要与 Scan Chain Cell 报告和 Post-scan 网表一致；
3. 任务书若要求 SCANDEF，缺文件或内容不一致都属于交付问题。

本仓库的赛题文档把 SCANDEF 列为条件性输出，具体是否必交以每个 case 的任务说明为准。[任务边界与评分规则第 4 章](<../比赛入门文档/02-任务边界与评分规则.md>)

## 7. 任务要求—配置—证据核验表

| 任务要求 | 配置对象 | 应查看的证据 | 常见误判 |
| --- | --- | --- | --- |
| 包裹 `io_*` | Wrapper scope / cell type | Wrapper Configuration、Implementation | 只看到 Wrapper 单元，不核对端口集合 |
| 2 条 Wrapper Chain | Wrapper chain count | Chain/Wrapper 报告 | 把 Internal Scan 链数量当成 Wrapper 链数量 |
| 使用某控制信号 | WSC/DFT Signal | Signal、Configuration 报告 | 只检查名字，不检查极性和连接 |
| 生成 CTL | CTL write/export | 文件存在、模式/链信息可解析 | 把空文件当作有效 CTL |
| 生成 SCANDEF | Scan chain write/export | 文件与实际链顺序比对 | 只检查文件名，不检查内容 |

## 8. 给外行人的“包裹测试”类比

想象把一台机器寄给别人维修：Wrapper 是包装箱上的标准插头，WIR 是“选择维修模式”的拨码开关，WBR 是记录输入/输出状态的标签条，CTL 是随箱附带的操作说明，SCANDEF 是箱内各个插头的接线图。包装箱存在不代表接线正确；只有说明书、接线图、实际箱内线路和测试结果互相吻合，交付才算完成。

## 参考资料

- [《VLSI Test Principles and Architectures》：第 10.4.2～10.4.5 节](<../../学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md>)
- [《VLSI测试方法学和可测性设计》：第 12.2～12.4 节](<../../学习材料/DFT补强/VLSI测试方法学和可测性设计.md>)
- [IEEE 1500 标准入口](https://standards.ieee.org/ieee/1500/)
- [IEEE 1450 标准入口](https://standards.ieee.org/ieee/1450/)
- [比赛入门文档 02：任务边界与评分规则](<../比赛入门文档/02-任务边界与评分规则.md>)
