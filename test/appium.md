# Appium

基于Node.js.Appium通过UI Automator与Android SDK的绑定来驱动Android的自动化。过程与IOS的测试很相似。Appium作为一个HTTP server接受来自JSON线协议的test脚本命令。Appium发送这些命令给UI Automator，以便于他们能在模拟器或者真实的设备上执行。在这之间，Appium把JSON命令翻译成Android SDK能识别的UI Automator的java命令。

* appium是开源的移动端自动化测试框架
* appium可以测试原生的、混合的、以及移动端的web项目
* appium可以测试ios，android应用（当然了，还有firefoxos）
* appium是跨平台的，可以用在osx，windows以及linux桌面系统上
* Appium 允许使用selenium webdriver框架来构建移动测试

Appium在Android上基于UIAutomator实现了测试的代理程序（Bootstrap.jar），在iOS上基于UIAutomation实现了测试的代理程序（Bootstrap.js）。当测试脚本运行时，每行WebDriver的脚本都将转换成Appium的指令发送给Appium服务器，而Appium服务器将测试指令交给代理程序，将由代理程序负责执行测试。比如脚本上的一个点击操作，在Appium服务器上都是touch指令，当指令发送到Android系统上时，Android系统上的Bootstrap.jar将调用UIAutomator的方法实现点击操作；而当指令发送到iOS系统上时，iOS的Bootstrap.js将调用UIAutomation的方法实现点击操作。由于Appium有了这样的能力，同样的测试脚本可以实现跨平台运行。

## 原理

由客户端（Appium Client）和服务器（Appium Server）两部分组成，客户端与服务器端通过JSON Wire Protocol进行通信。

* Appium服务器：Appium服务器是Appium框架的核心。它是一个基于Node.js实现的HTTP服务器。Appium服务器的主要功能是接受从Appium客户端发起的连接，监听从客户端发送来的命令，将命令发送给bootstrap.jar（iOS手机为bootstrap.js）执行，并将命令的执行结果通过HTTP应答反馈给Appium客户端。
* Bootstrap.jar：Bootstrap.jar是在Android手机上运行的一个应用程序，它在手机上扮演TCP服务器的角色。当Appium服务器需要运行命令时，Appium服务器会与Bootstrap. jar建立TCP通信，并把命令发送给Bootstrap.jar; Bootstrap.jar负责运行测试命令。
* Appium客户端：它主要是指实现了Appium功能的WebDriver协议的客户端Library，它负责与Appium服务器建立连接，并将测试脚本的指令发送到Appium服务器。现有的客户端Library有多种语言的实现，包括Ruby、Python、Java、JavaScript（Node. js）、Object C、PHP和C#。Appium的测试是在这些Library的基础上进行开发的。
* Session：Appium的客户端和服务端之间进行通信都必须在一个Session的上下文中进行。客户端在发起通信的时候首先会发送一个叫作“Desired Capabilities”的JSON对象给服务器。服务器收到该数据后，会创建一个session并将session的ID返回到客户端。之后客户端可以用该session的ID发送后续的命令。
* Desired Capabilities：Desired Capabilities是一组设置的键值对的集合，其中键对应设置的名称，而值对应设置的值。Desired Capabilities主要用于通知Appium服务器建立需要的Session，其中一些设置可以在Appium运行过程中改变Appium服务器的运行行为。

## 安装

### 服务端

* 视图安装 [appium/appium-desktop](https://github.com/appium/appium-desktop):Appium Server and Inspector in Desktop GUIs for Mac, Windows, and Linux
* 指令安装
  - node
  - npm install appium-doctor -g
  - JDK安装以及添加环境变量：新建JAVA_HOME E:\Java\jdk1.7.0-》path添加%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin-〉CLASSPATH 变量,值填写.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar
  - android SDK安装以及添加环境变量：ANDROID_HOME设置其值为Android SDK路径如：F:/android_sdk-》path添加%ANDROID_HOME%\tools;%ANDROID_HOME%\platform-tools

```sh
# 配置环境变量  ANDROID_HOME JAVA_HOME
brew install node
brew install carthage
install -g grunt-cli
npm install -g appium # 安装appium-server
npm install -g appium-doctor # 用于检测appium运行环境
npm install -g wd # webdriver

appium-doctor # 监测配置
appium
```

### 客户端

appiumclient是对webdriver原生api的一些扩展和封装。它可以帮助我们更容易的写出用例，写出更好懂的用例。

## 参考

* [appium/appium](https://github.com/appium/appium): 📱 Automation for iOS, Android, and Windows Apps. <http://appium.io/>
