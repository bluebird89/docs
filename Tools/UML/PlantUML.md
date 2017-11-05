# PlantUML


## 文档

* [Drawing UML with PlantUML](http://plantuml.com/PlantUML_Language_Reference_Guide.pdf)
* [plantuml使用教程](http://archive.3zso.com/archives/plantuml-quickstart.html)

## 使用 Sublime + PlantUML 高效地画图

用文字表达出图的内容，然后就可以直接生成图片

### 安装

* sublime
* 安装 graphviz `brew install graphviz`
* 安装插件 sublime_diagram_plugin
* Alt + d 来生成 PlantUML 图片

### 不同类型语法
* 时序图 sequence diagram
    - 使用 title 来指定标题
    - '->' 和 '-->' 来指示线条的形式，用 -> , -->, `<-`, `<--` 来绘制参与者（Participants）之 间的消息（Message
    - 在每个时序后面加冒号 : 来添加注释 注释语句:以单引号开始头行，即是一个单行注释。多行注释可以使用"'"表 示注释内容的开始，然后使用"'"来表示注释内容的结束。
    - 使用 note 来显示备注，备注可以指定显示在左边或右边
    - 使用 == xxx == 来分隔时序图
    - 使用 ... 来表示延迟省略号
    - 节点可以给自己发送消息，方法是发送方和接收方使用同一个主体即可
* 用例图 use case diagram  
    - 用例图是指由参与者（Actor）、用例（Use Case）以及它们之间的关系构成的用于描述系统功能的静态视图
    - 百度百科上有简易的入门资料，其中用例之间的关系 (include, extends) 是关键
    - 使用 actor 来定义参与者
    - 使用括号 (xxx) 来表示用例，用例用椭圆形表达
    - 使用不同的线条表达不同的关系。包括参与者与用例的关系，用例与用例的关系
* 流程图 activity diagram 
    - 使用 start 来表示流程开始，使用 stop 来表示流程结束
    - 顺序流程使用冒号和分号 :xxx; 来表示
    - 条件语句使用 if ("condition 1") then (true/yes/false/no) 来表示
    - 条件语句可以嵌套
* 组件图
    - 使用方括号 [xxx] 来表示组件
    - 可以把几个组件合并成一个包，可以使用的关键字为 package, node, folder, frame, cloud, database。不同的关键字图形不一样。
    - 可以在包内部用不同的箭头表达同一个包的组件之间的关系
    - 可以在包内部直接表达到另外一个包内部的组件的交互关系
    - 可以在流程图外部直接表达包之间或包的组件之间的交互关系
* 状态图 state diagram
    - 使用 [*] 来表示状态的起点
    - 使用 state 来定义子状态图
    - 状态图可以嵌套
    - 使用 scale 命令来指定生成的图片的尺寸

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

