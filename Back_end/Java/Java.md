# Java

* Java是由Sun Microsystems公司于1995年5月推出的Java面向对象程序设计语言和Java平台的总称。由James Gosling和同事们共同研发，并在1995年正式推出。
* Java编程语言的风格十分接近C++语言。继承了C++语言面向对象技术的核心，Java舍弃了C++语言中容易引起错误的指针，改以引用取代，同时移除原C++与原来运算符重载，也移除多重继承特性，改用接口取代，增加垃圾回收器功能。
* 在Java SE 1.5版本中引入了泛型编程、类型安全的枚举、不定长参数和自动装/拆箱特性。太阳微系统对Java语言的解释是："Java编程语言是个简单、面向对象、分布式、解释性、健壮、安全与系统无关、可移植、高性能、多线程和动态的语言"。
* Java不同于一般的编译语言或直译语言。它首先将源代码编译成字节码，然后依赖各种不同平台上的虚拟机来解释执行字节码，从而实现了"一次编写，到处运行"的跨平台特性。在早期JVM中，这在一定程度上降低了Java程序的运行效率。但在J2SE1.4.2发布后，Java的运行速度有了大幅提升。执行Java应用程序必须安装爪哇运行环境（Java Runtime Environment，JRE），JRE内部有一个Java虚拟机（Java Virtual Machine，JVM）以及一些标准的类库（Class Library）。通过JVM才能在电脑系统执行Java应用程序（Java Application），这与.Net Framework的情况一样，所以电脑上没有安装JVM，那么这些程序将不能够执行。 实现跨平台性的方法是大多数编译器在进行Java语言程序的编码时候会生成一个用字节码写成的"半成品"，这个"半成品"会在Java虚拟机（解释层）的帮助下运行，虚拟机会把它转换成当前所处硬件平台的原始代码。之后，Java虚拟机会打开标准库，进行数据（图片、线程和网络）的访问工作。主要注意的是，尽管已经存在一个进行代码翻译的解释层，有些时候Java的字节码代码还是会被JIT编译器进行二次编译。 C++语言被用户诟病的原因之一是大多数C++编译器不支持垃圾收集机制。通常使用C++编程的时候，程序员于程序中初始化对象时，会在主机内存堆栈上分配一块内存与地址，当不需要此对象时，进行析构或者删除的时候再释放分配的内存地址。如果对象是在堆栈上分配的，而程序员又忘记进行删除，那么就会造成内存泄漏（Memory Leak）。长此以往，程序运行的时候可能会生成很多不清除的垃圾，浪费了不必要的内存空间。而且如果同一内存地址被删除两次的话，程序会变得不稳定，甚至崩溃。因此有经验的C++程序员都会在删除之后将指针重置为NULL，然后在删除之前先判断指针是否为NULL。 C++中也可以使用"智能指针"（Smart Pointer）或者使用C++托管扩展编译器的方法来实现自动化内存释放，智能指针可以在标准类库中找到，而C++托管扩展被微软的Visual C++ 7.0及以上版本所支持。智能指针的优点是不需引入缓慢的垃圾收集机制，而且可以不考虑线程安全的问题，但是缺点是如果不善使用智能指针的话，性能有可能不如垃圾收集机制，而且不断地分配和释放内存可能造成内存碎片，需要手动对堆进行压缩。除此之外，由于智能指针是一个基于模板的功能，所以没有经验的程序员在需要使用多态特性进行自动清理时也可能束手无策。 Java语言则不同，上述的情况被自动垃圾收集功能自动处理。对象的创建和放置都是在内存堆栈上面进行的。当一个对象没有任何引用的时候，Java的自动垃圾收集机制就发挥作用，自动删除这个对象所占用的空间，释放内存以避免内存泄漏。
* 甲骨文与该平台的另外两大贡献者IBM 和 Red Hat 共同做出了这个决定:Oracle 已选择 Eclipse 基金会作为 Java EE 的新东家。

## JDK(Java Development Kit)版本

JVM->JRE:(Java Runtime Environment)->JDK_

- Open JDK:免费的开源实现,GPL License发布，很多Linux发行版中都会包含这个Open JDK 。
- Oracle JDK
  + JavaSE(J2SE)(Java2 Platform Standard Edition，java平台标准版）:从JDK 5.0开始，改名为Java SE
    * Java SE 5.0 (1.5.0)
    * Java SE 8.0 (1.8.0):从2019年1月 后续的update 开始就要收费 8u191, 8u192这样的东西，191,192就是update 的编号。
    * Java SE 9
    * Java SE 10
  + JavaEE(J2EE)(Java 2 Platform,Enterprise Edition，java平台企业版):从2018年2月26日开始，J2EE改名为Jakarta EE
  + JavaME(J2ME)(Java 2 Platform Micro Edition，java平台微型版)。
  - 组件
    + javac – 编译器，将源程序转成字节码
    + jar – 打包工具，将相关的类文件打包成一个文件
    + javadoc – 文档生成器，从源码注释中提取文档
    + jdb – debugger，查错工具
    + java – 运行编译后的java程序（.class后缀的）
    + appletviewer：小程序浏览器，一种执行HTML文件上的Java小程序的Java浏览器。
    + Javah：产生可以调用Java过程的C过程，或建立能被Java程序调用的C过程的头文件。
    + Javap：Java反汇编器，显示编译类文件中的可访问功能和数据，同时显示字节代码含义。
    + Jconsole: Java进行系统调试和监控的工具
* Oracle Java SE Advanced, Java  SE Advanced Desktop, Java SE Suite:为企业级用户提供的高级工具和功能，可以监控、部署、管理企业级的Java程序

### 安装

* [下载JDK(Java Development Kit)](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* Mac
  - 安装
  - 配置环境变量
  - 确认shell,修改配置文件,添加环境变量

```sh
# windows
JAVA_HOME C:\Program Files (x86)\Java\jdk1.8.0_91        # 要根据自己的实际路径配置
CLASSPATH .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar\;         # 记得前面有个"."
Path %JAVA_HOME%\bin;%JAVA_HOME%\jre\bin\; # win10 path 分条添加

# ubuntu
# using the version packaged with Debian：OpenJDK 8
sudo apt-get update
sudo apt-get install default-jre # JDK 包含JRE(**推荐**)
sudo apt-get install default-jdk

# Installing the Oracle JDK
sudo apt-get install software-properties-common
sudo add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
sudo apt-get update
sudo apt-get install oracle-java8-installer
javac -version

sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get install oracle-java11-installer
sudo apt-get install oracle-java11-set-default

## JAVA_HOME Environment Variable配置
sudo vim /etc/environment # 添加 JAVA_HOME="/usr/lib/jvm/java-8-oracle"
source /etc/environment
echo $JAVA_HOME

# mac
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
export PATH=${PATH}:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 或者
JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export JAVA_HOME
source .bash_profile | source .zshrc

## centos
sudo yum install java-1.8.0-openjdk
sudo yum install java-1.8.0-openjdk-devel

# 多版本管理
sudo update-alternatives --config java | javac # 会获得程序路径

java -version
```

### Java 源程序与编译型运行

* 编译型源程序->可执行程序->操作系统执行
* Java 源程序：源程序（.java）->字节码程序（.class）->**解释器执行**->操作系统执行
  - 源文件:Javac 后面跟着的是java文件的文件名，例如 HelloWorld.java。 该命令用于将 java 源文件编译为 class 字节码文件
    + 一个源文件中只能有一个public类
    + 一个源文件可以有多个非public类
    + 源文件的名称应该和public类的类名保持一致。例如：源文件中public类的类名是Employee，那么源文件应该命名为Employee.java。
    + 如果一个类定义在某个包中，那么package语句应该在源文件的首行。
    + 如果源文件包含import语句，那么应该放在package语句和类定义之间。如果没有package语句，那么import语句应该在源文件中最前面。
    + import语句和package语句对源文件中定义的所有类都有效。在同一源文件中，不能给不同的类不同的包声明。

  - Java 后面跟着的是java文件中的类名

```java
//  HelloWorld.java
public class HelloWorld {
    /* 第一个Java程序
     * 它将打印字符串 Hello World
     */
    public static void main(String []args) {
        System.out.println("Hello World"); // 打印 Hello World
    }
}

javac HelloWorld.java // 编译
java HelloWorld // 运行
```

## 基础

* 大小写敏感：Java是大小写敏感的
* 类名：对于所有的类来说，类名的首字母应该大写。如果类名由若干单词组成，那么每个单词的首字母应该大写，例如 MyFirstJavaClass 。
* 方法名：所有的方法名都应该以小写字母开头。如果方法名含有若干单词，则后面的每个单词首字母大写。
* 源文件名：源文件名必须和类名相同。当保存文件的时候，你应该使用类名作为文件名保存（切记Java是大小写敏感的），文件名的后缀为.java。（如果文件名和类名不相同则会导致编译错误）。
* 主方法入口：所有的Java 程序由public static void main(String []args)方法开始执行。
* 注释：单行注释与多行注释
* 标志符：类名、变量名以及方法名
  - 所有的标识符都应该以字母（A-Z或者a-z）,美元符（$）、或者下划线（_）开始
  - 首字符之后可以是字母（A-Z或者a-z）,美元符（$）、下划线（_）或数字的任何字符组合
  - 关键字不能用作标识符
  - 标识符是大小写敏感的
  - 合法标识符举例：age、$salary、_value、__1_value
  - 非法标识符举例：123abc、-salary
* 类型
  - 数组：数组是储存在堆上的对象，可以保存多个同类型变量
  - 枚举：枚举限制变量只能是预先设定好的值

```java
/* 这是第一个Java程序
*它将打印Hello World
* 这是一个多行注释的示例
*/

// 这是单行注释的示例

public class Test {
  int d = 25;

  public static void main(String[] args) {
     System.out.println("d++   = " +  (d++) );
     System.out.println("++d   = " +  (++d) );
  }
}
```

## 数据类型

变量就是申请内存来存储值。当创建变量的时候，需要在内存中申请空间。变量为地址别名，值为存储内容 内存管理系统根据变量的类型为变量分配存储空间，分配的空间只能用来储存该类型数据。

* 内置数据类型
  - byte、int、long、和short都可以用十进制、16进制以及8进制的方式来表示
  - 字面量可以赋给任何内置类型的变量
  * byte
    - 数据类型是8位、有符号的，以二进制补码表示的整数
    - 范围：128（-2^7）127（2^7-1）
    - 默认值是 0
    - byte 变量占用的空间只有 int 类型的四分之一
  * short
    + 数据类型是 16 位、有符号的以二进制补码表示的整数
    + 范围：-32768（-2^15） 32767（2^15 - 1）；
    + 一个short变量是int型变量所占空间的二分之一；
    + 默认值是 0；
  - int
    + 数据类型是32位、有符号的以二进制补码表示的整数；
    + 范围：-2,147,483,648（-2^31） 2,147,483,647（2^31 - 1）；
    + 一般地整型变量默认为 int 类型；
    + 默认值是 0 ；
  - long
    + 数据类型是 64 位、有符号的以二进制补码表示的整数；
    + 范围： -9,223,372,036,854,775,808（-2^63） 9,223,372,036,854,775,807（2^63 -1）；
    + 主要使用在需要比较大整数的系统上；
    + 默认值是 0L；
  - float
    + 数据类型是单精度、32位、符合IEEE 754标准的浮点数；
    + 在储存大型浮点数组的时候可节省内存空间；
    + 默认值是 0.0f；
    + 浮点数不能用来表示精确的值，如货币
  - double
    + 数据类型是双精度、64 位、符合IEEE 754标准的浮点数；
    + 浮点数的默认类型为double类型；
    + double类型同样不能表示精确的值，如货币；
    + 默认值是 0.0d；
  - boolean
    + 数据类型表示一位的信息；
    + 只有两个取值：true 和 false；
    + 这种类型只作为一种标志来记录 true/false 情况；
    + 默认值是 false
  - char
    + 一个单一的 16 位 Unicode 字符；
    + 最小值是 \u0000（即为0）；
    + 最大值是 \uffff（即为65,535）；
    + char 数据类型可以储存任何字符
* 自动类型转换
  + 整型、实型（常量）、字符型数据可以混合运算。运算中，不同类型的数据先转化为同一类型，然后进行运算.
  + 优先级：byte,short,char—> int —> long—> float —> double
  - 不能对boolean类型进行类型转换。
  - 不能把对象类型转换成不相关类的对象。
  - 在把容量大的类型转换为容量小的类型时必须使用强制类型转换。
  - 转换过程中可能导致溢出或损失精度
  - 浮点数到整数的转换是通过舍弃小数得到，而不是四舍五入
  - 必须满足转换前的数据类型的位数要低于转换后的数据类型，例如: short数据类型的位数为16位，就可以自动转换位数为32的int类型，同样float数据类型的位数为32，可以自动转换为64位的double类型。
* 强制转换
  - 条件是转换的数据类型必须是兼容的。
  - 格式：(type)value type是要强制类型转换后的数据类型
* 隐含强制类型转换
  - 整数的默认类型是 int。
  - 浮点型不存在这种情况，因为在定义 float 类型时必须在数字后面跟上 F 或者 f
* 变量
  - 成员变量（非静态变量）：成员变量是定义在类中，方法体之外的变量。这种变量在创建对象的时候实例化。成员变量可以被类中方法、构造方法和特定类的语句块访问。
    + 实例变量声明在一个类中，但在方法、构造方法和语句块之外；
    + 当一个对象被实例化之后，每个实例变量的值就跟着确定；
    + 实例变量在对象创建的时候创建，在对象被销毁的时候销毁；
    + 实例变量的值应该至少被一个方法、构造方法或者语句块引用，使得外部能够通过这些方式获取实例变量信息；
    + 实例变量可以声明在使用前或者使用后；
    + 访问修饰符可以修饰实例变量；
    + 实例变量对于类中的方法、构造方法或者语句块是可见的。一般情况下应该把实例变量设为私有。通过使用访问修饰符可以使实例变量对子类可见；
    + 实例变量具有默认值。数值型变量的默认值是0，布尔型变量的默认值是false，引用类型变量的默认值是null。变量的值可以在声明时指定，也可以在构造方法中指定；
    + 实例变量可以直接通过变量名访问。但在静态方法以及其他类中，就应该使用完全限定名：ObejectReference.VariableName。
  - 类变量（静态变量）：类变量也声明在类中，方法体之外，但必须声明为static类型。
    + 类变量也称为静态变量，在类中以static关键字声明，但必须在方法构造方法和语句块之外。
    + 无论一个类创建了多少个对象，类只拥有类变量的一份拷贝。
    + 静态变量除了被声明为常量外很少使用。常量是指声明为public/private，final和static类型的变量。常量初始化后不可改变。
    + 静态变量储存在静态存储区。经常被声明为常量，很少单独使用static声明变量。
    + 静态变量在第一次被访问时创建，在程序结束时销毁。
    + 与实例变量具有相似的可见性。但为了对类的使用者可见，大多数静态变量声明为public类型。
    + 默认值和实例变量相似。数值型变量默认值是0，布尔型默认值是false，引用类型默认值是null。变量的值可以在声明的时候指定，也可以在构造方法中指定。此外，静态变量还可以在静态语句块中初始化。
    + 静态变量可以通过：ClassName.VariableName的方式访问。
    + 类变量被声明为public static final类型时，类变量名称一般建议使用大写字母。如果静态变量不是public和final类型，其命名方式与实例变量以及局部变量的命名方式一致。
  - 局部变量：在方法、构造方法或者语句块中定义的变量被称为局部变量。变量声明和初始化都是在方法中，方法结束后，变量就会自动销毁
    - 局部变量声明在方法、构造方法或者语句块中；
    + 局部变量在方法、构造方法、或者语句块被执行的时候创建，当它们执行完成后，变量将会被销毁；
    + 访问修饰符不能用于局部变量；
    + 局部变量只在声明它的方法、构造方法或者语句块中可见；
    + 局部变量是在栈上分配的。
    + 局部变量没有默认值，所以局部变量被声明后，必须经过初始化，才可以使用。
* 引用数据类型
  - 引用类型的变量非常类似于C/C++的指针。引用类型指向一个对象，指向对象的变量是引用变量。这些变量在声明时被指定为一个特定的类型。变量一旦声明后，类型就不能被改变了。
  - 对象、数组都是引用数据类型。
  - 所有引用类型的默认值都是null。
  - 一个引用变量可以用来引用任何与之兼容的类型。

```java
type identifier [ = value][, identifier [= value] ...] ;

int d = 3, e = 4, f = 5; // 声明三个整数并赋予初值
double d1 = 123.4;
boolean one = true;
char letter = 'A';
char a = '\u0001'; // 可以包含任何Unicode字符
String s = "runoob";  // 声明并初始化字符串 s

Byte.SIZE
Byte.MIN_VALUE
Byte.MAX_VALUE
Integer.SIZE
Integer.MIN_VALUE
Integer.MAX_VALUE
Character.SIZE

int decimal = 100;
int octal = 0144;
int hexa =  0x64;

byte a = 68;
char a = 'A'

int i =128;
byte b = (byte)i; // 值 128 时候就会导致溢出
(int)23.7 == 23;
(int)-45.89f == -45

int i1 = 123;
byte b = (byte)i1;
```

## 常量

常量在程序运行时是不能被修改的。 使用 final 关键字来修饰常量.用大写字母表示常量

```java
final double PI = 3.1415927;

"two\nlines"
"\"This is in quotes\""
char a = '\u0001';
String a = "\u0001";

// 转义字符序列
\n 换行 (0x0a)
\r  回车 (0x0d)
\f  换页符(0x0c)
\b  退格 (0x08)
\0  空字符 (0x20)
\s  字符串
\t  制表符
\"  双引号
\'  单引号
\\  反斜杠
\ddd  八进制字符 (ddd)
\uxxxx  16进制Unicode字符 (xxxx)
```

## 运算符

* 算术运算符：用在数学表达式 + - * / % ++ --
* 关系运算符: == != > < >= <=
* 位运算符：应用于整数类型(int)，长整型(long)，短整型(short)，字符型(char)，和字节型(byte)等类型，作用在所有的位上，并且按位运算。
  - & |:与 或
  - ^：如果相对应位值相同，则结果为0，否则为1
  - ~：按位取反运算符翻转操作数的每一位，即0变成1，1变成0
  - <<  按位左移运算符。左操作数按位左移右操作数指定的位数
  - />>  按位右移运算符。左操作数按位右移右操作数指定的位数
  - />>>   按位右移补零操作符。左操作数的值按右操作数指定的位数右移，移动得到的空位以零填充。
* 逻辑运算符：&& || ！
  - 当使用与逻辑运算符时，在两个操作数都为true时，结果才为true，但是当得到第一个操作为false时，其结果就必定是false，这时候就不会再判断第二个操作了
  - 逻辑或时，有一个为true,就通过
* 赋值运算符：= != += -= /= (%)= <<= >>= &= ^= |=
* 条件运算符（?:）
* instanceof 运算符:用于操作对象实例，检查该对象是否是一个特定类型（类类型或接口类型）
* 优先级：属性》一元〉乘法》加减〉移位》关系〉是否相等》位与〉位异或》位或〉逻辑与》逻辑或〉条件》赋值〉逗号

```java
int a = 10;
d++   = 25
++d   = 27

A = 0011 1100
A << 2 // 240，即 1111 0000
A >> 2 // 15 1111
A>>>2 // 15即0000 1111

variable x = (expression) ? value if true : value if false

( Object reference variable ) instanceof  (class/interface type)
String name = "James";
boolean result = name instanceof String;

// 优先级
() [] .(点操作符)
+ + - ！〜 // 一元
* /％ // 乘性
+ -
>> >>>  <<
>> = << =
==  !=
＆
^
|
&&
||
？：  // 从右到左
= + = - = * = / =％= >> = << =＆= ^ = | = // 从右到左
，
```

## 控制语句

* 条件
  - if
  - switch
    + 变量类型可以是： byte、short、int 或者 char。从 Java SE 7 开始，支持字符串 String 类型
    + 可以拥有多个 case 语句。每个 case 后面跟一个要比较的值和冒号。
    + case 语句中的值的数据类型必须与变量的数据类型相同，而且只能是常量或者字面常量。
    + 当变量的值与 case 语句的值相等时，那么 case 语句之后的语句开始执行，直到 break 语句出现才会跳出 switch 语句。
    + case 语句不必须要包含 break 语句。如果没有 break 语句出现，程序会继续执行下一条 case 语句，直到出现 break 语句。
    + 可以包含一个 default 分支，该分支一般是 switch 语句的最后一个分支（可以在任何位置，但建议在最后一个）。
    + default 在没有 case 语句的值和变量值相等的时候执行。default 分支不需要 break 语句。
  - 嵌套
* 循环
  - while
  - do...while
  - for
* 其它
  - break 主要用在循环语句或者 switch 语句中，用来跳出整个语句块。跳出最里层的循环，并且继续执行该循环下面的语句。
  - continue 适用于任何循环控制结构中。作用是让程序立刻跳转到下一次循环的迭代。

```java
int x = 30;

if( x == 10 ){
   System.out.print("Value of X is 10");
}else if( x == 20 ){
   System.out.print("Value of X is 20");
}else if( x == 30 ){
   System.out.print("Value of X is 30");
}else{
   System.out.print("这是 else 语句");
}

char grade = 'C';
switch(grade)
{
   case 'A' :
      System.out.println("优秀");
      break;
   case 'B' :
   case 'C' :
      System.out.println("良好");
      break;
   case 'D' :
      System.out.println("及格");
   case 'F' :
      System.out.println("你需要再努力努力");
      break;
   default :
      System.out.println("未知等级");
}

while( x < 20 ) {
   System.out.print("value of x : " + x );
   x++;
   System.out.print("\n");
}

do{
   System.out.print("value of x : " + x );
   x++;
   System.out.print("\n");
}while( x < 20 );

for(int x = 10; x < 20; x = x+1) {
   System.out.print("value of x : " + x );
   System.out.print("\n");
}

String [] names ={"James", "Larry", "Tom", "Lacy"};
for( String name : names ) {
   System.out.print( name );
   System.out.print(",");
}
```

### Number and Math

* Java 语言为每一个内置数据类型提供了对应的包装类。
  - 由编译器特别支持的包装称为装箱，所以当内置数据类型被当作对象使用的时候，编译器会把内置类型装箱为包装类。
  - 相似的，编译器也可以把一个对象拆箱为内置类型。Number 类属于 java.lang 包。
* 所有的包装类（Integer、Long、Byte、Double、Float、Short）都是抽象类 Number 的子类
* Math 包含了用于执行基本数学运算的属性和方法
  - xxxValue() 方法用于将 Number 对象转换为 xxx 数据类型的值
  - random() 方法用于返回一个随机数，随机数范围为 0.0 =< Math.random < 1.0。
  - compareTo() 方法用于将 Number 对象与方法的参数进行比较。可用于比较 Byte, Long, Integer等。该方法用于两个相同数据类型的比较，两个不同类型的数据不能用此方法来比较
  - equals() 方法用于判断 Number 对象与方法的参数进是否相等
  - valueOf() 方法用于返回给定参数的原生 Number 对象值，参数可以是原生数据类型, String等。该方法可以接收两个参数一个是字符串，一个是基数
  - toString() 方法用于返回以一个字符串表示的 Number 对象值。
  - parseInt() 方法用于将字符串参数作为有符号的十进制整数进行解析。如果方法有两个参数， 使用第二个参数指定的基数，将字符串参数解析为有符号的整数。
  - abs() 返回参数的绝对值
  - ceil() 返回大于等于( >= )给定参数的的最小整数
  - floor() 返回小于等于（<=）给定参数的最大整数
  - round():表示四舍五入，算法为 Math.floor(x+0.5)，即将原来的数字加上 0.5 后再向下取整，所以，Math.round(11.5) 的结果为12，Math.round(-11.5) 的结果为-11
  - rint() 方法返回最接近参数的整数值
  - min() 方法用于返回两个参数中的最小值
  - max() 返回两个参数中的最大值
  - exp() 返回自然数底数e的参数次方
  - log() 方法用于返回参数的自然数底数的对数值
  - double pow(double base, double exponent) 方法用于返回第一个参数的第二个参数次方。
  - sqrt() 求参数的算术平方根
  - sin() 方法用于返回指定double类型参数的正弦值
  - cos() 方法用于返回指定double类型参数的余弦值
  - tan() 方法用于返回指定double类型参数的正切值
  - asin() 求指定double类型参数的反正弦值
  - acos() 求指定double类型参数的反余弦值
  - atan() 求指定double类型参数的反正切值
  - atan2() 方法用于将矩形坐标 (x, y) 转换成极坐标 (r, theta)，返回所得角 theta。该方法通过计算 y/x 的反正切值来计算相角 theta，范围为从 -pi 到 pi。
  - toDegrees() 将参数转化为角度
  - toRadians() 将角度转换为弧度

```java
Integer i1 = 128;  // 装箱，相当于 Integer.valueOf(128);
int t = i1; //相当于 i1.intValue() 拆箱

// 当两个 Integer 变量的数值超出 -128 ~ 127 范围时, 变量使用了不同地址：
Integer a=123;
Integer b=123;
a==b;        // 输出 true
a.equals(b);  // 输出 true

a=1230;
b=1230;
a==b;        // 输出 false
a.equals(b);  // 输出 true

System.out.println("90 度的正弦值：" + Math.sin(Math.PI/2)); // 1.0
System.out.println("0度的余弦值：" + Math.cos(0)); // 1.0
System.out.println("60度的正切值：" + Math.tan(Math.PI/3)); // 1.7320508075688767
System.out.println("1的反正切值： " + Math.atan(1)); // 0.7853981633974483
System.out.println("π/2的角度值：" + Math.toDegrees(Math.PI/2)); // 90.0
System.out.println(Math.PI);

Integer x = 5;
x.byteValue(); // 5
x.doubleValue(); // 5.0
x.longValue(); // 5

Math.random();

x.compareTo(3); // 1
x.compareTo(5); // 0
x.compareTo(8); // -1

Integer x = 5;
Integer y = 10;
Integer z =5;
Short a = 5;
x.equals(y); // false
x.equals(z); // true
x.equals(a); // false

Integer x =Integer.valueOf(9);
Double c = Double.valueOf(5);
Float a = Float.valueOf("80");
Integer b = Integer.valueOf("444",16);   // 使用 16 进制
System.out.println(x); // 9
System.out.println(c); // 5.0
System.out.println(a); // 80.0
System.out.println(b); // 1092

x.toString() // 5
Integer.toString(12) // 12

int x =Integer.parseInt("9"); // 9
double c = Double.parseDouble("5"); // 5.0
int b = Integer.parseInt("444",16); // 1092

Integer a = -8;
double d = -100;
float f = -90;
System.out.println(Math.abs(a));
System.out.println(Math.abs(d));
System.out.println(Math.abs(f));

Math.floor(-1.5)=-2.0
Math.round(-1.5)=-1
Math.ceil(-1.5)=-1.0
Math.floor(-1.6)=-2.0
Math.round(-1.6)=-2
Math.ceil(-1.6)=-1.0

double d = 100.675;
double e = 100.500;
double f = 100.200;
Math.rint(d); // 101.0
Math.rint(e); // 100.0
Math.rint(f); // 100.0
Math.min(12.123, 12.456) // 12.123
Math.max(12.123, 12.456) // 12.456

Math.E // 2.7183
Math.exp(11.635) // 112983.831
Math.log(11.635) // 2.454
Math.pow(11.635, 2.760) // 874.008
Math.sqrt(11.635) // 3.411
Math.sin(45.0) // 0.7071
Math.tan(45.0) // 1.0000
Math.atan2(45.0, 30.0) // 0.982793723247329
Math.toDegrees(30.0) // 1718.8733853924698
Math.toRadians(30.0) // 0.5235987755982988
System.out.printf("浮点型变量的值为 " +
                  "%f, 整型变量的值为 " +
                  " %d, 字符串变量的值为 " +
                  "is %s", floatVar, intVar, stringVar);
```

### Character 类

用于对单个字符进行操作。 在对象中包装一个基本类型 char 的值.常会遇到需要使用对象，而不是内置数据类型的情况。为了解决这个问题，Java语言为内置数据类型char提供了包装类Character类

* 在某些情况下，Java编译器会自动创建一个Character对象
* 将一个char类型的参数传递给需要一个Character类型参数的方法时，那么编译器会自动地将char类型参数转换为Character对象。 这种特征称为装箱，反过来称为拆箱。
* 打印语句遇到一个转义序列时，编译器可以正确地对其进行解释
* 方法
  - isLetter() 是否是一个字母
  - isDigit() 是否是一个数字字符
  - isWhitespace() 是否是一个空白字符
  - isUpperCase() 是否是大写字母
  - isLowerCase() 是否是小写字母
  - toUpperCase() 指定字母的大写形式
  - toLowerCase() 指定字母的小写形式
  - toString() 返回字符的字符串形式，字符串的长度仅为1

```java
char ch = 'a';
// Unicode 字符表示形式
char uniChar = '\u039A';
// 字符数组
char[] charArray ={ 'a', 'b', 'c', 'd', 'e' };

Character ch = new Character('a');

// 原始字符 'a' 装箱到 Character 对象 ch 中
Character ch = 'a';
// 原始字符 'x' 用 test 方法装箱 返回拆箱的值到 'c'
char c = test('x');

\t  // 在文中该处插入一个tab键
\b  // 在文中该处插入一个后退键
\n  // 在文中该处换行
\r  // 在文中该处插入回车
\f  // 在文中该处插入换页符
\'  // 在文中该处插入单引号
\"  // 在文中该处插入双引号
\\  // 在文中该处插入反斜杠

Character.isLetter('c') // true
Character.isLetter('5') // false
Character.isDigit('5') // true
Character.isWhitespace(' ') // true
Character.isWhitespace('\n') // true
Character.isWhitespace('\t') // true
Character.isUpperCase('C') // true
Character.isLowerCase('c') // true
Character.toUpperCase('a') // A
Character.toLowerCase('A') // a
Character.toString('a') // a
Character.toString('A') // A
```

### String类

* 字符串属于对象，Java 提供了 String 类来创建和操作字符串
* String 类是不可改变的，所以你一旦创建了 String 对象，那它的值就无法改变了
* 方法
  - char charAt(int index)返回指定索引处的 char 值。
  - int compareTo(Object o)把这个字符串和另一个对象比较。
    + 字符串与对象进行比较。
  - int compareTo(String anotherString)按字典顺序比较两个字符串。
    + 先比较对应字符的大小(ASCII码顺序),如果第一个字符和参数的第一个字符不等,结束比较,返回他们之间的差值,如果第一个字符和参数的第一个字符相等,则以第二个字符和参数的第二个字符做比较,以此类推,直至比较的字符或被比较的字符不一样
    + 如果参数字符串等于此字符串，则返回值 0；
    + 如果此字符串小于字符串参数，则返回一个小于 0 的值；
    + 如果此字符串大于字符串参数，则返回一个大于 0 的值。
  - int compareToIgnoreCase(String str)按字典顺序比较两个字符串，不考虑大小写。
  - String concat(String str)将指定字符串连接到此字符串的结尾。
  - boolean contentEquals(StringBuffer sb)当且仅当字符串与指定的StringBuffer有相同顺序的字符时候返回真。
  - static String copyValueOf(char[] data)返回指定数组中表示该字符序列的 String。
  - static String copyValueOf(char[] data, int offset, int count)返回指定数组中表示该字符序列的 String。
  - boolean endsWith(String suffix)测试此字符串是否以指定的后缀结束。
  - boolean equals(Object anObject)将此字符串与指定的对象比较。
  - boolean equalsIgnoreCase(String anotherString)将此 String 与另一个 String 比较，不考虑大小写。
  - byte[] getBytes()使用平台的默认字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。
  - byte[] getBytes(String charsetName)使用指定的字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。
  - void getChars(int srcBegin, int srcEnd, char[] dst, int dstBegin)将字符从此字符串复制到目标字符数组。
  - int hashCode()返回此字符串的哈希码。
  - int indexOf(int ch)返回指定字符在此字符串中第一次出现处的索引。
  - int indexOf(int ch, int fromIndex)返回在此字符串中第一次出现指定字符处的索引，从指定的索引开始搜索。
  - int indexOf(String str)返回指定子字符串在此字符串中第一次出现处的索引。
  - int indexOf(String str, int fromIndex)返回指定子字符串在此字符串中第一次出现处的索引，从指定的索引开始。
  - String intern()返回字符串对象的规范化表示形式。
  - int lastIndexOf(int ch)返回指定字符在此字符串中最后一次出现处的索引。
  - int lastIndexOf(int ch, int fromIndex)返回指定字符在此字符串中最后一次出现处的索引，从指定的索引处开始进行反向搜索。
  - int lastIndexOf(String str)返回指定子字符串在此字符串中最右边出现处的索引。
  - int lastIndexOf(String str, int fromIndex)返回指定子字符串在此字符串中最后一次出现处的索引，从指定的索引开始反向搜索。
  - int length()返回此字符串的长度。
  - boolean matches(String regex)告知此字符串是否匹配给定的正则表达式。
  - boolean regionMatches(boolean ignoreCase, int toffset, String other, int ooffset, int len)测试两个字符串区域是否相等。
  - boolean regionMatches(int toffset, String other, int ooffset, int len)测试两个字符串区域是否相等。
  - String replace(char oldChar, char newChar)返回一个新的字符串，它是通过用 newChar 替换此字符串中出现的所有 oldChar 得到的。
  - String replaceAll(String regex, String replacement)使用给定的 replacement 替换此字符串所有匹配给定的正则表达式的子字符串。
  - String replaceFirst(String regex, String replacement)使用给定的 replacement 替换此字符串匹配给定的正则表达式的第一个子字符串。
  - String[] split(String regex)根据给定正则表达式的匹配拆分此字符串。
  - String[] split(String regex, int limit)根据匹配给定的正则表达式来拆分此字符串。
  - boolean startsWith(String prefix)测试此字符串是否以指定的前缀开始。
  - boolean startsWith(String prefix, int toffset)测试此字符串从指定索引开始的子字符串是否以指定前缀开始。
  - CharSequence subSequence(int beginIndex, int endIndex)返回一个新的字符序列，它是此序列的一个子序列。
  - String substring(int beginIndex)返回一个新的字符串，它是此字符串的一个子字符串。
  - String substring(int beginIndex, int endIndex)返回一个新字符串，它是此字符串的一个子字符串。
  - char[] toCharArray()将此字符串转换为一个新的字符数组。
  - String toLowerCase()使用默认语言环境的规则将此 String 中的所有字符都转换为小写。
  - String toLowerCase(Locale locale)使用给定 Locale 的规则将此 String 中的所有字符都转换为小写。
  - String toString()返回此对象本身（它已经是一个字符串！）。
  - String toUpperCase()使用默认语言环境的规则将此 String 中的所有字符都转换为大写。
  - String toUpperCase(Locale locale)使用给定 Locale 的规则将此 String 中的所有字符都转换为大写。
  - String trim()返回字符串的副本，忽略前导空白和尾部空白。
  - static String valueOf(primitive data type x)返回给定data type类型x参数的字符串表示形式。

```java
// 初始化字符串
String greeting = "Hello World!";
char[] helloArray = { 'r', 'u', 'n', 'o', 'o', 'b'};
String helloString = new String(helloArray);

greeting.length();
string1.concat(string2);
"Hello," + " World" + "!"

String fs;
fs = String.format("浮点型变量的值为 " +
                   "%f, 整型变量的值为 " +
                   " %d, 字符串变量的值为 " +
                   " %s", floatVar, intVar, stringVar);

String s = "www.runoob.com";
s.charAt(8); // o
String str1 = "Strings";
String str2 = "Strings";
String str3 = "Strings123";
str1.compareTo( str2 ); // 0
str2.compareTo( str3 ); // -3
str3.compareTo( str1 ); // 3
```

## OOP

* 包
* 类：类是一个模板，它描述一类对象的行为和状态。
  - 抽象类：如果一个类包含抽象方法，那么该类一定要声明为抽象类
    + 抽象方法是一种没有任何实现的方法，该方法的的具体实现由子类提供。
    + 抽象方法不能被声明成 final 和 static。
    + 任何继承抽象类的子类必须实现父类的所有抽象方法，除非该子类也是抽象类。
    + 如果一个类包含若干个抽象方法，那么该类必须声明为抽象类。抽象类可以不包含抽象方法。
    + 抽象方法的声明以分号结尾，例如：public abstract sample();
* 对象：对象是类的一个实例，有状态和行为
* 继承
  * 可以重用已存在类的方法和属性。被继承的类称为超类（super class），派生类称为子类（subclass）
  * 父类中声明为 public 的方法在子类中也必须为 public。
  * 父类中声明为 protected 的方法在子类中要么声明为 protected，要么声明为 public，不能声明为 private。
  * 父类中声明为 private 的方法，不能够被继承。
+ 访问控制修饰符
  * private : 在同一类内可见。使用对象：变量、方法。 注意：不能修饰类（外部类）
    - 声明为 private 的方法、变量和构造方法只能被所属类访问
    - 声明为私有访问类型的变量只能通过类中公共的 getter 方法被外部类访问
    - 主要用来隐藏类的实现细节和保护类的数据
  - public : 对所有类可见。使用对象：类、接口、变量、方法
    + 如果几个相互访问的 public 类分布在不同的包中，则需要导入相应 public 类所在的包。
    + 由于类的继承性，类所有的公有方法和变量都能被其子类继承。
  - protected : 对同一包内的类和所有子类可见。使用对象：变量、方法。 注意：不能修饰类（外部类）
    + 子类与基类在同一包中：被声明为 protected 的变量、方法和构造器能被同一个包中的任何其他类访问；
    + 子类与基类不在同一包中：那么在子类中，子类实例可以访问其从基类继承而来的 protected 方法，而不能访问基类实例的protected方法。
* 非访问控制修饰符
  - static:用来修饰类方法和类变量。
    + 静态变量：关键字用来声明独立于对象的静态变量，无论一个类实例化多少对象，它的静态变量只有一份拷贝
    + 静态方法不能使用类的非静态变量。
  - final:用来修饰类、方法和变量
    - 修饰的类不能够被继承
    - 修饰的方法可以被子类继承，但是不能被子类修改,防止该方法的内容被修改
    - 修饰的变量为常量，是不可修改的,必须显式指定初始值 常和 static 修饰符一起使用来创建类常量。
  - abstract:用来创建抽象类和抽象方法
    + 抽象类不能用来实例化对象，声明抽象类的唯一目的是为了将来对该类进行扩充
    + 一个类不能同时被 abstract 和 final 修饰。如果一个类包含抽象方法，那么该类一定要声明为抽象类
  - synchronized:同一时间只能被一个线程访问,可以应用于四个访问修饰符
  - ransient:序列化的对象包含被 transient 修饰的实例变量时，java 虚拟机(JVM)跳过该特定的变量。
    - 该修饰符包含在定义变量的语句中，用来预处理类和变量的数据类型。
  - volatile
    - 在每次被线程访问时，都强制从共享内存中重新读取该成员变量的值。
    - 当成员变量发生变化时，会强制线程将变化值回写到共享内存。
    - 在任何时刻，两个不同的线程总是看到某个成员变量的同一个值。
    - 一个 volatile 对象引用可能是 null。

```java
abstract class Caravan{
   private double price;
   private String model;
   private String year;
   public abstract void goFast(); //抽象方法
   public abstract void changeColor();
}

public synchronized void showDetails(){
.......
}

public transient int limit = 55;   // 不会持久化

// 在一个线程调用 run() 方法（在 Runnable 开启的线程），在另一个线程调用 stop() 方法。 如果 第一行 中缓冲区的 active 值被使用，那么在 第二行 的 active 值为 false 时循环不会停止。但是以上代码中我们使用了 volatile 修饰 active，所以该循环会停止。
public class MyRunnable implements Runnable
{
    private volatile boolean active;
    public void run()
    {
        active = true;
        while (active) // 第一行
        {
            // 代码
        }
    }
    public void stop()
    {
        active = false; // 第二行
    }
}
```

## 包

* 包主要用来对类和接口进行分类。如果给出一个完整的限定名，包括包名、类名，那么Java编译器就可以很容易地定位到源代码或者类。
* Import语句就是用来提供一个合理的路径，使得编译器可以找到某个类。

```java
// 下面的命令行将会命令编译器载入 java_installation/java/io路径下的所有类
import java.io.*;
```

## 接口

* 接口可理解为对象间相互通信的协议。
* 接口只定义派生要用到的方法，但是方法的具体实现完全取决于派生类。
* 使用默认访问修饰符声明的变量和方法，对同一个包内的类是可见的。
* 接口里的变量都隐式声明为 public static final,
* 接口里的方法默认情况下访问权限为 public。

### 类

* 变量
  - 成员变量（非静态变量）：成员变量是定义在类中，方法体之外的变量。这种变量在创建对象的时候实例化。成员变量可以被类中方法、构造方法和特定类的语句块访问。
  - 类变量（静态变量）：类变量也声明在类中，方法体之外，但必须声明为static类型。
  - 局部变量：在方法、构造方法或者语句块中定义的变量被称为局部变量。变量声明和初始化都是在方法中，方法结束后，变量就会自动销毁
* 构造方法
  - 每个类都有构造方法。如果没有显式地为类定义构造方法，Java编译器将会为该类提供一个默认构造方法。
  - 在创建一个对象的时候，至少要调用一个构造方法。构造方法的名称必须与类同名，一个类可以有多个构造方法。

### 对象

用关键字new来创建一个新的对象

* 声明：声明一个对象，包括对象名称和对象类型。
* 实例化：使用关键字new来创建一个对象。
* 初始化：使用new创建对象时，会调用构造方法初始化对象。

```java
public class Puppy{
   int puppyAge;
   public Puppy(String name){
      // 这个构造器仅有一个参数：name
      System.out.println("小狗的名字是 : " + name );
   }

   public void setAge( int age ){
       puppyAge = age;
   }

   public int getAge( ){
       System.out.println("小狗的年龄为 : " + puppyAge );
       return puppyAge;
   }

   public static void main(String []args){
      /* 创建对象 */
      Puppy myPuppy = new Puppy( "tommy" );
      /* 通过方法来设定age */
      myPuppy.setAge( 2 );
      /* 调用另一个方法获取age */
      myPuppy.getAge( );
      /*你也可以像下面这样访问成员变量 */
      System.out.println("变量值 : " + myPuppy.puppyAge );
   }
}
```

## 知识点

* 基础知识：
  - Java反射：Field、Type
  - Java代理：proxy、cglib
  - Java线程：Thread、Runnable、ExecutorService、Callable、Future、ThreadPoolExecutor
  - Java数据结构：HashMap ArrayList LinkedList HashSet BlockingQueue ConcurrentHashMap TreeMap
  - JVM：运行时数据区、堆设置、收集器设置、回收日志分析
  - Lambda表达式：stream、filter、collect、map、forEach、
  - 并发与锁：synchronized、ReentrantLock、ReadWriteLock、Atomic；
  - 通讯协议：HTTP、TCP/IP、NIO、BIO、WebSocket
  - 数据结构：表、栈、队列、二叉树、AVL树、BTree、黑红数、散列、图。
  - 常用算法：冒泡排序，选择排序，插入排序、堆排序，归并排序、快速排序；二分查找；布隆过滤器；
  - 设计模式：工厂模式、观察者模式、单例模式、代理模式、命令模式、策略模式
  - Web容器：tomcat、jboss、jetty
  - HTTP服务：httpd、nginx、openResty、kong
  - 工具包：common、poi、gson、guava
  - 构建工具：maven、gradle
  - 通讯框架：netty、mina
  - 序列化：hessian、protostuff、json
  - 服务发现：zookeeper、etcd、eureka、consul
  - 数据库：mysql、mongoDB、redis、mycat、berkeleyDB
  - 连接池：dbcp、c3o0、druid、jdbc、http
  - 大数据：spark、storm、hadoop、hdfs
  - 容器：docker、k8s
  - 监控：zabbix、prometheus
* 开源框架：
  - Spring：IOC、AOP、事务处理
  - SpringMVC：DispatcherServlet、HandlerMapping、HandlerAdapter、Controller、Intercepter、View
  - SpringBoot：集成web、hibernate、mybatis、redis、docker下使用
  - SpringCloud：Netfix、Config、Bus、Eureka、Consul、Stream、Task、Gateway
  - Hibernate：Configuration、SessionFactory、乐观锁、二级缓存、高并发、多数据源
  - Mybatis：Configuration、SqlSession、Executor 、TypeHandler、动态sql、二级缓存
  - Netty：nio、拆念包、future、pipeline
  - Guava：限流算法、布隆过滤器、JVM缓存
  - Hystrix：隔离、熔断、降级
  - 消息队列：rabbitMQ、rocketMQ、kafka
  - RPC框架：dubbo、motan、thrift、grpc
  - 搜索隐形：Lucene、Elasticsearch、Solr
* 数据库：
  - Mysql：主备、读写分、横向纵向拆分、调优、语法、索引、优化
  - Redis：主备、读写分离、持久化、命中和过期
  - MogoDB：集合、文档、文件、索引、聚合函数、分片
* 消息队列：
  - 概念：topic、message、queue、producer、consumer、broker
  - 消息类型：顺序消息、定时消息、延迟消息、事务消息
  - 消息回溯、消息堆积、消息拉取、消息签收
* 高并发：
  - 服务拆分：微服务化、分布式事务、数据库水平垂直拆分
  - 服务治理：zookeeper、rpc
  - 消息队列：异步处理、最终一致性
  - 缓存技术：JVM缓存、redis缓存、nginx缓存、CDN缓存、浏览器缓存。缓存击穿、缓存雪崩、缓存淘汰
  - 并发编程
    + 学习JDK源码
    + 看JVM源码
    + 看CPU架构
    + 在技术点逐渐深度研究的过程中，广度也得到了完善
* 高可用：
  - 负载均衡：算法、动静分离、切换、检测
  - 超时重试：超时时间、重试机制和策略
  - 限流：算法、容器、nginx、防止抖动
  - 隔离：线程隔离、进程隔离、机房隔离、读写隔离、动静隔离，采用hystrix、servlet3做隔离熔断
  - 降级：自动降级、人工降级，控制中心，采用hystrix手段
  - 监控：进程监控、线程监控、机器监控，报警
* 问题解决
  1.如何解决单点故障；(lvs、F5、A10、Zookeep、MQ)
  2.如何保证数据安全性；(热备、冷备、异地多活)
  3.如何解决检索难题；(数据库代理中间件：mysql-proxy、Cobar、MaxScale等;)
  4.如何解决统计分析问题；(离线、近实时)

把精力放在java基础，设计模式，jvm原理，spring+springmvc原理及源码，linux，mysql事务隔离与锁机制，mongodb，http/tcp，多线程，分布式架构（dubbo，dubbox，spring cloud），弹性计算架构，微服务架构（springboot+zookeeper+docker+jenkins），java性能优化，以及相关的项目管理等等。

后端追求的是：三高（高并发，高可用，高性能），安全，存储，业务等等。

## 客户端

- JavaFX
- swing
- Spring

JavaEE/JDBC/Weblogic

## 资源

* [插件库](https://plugins.jetbrains.com/idea)
  - [Cloud Toolkit](https://www.aliyun.com/product/cloudtoolkit): 一款 IDE 插件，可以帮助开发者更高效地开发、测试、诊断并部署应用
* 测试
  - [alibaba/arthas](https://github.com/alibaba/arthas):Alibaba Java Diagnostic Tool Arthas/Alibaba Java诊断利器Arthas https://alibaba.github.io/arthas/
  - [mockito/mockito](https://github.com/mockito/mockito):Most popular Mocking framework for unit tests written in Java http://mockito.org
* datetime
  - [JodaOrg/joda-time](https://github.com/JodaOrg/joda-time):Joda-Time is the widely used replacement for the Java date and time classes prior to Java SE 8. http://www.joda.org/joda-time/
* 框架
  - [lets-blade/blade](https://github.com/lets-blade/blade):🚀 Lightning fast and elegant mvc framework for Java8 https://lets-blade.com

## project

* [b3log/symphony](https://github.com/b3log/symphony):🎶 一款用 Java 实现的现代化社区（论坛/BBS/社交网络/博客）平台。https://hacpai.com https://sym.b3log.org
* [macrozheng/mall](https://github.com/macrozheng/mall):mall项目是一套电商系统，包括前台商城系统及后台管理系统，基于SpringBoot+MyBatis实现。 前台商城系统包含首页门户、商品推荐、商品搜索、商品展示、购物车、订单流程、会员中心、客户服务、帮助中心等模块。 后台管理系统包含商品管理、订单管理、会员管理、促销管理、运营管理、内容管理、统计报表、财务管理、权限管理、设置等模块。 http://39.98.69.210/index.html

## 面试

* [Snailclimb/JavaGuide](https://github.com/Snailclimb/JavaGuide):【Java学习+面试指南】 一份涵盖大部分Java程序员所需要掌握的核心知识。 https://github.com/Snailclimb/JavaGuide
* [可能是一份最适合你的后端面试指南](https://juejin.im/post/5ba591386fb9a05cd31eb85f)
* [doocs/advanced-java](https://github.com/doocs/advanced-java):😮 互联网 Java 工程师进阶知识完全扫盲：涵盖高并发、分布式、高可用、微服务等领域知识

## 教程

* [Java 教程](http://www.runoob.com/java/)
* [Java学习路线图](http://www.jianshu.com/p/d51551b0a8ba)
* [史上最精炼JAVA知识点基础总结](http://www.jianshu.com/p/9caf1c755889)
* [shuzheng/zheng](https://github.com/shuzheng/zheng):基于Spring+SpringMVC+Mybatis分布式敏捷开发系统架构，提供整套公共微服务服务模块：集中权限管理（单点登录）、内容管理、支付中心、用户管理（支持第三方登录）、微信平台、存储系统、配置中心、日志分析、任务和通知等，支持服务治理、监控和追踪，努力为中小型企业打造全方位J2EE企业级开发解决方案。 http://47.93.195.63/zheng-upms-server
* [apachecn/thinking-in-java-zh](https://github.com/apachecn/thinking-in-java-zh):📖 Java 编程思想
* [doocs/advanced-java](https://github.com/doocs/advanced-java):😮 互联网 Java 工程师进阶知识完全扫盲 https://doocs.github.io/advanced-java

## 工具

* [Java SE](https://www.oracle.com/technetwork/java/javase)
* [OpenJDK](http://openjdk.java.net)
* [alibaba/p3c](https://github.com/alibaba/p3c):Alibaba Java Coding Guidelines pmd implements and IDE plugin
* [apache/httpcomponents-core](https://github.com/apache/httpcomponents-core)
* [apache/tomcat](https://github.com/apache/tomcat)
* [apache/jmeter](https://github.com/apache/jmeter)a 100% pure Java application designed to test and measure performance. It may be used as a highly portable server benchmark as well as multi-client load generator.
* [alibaba/fastjson](https://github.com/alibaba/fastjson)A fast JSON parser/generator for Java
* [Apache Camel](https://github.com/apache/camel) is a powerful open source integration framework based on known Enterprise Integration Patterns with powerful Bean Integration.
* [grpc/grpc-java](https://github.com/grpc/grpc-java)The Java gRPC implementation. HTTP/2 based RPC https://grpc.io
* [alibaba/p3c](https://github.com/alibaba/p3c):Alibaba Java Coding Guidelines pmd implements and IDE plugin https://github.com/alibaba/p3c/wiki
* [vipshop/vjtools](https://github.com/vipshop/vjtools):The vip.com's java coding standard, libraries and tools
* [oracle/opengrok](https://github.com/oracle/opengrok):OpenGrok is a fast and usable source code search and cross reference engine, written in Java http://oracle.github.io/opengrok/
* [kevinsawicki/http-request](https://github.com/kevinsawicki/http-request):Java HTTP Request Library
* [ReactiveX/RxJava](https://github.com/ReactiveX/RxJava):RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.
* [qiujiayu/AutoLoadCache](https://github.com/qiujiayu/AutoLoadCache):AutoLoadCache 是基于AOP+Annotation等技术实现的高效的缓存管理解决方案，实现缓存与业务逻辑的解耦，并增加异步刷新及“拿来主义机制”，以适应高并发环境下的使用。
* [eclipse-vertx/vert.x](https://github.com/eclipse-vertx/vert.x):Vert.x is a tool-kit for building reactive applications on the JVM http://vertx.io
* [alibaba/Sentinel](https://github.com/alibaba/Sentinel):A lightweight powerful flow control component enabling reliability and monitoring for microservices. (轻量级的流量控制、熔断降级 Java 库)
* [google/guava](https://github.com/google/guava):Google core libraries for Java
* [SDKMAN](https://sdkman.io):The Software Development Kit Manager
  - `curl -s "https://get.sdkman.io" | bash`
  - `source "$HOME/.sdkman/bin/sdkman-init.sh"`
* [liuanxin/api-document](https://github.com/liuanxin/api-document):java spring-mvc document collect

## 参考

* Alibaba Java Code Guidelines
* [aalansehaiyang/technology-talk](https://github.com/aalansehaiyang/technology-talk)：汇总java生态圈常用技术框架、开源中间件，系统架构、项目管理、经典架构案例、数据库、常用三方库、线上运维等知识
- [zhanglei-workspace/shopping-management-system](https://github.com/zhanglei-workspace/shopping-management-system)
* [iluwatar/java-design-patterns](https://github.com/iluwatar/java-design-patterns):Design patterns implemented in Java http://java-design-patterns.com
* [Java Algorithm And Data Structure Interview Questions and Programs](http://www.codespaghetti.com/java-algorithms-questions/)
* [Snailclimb/JavaGuide](https://github.com/Snailclimb/JavaGuide):A core knowledge that most Java programmers need to master https://github.com/Snailclimb/JavaGuide
* [google/guava](https://github.com/google/guava):Google core libraries for Java
* [crossoverJie/JCSprout](https://github.com/crossoverJie/JCSprout):👨‍🎓 Java Core Sprout : basic, concurrent, algorithm
* [安装教程](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-debian-8)类debian系统
* [Java并发](https://mp.weixin.qq.com/s?__biz=MjM5MzA1Mzc3Nw==&mid=2247484908&idx=1&sn=fe9004cd8369cabf448c9f43466bad0f&chksm=a69da8d291ea21c493d82e63705604055e2bd4d09f42c5e835051e3187a9cfefa317e6484b65)
* [ruibaby/halo](https://github.com/ruibaby/halo):Halo可能是最好的Java博客系统😉 https://docs.halo.run
