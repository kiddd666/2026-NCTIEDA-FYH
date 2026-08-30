# FYH Technical Decisions

> FYH 在 Scan Insertion 项目中的长期技术与工作流决策记录。
> 普通 bugfix、格式修改和临时调试不写入本文件；原则上只追加。

## Decision Index

| ID | Date | Decision | Status |
| --- | --- | --- | --- |
| ADR-001 | 2026-08-30 | 统一个人记录位置并使用仓库级本地覆盖规则 | Accepted |
| ADR-002 | 2026-08-30 | 个人进度与决策日志统一使用中文 | Accepted |
| ADR-003 | 2026-08-30 | 将 progress 从操作流水账收敛为阶段状态记录 | Accepted |
| ADR-004 | 2026-08-30 | FYH/docs 沿用团队文档的证据驱动结构风格 | Accepted |
| ADR-005 | 2026-08-30 | 暂停维护 Scan-Insertion 个人仓库 | Accepted |
| ADR-006 | 2026-08-30 | FYH 建立独立 Git 历史与 GitHub 远程 | Accepted |
| ADR-007 | 2026-08-30 | 以 TODO 为待办事实源并用独立看板展示 | Accepted |
| ADR-008 | 2026-08-30 | TODO 聚焦当前活跃任务并采用简洁看板粒度 | Accepted |

## ADR-001 — 统一个人记录位置并使用仓库级本地覆盖规则

**Date**: 2026-08-30  
**Status**: Accepted

### Context

FYH 同时在团队仓库 `D:\research\2026-NCTIEDA-Semitronix` 和个人
`D:\research\Scan-Insertion` 仓库中工作。若只在 `FYH/` 目录下约束记录，
修改团队仓库其他路径时容易漏记；若在团队规则文件中加入个人要求，又会
污染或改变团队共享政策。

### Decision

以团队仓库中的 `FYH/progress.md` 和 `FYH/decisions.md` 作为跨仓库的个人
权威日志；在团队仓库根目录使用本地、未跟踪的 `AGENTS.override.md`，将
“任务完成前更新 progress、必要时更新 decisions”的要求扩展到整个团队仓库。
`FYH/AGENTS.md` 保留详细记录格式，并明确团队 `AGENTS.md` 与 Git 规则优先。

### Alternatives

- 只依赖 `FYH/AGENTS.md`：无法稳定覆盖 `FYH/` 之外的团队仓库工作。
- 修改团队根 `AGENTS.md`：会把个人流程混入共享规则，增加团队协作负担。
- 在两个仓库各维护一套日志：产生重复来源，难以保持一致。

### Rationale

集中日志保持单一事实来源；本地 override 提供工作区范围的提醒，同时通过
Git 忽略规则避免个人偏好进入团队提交。个人仓库现有 `AGENTS.md` 已声明
使用这两个 canonical logs，因此无需复制日志文件。

### Consequences

- 每个有意义任务都必须在结束前向 `progress.md` 追加真实记录。
- 只有影响架构、DFT 规则、工具、接口、Schema、工作流或长期取舍的决定才
  追加 ADR。
- `AGENTS.override.md` 只在本地生效，换机器或清理未跟踪文件后需重新建立。

### Affected Components

- `FYH/AGENTS.md`
- `FYH/progress.md`
- `FYH/decisions.md`
- 团队仓库根 `AGENTS.override.md`
- `.gitignore` 中现有的 `FYH` 与 `AGENTS.override.md` 忽略规则
- `D:\research\Scan-Insertion\AGENTS.md` 的跨仓库记录约定

## ADR-002 — 个人进度与决策日志统一使用中文

**日期**：2026-08-30
**状态**：Accepted

### Context

FYH 的个人工作记录需要长期回顾，并服务于中文团队协作；此前规则没有
明确日志正文的语言。

### Decision

`FYH/progress.md` 与 `FYH/decisions.md` 的说明性文字统一使用中文。文件
路径、命令、Schema 名称、标识符等技术字面量可保留原文，以确保可执行性
和证据引用准确。

### Alternatives

- 不规定语言：后续条目可能中英文混杂，降低检索和回顾一致性。
- 全部翻译技术字面量：可能破坏命令、路径和接口名称的准确性。

### Rationale

中文符合个人与团队的主要工作语境；保留技术字面量可避免记录失真。

### Consequences

- 后续新增日志正文必须使用中文。
- 历史条目不强制回写或翻译。

### Affected Components

- `FYH/AGENTS.md`
- `FYH/progress.md`
- `FYH/decisions.md`
- 团队仓库根 `AGENTS.override.md`

## ADR-003 — 将 progress 从操作流水账收敛为阶段状态记录

**日期**：2026-08-30  
**状态**：Accepted

### Context

原规则要求每个有意义任务都更新 `progress.md`，导致单个文件修改、普通
调试和测试也可能产生记录，降低了日志对项目阶段判断和上下文恢复的价值。

### Decision

`progress.md` 只在阶段性项目状态变化时更新：稳定可用、首次可用能力、重要
实验结论、milestone、重要 blocker 变化、明显技术路线变化、长时间工作后的
checkpoint，或用户明确要求记录。同一目标的多个修改合并为一条；使用“几天后
重新打开项目是否能快速知道做到哪了？”作为最终判断。任务结束时分别判断
是否形成阶段性状态变化，以及是否形成重要长期技术决策。

### Alternatives

- 保持每个有意义任务必记：信息密度低，难以区分项目状态与操作细节。
- 只在 milestone 记录：可能遗漏重要 blocker、首次可用能力或恢复 checkpoint。

### Rationale

阶段状态记录能保留真正影响项目进展的信息，同时覆盖 milestone 之外的关键
转折点，并减少重复和噪声。

### Consequences

- 普通 bugfix、临时调试、测试、refactor 和格式修改默认不写入 `progress.md`。
- 既有历史条目不回溯删除；新规则从本 ADR 起生效。
- `decisions.md` 仍只记录重要、长期技术决策，普通实现选择不记录。

### Affected Components

- `FYH/AGENTS.md`
- `FYH/progress.md`
- `FYH/decisions.md`
- 团队仓库根 `AGENTS.override.md`
- `D:\research\Scan-Insertion\AGENTS.md` 的跨仓库记录段落

## ADR-004 — FYH/docs 沿用团队文档的证据驱动结构风格

**日期**：2026-08-30  
**状态**：Accepted

### Context

团队 `docs/比赛入门文档` 与 `docs/Agent 与系统预研` 已形成稳定的中文技术
文档风格：结论先行、编号层级、元数据、来源区分、结构化表格、流程图和明确
验收标准。FYH 后续需要在独立目录持续产出文档。

### Decision

将上述风格作为 `FYH/docs` 默认约定：中文说明配合 YAML front matter；按真实
阅读顺序组织编号标题；用表格、代码块和 Mermaid 表达结构；区分正式规则、
宣讲/答疑、实验观察、团队建议和待确认事项；结尾提供验证标准、状态或下一步，
并在文末加入 `## 参考资料`（或等价章节）及真实可点击的引用链接。该约定不
覆盖官方或工具生成文件的既定格式；无外部来源时明确声明，不编造链接。

### Alternatives

- 每篇 FYH 文档自由选择格式：短期灵活，但长期检索和协作一致性较差。
- 直接复制某一篇团队文档的固定模板：无法适配实验记录、方案说明等不同文体。

### Rationale

抽取团队文档中跨主题稳定有效的结构原则，同时保留按文档类型裁剪章节的
空间，能兼顾一致性、证据可回查性与实际可读性。

### Consequences

- 新建或大幅修改 `FYH/docs` 文档时默认遵循该风格。
- 每次写文档都要在文末保留来源链接，便于复核和恢复上下文。
- 历史 FYH 文档不因风格约定而强制重写。
- 技术字面量保留原文，避免路径、命令和接口引用失真。

### Affected Components

- `FYH/AGENTS.md`
- `FYH/docs/`（后续文档）
- `FYH/progress.md`
- `FYH/decisions.md`

## ADR-005 — 暂停维护 Scan-Insertion 个人仓库

**日期**：2026-08-30  
**状态**：Accepted

### Context

FYH 同时曾关联团队仓库和 `D:\research\Scan-Insertion` 个人仓库；当前用户
明确表示后者项目不再进行，继续例行检查会扩大任务范围并产生无效维护成本。

### Decision

将 `D:\research\Scan-Insertion` 标记为暂停维护范围。默认不读取、不修改、
不验证该仓库，也不为其新增进度记录；只有用户明确恢复项目或要求引用特定
资料时才重新启用检查。

### Alternatives

- 继续同步维护两个仓库：与当前项目范围不符，增加噪声和维护成本。
- 删除或归档仓库：超出本次请求范围，也可能破坏历史资料。

### Rationale

保留仓库及其历史文件，同时停止无必要的主动操作，既尊重当前项目取舍，也
避免不可逆的删除行为。

### Consequences

- 后续团队仓库任务不再默认检查 Scan-Insertion。
- 若未来恢复，需要用户明确提出，并重新确认其规则和工作范围。

### Affected Components

- `FYH/AGENTS.md`
- `FYH/progress.md`
- `FYH/decisions.md`
- `D:\research\Scan-Insertion`（仅标记为暂停维护，不修改其内容）

## ADR-006 — FYH 建立独立 Git 历史与 GitHub 远程

**日期**：2026-08-30  
**状态**：Accepted

### Context

FYH 物理上位于团队仓库 `D:\research\2026-NCTIEDA-Semitronix\FYH`，但个人
工作需要独立的提交、分支和远程同步边界。父仓库已忽略 `FYH`，仍需把该目录
正式发布到个人 GitHub 仓库。

### Decision

在 `FYH` 内保留独立 `.git`，以 `master` 作为首个远程分支，并将 `origin`
连接到 GitHub 仓库 `https://github.com/kiddd666/2026-NCTIEDA-FYH`；当前因
HTTPS 出站连接不稳定，实际使用 SSH transport
`git@github.com:kiddd666/2026-NCTIEDA-FYH.git`。FYH 的提交和 push 只使用
FYH 仓库根目录执行；父仓库不纳入 FYH 文件。

### Alternatives

- 将 FYH 作为父仓库普通子目录提交：会混合团队与个人历史，边界不清。
- 使用 Git submodule：需要父仓库提交 submodule 指针，增加团队协作耦合，当前无此需求。
- 仅保留本地仓库、不配置远程：无法完成个人跨环境同步与备份。

### Rationale

独立仓库满足个人历史可追溯和 GitHub 备份需求，同时维持父仓库现有忽略规则，
不改变团队仓库的提交模型。

### Consequences

- 后续 FYH 变更需在 FYH 仓库单独提交和 push。
- 需要在发布前分别检查两个仓库的根目录、状态和历史，防止误操作。
- 父仓库不会记录 FYH 的提交；跨仓库关联只能通过路径或文档说明表达。

### Affected Components

- `FYH/.git/`
- `FYH/README.md`
- `FYH/AGENTS.md`
- `FYH/TODO.md`
- 父仓库的 `FYH` 忽略规则（保持不变）

## ADR-007 — 以 TODO 为待办事实源并用独立看板展示

**日期**：2026-08-30
**状态**：Accepted

### Context

个人待办、下一步和阶段进度混在同一份日志中会造成职责重叠；仅靠文字清单也不
便于快速查看当前状态。需要一个明确的待办入口，同时保留 `progress.md` 的阶段
记录用途。

### Decision

以 `TODO.md` 作为个人待办与下一步的唯一事实源，使用 `KANBAN.md` 展示下一步、
进行中、阻塞、待办和已完成状态。`TODO.md` 链接到看板并维护任务 ID、优先级和
验收标准；`progress.md` 不记录具体待办，只记录有意义的阶段状态。

### Alternatives

- 继续把待办写入 `progress.md`：时间线与行动清单混杂，难以判断当前任务。
- 只使用看板：缺少稳定的任务描述、验收标准和可检索文本入口。
- 同时维护两份独立待办清单：容易出现状态和内容漂移。

### Rationale

单一事实源减少同步错误，看板提供快速浏览，阶段日志保留长期项目上下文，三者
职责清晰且适合纯 Markdown/Git 工作流。

### Consequences

- 新增或变更待办必须先修改 `TODO.md`，再同步移动 `KANBAN.md` 卡片。
- 只有阶段性状态变化才追加 `progress.md`，避免频繁记录小改动。
- 任务 ID 成为 TODO 与看板之间的稳定关联键。

### Affected Components

- `TODO.md`
- `KANBAN.md`
- `progress.md`
- `AGENTS.md`

## ADR-008 — TODO 聚焦当前活跃任务并采用简洁看板粒度

**日期**：2026-08-30
**状态**：Accepted

### Context

待办清单如果包含过多步骤和长期规划，会失去“当前正在做什么”的看板作用；同时，
任务完成与里程碑进度并不是一一对应关系。

### Decision

将 `TODO.md` 定义为当前活跃任务看板：只保留少量、简洁、可验收的任务，处理时
及时维护状态。详细拆解放到任务文档；`KANBAN.md` 作为同步的可视化视图。
完成 TODO 项不自动写入 `progress.md`，后者继续只按里程碑记录阶段状态。

### Alternatives

- 在 TODO 中保留完整任务分解：看板噪声高，难以识别当前重点。
- 每完成一项就写 progress：进度日志退化为操作流水账。
- 只维护 KANBAN：缺少稳定的任务文字入口和状态事实源。

### Rationale

简洁任务粒度和及时状态维护能提高日常执行准确性；将任务状态与阶段日志分离，
同时保留行动跟踪和长期项目回顾的价值。

### Consequences

- 新任务先进入 `TODO.md`，并同步到 `KANBAN.md`。
- 复杂任务必须链接到独立说明文档，而不是继续扩展看板条目。
- 进度记录需要单独判断是否达到里程碑。

### Affected Components

- `TODO.md`
- `KANBAN.md`
- `progress.md`
- `AGENTS.md`
