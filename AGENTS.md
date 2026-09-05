
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
├── docs/        # 个人研究与学习文档
│   ├── 学习笔记/      # DFT学习笔记
│   │   ├── agent使用技巧/                # Agent使用技巧笔记
│   │   │   └── codex使用技巧.md # Codex使用技巧笔记
│   │   ├── assets/                   # 学习笔记配图资产
│   │   │   ├── fig10_21_1500_system_overview.jpg        # 教材Fig.10.21系统概览
│   │   │   ├── fig10_22_core_wrapper_test_interface.jpg # 教材Fig.10.22核外壳测试接口
│   │   │   ├── fig10_23_1500_serial_test_circuitry.jpg  # 教材Fig.10.23串行测试电路
│   │   │   ├── fig10_24_wir_circuitry.jpg               # 教材Fig.10.24 WIR电路设计
│   │   │   ├── fig10_25_bubble_symbols.jpg              # 教材Fig.10.25气泡图符号
│   │   │   ├── fig10_26_wbc_bubble_diagrams_1.jpg       # 教材Fig.10.26气泡图前半
│   │   │   ├── fig10_26_wbc_bubble_diagrams_2.jpg       # 教材Fig.10.26气泡图后半
│   │   │   ├── fig2_07_sequential_test_difficulty.jpg   # 教材Fig.2.7时序测试困难
│   │   │   ├── fig2_08_scan_design_concept.jpg          # 教材Fig.2.8扫描设计概念
│   │   │   ├── fig2_09a_muxed_d_scan_cell.jpg           # 教材Fig.2.9a扫描单元
│   │   │   ├── fig2_09b_muxed_d_scan_cell_waveforms.jpg # 教材Fig.2.9b扫描单元波形
│   │   │   ├── fig2_13_sequential_circuit_example.jpg   # 教材Fig.2.13时序电路示例
│   │   │   ├── fig2_14a_muxed_d_full_scan_circuit.jpg   # 教材Fig.2.14a全扫描电路
│   │   │   ├── fig2_14b_full_scan_test_operations.jpg   # 教材Fig.2.14b扫描测试时序
│   │   │   ├── fig2_23a_gated_clock_original.jpg        # 教材Fig.2.23a门控时钟原电路
│   │   │   ├── fig2_23b_gated_clock_fixed.jpg           # 教材Fig.2.23b门控时钟修复
│   │   │   ├── fig2_26a_async_reset_original.jpg        # 教材Fig.2.26a异步复位原电路
│   │   │   ├── fig2_26b_async_reset_fixed.jpg           # 教材Fig.2.26b异步复位修复
│   │   │   └── fig2_27_scan_design_flow.jpg             # 教材Fig.2.27扫描设计流程
│   │   └── DFT_Scan与Wrapper实验讲解笔记.md # Scan与Wrapper实验讲解笔记
│   └── 技术路线与实验规划/ # 技术路线与实验规划文档
│       ├── 00_项目核心任务.md       # 项目核心任务
│       ├── 01_开源资料与实验.md      # 开源资料与实验
│       └── 02_9.2学习计划与实验方案.md # 9月2日至5日学习与前置实验方案
├── experiments/ # 实验记录与产物
│   └── E05_tiny_core_scan/ # tiny_core 扫描实验
│       ├── build/     # 实验生成物
│       │   ├── e05_sim.vvp            # E05仿真编译产物
│       │   ├── sim_e05.log            # E05仿真日志
│       │   ├── tiny_core_scan.json    # 综合结构 JSON
│       │   ├── tiny_core_scan_synth.v # 综合后 Verilog 网表
│       │   └── yosys.log              # Yosys 综合日志
│       ├── README.md  # E05实验README
│       ├── results.md # E05结果记录
│       ├── scripts/   # 实验脚本
│       │   └── synth.ys # Yosys 综合脚本
│       ├── src/       # E05设计源码目录
│       │   ├── tiny_core_prescan.v # 扫描前 tiny_core 设计
│       │   └── tiny_core_scan.v    # 插入扫描链的 tiny_core
│       ├── tb/        # E05测试平台目录
│       │   └── tiny_core_scan_tb.v # 扫描链测试平台
│       └── waves/     # E05波形目录
│           └── wave.vcd # 扫描实验波形
├── README.md    # FYH个人仓库说明
└── scripts/     # 个人辅助脚本
<!-- file-tree:tree:end -->
```

## 文件树标签词表

<!-- file-tree:tags:begin 由脚本渲染，禁止手改 -->
| 标签 | 说明 |
| --- | --- |
<!-- file-tree:tags:end -->
