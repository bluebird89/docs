# [Selenium](https://www.selenium.dev/)

推荐ruby ,python ,java 任意一门语言来进行学习

## 安装

```sh
pip install -U selenium # mac报错

brew install selenium-server-standalone
brew install chromedriver

selenium-server -port 4444 # 启动服务
```

### selenium IDE

* 嵌入到Firefox浏览器中的一个插件，实现简单的浏览器操作的录制与回放功能
* 快速的创建bug重现脚本，在测试人员的测试过程中，发现了bug之后可以通过IDE将重现的步骤录制下来，以帮助开发人员更容易的重现bug。
* IDE录制的脚本可以可以转换成多种语言，从而帮助我们快速的开发脚本

### selenium Grid

* 一种自动化的测试辅助工具，Grid通过利用现有的计算机基础设施，能加快Web-app的功能测试
* 利用Grid，可以很方便地同时在多台机器上和异构环境中并行运行多个测试事例。其特点为：
	+ 并行执行
	+ 通过一个主机统一控制用例在不同环境、不同浏览器下运行。
	+ 灵活添加变动测试机

### selenium RC

* 核心工具，selenium RC 支持多种不同的语言编写自动化测试脚本，通过selenium RC 的服务器作为代理服务器去访问应用从而达到测试的目的。
	- Client Libraries库主要主要用于编写测试脚本，用来控制selenium Server的库。
	- Selenium Server负责控制浏览器行为
		+ Selenium Core是被Selenium Server嵌入到浏览器页面中的。其实Selenium Core就是一堆JS函数的集合，就是通过这些JS函数，才可以实现用程序对浏览器进行操作。
		+ Launcher用于启动浏览器，把selnium Core加载到浏览器页面当中，并把浏览器的代理设置为Selenium Server 的Http Proxy。

### selenium 2.0

　　selenium 2.0 = selenium 1.0 + WebDriver

　　需要强调的是，在selenium 2.0 中主推的是WebDriver ，WebDriver 是selenium RC 的替代品，因为 selenium 为了向下兼容性，所以selenium RC 并没有彻底抛弃，如果你使用selenium开发一个新自动化测试项目，强列推荐使用WebDriver 。那么selenium RC 与webdriver 主要有什么区别呢？

　　selenium RC 在浏览器中运行JavaScript应用，使用浏览器内置的JavaScript 翻译器来翻译和执行selenese命令（selenese 是selenium命令集合）。

　　WebDriver通过原生浏览器支持或者浏览器扩展直接控制浏览器。WebDriver针对各个浏览器而开发，取代了嵌入到被测Web应用中的JavaScript。与浏览器的紧密集成支持创建更高级的测试，避免了JavaScript安全模型导致的限制。除了来自浏览器厂商的支持，WebDriver还利用操作系统级的调用模拟用户输入。

　　如果是新项目直接学习webdriver 就OK了，RC是过时技术。

## 学习路线

* 需要熟悉webdriver API
* 先学习元素的定位，selenium 提供了id、name、class name、 tag name、link text、partial link text、 xpath、css、等定位方法。xpath和css 功能强大语法稍微复杂，在这其间你可能还需要了解更多的前端知识。xml ,javascript 等。
* 定位元素的目的是为了操作元素，接就要学习各种元素有操作，输入框，下拉框，按钮点击，文件上传、下载，分页，对话框，警告框...等等
* 需要做的就是学习并使用单元测试框架，单元测试框架本身就解决了用例的组织与运行
