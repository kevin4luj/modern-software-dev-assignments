# Week 1 学习计划（Prompting Techniques）

## 你的当前起点
- 进度：`无`
- 环境：已完成仓库克隆、Ollama 安装、模型拉取（`mistral-nemo:12b`、`llama3.1:8b`）
- 状态：对课程整体和 Week 1 内容还不熟悉

## 本周学习目标
1. 了解 Week 1 的 6 种提示词技术各自解决什么问题。
2. 能独立完成 `week1/*.py` 中所有 `TODO`。
3. 至少让每个脚本成功一次（出现 `SUCCESS`）。
4. 能用自己的话说明每种技术的适用场景和局限。

## 本周重点难点
- 难点 1：不知道什么时候该用哪种 prompting 技术。
  - 应对：每学一个技术都写一句“适用场景 + 不适用场景”。
- 难点 2：模型输出不稳定，偶尔失败。
  - 应对：保留失败样例，微调 system prompt 的约束格式（输出格式、步骤、边界条件）。
- 难点 3：RAG / Tool Calling / Reflexion 比较抽象。
  - 应对：先跑通最小可用版本，再迭代 prompt，不先追求“完美答案”。

## 本周学习安排（建议 5 次，每次 60-90 分钟）

### Session 1：建立全局认知 + 跑通第一个任务
- 任务：
  - 阅读 `week1/assignment.md` 和 `week1/k_shot_prompting.py` 的 `TODO`，先明确题目目标。
  - 自行设计 2-4 组 few-shot 示例并完成 `YOUR_SYSTEM_PROMPT`。
  - 运行脚本，若失败先记录失败模式，再迭代 prompt 后重跑。
- 目的：
  - 理解 k-shot 的核心是“用示例约束模型输出行为”，而不只是碰运气跑通。
  - 建立“基于失败样例迭代提示词”的学习习惯。
- 验收标准：
  - 你能用 1 句话说明 k-shot 的作用与适用场景。
  - `python3 week1/k_shot_prompting.py` 出现至少 1 次 `SUCCESS`。
  - 保留至少 1 组失败输出与 1 组成功输出用于对比。
- 学后记录要求（写入 `week1/progress.md`）：
  - 今天写了什么 prompt、改了几轮、每轮改动点是什么。
  - 最大卡点是什么（如输出有多余文本/格式不稳定）。
  - 下一次准备怎么改（1-2 条可执行动作）。

### Session 2：Chain-of-thought + Self-consistency
- 任务：
  - 阅读 `week1/chain_of_thought.py` 与 `week1/self_consistency_prompting.py` 的 `TODO` 和测试逻辑。
  - 分别完成两个脚本的 system prompt，并各跑至少一轮。
  - 对失败样例做一次针对性迭代（如加强最终答案格式约束）。
- 目的：
  - 理解 Chain-of-thought 关注“推理过程清晰度”，Self-consistency 关注“多次采样后的稳定性”。
  - 建立“同一题目用不同 prompting 策略得到不同鲁棒性”的对比意识。
- 验收标准：
  - 两个脚本各至少出现 1 次 `SUCCESS`。
  - 你能用 1-2 句话说明这两种技术在稳定性上的差异。
  - 留存 1 条失败到成功的迭代记录。
- 学后记录要求（写入 `week1/progress.md`）：
  - 分别记录两个脚本的 prompt 版本与修改点。
  - 哪个脚本更容易波动，可能原因是什么。
  - 下次想优先优化哪个脚本、具体怎么改。

### Session 3：Tool Calling（重点）
- 任务：
  - 阅读 `week1/tool_calling.py`，重点看 `extract_tool_call`、`execute_tool_call` 的输入要求。
  - 设计 prompt 约束模型“只输出一个合法 JSON 对象”，并完成 `YOUR_SYSTEM_PROMPT`。
  - 运行脚本，若出现 JSON 解析失败，按失败信息迭代 prompt 再重跑。
- 目的：
  - 理解 Tool Calling 的核心是“结构化输出可被程序可靠执行”。
  - 训练把自然语言要求转成严格接口契约（字段、类型、格式）。
- 验收标准：
  - 脚本成功并正确执行 `output_every_func_return_type`。
  - 至少记录 1 次“输出非合法 JSON”或“字段错误”的失败样例及修正。
  - 你能解释为什么“可解析性”比“文案好看”更重要。
- 学后记录要求（写入 `week1/progress.md`）：
  - 记录最终 JSON 约束规则（例如必须包含 `tool`、`args`）。
  - 记录一次失败输出和对应修复动作。
  - 写出下次复用的“工具调用 prompt 模板”要点。

### Session 4：RAG（重点）
- 任务：
  - 阅读 `week1/rag.py`，完成 `YOUR_SYSTEM_PROMPT` 和 `YOUR_CONTEXT_PROVIDER`。
  - 分别测试“无上下文”与“有上下文（至少包含 `corpus[0]`）”两种情况。
  - 观察输出代码是否覆盖 `REQUIRED_SNIPPETS`，并据此迭代 prompt 或 context 选择。
- 目的：
  - 理解 RAG 的核心是“先检索，再生成”，减少模型臆测。
  - 形成“上下文质量直接决定答案质量”的判断能力。
- 验收标准：
  - 脚本至少出现 1 次 `SUCCESS`。
  - 你能明确说出“有/无上下文”时输出差异（至少 1 条）。
  - 形成一版可解释的 context 选择策略。
- 学后记录要求（写入 `week1/progress.md`）：
  - 记录你最终返回了哪些文档作为 context，为什么。
  - 记录一次缺少关键 snippet 的失败情况。
  - 记录后续如何改进检索选择（而非只改语气词）。

### Session 5：Reflexion + 周总结
- 任务：
  - 阅读 `week1/reflexion.py`，完成 `YOUR_REFLEXION_PROMPT` 与 `your_build_reflexion_context`。
  - 跑一次完整流程，观察“初版失败 -> 反思改进”的变化。
  - 写 Week 1 总结：6 种技术各 1 句“适用任务 + 主要局限”。
- 目的：
  - 理解 Reflexion 的价值在于“利用失败反馈做定向修复”。
  - 把本周零散技巧整理成可迁移的方法论。
- 验收标准：
  - Reflexion 流程至少 1 次 `SUCCESS`，或能清晰定位仍失败的具体原因。
  - 你能复述一次“失败原因 -> 反思提示 -> 改进结果”的链路。
  - 完成 Week 1 总结（覆盖 6 种技术）。
- 学后记录要求（写入 `week1/progress.md`）：
  - 记录初版失败点与反思后改动点。
  - 记录本周你最有把握和最没把握的技术各 1 个。
  - 记录下周（Week 2）开局前要补的 1-2 个知识点。

## 建议执行顺序（文件级）
1. `week1/k_shot_prompting.py`
2. `week1/chain_of_thought.py`
3. `week1/self_consistency_prompting.py`
4. `week1/tool_calling.py`
5. `week1/rag.py`
6. `week1/reflexion.py`

## 每次学习结束后的固定动作
1. 在 `week1/progress.md` 追加一条记录（不要覆盖旧记录）。
2. 至少写清楚：今天做了什么、卡点是什么、下一次要做什么。
3. 若脚本未通过，也要记录失败原因（这比“空记录”更有价值）。
