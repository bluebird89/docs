# UML Unified Modeling Language 统一建模语言

[TOC]

UML是一种开放的方法，用于说明、可视化、构建和编写一个正在开发的、面向对象的、软件密集系统的制品的开放方法

* 功能模型：从用户角度展示系统的功能，包括用例图
* 对象模型：采用对象，属性，操作，关联等概念展示系统的结构和基础，包括类别图、对象图
* 动态模型：展现系统的内部行为。包括序列图，活动图，状态图
* 结构图分为类图、轮廓图、组件图、组合结构图、对象图、部署图、包图
* 行为图又分活动图、用例图、状态机图和交互图(序列图、时序图、通讯图、交互概览图)

## 时序图 sequence diagram

通过描述对象之间发送消息的时间顺序显示多个对象之间的动态协作

* 使用 title 来指定标题
* '->' 和 '-->' 来指示线条的形式，用 -> , -->, `<-`, `<--` 来绘制参与者（Participants）之 间的消息（Message
* 在每个时序后面加冒号 : 来添加注释 注释语句:以单引号开始头行，即是一个单行注释。多行注释可以使用"'"表 示注释内容的开始，然后使用"'"来表示注释内容的结束。
* 使用 note 来显示备注，备注可以指定显示在左边或右边
* 使用 == xxx == 来分隔时序图
* 使用 ... 来表示延迟省略号
* 节点可以给自己发送消息，方法是发送方和接收方使用同一个主体即可
* ->表示消息传递，-->表示异步消息传递，note [left | right]对消息进行说明

![Alt text](http://g.gravizo.com/g?
  a --> b: how are you;
  note right: greeting;
  a -> a: i am thinking;
  b -> a: fine;)

## 用例图 use case diagram

参与者与用例的交互。下图是饭店的用例图

* 用例图是指由参与者（Actor）、用例（Use Case）以及它们之间的关系构成的用于描述系统功能的静态视图
* 百度百科上有简易的入门资料，其中用例之间的关系 (include, extends) 是关键
* 使用 actor 来定义参与者
* 使用括号 (xxx) 来表示用例，用例用椭圆形表达
* 使用不同的线条表达不同的关系。包括参与者与用例的关系，用例与用例的关系

![Alt text](http://g.gravizo.com/g?
  left to right direction;
  skinparam packageStyle rect;
  actor customer;
  actor chef;
  rectangle restaurant{
  customer -> (eat food); customer -> (pay for food); chef -> (cook food); } ）

## 流程图 activity diagram

描述程序的处理过程

* 使用 start 来表示流程开始，使用 stop 来表示流程结束
* 顺序流程使用冒号和分号 :xxx; 来表示
* 条件语句使用 if ("condition 1") then (true/yes/false/no) 来表示
* 条件语句可以嵌套
* 语法
  - 基本元素由方块和带箭头的线组成
  - 一个方块只代表一个函数或一个代码块，通常是函数，方块中可以写字，可以表达函数是属于哪个类或哪个实例等信息
  - 指向方块的线代表该函数的输入，背离方块的线代表函数的输出
  - 数据流动的时间轴遵守先从左到右，再从上到下的顺序
  - 每一对输入输出（输入在上，输出在下）加一个方块，表达了一次函数调用

![Alt text](http://g.gravizo.com/g?
  (*) --> "buy 10 apples"; if "is there watermelon " then; -->[true] "buy a apple"; -right-> (_); else; ->[false] "Something else"; -->(_); endif; )

## 组件图

表示组件是如何互相组织以构建更大的组件或是软件系统，绘了系统中组件提供的、需要的接口、端口等，以及它们之间的关系。

* 使用方括号 [xxx] 来表示组件
* 可以把几个组件合并成一个包，可以使用的关键字为 package, node, folder, frame, cloud, database。不同的关键字图形不一样
* 可以在包内部用不同的箭头表达同一个包的组件之间的关系
* 可以在包内部直接表达到另外一个包内部的组件的交互关系
* 可以在流程图外部直接表达包之间或包的组件之间的交互关系

![Alt text](http://g.gravizo.com/g?
  HTTP - [web server];
  [web server] - [app server];
  database "mysql" {;
  [database];
  };
  [app server] - [database];)

## 状态图 state diagram

描述一个对象在其生存期间的动态行为

* 使用 [*] 来表示状态的起点
* 使用 state 来定义子状态图
* 状态图可以嵌套
* 使用 scale 命令来指定生成的图片的尺寸

![Alt text](http://g.gravizo.com/g?
  [*] -> ready : start;
  ready -> running : get cpu;
  running -> ready : lost cpu;
  running -down-> block : io, sleep, locked;
  block -up-> ready : io return, sleep over, get lock;
  running -> [*] : complete;)

## 类图（class Diagrams）

* 描述系统中的类，以及各个类之间的关系的静态视图，常用于表示类、接口和它们之间的协作关系
* 实现（Realization）：一种类与接口的关系，表示类是接口所有特征和行为的实现,带三角箭头的虚线，空三角箭头指向接口
  - 类：单元格有3行（类名称、类属性、类方法），抽象类的类名称为斜体
  - 接口：单元格有2行（接口名称、接口方法）
* 泛化（Generalization）:一种继承关系，表示子类继承父类的所有特征和行为
  - 带三角箭头的实线，空三角箭头指向父类
* 依赖（Dependency）:带普通箭头的虚线，普通箭头指向被使用者
  - 一种使用的关系，即一个类的实现需要另一个类的协助
  - 一个类A使用到了另一个类B，而这种使用关系是具有偶然性的、临时性的、非常弱的，表现在代码层面，_/ _*为类B作为参数被类A在某个method中使用__ 例如人和烟草的关系
* 关联（Association）:一种拥有关系，使得一个类知道另一个类的属性和方法
  - 实线+实线箭头,带普通箭头的实线，指向被拥有者
  - 成员变量
  - 强依赖关系，表现在代码层面，**为被关联类B以类属性的形式出现在关联类A中**
  - 聚合（Aggregation）:一种整体与部分的关系。整体与部分之间是可分离，且部分可以离开整体而单独存在，具有各自的生命周期
    + 空菱形+实线+实线箭头
    + 体现的是整体与部分、拥有的关系，即has-a的关系
    + 强的关联关系；关联和聚合在语法上无法区分，必须考察具体的逻辑关系
  - 组合（Composition）
    + 心菱形+实线+实线箭头
    + 一种contains-a的关系，这种关系比聚合更强，也称为强聚合；体现整体与部分间的关系，但此时整体与部分是不可分的，整体的生命周期结束也就意味着部分的生命周期结束
    + 部分不可离开整体单独存在
* 对象图:类图的一个实例，是系统在某个时间点的详细状态的快照
  - 用来表示两个或者多个对象之间在某一时刻之间的关系

```
class Dummy {
  - private field1
  # protected field2
  ~ package method1()
  + public method2()
}
```

![Alt text](http://g.gravizo.com/g?
    Father <|-- Son)

![Alt text](http://g.gravizo.com/g?
    abstract class AbstractList
    interface List
    List <|.. AbstractList)

![Alt text](http://g.gravizo.com/g?
    Human ..> Cigarette)

![Alt text](http://g.gravizo.com/g?
    class Water
    class Human
    Human --> Water)

![Alt text](http://g.gravizo.com/g?
    Company o-- Human)

![Alt text](http://g.gravizo.com/g?
    Human *-- Brain)

## [Graphviz - Graph Visualization Software](http://www.graphviz.org/gallery/)

https://graphviz.gitlab.io/

* install and add  graphviz/bin to environment
* dot --help
* [使用graphviz绘制流程图](http://icodeit.org/2012/01/%E4%BD%BF%E7%94%A8graphviz%E7%BB%98%E5%88%B6%E6%B5%81%E7%A8%8B%E5%9B%BE/)

```sh
sudo apt install graphviz

touch example.npl

# first.dot
digraph first2{
a;
b;
c;
d;
a->b;
b->d;
c->d;
}

dot -Tpng first.dot -o first.png # 用的是dot布局 -T表示格式，即画成png格式，-o表示output
```

## 部署图

* 描述了系统内部的软件如何分布在不同的节点上

## PlantUML

* 使用 Sublime + PlantUML 高效地画图：用文字表达出图的内容，然后就可以直接生成图片
  - sublime
  - 安装 graphviz `brew install graphviz`
  - 安装插件 sublime_diagram_plugin
  - Alt + d 来生成 PlantUML 图片
* vscode:PlantUML、Graphviz Preview
  - 文件格式:.wsd, .pu, .puml, .plantuml, .iuml
  - 预览:Alt+D
  - 导出 F1/ctrl+shift+p; PlantUML:导出当前图表；选择导出格式png；导出即可
* 参考
  - [Drawing UML with PlantUML](http://plantuml.com/PlantUML_Language_Reference_Guide.pdf)
  - [plantuml使用教程](http://archive.3zso.com/archives/plantuml-quickstart.html)

```plantuml
// 时序图
@startuml

title 时序图

== 鉴权阶段 ==

Alice -> Bob: 请求
Bob -> Alice: 应答

== 数据上传 ==

Alice -> Bob: 上传数据
note left: 这是显示在左边的备注

Bob --> Canny: 转交数据
... 不超过 5 秒钟 ...
Canny --> Bob: 状态返回
note right: 这是显示在右边的备注

Bob -> Alice: 状态返回

== 状态显示 ==

Alice -> Alice: 给自己发消息

@enduml

// 用例图

@startuml

left to right direction
actor 消费者
actor 销售员
rectangle 买单 {
消费者 -- (买单)
(买单) .> (付款) : include
(帮助) .> (买单) : extends
(买单) -- 销售员
}

@enduml

// 流程图

@startuml

title 流程图

(*) --> "步骤1处理"
--> "步骤2处理"
if "条件1判断" then
    ->[true] "条件1成立时执行的动作"
    if "分支条件2判断" then
        ->[no] "条件2不成立时执行的动作"
        -> === 中间流程汇总点1 ===
    else
        -->[yes] === 中间流程汇总点1 ===
    endif
    if "分支条件3判断" then
        -->[yes] "分支条件3成立时执行的动作"
        --> "Page.onRender ()" as render
        --> === REDIRECT_CHECK ===
    else
        -->[no] "分支条件3不成立时的动作"
        --> render
    endif
else
    -->[false] === REDIRECT_CHECK ===
endif

if "条件4判断" then
    ->[yes] "条件4成立时执行的动作"
    --> "流程最后结点"
else
endif
--> "流程最后结点"
-->(*)

@enduml

// 新版本的流程图脚本
@startuml

start
:"步骤1处理";
:"步骤2处理";
if ("条件1判断") then (true)
    :条件1成立时执行的动作;
    if ("分支条件2判断") then (no)
        :"条件2不成立时执行的动作";
    else
        if ("条件3判断") then (yes)
            :"条件3成立时的动作";
        else (no)
            :"条件3不成立时的动作";
        endif
    endif
    :"顺序步骤3处理";
endif

if ("条件4判断") then (yes)
:"条件4成立的动作";
else
    if ("条件5判断") then (yes)
        :"条件5成立时的动作";
    else (no)
        :"条件5不成立时的动作";
    endif
endif
stop
@enduml

// 组件图
@startuml

package "组件1" {
    ["组件1.1"] - ["组件1.2"]
    ["组件1.2"] -> ["组件2.1"]
}

node "组件2" {
    ["组件2.1"] - ["组件2.2"]
    ["组件2.2"] --> [负载均衡服务器]
}

cloud {
    [负载均衡服务器] -> [逻辑服务器1]
    [负载均衡服务器] -> [逻辑服务器2]
    [负载均衡服务器] -> [逻辑服务器3]
}

database "MySql" {
    folder "This is my folder" {
        [Folder 3]
    }

    frame "Foo" {
        [Frame 4]
    }
}

[逻辑服务器1] --> [Folder 3]
[逻辑服务器2] --> [Frame 4]
[逻辑服务器3] --> [Frame 4]

@enduml

// 状态图
@startuml

scale 640 width

[*] --> NotShooting

state NotShooting {
    [*] --> Idle
    Idle --> Processing: SignalEvent
    Processing --> Idle: Finish
    Idle --> Configuring : EvConfig
    Configuring --> Idle : EvConfig
}

state Configuring {
    [*] --> NewValueSelection
    NewValueSelection --> NewValuePreview : EvNewValue
    NewValuePreview --> NewValueSelection : EvNewValueRejected
    NewValuePreview --> NewValueSelection : EvNewValueSaved
    state NewValuePreview {
        State1 -> State2
    }
}

@enduml
```

## [staruml](http://staruml.io/)

* 类型
  - 用例图、类图、序列图、状态图、活动图、通信图、构件图、部署图以及复合结构图
* 参考
  - [Docs](https://docs.staruml.io/)

## [ArgoUML]()

## 工具

* [bpmn-io/bpmn-js](https://github.com/bpmn-io/bpmn-js):A BPMN 2.0 rendering toolkit and web modeler. https://bpmn.io/toolkit/bpmn-js/
* [knsv/mermaid](https://github.com/knsv/mermaid):Generation of diagram and flowchart from text in a similar manner as markdown http://knsv.github.io/mermaid/
* Visio
* LucidChart
* Draw.io
* 软件
  - ProcessOn
  - Umlet
  - Lucidchart
  - [diagram](https://webdemo.myscript.com)
* [WebSequenceDiagrams](https://www.websequencediagrams.com/):Create sequence diagrams in seconds.
* [edraw-max](https://www.edrawsoft.com/edraw-max/):All-in-One
  Diagram Software
* [Dia](http://dia-installer.de/) `sudo apt install dia`

## 参考

* [入门UML](http://www.jianshu.com/p/1256e2643923)
* [图说设计模式](http://design-patterns.readthedocs.io/zh_CN/latest/index.html)
* [UML科普文](https://mp.weixin.qq.com/s/vo-44mor5y8Ck1Rs2jMPgw)
