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
* 第一条，它强调：简单固然好，但不能为了简单，而不去实现和客户约定好的需求。（当然，如果需求不合理，应该在前期通过和客户协商拒绝，或修改。但那是关于需求管理这个话题有关的故事，感兴趣者可以去查阅相关文章和书籍）
* 第二条，比如，现在有两个类：它们之间有一部分重复代码。为了消除掉这个重复，我们将重复代码提取到一个新的类里。于是两个类变为三个类，增加了一个新的代码元素。这当然让设计变得更复杂了。但这种复杂度产生了更重要的价值（让软件更具备正交性，从而让软件更易于修改），所以，不能为了保持简单，而不去消除这个重复
* 第三条也是如此，在简单和表达力之间，应该选择后者
* 第四条，建立在前三条都成立的基础之上，不要为自己猜想出的未来可能性去增加系统的复杂度

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
