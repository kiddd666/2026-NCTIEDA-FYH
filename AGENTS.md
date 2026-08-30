
# FYH Personal Working Rules

`FYH` 是物理上嵌套在团队仓库中的独立个人 Git 仓库，对应远程仓库
[`kiddd666/2026-NCTIEDA-FYH`](https://github.com/kiddd666/2026-NCTIEDA-FYH)。
文件位置上的嵌套不代表 Git 历史、提交或 push 共用。

## 1. Persistent Progress Tracking

`progress.md` is the persistent record of FYH's personal project progress.

```rust
A task does NOT automatically require a progress entry.
Before finishing, evaluate whether the work materially changed the project's persistent state.
If yes, update progress.md; otherwise do not.
```

Update `D:\research\2026-NCTIEDA-Semitronix\FYH\progress.md` only for a
stage-level project state change: a task or subtask reaching stable usable
status, a capability becoming usable for the first time, a concluded important
experiment, a milestone, an important blocker appearing or being resolved, a
clear technical-route change, a recovery checkpoint after extended work, or an
explicit request to record.

Do not record individual file edits, small bug fixes, ordinary debugging,
tests, refactors, or formatting changes. Merge multiple changes serving the
same goal into one progress entry.

Use this test: “几天后重新打开项目，这条信息是否能帮助我快速知道项目做到哪了？”
If not, do not add an entry.

When an entry is warranted, record the date, changed project state, key files,
validation evidence, current status, blockers, and next step. Keep the entry
focused on the resulting state rather than an operation-by-operation log.
`progress.md` 不承担待办清单职责；具体任务、优先级和下一步只维护在
`TODO.md`，进度条目的“下一步”只能概括阶段方向或引用 TODO 编号。完成一个
TODO 项并不自动触发进度记录，只有达到里程碑或形成其他明确的阶段性状态变化时
才追加 `progress.md`。

Prefer appending a new entry instead of rewriting historical entries.

Do not remove previous progress history unless explicitly requested.

All entries in `progress.md` must be written in Chinese. Keep file paths,
commands, identifiers, and other code literals in their original form when
needed for accuracy.

---

## 2. Technical Decision Tracking

`decisions.md` is the persistent record of important project-level technical decisions.

Whenever the task results in an important technical decision, update:

`D:\research\2026-NCTIEDA-Semitronix\FYH\decisions.md`

Examples of important decisions include:

- system architecture
- Agent architecture
- DFT / Scan Insertion rule interpretation
- data schema or interface design
- module boundaries
- tool selection
- workflow design
- file/directory conventions
- report parsing strategy
- netlist analysis strategy
- testing strategy
- important implementation tradeoffs
- decisions that affect other future tasks or team members

Do NOT record trivial implementation details, temporary debugging attempts,
formatting changes, or routine bug fixes unless they have long-term consequences.

Each decision should record:

- date
- decision title
- context / problem
- decision
- alternatives considered, when relevant
- rationale
- consequences / tradeoffs
- affected modules or files

Prefer appending new decisions instead of rewriting history.

All entries in `decisions.md` must be written in Chinese. Keep technical
identifiers, commands, schema names, and file paths in their original form
when needed for accuracy.

---

## 3. Definition of Done

Before finishing a task:

1. Complete the requested work, inspect the resulting diff, and run
   proportionate validation.
2. Decide: **是否形成阶段性状态变化？** 只有“是”才更新 `progress.md`。
3. Decide: **是否形成重要长期技术决策？** 只有“是”才更新 `decisions.md`。
4. In the final response, report what was completed, how it was validated,
   and whether each log was updated or not needed.

Neither log is mandatory for every task; completion depends on the work itself
and on making the two explicit evaluations above.

---

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

## 5. TODO 工作机制

`TODO.md`（Windows 下与用户所称的 `todo.md` 为同一文件）是当前活跃任务看板，
记录少量、可执行且尚未完成的事项，不作为过程日志。

`KANBAN.md` 是 TODO 的看板视图。通过 `TODO.md` 顶部的“打开看板”链接进入；
TODO 是唯一事实源，新增、完成、取消任务时同步调整看板，避免两份清单漂移。

- 每条任务只描述一个清晰结果，保持足够简短；必要时附文件、命令或 issue 链接，
  详细拆解放到对应任务文档，不在看板堆叠步骤。
- 使用 `[ ]` 待开始、`[>]` 进行中、`[x]` 已完成、`[-]` 已取消；按 `P0`–`P2`
  标注优先级，未标注时默认为 `P1`。
- 处理任务时及时更新状态，确保“下一步”“进行中”“阻塞”和“已完成”准确反映当前情况。
  完成项可保留在 TODO 中并附完成日期，但不因此自动追加 `progress.md`。
- 会影响架构、接口、工具、实验设计或长期工作流的取舍，另行追加到
  `decisions.md`，不要用 TODO 代替 ADR。
- 每次开始任务前只认领少量 `[>]` 项；任务结束时清理状态、补验证证据，并保持
  清单能反映下一步可执行工作。

---

## 6. Related Personal Repository (暂停维护)

`D:\research\Scan-Insertion` 当前项目已暂停，不属于 FYH 的主动维护范围。

- 不对该仓库进行例行检查、开发、调试、文档维护或进度记录。
- 不主动读取或修改该仓库的文件，也不把它纳入当前任务的验证范围。
- 只有在用户明确恢复该项目或要求引用其中的特定资料时，才重新检查其
  `AGENTS.md` 和相关文件，并按当时明确的范围执行。

## 7. Logging Entry Templates

Progress entries should use this order: date, task/goal, work completed,
files changed, validation, current status, blockers, and next step.

Decision entries should use ADR fields: Context, Decision, Alternatives,
Rationale, Consequences, and Affected Components. Keep entries append-only
unless correcting an explicit factual error.

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
- 用表格表达模块职责、字段映射、任务对照和来源优先级；用代码块表达
  契约、目录、命令和顺序流程。
- 对三个以上相互依赖的步骤、状态变化、分支或组件关系，优先使用
  Mermaid；图前说明读图目的，图后补充必要文字。
- 明确区分正式规则、宣讲/答疑口径、实验观察、团队建议和待确认事项；
  关键结论提供可回查的链接、文件或证据定位，不把推测写成事实。
- 关注职责边界、输入输出、失败路径、验证判据和可执行的检查清单，避免
  只有口号或泛泛而谈的总结。

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
