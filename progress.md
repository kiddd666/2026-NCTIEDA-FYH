
# FYH Progress

> 记录 FYH 在 2026 EDA 精英挑战赛 Scan Insertion 项目中的个人工作进度。
> 由人工与 Codex 共同维护，原则上只追加，不覆盖历史记录。

---

## 2026-08-30

### 当前状态

- 当前主责：
- 当前阶段：
- 正在进行：
- 下一步：

---

## 工作记录

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

### 2026-08-30 — 建立 TODO 与看板工作入口

**状态变化**

已将个人待办与下一步集中到 `TODO.md`，并新增 `KANBAN.md` 作为可视化看板；
`TODO.md` 顶部可直接打开看板。`progress.md` 继续只记录阶段性状态，不再承担
待办清单职责。

**验证**

- `TODO.md` 已包含唯一“下一步”入口、任务 ID、优先级和验收标准。
- `KANBAN.md` 已按状态提供下一步、进行中、阻塞、待办和已完成栏目。
- 两个文件均使用相对链接，可在仓库内直接跳转。

**当前状态**

个人任务入口和阶段进度记录已分离，后续可通过看板快速识别当前工作状态。

**下一阶段方向**

继续围绕 DFT / Scan Insertion 规则结构化推进，并在形成阶段性结果时更新本文件。

---

### 2026-08-30 — Kanban Markdown 看板首次可用

**状态变化**

VS Code 的 Kanban Markdown 扩展已完成团队根工作区配置，个人看板目录
`FYH/.devtool/features/` 已建立；配套 `kanban-markdown` Codex skill 已安装，
并新增中文使用教程。

**关键产物**

- 团队根 `.vscode/settings.json`：设置个人看板目录、默认状态/优先级和 Codex AI Agent。
- `docs/agent使用技巧/kanban-markdown看板使用教程.md`：记录打开、建卡、拖拽、
  文件格式、Codex 协作和故障检查方法。

**验证**

- `code --list-extensions` 检出 `lachyfs.kanban-markdown`。
- 团队根 `.vscode/settings.json` 已通过 JSON 解析校验。
- 教程包含 front matter、结构化章节和文末引用链接。

**当前状态**

团队根工作区下的 FYH 看板入口已具备首次使用条件；实际卡片可按后续 TODO 需要逐步创建。

**下一步**

在 VS Code 以团队仓库为工作区根目录执行 `Open Kanban Board`，创建并维护第一批
个人任务卡片。

---

### 2026-08-31 — 校正 Kanban 工作区与个人目录边界

**状态变化**

已明确 VS Code 工作区根目录为团队仓库 `D:\research\2026-NCTIEDA-Semitronix`，
FYH 为其中的个人目录；Kanban 配置已移动到团队根 `.vscode/settings.json`，
卡片数据保持在 `FYH/.devtool/features/`。

**关键修正**

- `kanban-markdown.featuresDirectory` 改为 `FYH/.devtool/features`。
- 在本地 `.git/info/exclude` 忽略 `.vscode/settings.json`，避免个人配置进入团队提交。
- 教程与 ADR-009 已同步新的工作区路径。

**验证**

- 根工作区设置 JSON 解析通过。
- 已确认 FYH 内不再保留旧的 `.vscode/settings.json`。
