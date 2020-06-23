# TDD 测试驱动开发

* 正确软件的开发套路
* 提高软件认知能力的方法
* 敏捷开发中的一项核心实践和技术，也是一种设计方法论
* 原理是在开发功能代码之前，先编写单元测试用例代码，测试代码确定需要编写什么产品代码
    - 分离关注点，一次只戴一顶帽子
    - 只在没有信心的地方写测试代码
    - 红：写一个失败的测试，它是对一个小需求的描述，只需要关心输入输出，这个时候根本不用关心如何实现。
    - 绿：专注在用最快的方式实现当前这个小需求，不用关心其他需求，也不要管代码的质量多么惨不忍睹。
    - 重构：既不用思考需求，也没有实现的压力，只需要找出代码中的坏味道，并用一个手法消除它，让代码变成整洁的代码。
* XP（Extreme Programming）的核心实践
* 优点
    - 降低开发者负担：通过明确的流程，让我们一次只关注一个点，思维负担更小
    - 保护网：TDD 的好处是覆盖完全的单元测试，对产品代码提供了一个保护网，让我们可以轻松地迎接需求变化或改善代码的设计。所以如果你的项目需求稳定，一次性做完，后续没有任何改动的话，能享受到 TDD 的好处就比较少了。
    - 提前澄清需求：先写测试可以帮助我们去思考需求，并提前澄清需求细节，而不是代码写到一半才发现不明确的需求。
    - 快速反馈：有很多人说 TDD 时，我的代码量增加了，所以开发效率降低了。但是，如果没有单元测试，你就要手工测试，你要花很多时间去准备数据，启动应用，跳转界面等，反馈是很慢的。准确说，快速反馈是单元测试的好处
* 三层含义
    - Test-Driven Development，测试驱动开发
    - Task-Driven Development，任务驱动开发，要对问题进行分析并进行任务分解
    - Test-Driven Design，测试保护下的设计改善。TDD 并不能直接提高设计能力，只是给你更多机会和保障去改善设计

## 分类

* UTDD（Unit Test Driven Development）
* ATDD（Acceptance Test Driven Development）
    - BDD（Behavior Driven Development）
    - Consumer-Driven Contracts Development
* 单元测试：可以进行的最低级别的测试。通常是在类内部测试方法。单元测试不直接与其他类交互，而是与模拟交互。这使单元测试变得孤立，并且易于调试和重构
* 集成测试：涉及多个类别。因此，它测试了类之间的集成，即依赖关系。它用于测试数据库是否为我们提供了正确的结果，外部 API 是否为我们提供了正确的数据等。它用于测试实际的类和功能，而不是使用模拟。与运行的单元测试相比，它要慢得多，因为它们与数据库和外部提供程序进行交互
* 功能测试：一种测试整个功能的测试，可能需要很多依赖。通常，将测试路由以获取正确的响应，或者测试与应用程序中某些功能相关的 Controller 方法。它们比集成测试慢，因为它们涉及更多的依赖关系
* 验收测试： 验收测试是最高级别的测试。只关心该功能是否可以通过客户的有利位置工作。测试流程通过网站单击并提交表格，并期望得到正确的结果。为此，我们使用了 Selenium 之类的工具

## 流程

* 需求分析
    - 协作需求梳理：澄清-》验收条件-》测试案例
    - Alice (actor) liked (verb) photo ... (object) on Cynthia's album (target). 从中抽取出四个要素：actor，verb，object，target(optional)，通过这四个要素，我们可以描述一个用户的行为
    - 系统分成几个部分：
        + activity receive and persistence - 当一个行为产生后，外部系统会调用 news feed 来创建 activity；
        + feed generator - 当 activity 创建成功后，它会扩散到所有 subscribers 那里生成 feed；
        + subscription generator - 当 activity 是某种特定 verb 的 activity， 我们维护 object 的 subscription 表（添加/删除）
* 代码设计
    - 定义接口
    - interface review
    - 开发：需要不断地为更加细分的接口设计添加新的测试例
        + 用户级。对于很多项目来说，用户级的接口是 API。这里可能是 rest API，GraphQL，RPC，私有协议等等。
        + app级。注意，这里说的 app 并非指一个单独的应用程序，而是逻辑上的概念。一个系统可以逻辑上分解成若干个内部的 app，它们互相作用，最后构成了这个系统。app 间如何互相调用，非常重要。
        + 模块级。我们只需要关心模块的公共接口。私有接口无所谓。
        + 对系统中不确定的，或者变化大的部分，不要引入过多的 case，而对于系统中确定的，或者接口已经发展稳定地部分，不妨把 TDD 延伸到模块级。
    - 分层
        + 把顶层的，用户级别的接口放在一个目录下，app 级别的按 app 名放在不同的子目录，模块级的按模块名放在不同的子目录，不要混在一起。用户级别的接口应该是最稳定的，添加新接口无妨，但是如果已有的接口要改变，我们需要从中分析原因并吸取经验
            * 是需求分析出了岔子，没有明确完整的需求？
            * 是接口设计阶段考虑的不够周全？
            * 是设计水平不够，导致接口不够对变化开放？
* 先分解任务，分离关注点:开卡、验卡，实现验收测试、
    - 确定测试实例化最关键：保证对业务理解一致
* 列 Example，用实例化需求，澄清需求细节
* 写测试，只关注需求，程序的输入输出，不关心中间过程
* 写实现，不考虑别的需求，用最简单的方式满足当前这个小需求即可,方式：红，绿，重构
    - 写一个测试用例
    - 运行测试
    - 写刚好能让测试通过的实现
    - 运行测试
    - 识别坏味道，用手法修改代码
    - 运行测试
* 重构，用手法消除代码里的坏味道
* 写完，手动测试一下，基本没什么问题，有问题补个用例，修复
* 转测试，小问题，补用例，修复
* 代码整洁且用例齐全

## 原则

* 除非是为了使一个失败的 unit test 通过，否则不允许编写任何产品代码
* 在一个单元测试中，只允许编写刚好能够导致失败的内容（编译错误也算失败）
* 只允许编写刚好能够使一个失败的 unit test 通过的产品代码
* 简单，只测试一个需求
* 符合 Given-When-Then 格式
* 速度快
* 包含断言
* Uncle Bob (Robert Martin)
    - You are not allowed to write any production code unless it is to make a failing unit test pass.不允许编写任何产品代码，除非目的是为了让失败的测试通过
    - You are not allowed to write any more of a unit test than is sufficient to fail; and compilation failures are failures. 不允许编写多于一个的失败测试，编译错误也是失败
    - You are not allowed to write any more production code than is sufficient to pass the one failing unit test.不允许编写多于恰好能让测试通过的产品代码
* 防止过度设计

## Test

* 验收条件细化

## Drive


## 实践

* 掌握测试驱动开发的方法，练好基本功、改进工作方式，提高开发效率
* 测试前移
* 项目：
    - 要求
        + 代码整洁，没有重复代码
        + 有单元测试，单元测试覆盖率100%
        + 10分钟内完成
    - 技能点
        + JUnit单元测试
        + 测试驱动开发
        + IDEA快捷键
    - 能力目标
        + IDE的快捷键操作
        + 用JUnit编写单元测试
        + 编写失败的测试，驱动出产品代码
        + 充分利用代码生成
        + 刻意练习的节奏

## 问题

* 不会合理拆分任务
* 不会写测试
* 不会写刚好的实现
* 不会重构
* 有没有Tasking?
    - 将一个原本的较大的需求，分解成一个个很小的需求,往往是非常容易的。通过这样的方式，可以缩短我们红绿重构的周期，得到快速的反馈
* 有没有选择最简单的Task先做？

## 工具

* Dbunit
* REst-Assusred
* [ SpectoLabs / hoverfly ](https://github.com/SpectoLabs/hoverfly):Lightweight service virtualization/API simulation tool for developers and testers https://hoverfly.io

## 参考

* [极限编程](http://www.extremeprogramming.cn)
* [eXtremeProgramming-cn/xp-gym-training](https://github.com/eXtremeProgramming-cn/xp-gym-training):Free open source training materials for eXtreme Programming practitioners and promoters
* [gigix/dojo-scaffold](https://github.com/gigix/dojo-scaffold):A Java/Gradle scaffold for coding dojos
