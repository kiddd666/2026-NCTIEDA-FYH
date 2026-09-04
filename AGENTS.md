
# FYH Personal Working Rules

`FYH` 是物理上嵌套在团队仓库中的独立个人 Git 仓库，对应远程仓库
[`kiddd666/2026-NCTIEDA-FYH`](https://github.com/kiddd666/2026-NCTIEDA-FYH)。
文件位置上的嵌套不代表 Git 历史、提交或 push 共用。

## 4. Git 边界与团队仓库关系

团队仓库是：

`D:\research\2026-NCTIEDA-Semitronix`

FYH 独立仓库的工作树是：

`D:\research\2026-NCTIEDA-Semitronix\FYH`

物理路径虽然位于团队仓库下，但所有 FYH 的 Git 操作必须以 FYH 自己的仓库根
为准，例如使用 `git -C D:\research\2026-NCTIEDA-Semitronix\FYH ...`。
不要在父目录执行会把 FYH 文件纳入团队提交的 `git add .`；提交、分支、remote
和 push 只属于 FYH 独立仓库。

父仓库通过 `.gitignore` / `.git/info/exclude` 忽略 `FYH`，但这只是可见性保护，
不能替代提交前的仓库根目录检查。每次发布前都分别核对两个仓库的
`git rev-parse --show-toplevel`、`git status` 和 `git log`。

尊重团队仓库根 `AGENTS.md` 及团队协作规则；本文件只约束 FYH 独立仓库内的
个人工作，不修改或覆盖父级团队仓库的 `AGENTS.md`。父仓库根
`AGENTS.override.md` 是本地未跟踪文件，不得提交或 push。

---

## 6. Related Personal Repository (暂停维护)

`D:\research\Scan-Insertion` 当前项目已暂停，不属于 FYH 的主动维护范围。

- 不对该仓库进行例行检查、开发、调试、文档维护或进度记录。
- 不主动读取或修改该仓库的文件，也不把它纳入当前任务的验证范围。
- 只有在用户明确恢复该项目或要求引用其中的特定资料时，才重新检查其
  `AGENTS.md` 和相关文件，并按当时明确的范围执行。

## 8. `FYH/docs` 文档写作与结构风格

新建或 substantially 修改 `D:\research\2026-NCTIEDA-Semitronix\FYH\docs`
下的文档时，沿用团队 `docs/比赛入门文档` 与 `docs/Agent 与系统预研` 的
写作方式。正文说明使用中文；路径、命令、API、Schema、代码和其他技术
标识符保留原文。

### 7.1 文档骨架

- 文件开头使用 YAML front matter，按文档需要填写 `type`、`tags`、
  `source_type`、`date`、`status` 等元数据。
- 使用清晰的一级标题；具有阅读顺序、阶段或层级的内容使用连续编号的
  `## 1.`、`### 1.1` 标题。
- 开头先给出一句话结论或文档定位，再展开背景、目标、边界和正文。
- 结尾给出验证标准、待确认事项、落地路线、当前状态或下一步，按文档
  目的取舍，不机械套用章节。

### 7.2 表达与证据

- 先讲结论，再解释依据、推导和例外；短段落承载一个主要判断。
- 优先写清楚“谁负责、要做什么、产出什么、何时完成、怎样算完成”；参考团队
  文档中的“分工—共同原则—近期行动—完成标准—待确认问题”结构组织内容。
- 用表格表达职责、任务、产出、依赖和验收标准；用代码块表达契约、目录和命令。
  只有文字难以说明多个组件或状态关系时才使用 Mermaid，不为形式添加图。
- 明确区分正式规则、宣讲/答疑口径、实验观察、团队建议和待确认事项；
  关键结论提供可回查的链接、文件或证据定位，不把推测写成事实。
- 关注职责边界、输入输出、失败路径、验证判据和可执行的检查清单，避免
  只有口号或泛泛而谈的总结。
- 尽量使用自然、具体的中文，少用抽象词和口号式表达。如果确实需要概括性术语，
  必须紧接着说明对应的动作、负责人和验收结果；优先改写为读者可以直接执行的说法。
- 不机械套用“背景—挑战—展望”或三段式结构；内容少时直接写结论和行动，
  内容多时再分节。

### 7.4 文末引用

- 每次写文档都在文末加入 `## 参考资料`（或语义等价的“引用”章节）。
- 引用使用可点击的 Markdown 链接，优先指向官方来源、仓库内相关文档或
  实际实验产物；本地文件使用正确的相对路径，外部资料保留完整 URL。
- 只列出实际查阅或支撑正文判断的来源；没有外部来源时明确写“暂无外部
  引用”，不得编造链接。

### 7.3 适用范围

该风格是 `FYH/docs` 的默认约定，不覆盖团队根目录 `AGENTS.md`、官方文档
格式或工具生成文件的既定格式。若新文档属于实验记录、会议实录或其他不适合
编号的文体，应保留上述“结论—依据—验证”的清晰性并按内容自然组织。

## 文件树维护

`.agents/skills/file-tree/tree.json` 是 FYH 文件树的唯一数据源；使用同目录
脚本维护条目并渲染本文件中的树块。常用命令：

```bash
python .agents/skills/file-tree/scripts/tree_tool.py query --kw 关键词
python .agents/skills/file-tree/scripts/tree_tool.py get docs/技术路线/任务.md
python .agents/skills/file-tree/scripts/tree_tool.py check --strict
```

新增、删除或移动文件时，先用 `add`、`rm`、`mv`（或对应批量命令）更新
`tree.json`，不要直接手改树块；完成后运行 `check --strict`。

## 文件树（简版速览）

```
<!-- file-tree:tree:begin 由脚本渲染，禁止手改 -->
FYH/
├── .agents/     # Agent技能配置目录
│   └── skills/ # 本仓库使用的Agent技能
│       └── file-tree/ # 文件树维护技能
│           ├── agents/   # 技能平台元数据
│           │   └── openai.yaml # 技能界面元数据
│           ├── scripts/  # 文件树维护脚本
│           │   ├── tree_tool.py      # 文件树维护工具
│           │   └── tree_tool_test.py # 文件树契约测试
│           ├── SKILL.md  # 文件树技能说明
│           └── tree.json # 文件树唯一数据源
├── .gitignore   # FYH仓库忽略规则
├── .vscode/     # VS Code工作区配置
├── AGENTS.md    # FYH个人协作规则
├── decisions.md # 技术决策日志
├── docs/        # 个人研究与学习文档
│   ├── DFT与规则学习/  # DFT与规则学习资料
│   │   ├── 00_任务理解.md.md                 # 任务理解学习笔记
│   │   ├── 01_数字设计基础复习.md.md             # 数字设计基础复习
│   │   ├── 02_DFT基础.md.md                # DFT基础笔记
│   │   ├── 03_Internal Scan核心.md.md      # Internal Scan笔记
│   │   ├── 04_时钟边沿与Lockup.md.md          # 时钟边沿与Lockup
│   │   ├── 05_Scan DRC与门级根因分析.md.md      # Scan DRC根因分析
│   │   ├── 06_Wrapper Scan、CTL与交付物.md.md # Wrapper与CTL交付物
│   │   ├── 07_工具执行、报告核验与LEC.md.md        # 工具报告与LEC
│   │   ├── attachments/                  # DFT学习配图
│   │   │   ├── Pasted image 20260901093205.png # DFT学习配图
│   │   │   └── Pasted image 20260901094228.png # DFT学习配图
│   │   ├── 第一周成果交付/                      # 第一周网表读图交付
│   │   │   ├── 00_第一周成果交付说明.md              # 第一周交付总览与标准
│   │   │   ├── 01_读图讲义.md                   # 门级网表读图讲义
│   │   │   ├── 02_week1_reference_netlist.v # 第一周唯一参考网表
│   │   │   ├── 03_独立测验.md                   # 第一周独立测验
│   │   │   ├── 04_参考答案与逐线讲解.md              # 参考答案与逐线讲解
│   │   │   ├── 05_交叉复核表.md                  # 第一周交叉复核表
│   │   │   ├── D1_赛题能力清单与术语表.md             # 赛题能力清单与术语表
│   │   │   ├── D2_组合逻辑速查表.md                # 组合逻辑速查表
│   │   │   ├── D3_时序单元对照表.md                # 时序单元对照表
│   │   │   ├── D4_结构化门级网表及标注.md             # 结构化网表及标注
│   │   │   └── D5_Scan原理图与第一周测验.md          # Scan原理图与第一周测验
│   │   └── 第二周成果交付/                      # 第二周Scan交付包
│   │       ├── 00_第二周成果交付说明.md                         # 第二周交付总览
│   │       ├── 01_第二周练习讲义与单元契约.md                      # 练习讲义与单元契约
│   │       ├── 02_week2_dual_clock_reference_netlist.v # 第二周唯一练习网表
│   │       ├── 03_独立练习与测验.md                           # 第二周独立测验
│   │       ├── 04_参考答案与逐线讲解.md                         # 第二周参考答案
│   │       ├── 05_交叉复核表.md                             # 第二周交叉复核表
│   │       ├── D10_双时钟手工插链案例.md                        # 双时钟手工插链案例
│   │       ├── D6_三类ScanCell对照表.md                     # 三类ScanCell对照表
│   │       ├── D7_Full与PartialScan对照及手工插链.md           # FullPartialScan与手工插链
│   │       ├── D8_通用DRC根因表.md                          # 通用DRC根因表
│   │       └── D9_Scan流程卡片.md                          # Scan流程卡片
│   ├── 参考书籍/      # DFT参考书籍
│   │   ├── VLSI Test Principles and Architectures - Design for Testability.md # VLSI测试参考书
│   │   ├── VLSI测试方法学和可测性设计.md                                                 # VLSI测试方法学
│   │   └── 数字设计和计算机体系结构原书第2版.md                                               # 数字设计参考书
│   ├── 学习笔记/      # DFT学习笔记
│   │   ├── agent使用技巧/                   # Agent使用技巧笔记
│   │   │   ├── codex使用技巧.md # Codex使用技巧笔记
│   │   │   └── prompt/      # 提示词笔记
│   │   │       ├── codex with gpt.md # Codex与GPT提示词
│   │   │       └── 提问.md             # 提问提示词笔记
│   │   └── VLSI_Test_Principles_Ch02.md # VLSI测试教材笔记
│   └── 技术路线与实验规划/ # 技术路线与实验规划文档
│       ├── 00_项目核心任务.md            # 项目核心任务
│       ├── 01_开源资料与实验.md           # 开源资料与实验
│       ├── 02_DFT与设计知识学习地图及学习大纲.md # DFT学习地图
│       ├── 03_DFT与设计知识学习缺口报告.md    # DFT学习缺口
│       ├── 04_DFT与规则负责人项目学习路线.md   # DFT负责人学习路线
│       ├── 05_DFT基础知识清单_下周日讲解.md   # DFT基础知识清单
│       └── 06_9.2学习计划与实验方案.md      # 9月2日至5日学习与前置实验方案
├── experiments/ # 实验记录与产物
│   └── E05_tiny_core_scan/ # tiny_core 扫描实验
│       ├── build/              # 实验生成物
│       │   ├── tiny_core_scan.json    # 综合结构 JSON
│       │   ├── tiny_core_scan_synth.v # 综合后 Verilog 网表
│       │   ├── wave.vcd               # 扫描实验波形
│       │   └── yosys.log              # Yosys 综合日志
│       ├── scripts/            # 实验脚本
│       │   └── synth.ys # Yosys 综合脚本
│       ├── tiny_core_prescan.v # 扫描前 tiny_core 设计
│       ├── tiny_core_scan.v    # 插入扫描链的 tiny_core
│       └── tiny_core_scan_tb.v # 扫描链测试平台
├── progress.md  # 项目进展日志
├── README.md    # FYH个人仓库说明
├── scripts/     # 个人辅助脚本
└── TODO.md      # 当前任务清单
<!-- file-tree:tree:end -->
```

## 文件树标签词表

<!-- file-tree:tags:begin 由脚本渲染，禁止手改 -->
| 标签 | 说明 |
| --- | --- |
<!-- file-tree:tags:end -->
