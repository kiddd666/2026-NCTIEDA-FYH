我建议你以后把 Prompt 固定成这 7 个部分：

> **背景 → 目标 → 依据 → 范围 → 输出格式 → 质量要求 → 验收标准**

很多“不满意”其实不是 Codex 能力问题，而是你只告诉了它“做什么”，没有告诉它**“什么样才算做好”**。

## 一、你最适合用的万能 Prompt 模板

以后给 Codex 下任务，可以直接套：

```text
背景：
这是 XXX 项目，目前处于 XXX 阶段。
相关上下文请先阅读：
- xxx
- xxx
- xxx

任务：
我要你完成 XXX。

范围：
允许修改：
- xxx

不要修改：
- xxx

工作方式：
1. 先阅读现有代码/文档，不要直接开始写。
2. 先确认仓库中是否已有类似实现，优先复用。
3. 理解现状后再进行修改。
4. 不要为了“更完整”擅自扩大任务范围。

输出要求：
完成后告诉我：
1. 做了什么；
2. 修改了哪些文件；
3. 为什么这么做；
4. 如何验证；
5. 是否存在遗留问题；
6. 下一步建议；
7. 是否需要更新 progress.md / decisions.md。

质量要求：
- 不要泛泛而谈；
- 不要重复我已经知道的背景；
- 所有结论尽量基于当前仓库真实内容；
- 不确定的地方明确标记，不要猜；
- 优先给具体文件、函数、命令、路径和验证方法；
- 内容保持结构清晰、简洁但完整。

验收标准：
XXX 能够成功运行；
XXX 测试通过；
XXX 输出符合预期。
```

这套模板适合**写代码、分析仓库、做实验、修 Bug**。

---

# 二、如果是“生成文档”，Prompt 要多写 4 个东西

文档类任务最容易出现：

* 看起来很多，但没有重点；
* 像 AI 写的；
* 重复背景；
* 缺乏工程细节；
* 你想要学习文档，它写成报告；
* 你想要团队文档，它写成教程。

所以一定要告诉它：

**这份文档给谁看、拿来干什么、读完应该能做什么、不要写成什么。**

例如不要只说：

> 帮我写一份网表分析文档。

改成：

```text
请基于当前仓库实际实现，编写一份：

FYH/docs/netlist_analysis.md

这份文档的目的不是介绍“什么是门级网表”，而是让我和队友以后能够快速理解：

1. 当前项目如何分析门级网表；
2. 输入是什么；
3. 数据经过哪些步骤；
4. 当前能够识别哪些对象；
5. 每个模块分别负责什么；
6. 目前有哪些限制；
7. 如何运行和验证；
8. 下一步准备扩展什么。

目标读者：
已经有 Verilog 基础，但不熟悉当前代码的团队成员。

写作风格：
- 偏工程文档，不写成教材；
- 不要大量解释数字电路基础；
- 使用当前仓库真实文件、函数、路径和命令；
- 每个重要概念都尽量关联到实际代码；
- 不要虚构尚未实现的能力；
- “当前实现”和“未来规划”必须分开写。

结构建议：
# Overview
# Input
# Processing Flow
# Core Modules
# Data Structures
# How to Run
# Example
# Current Limitations
# Next Steps

篇幅：
控制在 1500～2500 字。
宁可信息密度高，也不要为了长度重复内容。

完成后再自查一次：
“一个没有参与开发的队友读完后，能否独立运行当前流程并知道代码在哪里？”
如果不能，请继续修改。
```

这里最后那个**自查问题**非常好用。

---

# 三、把“我不喜欢什么”直接告诉 Codex

这个技巧非常有效。

例如你可以长期在自己的规则里写：

```text
When writing technical documents for FYH:

Avoid:
- generic introductory material;
- repetitive summaries;
- excessive background knowledge;
- vague statements such as "this improves efficiency";
- unsupported claims;
- unnecessarily formal or promotional language;
- long sections without actionable information.

Prefer:
- concrete repository paths;
- real commands;
- actual function/module names;
- examples;
- tables when comparing concepts;
- clear distinction between current implementation and future plans;
- explicit assumptions and unresolved questions.
```

这样会比一句：

> “写详细一点”

有效很多。

---

# 四、尤其要少用这几个模糊词

比如：

> 详细分析一下。

Codex 不知道你所谓“详细”是什么意思。

你应该拆成：

```text
分析时至少覆盖：

- 当前实现
- 输入输出
- 调用链
- 数据流
- 关键算法
- 依赖
- 异常情况
- 验证方式
- 当前限制
- 后续扩展点
```

同理：

> 帮我优化。

应该改成：

```text
优化目标按优先级排列：

1. 正确性
2. 可维护性
3. 可测试性
4. 可读性

当前不追求：
- 性能极限
- 大规模重构
- 引入新框架
```

> 写专业一点。

应该改成：

```text
目标风格：
研究生/EDA工程项目内部技术文档。

要求：
- 使用准确的 DFT/EDA 术语；
- 保持工程表达；
- 避免营销语言；
- 避免口语化废话；
- 不要故意使用复杂词汇增加“专业感”。
```

---

# 五、我非常推荐你用“先提纲，再写正文”

如果文档比较重要，不要一次让 Codex 写完。

第一轮：

```text
先不要写正文。

请阅读：
- AGENTS.md
- FYH/xxx
- docs/xxx

我要编写《XXX》。

请先给我：
1. 这份文档应该解决什么问题；
2. 目标读者；
3. 推荐目录结构；
4. 每节应该回答什么问题；
5. 哪些内容当前仓库有证据支持；
6. 哪些内容目前缺少信息。

暂时不要创建文件。
```

你看完以后：

> 第 3、4 节太泛，把第 4 节改成实际数据流，第 6 节增加运行示例。按照修改后的结构正式写入文件。

这种方式生成的文档通常比“一步成文”好很多。

---

# 六、让 Codex 基于“来源”写，不要凭感觉写

这一点对你的项目尤其重要。

例如：

```text
这份文档只能基于：

1. 当前仓库实际代码；
2. docs/xxx.md；
3. 比赛正式赛题文档；
4. 当前测试结果。

如果某个结论无法从这些来源得到支持：

不要用通用知识自动补全，
请写成：

“当前仓库尚未明确”
或
“需要进一步确认”。

不要把规划中的能力写成已经实现的能力。
```

这会显著降低 AI 文档最烦人的问题：

> **“写得很像真的，但实际上项目根本没有。”**

---

# 七、给它一个你满意的“参照物”

这也是非常强的方法。

比如你觉得仓库里某一份文档写得很好：

```text
请阅读：

docs/03-技术路线与系统拆解.md

我比较满意这份文档的：

- 信息密度；
- 分层方式；
- 表格使用方式；
- “当前事实”和“建议方案”的区分方式。

接下来写新的 XXX 文档时沿用这种风格。

注意：
不要复制原文内容，只学习结构和表达方式。
```

相比：

> “写得像专业工程文档一点。”

效果会稳定很多。

---

# 八、不满意时不要说“重新写”，要指出“不满意的维度”

比如 Codex 写完以后，你觉得不好。

不要：

> 重新写一遍，我不满意。

可以这样：

```text
这版先不要推倒重写。

主要有四个问题：

1. 背景介绍过多，占比太高；
2. 没有把说明关联到真实代码；
3. “当前实现”和“未来方案”混在一起；
4. 下一步写得太泛。

请保留已有正确内容，只针对这些问题修改：

- 背景压缩到全文 10% 以内；
- 每个主要模块补充实际文件路径；
- 增加 Current Implementation / Planned Work 的明确区分；
- Next Steps 改成可执行任务，而不是原则性建议。

修改后重新自查一次全文。
```

这种“**定点修稿**”远比重新生成稳定。

---

# 九、你可以建立一个自己的“文档默认规则”

我很推荐你把下面这小段加入 `FYH/AGENTS.md`：

```markdown
## Documentation Preferences

When generating technical documentation for FYH:

1. Identify the purpose and target reader before writing.
2. Prefer repository-grounded facts over generic explanations.
3. Clearly separate:
   - current implementation;
   - verified results;
   - assumptions;
   - future plans.
4. Use real paths, commands, modules, functions, and examples whenever possible.
5. Avoid repetitive background and AI-style filler.
6. Do not claim unimplemented features as completed.
7. Prefer concise, high-information-density writing.
8. For important documents, first inspect existing related docs and preserve project terminology.
9. Use tables for comparisons and checklists for actionable requirements.
10. Before finishing, ask:
   "Could another team member use this document to understand or perform the task without asking the author?"
```

之后你不用每次 Prompt 都重复这些要求。

---

## 你可以直接记住一个公式

以后写 Prompt 时问自己：

**我有没有告诉 Codex：**

> **做什么 + 为什么做 + 看什么 + 改什么 + 不改什么 + 写成什么样 + 怎么才算完成**

如果这 7 件事情都明确，Codex 输出质量通常会稳定很多。

而对于**文档**，再补两项：

> **给谁看 + 读完以后应该能做什么**

例如你以后完全可以只给我一句：

> “我要让 Codex 写 `DFT规则知识库` 文档，帮我生成一个高质量 Prompt。”

我可以直接根据这个仓库和你的目标，给你整理成**可直接粘贴给 Codex 的最终 Prompt**。
