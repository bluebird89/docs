# 敏捷实施@ThoughtWorks

## 敏捷目的

* 缩短开发周期
* 提高质量
* 提升用户满意度
* 提升团队人员能力
* 增强协作
* 减少工作量，提高产能
* 产品创新
* 改变管理方式，增强成员参与感

## 措施

* 建立敏捷实施工作组
* 领导积极参与敏捷实施工作
* 培养企业内部敏捷教练
* 建立技术内部团队来落地持续集成、自动化测试等交付技术
* 雇佣外部敏捷教练
* 例行敏捷会议
* 组织敏捷相关工作
* 调整运作流程规范
* 新的敏捷角色，Scrum master
* 调整绩效管理制度
* 把敏捷改进设为团队目标
* 建立一系列实践社区
* 改造原有系统架构，更快速响应变化

## 实践

* 小团队敏捷（Scrum）
* 看板
* 用户故事
* 大规模敏捷（SAFs LeSS）
* 特性团队
* 领域建模，可变化设计（UML）
* 结对编程
    - 硬件设置
        + 需要一个大的外接显示器和有一个可以调节高度的桌子（当然也可以用纸箱子DIY一个低配版:直接决定结对能不能作为一个可持续的团队工程实践.
        + 纸和笔永远是你（们）的好朋友，在实际动手写代码之前，请拿出纸笔来将要做的事情划分成更细粒度，可以验证的任务列表，贴在显示器的下边缘。最后，另外记得将手机调成震动模式，利人利己。
    - 软件设置
        + 可以切换到自己熟悉的Keymap：在Intellij/WebStorm里 Ctrl+`来切换各种设置
        + 至少熟悉一个IDE/编辑器，比如通过纯键盘的操作完成
            * 按照名称查文件
            * 按照内容搜索
            * 定位到指定文件的指定行/指定函数
            * 选中变量，表达式，语句等
            * 可以快速执行测试（可以在命令行，也可以在IDE中）
        + 熟常基本Shell技能和常用命令行工具的使用，可以完成诸如
            * 文件搜索
            * 网络访问
            * 正则表达式的应用
            * 查找替换文件中的内容
    - 结对双方会有一个人比较有经验，而另一个人则在某方面需要catchup：需要双方有一个人来做主导，另一个人来观察，并在过程中交互，答疑解惑，共同完成任务。
        + 主导者
            * 千万不要太投入，而无视peer的感受
            * 主导者太热心的coach，而忽视了给新人实际锻炼的机会。这时候需要主导者给peer更多的实践机会：比如在带着新人编写了一个小的TDD循环（红绿重构）之后，可以抑制住自己接着写的冲动
            * 看到peer正在用一个不好的做法来完成任务时，你可以即使让他停下来，并通过问问题的方式来启发他： 还有更好的做法吗？  你觉得XXX会不会更好？
        + 观察者：抓住一切可能的机会来向你的peer学习
            * 快捷键的使用：通过快捷键删除了花括号（block）中的所有代码
            * 命令行工具参数的应用：将curl的返回值以prettify过的样式打印到控制台
            * 良好的编程习惯：通过命令行merge了一个PR
            * 保持你的专注力和好奇心
        + 实践的时候，可以采取Ping-Pong的方式来互换主导者和观察者的角色。比如，A写一个测试，B来写实现，A来重构，然后换B来写测试，A来实现，B来做重构等等
    - 保持专注
        + 需要一起完成任务划分。这样可以确保你们可以永远关注在单一任务上，避免任务切换带来的损耗。
        + 在做完一项任务后，用mark笔轻轻将其从纸上划掉（或者打钩）。
            + 既可以将你们的工作进度很好的表述出来，
            + 在任何时候帮助你们回到正在做的事情上
            + 另外这个微小的具有仪式感的动作是对大脑的一个正向反馈，促进多巴胺的分泌
    - 无法统一的意见
        + 所坚持的只是一个假的“真理”，先前的坚持和做技术选型时的理由就变得很可笑：那只不过是为了使用自己熟悉的技术而编造的理由而已。保持open mind是一件知易行难的事情，希望大家在争辩时能念及这个小例子，可能会少一些无谓的争辩。
        + 难以统一意见的场景，我建议可以将其搁置，先按照某一种提议进行，知道发现明显的，难以为继的缺陷为止。
        + 技术选型时我自然的选了更早项目中使用的scss module，而团队里的另一个同事则提议使用styled-component。我们谁也没有说服谁，最后写代码的时候就有两种风格。直到有一天，我在代码库里看到了用styled-component写的很漂亮的组件，我自己尝试着把相关的scss重写成styled-component，结果发现确实比单独的scss文件要更好维护一些，而且也不影响既有的测试。
    - 棘手的任务
        + 两人分头研究，并严格控制时间。比如Time box 30分钟。不过很可能在30分钟后，你们中至少有一个人已经对要怎么做有了头绪，如果30分钟还没有头绪，则可以求助团队其他成员。
    - 张弛有度
        + 普通人很难全神贯注在某件事情上超过30分钟。这时候一个短暂的break可以让大脑得到很好的休息。
            * 从Todo列表中找出下一个任务
            * 设置一个不可中断的25分钟，开始工作
            * 时间到了之后，休息5分钟
            * 重复2-3，4次之后休息15分钟
    - 结对轮换
        + 需要定期或者不定期的轮转，比如一周轮换一到两次，A和C来写订单，B和D来写门店管理，这样可以保证领域知识，工程实践，工具的使用等等知识都很好的在团队内部共享。
        + 发现让不同角色的团队成员轮换结对所带来的好处（伴随着短期阵痛的）远胜过知识的隔离带来的坏处。团队中的前端开发如果花费一些时间和DevOps一起结对，他会对系统的整个架构更加清楚；而后端开发和DevOps结对则可能让他意识到代码中的潜在缺陷和解决方法
    - 尊重
        + 如果你不愿意和某一特性的人结对，那么首先不要让自己成为那样的人。
        + 尊重还体现在很多其他细节中。当你不得不中断结对而去做其他事情时，务必让你的peer知道。当你的peer回来之后，你需要及时和他catchup，告诉他你正在做什么，已经做到了哪一步等等。快速的将他带入到上下文中。
    - 控制情绪：具有很强的传染性
        + 当你们的工作任务收到各种blocker，被各种其他事情干扰而导致进度难以推进时，一定要注意自己情绪的控制。如果你的peer一直在旁边唉声叹气，或者抱怨连连，你会变得非常沮丧，并且很难集中精力在积极解决问题上。
    - 需要总结一下自己记录的知识点，这是一个绝佳的提升自己能力的方法。通过实战，发现自己的缺点，并通过近距离观察别人如何解决该问题，最终会以很深刻的印象记录下来，这时候针对性的查漏补缺是可以取得非常好的效果。
* 测试驱动开发（TDD）
* 验收驱动开发（ATDD）
* 自动化测试
* 持续发布
* 持续集成
* DevOps(开发运维写作)
* 设计思维
* 前端需求管理的敏捷（需求价值分析、电梯演讲、MVP）
* 敏捷管理工具（JIRA、TFS、RTC、Rally）
* 微服务框架
* 精益创业、黑客营销
* 项目组合的敏捷管理
* 预算与绩效管理的敏捷

## 实践中问题

* 项目定位不稳定，缺乏明确目标
* 需求变化过于频繁
* 需求不合理
* 用户、客户等涉众意见不合
* 需求和工作拆分不详细
* 工作量过载
* 团队成员不想学习新东西
* 流程或运作模式笨重
* 团队之间协作不良、能力不足、异地分布
* 需求实现技术复杂
* 代码或架构不良
* 开发、测试、运维协作不良
* 敏捷开发
* 极限编程
* 快速迭代
* 持续集成
* 精益创业

## 习惯

1、清晰的变量名和方法名
2、能提取成公共组件/方法/类的的绝不复制粘贴
3、拥抱函数式编程，使用声明式编程（因为可读性强）
4、写好方法/函数注释，写出每一个参数的描述和数据类型，对可选参数赋默认值
5、优先使用组合而不是继承
6、使用智能的编辑器，规避语法错误（因为高效）
7、不搞特殊化，坚持规范，不偷懒
8、使用更高层次的抽象，维护更少的状态，尽量提高代码的复用性

1.善于使用逻辑反转，简化代码
2.多使用接口，可以减少工作量，以及开发粗心的后果
3.使用代码format工具
4.写代码多使用注释，以及抱着给别人写代码看的态度
5.要打log,判断运行时间，多做优化

1:注释。如果你能靠变量名说明原由的，你可以不写，不然请写上注释。
2:变量方法命名。一个清晰的命名可以让后面的人知道这是来干什么的。
3:方法行数尽量少，清晰的结构，尽量用获取的方式来赋值变量，那么就不必把获取的代码全揉在一个方法中。
4:六大原则和设计模式：工厂、策略、代理等用起来会让人感觉很爽，再次来修改代码的时候会比较得心应手。
5:适当运动。在努力的同时，请保持一个好身体。

## 经验

* Upgrade early and upgrade often. The closer you are to a new version of Rails, the easier upgrades will be. This encourages your team to fix bugs in Rails instead of monkey-patching the application or reinventing features that exist upstream.
* Keep upgrade infrastructure in place. There will always be a new version to upgrade to, so once you’re on a modern version of Rails add a build to run against the master branch. This will catch bugs in Rails and your application early, make upgrades easier, and increase your upstream contributions.
* Upstream your tooling instead of rolling your own. The more you push upstream to gems or Rails, the less logic you need in your application. Save your application code for what truly makes your company special (i.e. Pull Requests), instead of tools to make your application run smoothly (i.e. concurrent testing libraries)
* Avoid using private API’s in your frameworks. Rails has a lot of code that’s not private but isn’t documented on purpose. That code is subject to change without notice, so writing code that relies on private code can easily break in an upgrade.
* Address technical debt often. It’s easy to think “this is working, why mess with it”, but if no one knows how that code works, it can quickly become a bottleneck for upgrades. Try to prevent coupling your application logic too closely to your framework. Ensure that the line where your application ends and your framework begins is clear. You can do this by addressing technical debt before it becomes difficult to remove.
* Do incremental upgrades. Each minor version of Rails provides the deprecation warnings for the next version. By upgrading from 3.2 to 4.0, 4.0 to 4.1, etc we were able to identify problems in the next version early and define clear milestones.
* Keep up the momentum. Rails upgrades can seem daunting. Create ways in which your team can have quick wins to keep momentum going. Share the responsibility across teams so that everyone is familiar with the new version of the framework and prevent burnout. Once you’re on the newest version add a build to your app that periodically runs your suite against edge Rails so you can catch bugs in your code or your framework early.
* Expect things to break. Upgrades are hard and in an application as large as GitHub things are bound to break. While we didn’t take the site down during the upgrade we had issues with CI, local development, slow queries, and other problems that didn’t show up in our CI builds or click testing.

## 工具

* MyCollab
* Odoo
* OpenProject
* OrangeScrum
* Taiga
* Tuleap
* Jira Software from Atlassian
* VivifyScrum
* Binfire
* VersionOne
* Wrike
*  Zoho Sprints
*  PivotalTracker
*  Assembla
*  Planbox
*  2. Axosoft

## 图书

* 解析极限编程
* 精益思想
* 《持续交付》Jez Humble
* 持续交付2.0：业务引领的DevOps精要 乔梁
