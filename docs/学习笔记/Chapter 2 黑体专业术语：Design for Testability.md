Chapter 2 黑体专业术语：Design for Testability

提取说明：依据 Zotero 附件 PDF 的字体属性，提取 Chapter 2（PDF 印刷页 37–95；文件页 68–126）正文中以 bold 或 bold italic 字体标示的专业术语；已去重并按章节归类。章节标题、图表编号和非术语性强调词未单独重复列出。页码为书内印刷页码。

2.1 Introduction（pp. 37–40）

• design for testability (DFT)｜可测性设计

• integrated circuit (IC)｜集成电路

• parts per million (PPM)｜每百万件数

• small-scale integration (SSI)｜小规模集成

• very-large-scale integration (VLSI)｜超大规模集成

• fault simulation｜故障仿真

• fault grading｜故障评分

• testability measures｜可测性度量

• ad hoc｜专用的

• testability enhancement｜可测性增强

• testability｜可测性

• controllability｜可控性

• observability｜可观测性

• automatic test pattern generation (ATPG)｜自动测试向量生成

• scan cells｜扫描单元

• scan design｜扫描设计

• scan chains｜扫描链

• scan input (SI)｜扫描输入

• scan output (SO)｜扫描输出

• full-scan design｜全扫描设计

• almost full-scan design｜准全扫描设计

• partial-scan design｜部分扫描设计

• pipelined partial-scan design｜流水线式部分扫描设计

• feed-forward partial-scan design｜前馈式部分扫描设计

• balanced partial-scan design｜平衡式部分扫描设计

• scan design rules｜扫描设计规则

• automatic test equipment (ATE)｜自动测试设备

• built-in self-test (BIST)｜内建自测试

• soft errors｜软错误

• special-purpose scan designs｜特殊用途扫描设计

• register-transfer level (RTL)｜寄存器传输级

2.2 Testability Analysis（pp. 40–50）

• testability analysis｜可测性分析

• Sandia Controllability/Observability Analysis Program (SCOAP)｜Sandia 可控性/可观测性分析程序

• topology-based testability analysis｜基于拓扑的可测性分析

• simulation-based testability analysis｜基于仿真的可测性分析

• RTL testability analysis｜RTL 可测性分析

• deterministic testability｜确定性可测性

• logic built-in self-test｜逻辑内建自测试

• random testability｜随机可测性

• probability-based testability measures｜基于概率的可测性度量

• random-pattern resistant (RP-resistant)｜随机模式抗性

• statistical sampling｜统计抽样

• random resistant fault analysis (RRFA)｜随机抗性故障分析

• statistical fault analysis｜统计故障分析

• structure graph｜结构图

• sequential depth｜时序深度

• directed acyclic graph (DAG)｜有向无环图

• 0-controllability｜0 可控性

• 1-controllability｜1 可控性

• primary input｜主输入

• primary output｜主输出

• branch｜分支

• stem｜干线

2.3 Design for Testability Basics（pp. 50–53）

• structured approach｜结构化方法

• electronic design automation (EDA)｜电子设计自动化

• test point insertion (TPI)｜测试点插入

• test points｜测试点

• test mode (TM)｜测试模式

• normal mode｜正常模式

• shift mode｜移位模式

• capture mode｜捕获模式

• scan cells｜扫描单元

• scan chains｜扫描链

2.4 Scan Cell Designs（pp. 54–58）

• muxed-D scan｜Muxed-D 扫描

• clocked-scan｜时钟扫描

• level-sensitive scan design (LSSD)｜电平敏感扫描设计

• edge-triggered muxed-D scan cell｜边沿触发 Muxed-D 扫描单元

• scan enable (SE)｜扫描使能

• data input (DI)｜数据输入

• scan input (SI)｜扫描输入

• level-sensitive/edge-triggered muxed-D scan cell｜电平敏感/边沿触发 Muxed-D 扫描单元

• clocked-scan cell｜时钟扫描单元

• shift register latch (SRL)｜移位寄存器锁存器

2.5 Scan Architectures（pp. 59–68）

• primary inputs (PIs)｜主输入

• pseudo-primary inputs (PPIs)｜伪主输入

• primary outputs (POs)｜主输出

• pseudo-primary outputs (PPOs)｜伪主输出

• hold cycle｜保持周期

• single-latch design｜单锁存器设计

• double-latch design｜双锁存器设计

• functional partitioning｜功能划分

• serial scan design｜串行扫描设计

• random-access scan｜随机访问扫描

• random-access memory (RAM)｜随机访问存储器

• progressive random-access scan (PRAS)｜渐进式随机访问扫描

• static random-access memory (SRAM)｜静态随机访问存储器

• multiple-input signature register (MISR)｜多输入特征寄存器

2.6 Scan Design Rules（pp. 70–75）

• tristate buses｜三态总线

• bidirectional I/O ports｜双向 I/O 端口

• gated clocks｜门控时钟

• derived clocks｜派生时钟

• combinational feedback loops｜组合反馈环

• asynchronous set/reset signals｜异步置位/复位信号

• phase-locked loop (PLL)｜锁相环

• netlist｜网表

• testable design｜可测试设计

• staggered clocking｜交错时钟

• one-hot clocking｜独热时钟

• clock grouping｜时钟分组

2.7 Scan Design Flow（pp. 76–86）

• one-pass synthesis｜单遍综合

• single-pass synthesis｜单遍综合

• scan configuration｜扫描配置

• scan replacement｜扫描替换

• scan-ready design｜扫描就绪设计

• scan reordering｜扫描重排序

• intra-scan-chain reordering｜扫描链内重排序

• inter-scan-chain reordering｜扫描链间重排序

• scan stitching｜扫描串接

• scan extraction｜扫描提取

• standard delay format (SDF)｜标准延迟格式

• clock-tree synthesis (CTS)｜时钟树综合

• flush tests｜冲刷测试

• static timing analysis (STA)｜静态时序分析

• broadside-load｜宽侧加载

• broadside-load test｜宽侧加载测试

2.8 Special-Purpose Scan Designs（pp. 87–91）

• enhanced scan｜增强扫描

• snapshot scan｜快照扫描

• false paths｜伪路径

• over-test｜过度测试

• launch-on-shift｜移位启动

• launch-on-capture｜捕获启动

• scan set｜扫描集合

• error-resilient scan｜容错扫描

• single-event upsets (SEUs)｜单粒子翻转

• error-correcting code (ECC)｜纠错码

• soft error rate (SER)｜软错误率

2.9 RTL Design for Testability（pp. 92–95）

• analog and mixed-signal (AMS)｜模拟与混合信号

• fast synthesis｜快速综合

• hardware description language (HDL)｜硬件描述语言

• RTL scan synthesis｜RTL 扫描综合

• pseudo RTL scan synthesis｜伪 RTL 扫描综合

• RTL scan extraction｜RTL 扫描提取

• scan verification｜扫描验证
