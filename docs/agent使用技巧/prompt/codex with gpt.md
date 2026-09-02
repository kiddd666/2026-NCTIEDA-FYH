
使用 Codex with ChatGPT 分析当前项目。

先让 ChatGPT：

1. 阅读当前项目相关文档和代码
2. 判断当前实现状态
3. 找出最重要的问题
4. 制定下一步实施方案

然后由 Codex：

1. 根据方案修改文件
2. 运行测试
3. 检查结果

最后再次让 ChatGPT Review git diff 和测试结果。
如果 Review 发现问题，继续修改直到通过。





使用 Codex with ChatGPT 完成 Scan Chain 插入模块。

先让 ChatGPT 阅读相关代码并给出实现方案，
Codex 根据方案实施并运行测试，
完成后再让 ChatGPT 检查 git diff 和测试结果。
