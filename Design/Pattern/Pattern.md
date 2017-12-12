# 设计模式

抽象和设计能力，写出一种巧妙，可以伸缩，可以维护的代码架构；

设计模式（Design pattern）代表了最佳的实践，通常被有经验的面向对象的软件开发人员所采用。设计模式是软件开发人员在软件开发过程中面临的一般问题的解决方案。这些解决方案是众多软件开发人员经过相当长的一段时间的试验和错误总结出来的。

设计模式是一套被反复使用的、多数人知晓的、经过分类编目的、代码设计经验的总结。使用设计模式是为了重用代码、让代码更容易被他人理解、保证代码可靠性。 毫无疑问，设计模式于己于他人于系统都是多赢的，设计模式使代码编制真正工程化，设计模式是软件工程的基石，如同大厦的一块块砖石一样。项目中合理地运用设计模式可以完美地解决很多问题，每种模式在现实中都有相应的原理来与之对应，每种模式都描述了一个在我们周围不断重复发生的问题，以及该问题的核心解决方案，这也是设计模式能被广泛应用的原因。

在 1994 年，由 Erich Gamma、Richard Helm、Ralph Johnson 和 John Vlissides 四人合著出版了一本名为 Design Patterns - Elements of Reusable Object-Oriented Software（中文译名：设计模式 - 可复用的面向对象软件元素） 的书，该书首次提到了软件开发中设计模式的概念。
四位作者合称 GOF（四人帮，全拼 Gang of Four）。他们所提出的设计模式主要是基于以下的面向对象设计原则。

- 对接口编程而不是对实现编程。
- 优先使用对象组合而不是继承。

## 设计模式的一些原则

* 找出应用中可能需要改变之处，把它们独立出来，不要和哪些不需要改变的代码混在一起（低耦合）； 针对接口编程，而不是针对实现编程；
* 关键在于多态，程序可以针对超类型编程，执行时会根据实际状况执行到真正的行为，不会被绑死在超类型的行为上（在JavaScript中并没有超类型的概念。）我的理解是，接口可以理解为一个动作，而动作的具体实现则不用确定。这一点在下文讲解多态时会有一个更加具体的例子。

## 设计模式

* 单一职责原则(Single Responsibility Principle, SRP)： There should never be more than one reason for a class to change. 言下之意做到类只承担单一职责(最细粒度)也就能尽可能地降低类变更的可能性，不同职责要分开单独定义。其实这一原则不仅仅适用于类，还适用于接口以及方法的设计；
* 开闭原则(Open-Closed Principle, OCP)： Softeware entities like classes,modules and functions should be open for extension but closed for modifications. 这句话翻译过来大意就是，一个软件实体如类、模块和函数，应该通过扩展来实现变化，而不是通过修改已有代码来实现变化。比如参数类型、引用对象尽量使用接口或者抽象类，而不是具体实现类；
* 依赖倒转原则(Dependence Inversion Principle, DIP)： High level modules should not depend upon low level modules. Both should depend upon abstractions. Abstractions should not depend upon details. Details should depend upon abstractions. 依赖多出现在方法参数中。高层模块不应该依赖低层模块(具体实现)，以防止一旦低层模块(具体实现)发生变化，将引起高层模块不必要的改变，同时高层模块之上可能有更高层的模块存在，因此两者都应该依赖于抽象。抽象不依赖具体实现细节，而让具体实现细节依赖抽象。抽象不变，具体实现细节改变可以使影响最小化，也就是要针对接口编程。这一条与里氏代换原则结合起来更容易理解，也可以看出这些原则并不应该被孤立地运用于系统设计中，而应该协同配合起来运用；
* 里氏代换原则(Liskov Substitution Principle, LSP)： Functions that use pointers or referrnces to base classes must be able to use objects of derived classes without knowing it. 任何基类可以出现的地方，子类一定可以出现，且必须遵从基类所有规则定义，但反过来说，除了扩展基类，我们又为什么要违背基类规则定义呢？这一条与开关原则结合起来理解就是，基类遵循关原则，子类遵循开原则，子类必须满足LSP才允许继承，否则就断开这种继承关系；
* 接口隔离原则(Interface Segregation Principle, ISP)： Clients should not be forced to depend upon interfaces that they don't use.The dependcy of one class to another one should depend on the smallest possible interface. 使用多个隔离的接口，比使用单个接口要好，也有利于降低类之间的耦合度。类间的依赖关系要建立在最小的接口之上，要防止类必须实现接口中对于自己来说无用的方法情形的出现；
* 迪米特法则(Law of Demeter, LoD)，也称最少知识原则(Least Knowledge Principle, LKP)： Only talk to your immedate friends. 一个模块或子系统应当尽量少地与其他模块或子系统之间发生直接相互作用，可以通过增加“即时朋友”这个中间人来中转通信，只与“朋友”保持联系，与“陌生人”概不谋面，当模块或子系统出现版本升级更新或环境移植之后，只要朋友不变就好;
* 合成/聚合复用原则(Composite/Aggregate ReusePrinciple ，CARP)：该原则要求在设计上尽量使用合成/聚合来达到复用的目的，而不是使用继承，也就是说前者优先于后者而被运用。继承会将基类的细节暴露给子类，也称白箱复用，如果基类发生改变，子类也必须相应做出变动，且多继承不易维护。CARP几乎可用于任何环境，依赖少，但是合成/聚合造成类中多对象需要管理

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
```


## 技术

### 小技巧

* 在一个请求中重复读取数据库的数据是应该完全避免的，将请求缓存到静态属性中

## 参考

- Design Patterns - Elements of Reusable Object-Oriented Software（中文译名：设计模式 - 可复用的面向对象软件元素）
- [常见设计模式的定义，应用场景和方法](http://www.jianshu.com/p/f3c76b695167)
