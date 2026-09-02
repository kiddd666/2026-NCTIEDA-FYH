# FYH Progress

> 记录 FYH 在 2026 EDA 精英挑战赛 Scan Insertion 项目中的个人工作进度。
> 由人工与 Codex 共同维护，原则上只追加，不覆盖历史记录。

---


## 工作记录

### 2026-08-31 — 完成 DFT 七层通俗学习笔记网络

**状态变化**

已依据《DFT 与设计知识学习地图及学习大纲》第四章 4.1～4.7，建立七份面向外行的
分层学习笔记，覆盖数字设计、可测性、Internal Scan、时钟与 Lockup、Scan DRC
根因、Wrapper/CTL 交付物以及工具执行与 LEC。每份笔记首行均双链回原大纲对应小节，
正文关键判断附教材、赛题指南或标准/工具官方来源。

**关键文件**

- `docs/DFT与规则知识网络/01_数字设计基础.md`
- `docs/DFT与规则知识网络/02_测试与可测性基础.md`
- `docs/DFT与规则知识网络/03_Internal Scan核心.md`
- `docs/DFT与规则知识网络/04_时钟边沿与Lockup.md`
- `docs/DFT与规则知识网络/05_Scan DRC与门级根因分析.md`
- `docs/DFT与规则知识网络/06_Wrapper Scan、CTL与交付物.md`
- `docs/DFT与规则知识网络/07_工具执行、报告核验与LEC.md`
- `.agents/skills/file-tree/tree.json`

**验证**

- `python .agents/skills/file-tree/scripts/tree_tool.py check` 通过，文件树与磁盘一致。
- 逐份检查 7 个首行双链均能匹配原文 4.1～4.7 标题，内部 Markdown 文件链接无缺失目标。
- 用 HTTP HEAD 验证 IEEE 1800/1500/1450 与 Yosys EQY 官方引用链接均返回 `200`。

**阻塞**

无。

### 2026-08-31 — 切换为 Obsidian Markdown 阅读工作流

**状态变化**

已移除个人仓库中的卡片工具配置、同步脚本、卡片目录和相关教程；TODO、项目文档、
进度与决策记录统一回到普通 Markdown，后续以 Obsidian 作为个人文档阅读入口。

**关键文件**

- `TODO.md`
- `AGENTS.md`
- `README.md`
- `docs/02_周行动任务.md`
- `progress.md`
- `decisions.md`

**验证**

- 已删除额外同步脚本、卡片目录和相关教程。
- 已移除 VS Code 中的额外任务插件及本机对应 Codex skill。
- 已检查 FYH、根目录本地规则和工作区配置，不再包含相关配置或术语。

### 2026-08-30 — 初始化个人工作记录机制

**目标**

建立 Codex 自动维护个人项目进度的机制。

**完成**

- 创建 `FYH/AGENTS.md`
- 创建 `FYH/progress.md`
- 创建 `FYH/decisions.md`

**验证**

- 确认 Codex 可读取个人 AGENTS 规则。
- 后续任务完成时检查是否自动追加进度。

**状态**

Completed

**下一步**

开始具体 DFT / 规则方向开发任务。

---

### 2026-08-30 — 审查并完善个人 Codex 工作记录规则

**目标**

确认团队规则未被覆盖，并让个人记录要求覆盖团队仓库内 `FYH/` 之外的工作。

**完成**

- 检查团队仓库 `AGENTS.md`、个人 `FYH/AGENTS.md`、根目录 override、Git 状态与忽略规则。
- 完善 `FYH/AGENTS.md`：明确根目录本地 override 的作用范围、不可提交要求、跨仓库 canonical logs 与条目模板。
- 完善根目录 `AGENTS.override.md`：声明其未跟踪、仓库级作用范围及两个 canonical logs。
- 将 `FYH/decisions.md` 初始化为 ADR-001，记录集中日志与本地 override 的长期工作流取舍。
- 确认 `D:\research\Scan-Insertion\AGENTS.md` 已引用同一组 canonical logs，无需复制日志。

**修改文件**

- `FYH/AGENTS.md`
- `FYH/progress.md`
- `FYH/decisions.md`
- `AGENTS.override.md`（本地文件）

**验证**

- 已读取并核对团队 `AGENTS.md`，未修改其内容。
- 已用 `git check-ignore` 确认 `FYH/` 与 `AGENTS.override.md` 被忽略，不会进入团队 Git 提交。
- 已检查团队仓库与 `D:\research\Scan-Insertion` 的工作树状态；未触碰 Scan-Insertion 中既有未提交变更。

**当前状态**

个人记录机制已建立并可用于后续任务；本次规则与日志更新已完成。

**阻塞**

无。

**下一步**

开始下一项实际 DFT、规则或工具任务；按本机制在任务结束前追加真实进度。

---

### 2026-08-30 — 核查 Codex 文件链接的默认打开方式

**目标**

确认 Codex 中点击工作区文件链接时，能否设置为默认在 VS Code 而不是 Codex 面板打开。

**完成**

- 查阅了当前可用的 OpenAI/Codex 设置说明入口，并检查本机 Codex 桌面端与 VS Code 扩展的配置项。
- 未发现“文件链接默认使用外部编辑器/VS Code”这一全局设置；现有文件链接行为仍由 Codex 面板处理。
- 整理了可行替代方案：在 VS Code 中使用 Codex 扩展，或通过 `code <文件路径>` 打开文件。

**修改文件**

- `FYH/progress.md`

**验证**

- 检查了 Codex 全局状态中的持久化设置键，未发现外部编辑器或 VS Code 默认打开选项。
- 检查了已安装 OpenAI Codex VS Code 扩展的 `package.json` 配置项，未发现该选项。

**当前状态**

已确认当前版本不提供可配置的全局默认行为。

**阻塞**

无。

**下一步**

如需在 VS Code 中编辑，可直接在 VS Code 使用 Codex 扩展，或让我在回复中提供可复制的 `code` 命令。

---

### 2026-08-30 — 确认个人日志语言约定

**目标**

将 `progress.md` 与 `decisions.md` 的自然语言记录统一为中文。

**完成**

- 在 `FYH/AGENTS.md` 中加入两份日志使用中文记录的强制约定。
- 在根目录 `AGENTS.override.md` 中同步提醒该语言约定。

**修改文件**

- `FYH/AGENTS.md`
- `AGENTS.override.md`（本地文件）
- `FYH/progress.md`

**验证**

- 已检查新增规则明确要求两份日志使用中文，同时允许保留原始路径、命令和技术标识符。

**当前状态**

语言约定已生效。

**阻塞**

无。

**下一步**

后续日志条目使用中文撰写。

---

### 2026-08-30 — 将个人进度记录收敛为阶段状态日志

**状态变化**

个人工作记录机制从“每个有意义任务必记”调整为“仅记录阶段性项目状态变化”，
并在任务结束时分别判断 progress 与 decisions 是否需要更新。

**规则结果**

- 单个文件修改、小 bug、普通调试、测试、refactor 和格式修改默认不再写入
  `progress.md`。
- 稳定可用、首次可用能力、重要实验结论、milestone、重要 blocker 变化、明显
  技术路线变化、恢复 checkpoint 或用户明确要求时，合并追加一条记录。
- `decisions.md` 继续只记录重要、长期技术决策。

**当前状态**

新记录规则已同步至团队仓库根 override 与个人 Scan-Insertion 仓库规则。

**下一步**

后续任务按“几天后重新打开项目，是否能快速知道做到哪了？”判断是否追加记录。

---

### 2026-08-30 — 确立 FYH 文档写作与结构规范

**状态变化**

已阅读团队 `docs/比赛入门文档` 与 `docs/Agent 与系统预研` 的代表性文档，
并将其可复用的结构、证据表达、表格/代码块/Mermaid 使用方式固化为
`FYH/docs` 的默认写作规范。

**当前状态**

后续 `FYH/docs` 文档将默认采用中文正文、元数据 front matter、结论先行、
编号层级、证据来源区分、可执行验证标准、必要图示，并在文末加入真实的引用
链接。

**下一步**

创建或修改 `FYH/docs` 文档时按该规范组织内容，并根据文档类型灵活裁剪章节。

---

### 2026-08-30 — 暂停 Scan-Insertion 个人仓库维护

**状态变化**

根据用户决定，`D:\research\Scan-Insertion` 从当前主动维护范围移出，暂作为
停止维护的个人仓库；后续不再对其进行例行检查或修改。

**当前状态**

当前工作范围仅保留团队仓库及 `FYH` 个人记录机制。只有用户明确恢复
Scan-Insertion 项目或要求引用特定资料时，才重新检查该仓库。

**下一步**

继续处理团队仓库范围内的任务；不主动触碰已暂停的 Scan-Insertion 仓库。

---

### 2026-08-30 — 规划使用 `code -r` 打开文件的快捷方式

**目标**

为重复使用 `code -r "文件路径"` 打开 VS Code 文件提供稳定的命令行方式。

**完成**

- 确认本机已安装并可从 PATH 调用 VS Code CLI：`D:\Microsoft VS Code\bin\code.cmd`。
- 确认当前 PowerShell 配置文件尚未创建，可通过配置函数或别名封装 `code -r`。

**修改文件**

- `FYH/progress.md`

**验证**

- 使用 `Get-Command code` 成功解析到 `code.cmd`。
- 检查 `$PROFILE`，确认配置文件当前不存在。

**当前状态**

已具备配置 PowerShell 快捷命令的前提；尚未写入用户 PowerShell 配置，等待用户选择是否采用该方案。

**阻塞**

无。

**下一步**

在 PowerShell 配置文件中加入 `code -r` 包装函数，并按需补充 Codex 文件链接的外部打开关联。

---

### 2026-08-30 — FYH 独立 GitHub 仓库首次发布

**目标**

将物理嵌套在团队仓库中的 `FYH` 建立为独立个人仓库，并固定个人工作记录机制。

**完成**

- 新增 `README.md`，说明仓库边界、常用检查和四份个人工作文件的职责。
- 完善 `AGENTS.md` 的独立 Git 边界和 TODO 使用规则。
- 完善 `TODO.md`，定义待办状态、优先级、验收证据及与两份日志的分工。
- 配置远程仓库 `https://github.com/kiddd666/2026-NCTIEDA-FYH`，当前使用其
  SSH transport `git@github.com:kiddd666/2026-NCTIEDA-FYH.git`。
- 创建首次提交并 push 到远程 `master` 分支。

**验证**

- FYH 与父仓库的 `git rev-parse --show-toplevel` 指向不同根目录。
- FYH 首次提交仅包含个人仓库文件；父仓库状态未出现 FYH 文件。
- 远程分支与本地首次提交一致。

**当前状态**

FYH 独立仓库已可独立提交、同步和回溯；个人工作机制已在仓库内生效。

**阻塞**

无。

**下一步**

按 `TODO.md` 认领下一项可验收的 DFT / Scan Insertion 工作，并在形成阶段性结果时更新本文件。

---

### 2026-08-31 — 完成 Scan Insertion 项目三层任务规划

**状态变化**

已将赛题指南、官方宣讲/Q&A口径、团队技术路线、架构、分工、DFT 学习资料和个人
路线整合为“总项目任务书—阶段任务目标—周行动任务”三层体系，规划窗口为
2026-08-31 至 2026-11-07。`TODO.md` 已收敛为当前两周的可执行产出任务，不再复制
整段两个月计划。

**关键文件**

- `docs/00_总项目任务书.md`
- `docs/01_阶段任务目标_20260831-20261107.md`
- `docs/02_周行动任务.md`
- `TODO.md`
- `decisions.md`（ADR-012）

**验证**

- 三份文档均包含 YAML front matter、编号章节、职责边界、交付物和 Definition of Done；
- 已覆盖任务一/任务二、Agent 闭环、模块、DFT/规则、工具环境、测试、审计、Docker、风险和最终交付；
- 当前/下一周任务均写明资料/工具、产出、完成标准、优先级和依赖；
- 重新检查官方指南、宣讲整理、Q&A 索引和团队文档，提交形态、路径、API、
  `limitations.md` 等差异已保留为“待确认”。

---

### 2026-08-31 — 形成下周日 Scan Insertion 基础知识清单

**状态变化**

根据个人任务说明，将下周日讲解前必须掌握的内容收敛为一份可执行清单，覆盖数字设计与门级网表、Scan/DFT、时钟域与 Lockup、Wrapper、Dofile 流程、DRC 根因、报告验收、EQY/LEC 和团队协作接口，并为各项内容定义了掌握标准与自测关口。

**关键文件**

- `docs/DFT learning/DFT基础知识清单_下周日讲解.md`

**验证**

- 文档包含 YAML front matter、编号章节、优先级表、自测清单和本地参考资料链接。
- 明确区分通用原理、比赛语义、工具手册待确认项，以及任务一/任务二的网表修改边界。

---

### 2026-09-02 — 完成 Chapter 2 DFT 系统学习笔记

**状态变化**

已完成《VLSI Test Principles and Architectures: Design for Testability》Chapter 2 的中文结构化整理，覆盖可测性分析、SCOAP、Ad Hoc/Structured DFT、扫描单元与扫描架构、扫描规则、扫描设计流程、特殊用途扫描和 RTL DFT，并补充了面向 Scan Insertion 比赛的工程联系、掌握分级与实验建议。

**关键文件**

- `docs/学习笔记/VLSI_Test_Principles_Ch02.md`

**验证**

- 笔记按 Chapter/Section 层级组织，公式使用 Obsidian 可渲染的块公式；
- 已检查行内公式定界符和 Mermaid 图示语法；
- 原始教材 `学习材料/DFT补强/VLSI Test Principles and Architectures - Design for Testability.md` 未修改；
- 文件已通过 file-tree 工具登记。

---

### 2026-09-02 — 建立 FYH 独立文件树

**状态变化**

FYH 已建立独立的文件树维护能力，Agent 可通过 `tree.json` 查询文件职责、通过
`AGENTS.md` 的简版树快速定位目录与文件。

**关键文件**

- `.agents/skills/file-tree/tree.json`
- `.agents/skills/file-tree/scripts/tree_tool.py`
- `AGENTS.md`

**验证**

- 已登记当前 FYH 仓库的目录与文件条目；
- `python .agents/skills/file-tree/scripts/tree_tool.py check --strict` 通过；
- 文件树技能文件位于 FYH 独立仓库，未纳入父项目变更统计。

---

### 2026-09-02 — 同步 FYH 目录重组到文件树

**状态变化**

已将 FYH 最近的目录重组同步到文件树：新增 `docs/DFT与规则学习`、`docs/参考书籍`
和 `docs/技术路线与实验规划` 三个资料区，并移除已不存在的旧路径条目。

**关键文件**

- `.agents/skills/file-tree/tree.json`
- `AGENTS.md`

**验证**

- 文件树已登记当前磁盘上的新目录与文件；
- 已运行 `python .agents/skills/file-tree/scripts/tree_tool.py render`；
- 保留 FYH 工作树中原有的删除、新增和未暂存状态，未操作父仓库。
