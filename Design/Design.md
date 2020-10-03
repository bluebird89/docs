# Design

* IDEA（International Design Excellence Awards)

## 业务系统设计

* 将合适的功能放到合适的模块中。合理地划分模块也可以做到模块层面的高内聚、低耦合，架构整洁清晰
* 接口设计
* 数据库设计
* 业务模型设计

## Simple Design 简单设计

* 定义
    - 通过测试 - 保证需求要满足 (Unit Test)
    - 表达意图 - 该有的概念要在代码中体现
    - 消除重复 - 尽量消除重复代码
    - 最少程序元素 - 减少类、接口、属性、方法、参数、变量等程序元素
* 覆盖四个维度：需求、易修改性、可理解性、复杂度
* 这四条规则从上到下优先级递减，但是社区里对第二条和第三条的优先级有争议。（Martin Fowler 认为第二条和第三条同等重要）
    - 强调：简单固然好，但不能为了简单，而不去实现和客户约定好的需求。（当然，如果需求不合理，应该在前期通过和客户协商拒绝)
    - 比如，现在有两个类：它们之间有一部分重复代码。为了消除掉这个重复，我们将重复代码提取到一个新的类里。于是两个类变为三个类，增加了一个新的代码元素。这当然让设计变得更复杂了。但这种复杂度产生了更重要的价值（让软件更具备正交性，从而让软件更易于修改），所以，不能为了保持简单，而不去消除这个重复
    - 在简单和表达力之间，应该选择后者
    - 建立在前三条都成立的基础之上，不要为自己猜想出的未来可能性去增加系统的复杂度

## 用户故事 User Story

* 定义
    - A tool for iterative development
    - Represents a unit of work that should be developed
    - Help track that piece of functionality;s lifecycle
    - It is a token for a conversation , a placeholder for a conversation
* 作用
    - 用于需求描述
    - 促进共同理解￼
* Story Card
    - A conversation placeholder, not a detailed requirements document
    - Designs may be needed for a story before it is ready for development
    - Focus on the user,their goals and the value they seek
    - Mock ups are a low-fi sketch that convey story concept and prompt early feedback
    - NARRATIVE: Describes the purpose of a story
    - ACCEPTANCE CRITERIA: describe the requirements to complete a card: Given when That
    - Structure
        + Biz Value
        + Description
        + Hi-fi/low-fi Mockup
        + ACCEPTANCE CRITERIA
* 怎么写
    - 角色:从系统中的角色出发，沿着User Journey梳理用户故事。细分角色，比如一个育儿社区应用，用户可以有爸爸，妈妈，爷爷奶奶等，他们需求和痛点可能是不一样的
    - 格式:`As a ... I want ... So that ...`
        + 原来描述需求时，基本只有中间的功能部分。不提这个功能是为谁做的，需求不明确时，不知道该找谁确认，功能上线后，不知道找谁要反馈。也不提满足了用户的什么价值，做出来也没有用户去用
    - 原则
        + 3C原则
            * Card，用粗笔将 User Story 写到物理卡片上，用粗笔是强迫不能写太多太详细，促进当面沟通
            * Conversation，Dev 会拿着卡去找 BA 和 QA 讨论
            * Confirmation，讨论完要确认验收条件
        + INVEST原则
            * Independent：每个用户故事应该是独立的，不会和其他用户故事产生耦合.如果用户故事存在依赖性那么就会导致用户故事之间存在着不同的优先级，只有被依赖的用户故事完成才能继续开发依赖的用户故事。一般可以通过组合用户故事或者分割用户故事来减少用户故事间的相互依赖性。
            * Negotiable：并不会非常明确的阐述功能，细节应带到开发阶段跟程序员、客户来共同商议
            * Valuable：每一个用户故事的交付都要能够给用户带来用户价值,因此应该站在用户的角度去编写，描述的是一个一个的feature，而非一个一个的task
            * Estimable：故事不能太大，也不要有太大的业务和技术不确定因素，否则就无法评估
            * Small：要小一点，但不是越小越好，短小的故事可以减少划分过程中估算的误差，最好的故事是能够在一个迭代周期之内完成的。如果太大就应该考虑将其拆分为多个粒度更小的用户故事
            * Testable：需要能够进行验收测试，最好能把Test Case提前加进去
                - 对应的验收测试也最好是自动运行的
                - 必须在定义了验收测试通过的标准后才能认为故事划分完毕
    - 准备
        + 开始写共识之前，先完成用户体验地图和人物形象构建是很有用的。从产品草图开始也一样。
        + 做准备时，确保准备好卡片、马克笔、和大面的墙以及排卡片时需要的大桌子
        + 确保产品负责人和团队都参与写故事，对于大型团队，考虑组成小队，并分别专注于用户体验的不同部分
    - 对于API卡，两点建议
        + 从User Story描写的角度，“As a ” 这个User可以是一个Persona，也可以是第三方的系统。比如说“As e-Comm Digital web app, I want to call Customer API to retrieve customer details”.
        + 最适合用GIVEN WHEN THEN的方式来定义AC
            * GIVEN a customer exists
            * WHEN a GET request of Customer API is made
            * THEN Customer Name, Contact Details, Product Details are returned in the response.
* Check
    - Simple to understand
    - Testable
    - Estimable
    - Has Business Value
    - Can be aimed in an iteration (timebox)
    - Understandable by the user
* [如何拆分](https://insights.thoughtworks.cn/product-requirement-analysis/)
* 如何划分优先级
    - ![moscow](../_stataic/moscow.png "Optional title")
    - ![private metrics](../_stataic/private_metrics.png "Optional title")
    - ![story mapping](../_static/story_mapping.png "Optional title")
* 估算:相对估算
    - ![estimation](../_static/estimation.png "Optional title")
* 非功能性需求
    - ![cross functional requirements](../_staic/cross_functional_requirements.png "Optional title")
* 交付管理
    - ![Why just in time](../_staic/story_in_time.png "Optional title")
    - ![story's lifecycle](../_static/lifecycle__of_story.png "Optional title")
    - ![需求层次](../_static/product_level.png "Optional title")
* 什么是好的Story,几个反模式
    - 按照技术架构分层进行拆分，常见的会按照持久层、应用层、展示层进行拆分。这种拆分方式拆出来的用户故事，会明显破坏INVEST中的Valuable的原则，而且各个故事卡由于各方面的原因，如开发进度不统一，无法灵活的集成上线。
    - 拆分时，把复杂的UI交互算在故事卡片中。大部分情况下，比较fancy的UI交互都不是核心的业务功能，这部分功能可以作为用户体验优化的卡片，独立拆出来。
    - 拆分时，过早考虑性能问题。在性能基本达标、不出现大问题的情况下，提升性能很多情况下也属于用户体验的一部分，可以单独拆出来，左右优化卡片。
    - 拆出一些管理类的卡片。比如管理产品，实际上可能包含很多产品相关的操作，如导入、编辑、同步信息、改变状态、上架、下架等，所以应该根据具体的功能，拆分成更为准确和大小合适的故事卡片

![Alt text](../__static/3c.png "Optional title")

## 图书

* 《设计原本》
* 《写给大家看的设计书》：界面设计
* 通用设计法则：交互设计
* 《[精益设计：设计团队如何改善用户体验](https://book.douban.com/subject/24896848/)》
* 《[用户体验草图设计](https://book.douban.com/subject/10542579/)》
* 《[About Face 4: 交互设计精髓](https://book.douban.com/subject/26642302/)》
* 《[移动优先+响应式Web设计](https://book.douban.com/subject/26291332/)》
* 《[交互设计指南](https://book.douban.com/subject/4881989/)》
* 《设计心理学》系列
* 《交互设计之路：让高科技产品回归人性（The Inmates Are Running The Asylum: Why High Tech Products Drive Us Crazy and How to Restore the Sanity）》
* 《简约至上》
* 《用户体验的要素》
* 《人人都是产品经理》
* 可士和式
* 设计中的设计
* 设计师要懂心理学
* 移动交互设计精髓：设计完美的移动用户界面
* 交互设计那些事儿
* 无懈可击的web设计
* 无界面交互
* 非设计人员的设计
* 产品经理手册
* 上瘾：让用户养成使用习惯的四大产品逻辑
* 程序员的思维修炼

## 工具

* [wiredjs/wired-elements](https://github.com/wiredjs/wired-elements):Collection of custom elements that appear hand drawn. Great for wireframes or a fun look. https://wiredjs.com
* [flinto](https://www.flinto.com/):The App Design App
* Drama的便捷三合一功能将设计，动画和原型设计独特地集成到一个熟悉的工具中。不再需要在应用程序之间切换或学习新东西。 通过提供Magic Move，Time Travel，3D图层，驱动程序和Magic Drag等高级功能，Drama真正成为满足您设计需求的一站式解决方案
* [Figma](https://www.figma.com/)

## 参考

* [gztchan/awesome-design](https://github.com/gztchan/awesome-design):Curated design resources
* [空谷札记](https://www.yuque.com/arvinxx/note)
