
我建议你重点养成下面 9 个习惯：

1. **一次只交给 Codex 一个明确目标。** 不要说“帮我把 DFT 模块做好”，而要说“先阅读 `FYH/...` 和相关接口，实现门级网表中 DFF/clock/reset 的提取，补测试，不修改其他模块”。OpenAI 的实践建议是把任务控制在类似一个工程师大约一小时能完成、或几百行代码量级的范围内。([OpenAI][1])
2. **Prompt 固定写成「目标 + 范围 + 约束 + 验收」。** 你以后甚至可以一直套这个模板：

   > 目标：完成 XXX。
   > 先阅读：XXX、XXX。
   > 允许修改：XXX。
   > 不要修改：XXX。
   > 要求：尽量复用现有实现，不重复造轮子。
   > 验收：运行 XXX 测试并检查结果。
   > 完成后给我修改文件、测试结果，以及 progress/decisions 是否需要更新。
   >

   这其实和 OpenAI 建议“像写 GitHub Issue 一样给 Codex 下任务”是一致的。([OpenAI][1])
3. **复杂任务先让它调查，不要马上写代码。** 比如：

   > 先不要修改任何文件。阅读当前仓库中与 netlist analysis 有关的代码、AGENTS.md 和文档，告诉我现状、调用关系、缺口和推荐修改方案。
   >

   你确认思路后再说：

   > 按方案 B 实现。
   >

   如果你的 Codex 客户端提供 Ask/Code 这类模式，大修改优先先 Ask/规划，再进入实际修改，这也是 OpenAI 推荐的工作方式。([OpenAI][1])
4. **让 Codex“先找已有实现，再新写”。** 这是非常重要的省代码技巧。比如不要直接说“写 JSON parser”，而说：

   > 先搜索仓库是否已有 Yosys JSON、netlist parser、cell classification 相关实现；能复用就复用，确认没有再新建。
   >

   否则 AI 很容易在不同目录造出 `parser.py`、`netlist_parser.py`、`analyze_netlist.py` 三套差不多的东西。
5. **强制验证，不接受“代码看起来没问题”。** 最后的 Definition of Done 应该是：

   > 修改 → 运行测试/命令 → 检查退出码和输出 → 查看 git diff → 再汇报。
   >

   Codex 本身就被设计成可以运行命令验证自己的修改；让它拥有稳定的开发环境、测试命令和启动方式，也会显著降低错误率。([OpenAI][1])
6. **AGENTS.md 不要越写越长。** 你现在正在做 AGENTS 规则，这是对的，但别以后什么都塞进去。OpenAI 的经验很明确：一个巨大的 `AGENTS.md` 会挤占上下文、快速过时，而且“所有事情都重要”等于没有重点；更好的方式是给 Codex 一张“地图”，详细知识放在独立文档里。([OpenAI][2])
   你可以保持：

   ```text
   AGENTS.md
      ↓
   告诉 Codex去哪里找
      ├─ docs/rules/
      ├─ docs/architecture/
      ├─ FYH/progress.md
      ├─ FYH/decisions.md
      └─ tests/
   ```

   而不是把 DFT 教材、比赛规则、Git 规范、所有技术路线全复制进去。
7. **把“解释”和“执行”分开。** 你之前觉得 Codex 回答不如 GPT 网页版，这其实很正常地可以通过分工解决：ChatGPT 更适合你用来“学为什么、讨论方案、分析比赛规则、看实验结果”；Codex 更适合“去仓库里找到文件 → 修改 → 跑命令 → 测试 → 给 diff”。我建议你的典型工作流就是：

   ```text
   GPT：这个问题应该怎么设计？
          ↓
   你确定方案
          ↓
   Codex：在真实仓库中实现
          ↓
   Codex：测试 + diff
          ↓
   GPT：分析结果 / 决定下一步
   ```

   不需要逼 Codex 同时承担老师、架构师、程序员、项目经理四个角色。
8. **经常让它做 review，而不仅是写代码。** 很实用的 Prompt 是：

   > 不修改代码，review 当前 diff。重点检查逻辑错误、重复实现、路径硬编码、异常处理、Windows/Linux兼容性、是否违反 AGENTS.md、测试是否足够。
   >

   或：

   > 假设你是第二名团队成员，对这个实现做 code review，只列真实风险，不为了挑错而挑错。
   >

   这种用法在比赛后期尤其有价值。
9. **对危险操作明确设边界。** Codex 的沙箱、写入目录、网络和审批都是可以限制的；OpenAI 也明确建议把日常开发放在受限边界内，高风险动作单独审核。([OpenAI][3]) 对你的比赛仓库，可以直接长期规定：

   > 不执行 `git push --force`、不删除未知文件、不修改团队公共规则、不覆盖原始实验数据、不修改比赛输入文件；涉及这些操作先停止并说明。
   >

   尤其你们这个 Scan Insertion 赛题本身又强调输入保护、真实日志和可审计流程，这种习惯非常值得现在就建立。

你现在最值得形成的 Codex 使用口诀其实就五步：

**先读 → 再计划 → 小范围改 → 自己验证 → 看 diff。**

以后你给 Codex 下任务，尽量不要只发：

> “帮我实现这个。”

而是发：

> **先阅读相关代码和 AGENTS → 找已有实现 → 给出简短方案 → 在限定范围内实现 → 跑测试 → 检查 diff → 汇报。**

这个改动会明显提升 Codex 的稳定性。

[1]: https://openai.com/business/guides-and-resources/how-openai-uses-codex/?utm_source=chatgpt.com
[2]: https://openai.com/index/harness-engineering/?utm_source=chatgpt.com
[3]: https://openai.com/index/running-codex-safely/?utm_source=chatgpt.com
