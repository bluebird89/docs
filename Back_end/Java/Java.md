# Java：

Java是由Sun Microsystems公司于1995年5月推出的Java面向对象程序设计语言和Java平台的总称。由James Gosling和同事们共同研发，并在1995年正式推出。Java编程语言的风格十分接近C++语言。继承了C++语言面向对象技术的核心，Java舍弃了C++语言中容易引起错误的指针，改以引用取代，同时移除原C++与原来运算符重载，也移除多重继承特性，改用接口取代，增加垃圾回收器功能。在Java SE 1.5版本中引入了泛型编程、类型安全的枚举、不定长参数和自动装/拆箱特性。太阳微系统对Java语言的解释是："Java编程语言是个简单、面向对象、分布式、解释性、健壮、安全与系统无关、可移植、高性能、多线程和动态的语言"。

Java不同于一般的编译语言或直译语言。它首先将源代码编译成字节码，然后依赖各种不同平台上的虚拟机来解释执行字节码，从而实现了"一次编写，到处运行"的跨平台特性。在早期JVM中，这在一定程度上降低了Java程序的运行效率。但在J2SE1.4.2发布后，Java的运行速度有了大幅提升。执行Java应用程序必须安装爪哇运行环境（Java Runtime Environment，JRE），JRE内部有一个Java虚拟机（Java Virtual Machine，JVM）以及一些标准的类库（Class Library）。通过JVM才能在电脑系统执行Java应用程序（Java Application），这与.Net Framework的情况一样，所以电脑上没有安装JVM，那么这些程序将不能够执行。 实现跨平台性的方法是大多数编译器在进行Java语言程序的编码时候会生成一个用字节码写成的"半成品"，这个"半成品"会在Java虚拟机（解释层）的帮助下运行，虚拟机会把它转换成当前所处硬件平台的原始代码。之后，Java虚拟机会打开标准库，进行数据（图片、线程和网络）的访问工作。主要注意的是，尽管已经存在一个进行代码翻译的解释层，有些时候Java的字节码代码还是会被JIT编译器进行二次编译。 C++语言被用户诟病的原因之一是大多数C++编译器不支持垃圾收集机制。通常使用C++编程的时候，程序员于程序中初始化对象时，会在主机内存堆栈上分配一块内存与地址，当不需要此对象时，进行析构或者删除的时候再释放分配的内存地址。如果对象是在堆栈上分配的，而程序员又忘记进行删除，那么就会造成内存泄漏（Memory Leak）。长此以往，程序运行的时候可能会生成很多不清除的垃圾，浪费了不必要的内存空间。而且如果同一内存地址被删除两次的话，程序会变得不稳定，甚至崩溃。因此有经验的C++程序员都会在删除之后将指针重置为NULL，然后在删除之前先判断指针是否为NULL。 C++中也可以使用"智能指针"（Smart Pointer）或者使用C++托管扩展编译器的方法来实现自动化内存释放，智能指针可以在标准类库中找到，而C++托管扩展被微软的Visual C++ 7.0及以上版本所支持。智能指针的优点是不需引入缓慢的垃圾收集机制，而且可以不考虑线程安全的问题，但是缺点是如果不善使用智能指针的话，性能有可能不如垃圾收集机制，而且不断地分配和释放内存可能造成内存碎片，需要手动对堆进行压缩。除此之外，由于智能指针是一个基于模板的功能，所以没有经验的程序员在需要使用多态特性进行自动清理时也可能束手无策。 Java语言则不同，上述的情况被自动垃圾收集功能自动处理。对象的创建和放置都是在内存堆栈上面进行的。当一个对象没有任何引用的时候，Java的自动垃圾收集机制就发挥作用，自动删除这个对象所占用的空间，释放内存以避免内存泄漏。

openJDK版本

- JavaSE(J2SE）（Java2 Platform Standard Edition，java平台标准版）
- JavaEE(J2EE)(Java 2 Platform,Enterprise Edition，java平台企业版)
- JavaME(J2ME)(Java 2 Platform Micro Edition，java平台微型版)。

JDK：Java Development Kit
JRE: Java Runtime Environment

## [安装教程](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-debian-8)类debian系统

### linux

```sh
# using the version packaged with Debian：OpenJDK 8
sudo apt-get update
sudo apt-get install default-jre
# JDK 包含JRE(**推荐**)
sudo apt-get install default-jdk

# Installing the Oracle JDK
sudo apt-get install software-properties-common
sudo add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
sudo apt-get update
sudo apt-get install oracle-java8-installer
javac -version

sudo apt-get install oracle-java9-installer
# 多版本管理
sudo update-alternatives --config java | javac // 会获得程序路径

## JAVA_HOME Environment Variable配置
sudo vim /etc/environment # 添加 JAVA_HOME="/usr/lib/jvm/java-8-oracle"
source /etc/environment
echo $JAVA_HOME
java -version
```

### Mac

* 下载[资源包](http://www.oracle.com/technetwork/java/javase/downloads/index.html)
* 安装
* 配置环境变量
* 确认shell,修改配置文件,添加环境变量

```sh
# mac
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home
export PATH=${PATH}:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 或者
JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

export JAVA_HOME

source .bash_profile 或 source .zshrc
```

### 例子

```java
// 新建文件 HelloWorld.java
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

## Tomcat

### 在线安装

```sh
  sudo apt-get install tomcat8
  sudo vim /etc/default/tomcat8
  JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC" // 修改内存使用
  sudo service tomcat8 restart
  访问 http://localhost:8080
  sudo apt-get install tomcat8-docs tomcat8-admin tomcat8-examples
  sudo vim /etc/tomcat7/tomcat-users.xml // 配置管理后台
  <tomcat-users>
    <user username="admin" password="password" roles="manager-gui,admin-gui"/>
  </tomcat-users> 
  sudo service tomcat8 restart
  访问 http://localhost:8080/docs/
  访问 http://localhost:8080/examples/ 
  Virtual Host Manager http://localhost:8080/manager/html/
```

- /usr/share/tomcat8/：安装程序路径
- /var/lib/tomcat8/：应用程序、配置与日志
- /etc/tomcat8/：服务器配置server.xml 用户配置：tomcat-users.xml
- 命令行脚本：sudo /etc/init.d/tomcat8 start
- Tomcat 配置文件路径:Tomcat home directory : /usr/share/tomcat8 Tomcat base directory : /var/lib/tomcat8或/etc/tomcat8
- Tomcat的用户帐号信息都保存在 /var/lib/tomcat6/conf/tomcat-users.xml 的文件中
- 默认根目录：/usr/share/tomcat8-root

### 手动安装

```sh
sudo apt-get update
sudo apt-get install default-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat   // a home directory of /opt/tomcat (where we will install Tomcat)  with a shell of /bin/false (so nobody can log into the account) 
cd /tmp  // 存放临时文件
curl -O http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.5/bin/apache-tomcat-8.5.5.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/ 

// /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl start tomcat
```

## maven

```sh
sudo apt-get install maven2
```

## 客户端

- JavaFX
- swing
- Spring

JavaEE/JDBC/Weblogic

Oracle 已选择 Eclipse 基金会作为 Java EE 的新东家。甲骨文与该平台的另外两大贡献者 ---- IBM 和 Red Hat 共同做出了这个决定

## IDE:IntelliJ IDEA

[插件库](https://plugins.jetbrains.com/idea)

## 框架

- netty
- Spring

## 线程

* [Java 教程](http://www.runoob.com/java/)
* [Java学习路线图](http://www.jianshu.com/p/d51551b0a8ba) 
* [史上最精炼JAVA知识点基础总结](http://www.jianshu.com/p/9caf1c755889)
* [shuzheng/zheng](https://github.com/shuzheng/zheng):基于Spring+SpringMVC+Mybatis分布式敏捷开发系统架构，提供整套公共微服务服务模块：集中权限管理（单点登录）、内容管理、支付中心、用户管理（支持第三方登录）、微信平台、存储系统、配置中心、日志分析、任务和通知等，支持服务治理、监控和追踪，努力为中小型企业打造全方位J2EE企业级开发解决方案。 http://47.93.195.63/zheng-upms-server

## 工具

* Maven
* [apache/httpcomponents-core](https://github.com/apache/httpcomponents-core)
* [apache/tomcat](https://github.com/apache/tomcat)
* [apache/jmeter](https://github.com/apache/jmeter)a 100% pure Java application designed to test and measure performance. It may be used as a highly portable server benchmark as well as multi-client load generator.
* [alibaba/fastjson](https://github.com/alibaba/fastjson)A fast JSON parser/generator for Java
* [Apache Camel](https://github.com/apache/camel) is a powerful open source integration framework based on known Enterprise Integration Patterns with powerful Bean Integration. 
* [grpc/grpc-java](https://github.com/grpc/grpc-java)The Java gRPC implementation. HTTP/2 based RPC https://grpc.io
* [alibaba/p3c](https://github.com/alibaba/p3c):Alibaba Java Coding Guidelines pmd implements and IDE plugin https://github.com/alibaba/p3c/wiki

## 参考

- [zhanglei-workspace/shopping-management-system](https://github.com/zhanglei-workspace/shopping-management-system)
* [iluwatar/java-design-patterns](https://github.com/iluwatar/java-design-patterns):Design patterns implemented in Java http://java-design-patterns.com
