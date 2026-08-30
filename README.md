# FYH Personal Workspace

`FYH` 是面向 DFT / Scan Insertion 研究与个人实验记录的独立 Git 仓库。
它在文件系统上位于团队仓库 `D:\research\2026-NCTIEDA-Semitronix\FYH`，但拥有
独立的 `.git`、提交历史、分支和远程仓库：

<https://github.com/kiddd666/2026-NCTIEDA-FYH>

## 仓库边界

- 父级团队仓库：`D:\research\2026-NCTIEDA-Semitronix`
- 本仓库根目录：`D:\research\2026-NCTIEDA-Semitronix\FYH`
- 父仓库已通过 `.gitignore` / `.git/info/exclude` 忽略 `FYH`。
- FYH 的提交和 push 必须在本目录仓库中执行，不会写入团队仓库历史。

## 个人工作机制

| 文件 | 用途 | 更新时机 |
| --- | --- | --- |
| [`AGENTS.md`](AGENTS.md) | 个人协作、Git 边界和记录规则 | 工作机制变化时 |
| [`progress.md`](progress.md) | 阶段性项目状态 | 仅完成有意义的阶段或里程碑 |
| [`decisions.md`](decisions.md) | 影响后续路线的 ADR | 架构、接口、工具或实验设计决策 |
| [`TODO.md`](TODO.md) | 可执行待办清单 | 认领、完成或取消待办时 |
| [`KANBAN.md`](KANBAN.md) | TODO 的状态看板 | 与 TODO 状态变更同步 |

## 常用检查

```powershell
git -C D:\research\2026-NCTIEDA-Semitronix\FYH status
git -C D:\research\2026-NCTIEDA-Semitronix\FYH log --oneline
git -C D:\research\2026-NCTIEDA-Semitronix status
```

提交前分别确认两个命令指向不同的 Git 根目录，并检查父仓库没有出现 FYH 文件。
