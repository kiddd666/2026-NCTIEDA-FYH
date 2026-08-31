# FYH 待办

这里记录当前要做的事。主任务只保留一个清楚的结果，具体做法和文件产出写在子任务里。

## 当前周（2026-08-31～2026-09-06）

- [ ] 把比赛要求整理成一页可查的规则基线
  - [ ] 阅读正式规则、团队路线和现有入门文档。
  - [ ] 把内容分成“正式要求、团队决定、个人建议、待确认”四类。
  - 产出：`docs/DFT learning/00_scan_baseline.md`

- [ ] 建立从任务要求到报告证据的对应表
  - [ ] 为每条要求填写 DFT 含义、设计对象、配置对象和验收断言。
  - [ ] 记录来源等级、证据字段和仍待确认的内容。
  - 产出：`docs/DFT learning/requirement_matrix.md` 与 JSON 草案。

- [ ] 用一个小网表练习门级结构分析
  - [ ] 准备包含端口、触发器、锁存器、时钟、复位、MUX 和门控时钟的 Verilog 示例。
  - [ ] 记录实例、控制信号、时钟域和异步控制。
  - 产出：`docs/DFT learning/design_summary_sample.md` 与字段草案。

- [ ] 写出 Scan 基础规则笔记
  - [ ] 阅读指定 DFT 章节，解释 Scan Cell、shift/capture、Full/Partial Scan 和常见风险。
  - [ ] 区分教材原理、团队判断和需要工具手册确认的内容。
  - 产出：`docs/DFT learning/01_scan_rules_baseline.md`

- [ ] 和 Agent、工具负责人确认字段与复核方式
  - [ ] 准备矩阵字段、证据字段和 3～5 个待确认问题。
  - [ ] 记录谁负责解析、谁负责判定、谁负责复核。
  - 产出：会议结论和更新后的字段草案。

## 下一周（2026-09-07～2026-09-13）

- [ ] 说明双时钟和混合边沿下的链组织方法
  - [ ] 手工画一个双时钟案例，比较不同跨域情形的风险。
  - [ ] 写明 Lockup 的放置位置和报告检查点。
  - 产出：`02_internal_scan_lockup_rules.md` 与案例草图。

- [ ] 整理 Wrapper、CTL、SCANDEF 与 Internal Scan 的关系
  - [ ] 对照 Wrapper Cell、控制信号、Wrapper Chain、CTL 和 SCANDEF 的职责。
  - [ ] 把工具字段标成“已确认”或“待手册确认”。
  - 产出：`03_wrapper_ctl_scandef_rules.md` 与核验表。

- [ ] 建立 DRC 规则卡的空白模板
  - [ ] 按 DFTR1～DFTR17、DFTR-TIE、DFTR-L 建立卡片目录。
  - [ ] 为每张卡预留现象、对象、可能原因、修复限制、验证证据和来源。
  - 产出：`drc_rules/README.md` 与规则卡模板。

- [ ] 给手册术语和报告字段建立索引
  - [ ] 收集 DFT Signal、Internal Scan、Lockup、Wrapper、DRC 和报告字段。
  - [ ] 为每个词条记录出处和后续要写的验收条件。
  - 产出：`manual_taxonomy.md` 与 `report_assertions.md` 草案。

- [ ] 手工演练一次需求分析和验收
  - [ ] 选一条模拟 task spec，写出配置对象、预期报告和失败判据。
  - [ ] 请另一名成员复核每个判断。
  - 产出：一份 `requirement_mapping` 和验收记录。

## 依赖提醒

- Scan Insertion Tool Manual、Public case、实际 Liberty、官方 EQY/LEC 脚本和最新通知到位前，只写通用原理和模板，不猜工具事实。
- 任务字段、资料、产出和完成标准见 [`docs/02_周行动任务.md`](docs/02_%E5%91%A8%E8%A1%8C%E5%8A%A8%E4%BB%BB%E5%8A%A1.md)。

## 参考资料

- [团队角色与近期行动](../docs/比赛入门文档/04-团队角色与近期行动.md)
- [周行动任务](docs/02_%E5%91%A8%E8%A1%8C%E5%8A%A8%E4%BB%BB%E5%8A%A1.md)
