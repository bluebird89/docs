# 设计模式

* 在 1994 年，由 Erich Gamma、Richard Helm、Ralph Johnson 和 John Vlissides 四人合著出版了一本名为 Design Patterns - Elements of Reusable Object-Oriented Software（中文译名：设计模式 - 可复用的面向对象软件元素） 的书，该书首次提到了软件开发中设计模式的概念。四位作者合称 GOF（四人帮，全拼 Gang of Four）。他们所提出的设计模式主要是基于以下的面向对象设计原则
    - 对接口编程而不是对实现编程
    - 优先使用对象组合而不是继承
* 为了重用代码、让代码更容易被他人理解、保证代码可靠性
* 模式是对某情景下，针对某种问题的某种解决方案,而一个设计模式是用来解决一个经常出现的设计问题的经验方法
* 每种模式在现实中都有相应的原理来与之对应，每种模式都描述了一个周围不断重复发生的问题，以及该问题的核心解决方案
* 设计模式（Design pattern）代表了最佳的实践，通常被有经验的面向对象的软件开发人员所采用。设计模式是软件开发人员在软件开发过程中面临的一般问题的解决方案。这些解决方案是众多软件开发人员经过相当长的一段时间的试验和错误总结出来的。
* 应用场景

## 原则

* 高内聚低耦合
    - 内聚：从功能角度来度量模块内的联系，一个好的内聚模块应当恰好做一件事，它描述的是模块内的功能联系
        + 一个模块（类、函数）应该专注于一件事情，提供单一功能，避免编写万用函数、巨类
    - 耦合：软件结构中各模块之间相互连接的一种度量，耦合强弱取决于模块间接口的复杂程度
        + 模块之间应减少依赖、降低耦合度，这样在一个模块发生变化时，才不会引起广泛的连锁反应，从而提高系统的稳定性
    - 设计类的时候要最小化接口数量，把承担内部实现作用的成员函数私有化
    - 模块之间只通过接口通信，接口应尽量稳定，且数量要少，要符合最小知识原则，不要跟陌生人说话，这样做最终目的是为了隔离
* 复用
    - 类继承
        + 扩充基类的功能
        + 改写被复用的基类实现
        + 类继承是在编译时刻被静态确定的，父子类之间是如此紧密的依赖关系，以至于父类的任何变化常导致子类发生变化
    - 对象组合
        + 可以获得被组合对象的引用而在运行时刻动态变化
        + 可以要求对象之间遵守约定接口，而不破坏封装性
    - 组合优先于继承：继承和组合相辅相成，设计者往往过度使用继承，但依赖于对象组合的设计往往有更好的复用性
* 开闭原则：解决扩展性问题，对扩展开放，对修改封闭
* 针对接口编程，而不是针对实现编程
* 关键在于多态，程序可以针对超类型编程，执行时会根据实际状况执行到真正的行为，不会被绑死在超类型的行为上
    - 接口可以理解为一个动作，而动作的具体实现则不用确定
* 单一职责原则(Single Responsibility Principle, SRP)： There should never be more than one reason for a class to change. 言下之意做到类只承担单一职责(最细粒度)也就能尽可能地降低类变更的可能性，不同职责要分开单独定义。其实这一原则不仅仅适用于类，还适用于接口以及方法的设计；
* 开闭原则(Open-Closed Principle, OCP)： Softeware entities like classes,modules and functions should be open for extension but closed for modifications. 一个软件实体如类、模块和函数，应该通过扩展来实现变化，而不是通过修改已有代码来实现变化。比如参数类型、引用对象尽量使用接口或者抽象类，而不是具体实现类；
* 依赖倒转原则(Dependence Inversion Principle, DIP)： High level modules should not depend upon low level modules. Both should depend upon abstractions. Abstractions should not depend upon details. Details should depend upon abstractions. 依赖多出现在方法参数中。高层模块不应该依赖低层模块(具体实现)，以防止一旦低层模块(具体实现)发生变化，将引起高层模块不必要的改变，同时高层模块之上可能有更高层的模块存在，因此两者都应该依赖于抽象。抽象不依赖具体实现细节，而让具体实现细节依赖抽象。抽象不变，具体实现细节改变可以使影响最小化，也就是要针对接口编程。这一条与里氏代换原则结合起来更容易理解，也可以看出这些原则并不应该被孤立地运用于系统设计中，而应该协同配合起来运用；
* 里氏代换原则(Liskov Substitution Principle, LSP)： Functions that use pointers or referrnces to base classes must be able to use objects of derived classes without knowing it. 任何基类可以出现的地方，透明地使用其子类的对象，且必须遵从基类所有规则定义，但反过来说，除了扩展基类，我们又为什么要违背基类规则定义呢？这一条与开关原则结合起来理解就是，基类遵循关原则，子类遵循开原则，子类必须满足LSP才允许继承，否则就断开这种继承关系；
* 接口隔离原则(Interface Segregation Principle, ISP)： Clients should not be forced to depend upon interfaces that they don't use.The dependcy of one class to another one should depend on the smallest possible interface. 使用多个隔离的接口，比使用单个接口要好，也有利于降低类之间的耦合度。类间的依赖关系要建立在最小的接口之上，要防止类必须实现接口中对于自己来说无用的方法情形的出现；
* 迪米特法则(Law of Demeter, LoD)，也称最少知识原则(Least Knowledge Principle, LKP)： Only talk to your immedate friends. 一个模块或子系统应当尽量少地与其他模块或子系统之间发生直接相互作用，可以通过增加“即时朋友”这个中间人来中转通信，只与“朋友”保持联系，与“陌生人”概不谋面，当模块或子系统出现版本升级更新或环境移植之后，只要朋友不变就好;
* 合成/聚合复用原则(Composite/Aggregate ReusePrinciple ，CARP)：该原则要求在设计上尽量使用合成/聚合来达到复用的目的，而不是使用继承，也就是说前者优先于后者而被运用。继承会将基类的细节暴露给子类，也称白箱复用，如果基类发生改变，子类也必须相应做出变动，且多继承不易维护。CARP几乎可用于任何环境，依赖少，但是合成/聚合造成类中多对象需要管理
* 依赖倒置原则(Dependence Inversion Principle) 高层模块不应该依赖低层模块，二者都应该依赖其抽象；抽象不应该依赖细节；细节应该依赖抽象。
    - 下层实现接口；上层依赖借口

```php
/**
* 下列代码只用于表达《设计模式》中的某些设计原则精神。
* 如果是场景中会多次重复创建同一计算器，可以考虑单例模式或静态调用。
*/


/**
*
* Calculation接口对add、sub、mul和div等二元运算类型进行了简单的抽象定义。
*
* 要执行新的计算类型，只需在新的计算器类中实现该接口即可，不必修改任何已有代码。
*
*/
interface Calculation
{
    /**
    * do()方法可扩展到其他二元运算类型
    *
    *
    */
    public function do(float $operand1, float $operand2) : float;
}

/**
* AddCalculator 加法运算器
*/
class AddCalculator implements Calculation
{
    /**
    * 执行加法运算
    */
    public function do(float $operand1, float $operand2) : float
    {
        return $operand1 + $operand2;
    }
}

/**
* SubCalculator 减法运算器
*/
class SubCalculator implements Calculation
{
    /**
    * 执行减法运算
    */
    public function do(float $operand1, float $operand2) : float
    {
        return $operand1 - $operand2;
    }
}

/**
* MulCalculator 乘法运算器
*/
class MulCalculator implements Calculation
{
    /**
    * 执行乘法运算
    */
    public function do(float $operand1, float $operand2) : float
    {
        return $operand1 * $operand2;
    }
}

/**
* DivCalculator 除法运算器
*/
class DivCalculator implements Calculation
{
    /**
    * 执行除法运算
    */
    public function do(float $operand1, float $operand2) : float
    {
        return $operand1 / $operand2;
    }
}


class Calculator
{
    /**
    * 当前计算器
    */
    private $calculator;

    /**
    * 用于保存当前运算结果，可用作下一次运算的 $operand1
    */
    private $result = NULL;

    public function __construct(Calculation $calculator = NULL)
    {
        $this->calculator = $calculator;
    }

    /**
    * 更换当前计算器
    *
    * @return void
    */
    public function renewCalculator(Calculation $calculator)
    {
        $this->calculator = $calculator;
    }

    /**
    * 执行计算
    */
    public function do(float $operand1, float $operand2 = NULL, Calculation $calculator = NULL) : float
    {
        //如果$calculator != NULL，则更换当前计算器
        $this->calculator = $calculator ?? $this->calculator;

        if ($operand2 === NULL) {//启用前一次运算结果
            $operand2 = $operand1;
            $operand1 = $this->result;
        }

        $this->result = $this->calculator->do($operand1, $operand2);
        echo "{$this->result}\n";

        return $this->result;
    }
}

$cal = new Calculator(new AddCalculator());
$cal->do(12, 104.5);//116.5
$cal->do(12);//128.5

$cal->renewCalculator(new SubCalculator());
$cal->do(12);//116.5
$cal->do(104.5);//12
$cal->do(12);//0
$cal->do(12, null, new AddCalculator());//12

$cal->renewCalculator(new MulCalculator());
$cal->do(12, 104.5);//1254
$cal->do(12);//15048

$cal->renewCalculator(new DivCalculator());
$cal->do(12);//1254
$cal->do(12);//104.5
$cal->do(0);//INF. Warning: Division by zero
$cal->do(INF);//NAN
$cal->do('INF');//Fatal error: Uncaught TypeError: Argument 1 passed to Calculator::do() must be of the type float, string given

interface WorkableInterface
{
    public function work();
}
interface SleepableInterface
{
    public function sleep();
}
interface ManageableInterface
{
    public function beManaged();
}
class HumanWorker implements WorkableInterface, SleepableInterface, ManageableInterface
{
    public function work()
    {
        return 'human working.';
    }
    public function sleep()
    {
        return 'human sleeping';
    }
    public function beManaged()
    {
        $this->work();
        $this->sleep();
    }
}

class AndroidWorker implements WorkableInterface, ManageableInterface
{
    public function work()
    {
        return 'android working.';
    }
    public function beManaged()
    {
        $this->work();
    }
}
class Captain
{
    public function manage(ManageableInterface $worker)
    {
        $worker->beManaged();
    }
}
```

## 分类

* 创建型模式：对类的实例化过程的抽象。一些系统在创建对象时，需要动态地决定怎样创建对象，创建哪些对象，以及如何组合和表示这些对象。创建模式描述了怎样构造和封装这些动态的决定。包含类的创建模式和对象的创建模式。
    - Factory 工厂模式
    - Singleton 单例模式
    - Prototype 原型模式
* 结构型模式：描述如何将类或对象结合在一起形成更大的结构。分为类的结构模式和对象的结构模式
    - 类的结构模式使用继承把类，接口等组合在一起，以形成更大的结构。类的结构模式是静态的
    - 对象的结构模式描述怎样把各种不同类型的对象组合在一起，以实现新的功能的方法。对象的结构模式是动态的
    - Adapter 适配器模式
    - Decorator 装饰器模式
    - Proxy 代理模式
* 行为型模式：对在不同的对象之间划分责任和算法的抽象化。不仅仅是关于类和对象的，并是关于他们之间的相互作用
    - 类的行为模式使用继承关系在几个类之间分配行为
    - 对象的行为模式则使用对象的聚合来分配行为
    - Strategy 策略模式
    - Template 模板模式
    - Delegate 委派模式
    - Observer 观察者模式

## Architectural Patterns

* 分层模式
    - 表示层(也称为UI层)
    - 应用层(也称为服务层)
    - 业务逻辑层(也称为领域层)
    - 数据访问层(也称为持久化层)
* 客户端-服务器模式
* 主从设备模式：主设备组件在相同的从设备组件中分配工作，并计算最终结果，这些结果是由从设备返回的结果。
* 管道-过滤器模式：用于构造生成和处理数据流的系统。每个处理步骤都封装在一个过滤器组件内。要处理的数据是通过管道传递的。这些管道可以用于缓冲或用于同步。
* 代理模式：构造具有解耦组件的分布式系统。这些组件可以通过远程服务调用彼此交互。代理组件负责组件之间的通信协调。服务器将其功能(服务和特征)发布给代理。客户端从代理请求服务，然后代理将客户端重定向到其注册中心的适当服务。
    - 消息代理软件，如Apache ActiveMQ，Apache Kafka，RabbitMQ和JBoss Messaging
* 点对点模式：单个组件被称为对等点。对等点可以作为客户端，从其他对等点请求服务，作为服务器，为其他对等点提供服务。对等点可以充当客户端或服务器或两者的角色，并且可以随时间动态地更改其角色。
* 事件总线模式：包括4个主要组件：事件源、事件监听器、通道和事件总线。
    - 消息源将消息发布到事件总线上的特定通道上。
    - 侦听器订阅特定的通道。
    - 侦听器会被通知消息，这些消息被发布到它们之前订阅的一个通道上。
* 模型-视图-控制器模式：将信息的内部表示与信息的呈现方式分离开来
* 黑板模式：所有的组件都可以访问黑板。组件可以生成添加到黑板上的新数据对象。组件在黑板上查找特定类型的数据，并通过与现有知识源的模式匹配来查找这些数据。
    - 黑板——包含来自解决方案空间的对象的结构化全局内存
    - 知识源——专门的模块和它们自己的表示
    - 控制组件——选择、配置和执行模块
* 解释器模式

## 工厂

* 定义一个用于创建对象的接口，让接口子类通过工厂方法决定实例化哪一个类
* 工厂（Factory）负责生产（Create）产品，提供一个工厂抽象基类，该抽象基类提供生产的接口，为每一类图形，提供一个对应的工厂子类，生产对应的产品
    - 抽象工厂定义Create接口，返回Shape指针
    - 具象工厂（CircleFactory等）从抽象工厂派生，实现Create接口，并定义具象工厂的唯一变量，该全局变量的构造函数里，会将形状类型到对应工厂对象的对应关系注册到FactoryManager的map中。
* 一个工厂管理器（FactoryManager），在工厂管理器里维护这个对应关系（map很容易做映射），然后创建该工厂管理器的唯一实例（单例）

## 原型

* 通过给出一个原型对象来指明所要创建的对象的类型，然后用复制这个原型对象的方法创建出更多同类型的对象。原始模型模式允许动态的增加或减少产品类，产品类不需要非得有任何事先确定的等级结构，原始模型模式适用于任何的等级结构。缺点是每一个类都必须配备一个克隆方法
* 基于clone技术，为每个产品（形状）创建一个原型对象
* vs 工厂
    - 原型模式需要产品提供拷贝构造的能力
    - 原型模式不需要定义工厂类继承体现
    - 原型模式需要定义产品原型实例，而工厂模式需要定义各种工厂实例

## 单例 Singleton

* 一个类Class只有一个实例存在。并提供全局访问。Singleton限制了实例个数，有利于GC的回收。
* 需要解决限制该类型创建多个实例，一般通过私有化构造函数，禁拷贝构造的方式完成。
* 在多线程环境下，要解决并发创建的问题
    - 可以在进程启动，还没有创建其他线程的时候，把单例都创建出来
    - 可以通过多线程同步机制，确保只有一个实例被创建，这会引起一些额外的性能开销
* 在复杂的软件环境下，如果有大量不同类型的单件，要处理好，他们之间的构造顺序问题。

## 策略模式

针对一组算法，将每一个算法封装到具有共同接口的独立的类中，从而使得它们可以相互替换。策略模式使得算法可以在不影响到客户端的情况下发生变化。策略模式把行为和环境分开。环境类负责维持和查询行为类，各种算法在具体的策略类中提供。由于算法和环境独立开来，算法的增减，修改都不会影响到环境和客户端。

## 结构型

* 结构型（structural）：处理类或对象间的组合
    - 可以在不破坏类封装性的基础上，实现新的功能
    - 可以创建一组类的统一访问接口
    - 可以在不破坏类封装性的基础上，使得类可以同不曾估计到的系统进行交互

## 装饰模式

式以对客户端透明的方式扩展对象的功能，是继承关系的一个替代方案，提供比继承更多的灵活性。动态给一个对象增加功能，这些功能可以再动态的撤消。增加由一些基本功能的排列组合而产生的非常大量的功能。

## 适配器模式

把一个类的接口变换成客户端所期待的另一种接口，从而使原本因接口原因不匹配而无法一起工作的两个类能够一起工作。适配类可以根据参数返还一个合适的实例给客户端
将两个不兼容的类纠合在一起使用，属于结构型模式，需要Adaptee(被适配者)和Adaptor(适配器)两个身份。

## 代理模式

给某一个对象提供一个代理对象，并由代理对象控制对源对象的引用。代理就是一个人或一个机构代表另一个人或者一个机构采取行动。

某些情况下，客户不想或者不能够直接引用一个对象，代理对象可以在客户和目标对象直接起到中介的作用。客户端分辨不出代理主题对象与真实主题对象。代理模式可以并不知道真正的被代理对象，而仅仅持有一个被代理对象的接口，这时候代理对象不能够创建被代理对象，被代理对象必须有系统的其他角色代为创建并传入。

## 观察者模式

定义了一种一队多的依赖关系，让多个观察者对象同时监听某一个主题对象。这个主题对象在状态上发生变化时，会通知所有观察者对象，使他们能够自动更新自己。发布订阅。

## 模板模式（Template）

* 模板方法模式准备一个抽象类，将部分逻辑以具体方法以及具体构造子的形式实现，然后声明一些抽象方法来迫使子类实现剩余的逻辑。

不同的子类可以以不同的方式实现这些抽象方法，从而对剩余的逻辑有不同的实现。先制定一个顶级逻辑框架，而将逻辑的细节留给具体的子类去实现。

### 小技巧

* 在一个请求中重复读取数据库的数据是应该完全避免的，将请求缓存到静态属性中
* 将验证从控制器移动到请求类
* 一个控制器必须只有一个职责，因此应该将业务逻辑从控制器移到服务类
* 尽可能重用代码。 SRP（单一职责原则）正在帮助避免重复。倾向于使用 Eloquent 而不是 Query Builder 和原生的 SQL 查询
* 要优先于数组的集合批量赋值
* 不要在 Blade 模板中执行查询并使用关联加载
* 不要把 JS 和 CSS 放在 Blade 模板中，也不要将任何 HTML 放在 PHP 类中
* 在代码中使用配置和语言文件、常量，而不是写死它

## 图书

* Design Patterns:Elements of Reusable Object-Oriented Software（设计模式 - 可复用的面向对象软件元素）
* 《[Head First 设计模式（中文版）](https://book.douban.com/subject/2243615/)》
* 《[设计模式 : 可复用面向对象软件的基础](https://book.douban.com/subject/1052241/)》

## 参考

* [hoohack/DesignPattern](https://github.com/hoohack/DesignPattern):设计模式：PHP和Go语言实现
* [iluwatar/java-design-patterns](https://github.com/iluwatar/java-design-patterns)
* [DesignPatternsPHP](https://github.com/domnikl/DesignPatternsPHP)
* [kamranahmedse/design-patterns-for-humans](https://github.com/kamranahmedse/design-patterns-for-humans):Design Patterns for Humans™ - An ultra-simplified explanation 
* [设计模式](http://laravelacademy.org/resources/design-patterns)
* [Repository 模式](http://laravelacademy.org/post/3063.html)
* [教程](http://www.runoob.com/design-pattern/design-pattern-tutorial.html)
* [常见设计模式的定义，应用场景和方法](http://www.jianshu.com/p/f3c76b695167)
