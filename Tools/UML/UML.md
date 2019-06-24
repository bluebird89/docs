# UML

[TOC]

UML是一种开放的方法，用于说明、可视化、构建和编写一个正在开发的、面向对象的、软件密集系统的制品的开放方法。

- 功能模型：从用户的角度展示系统的功能，包括用例图。
- 对象模型：采用对象，属性，操作，关联等概念展示系统的结构和基础，包括类别图、对象图。
- 动态模型：展现系统的内部行为。包括序列图，活动图，状态图。

* 时序图:通过描述对象之间发送消息的时间顺序显示多个对象之间的动态协作。 ->表示消息传递，-->表示异步消息传递，note [left | right]对消息进行说明。

![Alt text](http://g.gravizo.com/g?
  a --> b: how are you;
  note right: greeting;
  a -> a: i am thinking;
  b -> a: fine;)

* 用例图:参与者与用例的交互。下图是饭店的用例图

![Alt text](http://g.gravizo.com/g?
  left to right direction;
  skinparam packageStyle rect;
  actor customer;
  actor chef;
  rectangle restaurant{
  customer -> (eat food); customer -> (pay for food); chef -> (cook food); } ）

* 活动图:当流程图来用，描述程序的处理过程。下图描述的是一个经典的程序员笑话。

![Alt text](http://g.gravizo.com/g?
  (*) --> "buy 10 apples"; if "is there watermelon " then; -->[true] "buy a apple"; -right-> (_); else; ->[false] "Something else"; -->(_); endif; )

* 组件图:表示组件是如何互相组织以构建更大的组件或是软件系统。下图是Web项目的组件图。

![Alt text](http://g.gravizo.com/g?
  HTTP - [web server];
  [web server] - [app server];
  database "mysql" {;
  [database];
  };
  [app server] - [database];)

* 状态图:描述一个对象在其生存期间的动态行为。

![Alt text](http://g.gravizo.com/g?
  [*] -> ready : start;
  ready -> running : get cpu;
  running -> ready : lost cpu;
  running -down-> block : io, sleep, locked;
  block -up-> ready : io return, sleep over, get lock;
  running -> [*] : complete;)

类图：用来描述类与类之间的关系

访问权限控制

```
class Dummy {
  - private field1
  # protected field2
  ~ package method1()
  + public method2()
}
```

类与类之间的关系

继承

![Alt text](http://g.gravizo.com/g?
    Father <|-- Son)

实现

![Alt text](http://g.gravizo.com/g?
    abstract class AbstractList
    interface List
    List <|.. AbstractList)

依赖:一个类A使用到了另一个类B，而这种使用关系是具有偶然性的、临时性的、非常弱的，表现在代码层面，_/ _*为类B作为参数被类A在某个method中使用__ 例如人和烟草的关系。

![Alt text](http://g.gravizo.com/g?
    Human ..> Cigarette)

关联:强依赖关系，表现在代码层面，**为被关联类B以类属性的形式出现在关联类A中**

![Alt text](http://g.gravizo.com/g?
    class Water
    class Human
    Human --> Water)

聚合：关联关系的一种特例，他体现的是整体与部分、拥有的关系，即has-a的关系，此时整体与部分之间是可分离的，他们可以具有各自的生命周期。

![Alt text](http://g.gravizo.com/g?
    Company o-- Human)

组合：关联关系的一种特例，他体现的是一种contains-a的关系，这种关系比聚合更强，也称为强聚合；他同样体现整体与部分间的关系，但此时整体与部分是不可分的，整体的生命周期结束也就意味着部分的生命周期结束。

![Alt text](http://g.gravizo.com/g?
    Human *-- Brain)

## [Graphviz - Graph Visualization Software](http://www.graphviz.org/gallery/)

https://graphviz.gitlab.io/

* install and add  graphviz/bin to environment
* dot --help

```sh
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

* [使用graphviz绘制流程图](http://icodeit.org/2012/01/%E4%BD%BF%E7%94%A8graphviz%E7%BB%98%E5%88%B6%E6%B5%81%E7%A8%8B%E5%9B%BE/)

## 软件

- ProcessOn
- Umlet
- ArgoUML
- PlantUML
- [staruml](https://sourceforge.net/projects/staruml/)
- Lucidchart
- 

## 参考

- [入门UML](http://www.jianshu.com/p/1256e2643923)
- [图说设计模式](http://design-patterns.readthedocs.io/zh_CN/latest/index.html)

## 工具

* [bpmn-io/bpmn-js](https://github.com/bpmn-io/bpmn-js):A BPMN 2.0 rendering toolkit and web modeler. https://bpmn.io/toolkit/bpmn-js/
* [knsv/mermaid](https://github.com/knsv/mermaid):Generation of diagram and flowchart from text in a similar manner as markdown http://knsv.github.io/mermaid/
* Draw.io
