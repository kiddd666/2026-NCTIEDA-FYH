# FYH 个人工作看板

> 这是 [`TODO.md`](TODO.md) 的可视化视图；任务 ID、优先级和验收标准以 TODO 为准。

## 状态说明

| 状态 | 含义 |
| --- | --- |
| 待办 | 尚未开始 |
| 下一步 | 默认优先处理的一项，只保留一个 |
| 进行中 | 当前正在处理 |
| 阻塞 | 等待外部输入、资料或工具 |
| 已完成 | 已达到 TODO 中的验收标准 |

## 下一步

| ID | 优先级 | 任务 | 验收标准 |
| --- | --- | --- | --- |
| FYH-001 | P0 | 完成 Scan 基础知识笔记 | 形成 `docs/dft_rules/00_scan_overview.md`，覆盖 scan chain、scan enable、shift/capture 基本概念 |

## 进行中

暂无。

## 阻塞

暂无。

## 待办

| ID | 优先级 | 任务 | 验收标准 |
| --- | --- | --- | --- |
| FYH-002 | P0 | 建立任务要求→配置→报告需求矩阵 | 产出 `requirement_matrix.md` 或 `requirement_matrix.json`，逐条映射配置与报告字段 |
| FYH-003 | P0 | 梳理 DFT Signal 规则 | 明确 clock、reset、scan enable、test mode、scan in/out 的条件、配置和验证 |
| FYH-004 | P0 | 梳理 Internal Scan 规则 | 覆盖 replacement、chain 数/长、clock domain、edge、stitching 验收条件 |
| FYH-005 | P0 | 形成 Lockup 规则 | 说明跨域/跨沿 timing 风险、lockup 条件和检查项 |
| FYH-006 | P0 | 形成 Wrapper Scan 规则 | 明确 wrapper cell、范围、控制信号及与 internal scan 的边界 |
| FYH-007 | P0 | 建立 DRC 分类与诊断规则 | 产出 `drc_rules/`，记录现象、原因、检查对象、修复和复验方式 |
| FYH-008 | P1 | 定义门级网表特征分析规范 | 明确 top、clock、reset、sequential cells、clock domains 等输出字段 |
| FYH-009 | P1 | 建立工具手册检索索引 | 按 DFT Signal、Internal Scan、Wrapper、DRC 分类并记录出处 |
| FYH-010 | P1 | 定义报告验收断言 | 将 chain、clock domain、wrapper 范围和指定输出转为可执行断言 |

## 已完成

暂无。

## 更新规则

1. 在 [`TODO.md`](TODO.md) 修改任务状态、描述或验收标准。
2. 将任务卡片在本文件对应状态栏移动；保持相同 ID。
3. 阶段完成才更新 `progress.md`；长期技术取舍才追加 `decisions.md`。
