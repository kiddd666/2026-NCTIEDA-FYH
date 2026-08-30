---
type: tool-guide
tags:
  - Kanban
  - VS Code
  - Codex
  - 项目管理
source_type: 官方 Marketplace / 官方仓库 / 本地工作区配置
date: 2026-08-30
status: active
---
# 01. Kanban Markdown 看板使用教程

> **文档定位：**使用 VS Code 的 Kanban Markdown 扩展，把 FYH 的个人待办转换成可拖拽的 Markdown 看板；卡片文件仍由 Git 和 Codex 管理，扩展只提供可视化编辑入口。

## 1. 核心结论

本项目将看板数据放在 FYH 个人仓库的 `FYH/.devtool/features/`，通过团队根工作区设置启用
Codex 的 “Build with AI”。看板列对应卡片 front matter 的 `status`，完成卡片
会自动移动到 `done/` 子目录。

## 2. 已完成的工作区配置

配置文件为团队根目录的 [`.vscode/settings.json`](../../../.vscode/settings.json)，当前设置如下：

| 设置                                  | 值                    | 作用                                    |
| ------------------------------------- | --------------------- | --------------------------------------- |
| `kanban-markdown.featuresDirectory` | `FYH/.devtool/features` | 看板卡片目录（相对于团队工作区根目录） |
| `kanban-markdown.filenamePattern`   | `name-date`         | 新卡片使用“名称-日期”文件名           |
| `kanban-markdown.defaultStatus`     | `backlog`           | 新卡片默认进入 Backlog                  |
| `kanban-markdown.defaultPriority`   | `medium`            | 新卡片默认优先级                        |
| `kanban-markdown.aiAgent`           | `codex`             | “Build with AI” 使用 Codex            |
| `kanban-markdown.showBuildWithAI`   | `true`              | 在卡片上显示 AI 操作入口                |
| `kanban-markdown.showFileName`      | `true`              | 在卡片上显示 Markdown 文件名            |

这些设置是团队工作区中的个人配置，并通过本地 Git exclude 避免进入团队提交。

## 3. 第一次打开看板

### 3.1 以团队仓库作为工作区根目录

在 VS Code 中打开：

```text
D:\research\2026-NCTIEDA-Semitronix
```

不要只打开 `FYH` 子目录；配置文件位于团队仓库根目录，路径
`FYH/.devtool/features` 必须相对于团队工作区解析。

### 3.2 打开看板

1. 按 `Ctrl+Shift+P` 打开 Command Palette；
2. 执行 `Open Kanban Board`；
3. 若扩展显示在 Activity Bar，也可以直接点击 Kanban Markdown 图标；
4. 按 `N` 新建第一张卡片，填写标题、优先级、负责人、截止日期和标签。

## 4. 看板和文件如何对应

默认列为 `Backlog → To Do → In Progress → Review → Done`，对应值分别是：

| 显示列      | `status` 值   | 文件位置                           |
| ----------- | --------------- | ---------------------------------- |
| Backlog     | `backlog`     | `.devtool/features/{id}.md`      |
| To Do       | `todo`        | `.devtool/features/{id}.md`      |
| In Progress | `in-progress` | `.devtool/features/{id}.md`      |
| Review      | `review`      | `.devtool/features/{id}.md`      |
| Done        | `done`        | `.devtool/features/done/{id}.md` |

卡片是普通 Markdown 文件，示例：

```markdown
---
id: "整理-dft-基础笔记-2026-08-30"
status: "todo"
priority: "high"
assignee: null
dueDate: null
created: "2026-08-30T10:00:00.000Z"
modified: "2026-08-30T10:00:00.000Z"
completedAt: null
labels: ["DFT", "学习"]
order: "a0"
---

# 整理 DFT 基础笔记

## 验收标准

- [ ] 术语和规则有来源链接
- [ ] 能回到团队文档的对应章节
```

保持字段顺序、双引号和 `order` 的字符串格式，便于扩展和 Codex skill 稳定解析。
移动到 Done 时，扩展会设置 `completedAt` 并将文件移入 `done/`。

## 5. 推荐的日常工作流

```text
TODO.md 确定目标
  ↓
看板卡片记录目标、优先级和验收标准
  ↓
拖动卡片推进状态（Backlog → To Do → In Progress → Review）
  ↓
Codex 按卡片上下文执行任务并验证
  ↓
通过验收后移动到 Done
  ↓
只有形成阶段性项目状态变化时，才更新 progress.md
```

建议把“要做什么”放在 `TODO.md`，把“当前在哪一列、优先级和验收条件”放在
看板卡片；`progress.md` 仍只记录阶段性项目状态，不作为操作流水账。

## 6. 与 Codex skill 配合

已安装的 `kanban-markdown` skill 负责按规范创建、读取、更新和移动卡片。典型
请求可以写成：

```text
读取 FYH 看板，找出 priority 为 high 且 status 为 todo 的卡片。
完成其中一项后，更新卡片的 status、modified 和验收清单；不要修改其他卡片。
```

Codex 更新卡片时应遵守：

- 不修改 `id` 和 `created`；
- 每次修改更新 `modified`；
- 移入 `done` 时设置 `completedAt` 并移动文件；
- 新卡片的 `order` 读取同列现有卡片后再生成；
- 卡片正文保留 `# 标题`，可加入验收清单、备注和引用。

## 7. 常见问题与检查

### 7.1 看不到卡片

- 确认 VS Code 打开的是 `FYH` 目录，而不是父级团队仓库；
- 确认设置中的 `featuresDirectory` 为 `FYH/.devtool/features`；
- 确认卡片是 `.md` 文件，且 front matter 字段完整；
- 执行 `Developer: Reload Window` 后重新打开看板。

### 7.2 卡片不在预期列

检查 `status` 是否为 `backlog`、`todo`、`in-progress`、`review` 或 `done` 之一，
并确认移动到 Done 的文件位于 `.devtool/features/done/`。

### 7.3 AI 按钮不可用

确认 VS Code 已安装并登录 Codex，且工作区设置包含：

```json
"kanban-markdown.aiAgent": "codex"
```

## 8. 使用验收清单

- [ ] VS Code 打开的根目录是 `D:\research\2026-NCTIEDA-Semitronix`；
- [ ] `Open Kanban Board` 可以打开看板；
- [ ] `N` 可以创建卡片；
- [ ] 拖拽卡片会更新 `status` 和 `order`；
- [ ] Done 卡片会进入 `done/` 并写入 `completedAt`；
- [ ] “Build with AI” 使用 Codex；
- [ ] 卡片正文中的验收标准和引用链接可回查；
- [ ] progress/decisions 仍按 FYH 个人记录规则判断是否更新。

## 参考资料

- [Kanban Markdown — Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=LachyFS.kanban-markdown)
- [Kanban Markdown VS Code Extension — GitHub](https://github.com/LachyFS/kanban-markdown-vscode-extension)
- [kanban-markdown Codex skill — GitHub](https://github.com/LachyFS/kanban-skill)
- [FYH 个人工作规则](../../AGENTS.md)
- [FYH TODO 清单](../../TODO.md)
