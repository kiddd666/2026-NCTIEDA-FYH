# FYH TODO

> 个人待办与下一步的唯一事实源。 [打开看板](KANBAN.md)

## 使用约定

- `[ ]` 待开始，`[>]` 进行中，`[x]` 已完成，`[-]` 已取消。
- 每项只描述一个可验收结果，并标注 `P0`（阻塞/最高优先级）、`P1`（常规）或
  `P2`（有空再做）。
- “下一步”区域只保留一个默认优先动作；开始工作时将对应任务改为 `[>]`。
- 完成或取消时补日期和验证依据；看板 `KANBAN.md` 同步移动任务卡片。
- `progress.md` 不记录待办；只有完成有意义的阶段性任务时，才追加阶段状态。
- 涉及架构、接口、工具、实验设计或长期流程的取舍，追加 ADR 到
  `decisions.md`。

## 下一步

- [ ] P0 FYH-001 完成 Scan 基础知识笔记 — 验收标准：形成可检索的
  `docs/dft_rules/00_scan_overview.md`，覆盖 scan chain、scan enable、shift/capture
  基本概念；来源和待确认项可回查。

## 待办清单

### P0 — 首批核心交付

- [ ] P0 FYH-002 建立任务要求→配置→报告需求矩阵 — 验收标准：产出
  `requirement_matrix.md` 或等价 `requirement_matrix.json`，每条要求都有配置位置和报告验收字段。
- [ ] P0 FYH-003 梳理 DFT Signal 规则 — 验收标准：明确 clock、reset、scan enable、test mode、scan in/out 的适用条件、配置和验证方式。
- [ ] P0 FYH-004 梳理 Internal Scan 规则 — 验收标准：覆盖 scan replacement、chain 数/长、clock domain、edge 和 stitching 验收条件。
- [ ] P0 FYH-005 形成 Lockup 规则 — 验收标准：说明跨时钟域/跨触发沿的 timing 风险、何时需要 lockup 及对应检查项。
- [ ] P0 FYH-006 形成 Wrapper Scan 规则 — 验收标准：说明 wrapper cell、范围、控制信号、wrapper chain 与 internal scan 的边界。
- [ ] P0 FYH-007 建立 DRC 分类与诊断规则 — 验收标准：产出 `drc_rules/`，包含现象、可能原因、检查对象、允许修复和复验方式。

### P1 — 分析与验证能力

- [ ] P1 FYH-008 定义门级网表特征分析规范 — 验收标准：明确 top、clock、reset、sequential cells、clock domains、gated clocks、async controls 等输出字段。
- [ ] P1 FYH-009 建立工具手册检索索引 — 验收标准：按 DFT Signal、Internal Scan、Wrapper、DRC 分类，记录概念、命令、参数、适用条件和出处。
- [ ] P1 FYH-010 定义报告验收断言 — 验收标准：将 chain 数、chain 长、clock domain、wrapper 范围和指定输出转为可执行断言。

## 关联资料

- 任务分工与启动清单：[`docs/DFT learning/任务.md`](docs/DFT%20learning/%E4%BB%BB%E5%8A%A1.md)
- 看板：[`KANBAN.md`](KANBAN.md)
