## Gauge+Taiko

* [gauge](https://github.com/getgauge/gauge):Light weight cross-platform test automation <https://gauge.org>
  - 一款开源的轻量级跨平台自动化测试工具，它的愿景是用更少的代码、更少的维护工作实现更多的自动化测试
  - 采用Markdown格式，支持用自然语言编写Spec，语法自由，编写工作简单易上手，不管是对业务人员还是技术人员都很友好；写出来的文档格式清晰，很好维护。
  - Gauge本身可以实现对Web页面的访问和控制，支持多种语言，各种API封装的很好，代码实现部分比Selenium要简单很多，尤其对于编程技能不是那么强的QA来讲非常友好，易上手，代码的可读性也更强一些。
* [Taiko](https://taiko.gauge.org/)：一款开源浏览器自动化测试工具
  - 交互式的录制体验。Taiko提供类似于irb的REPL，直接输入命令，可以看到浏览器执行结果，同时后续还可以把成功执行的命令直接生成JS代码，非常方便。
  - Taiko不仅提供常见UI自动化测试工具那样根据Id、name、CSS、Xpath等方式选择页面元素的功能，还提供智能选择器（Smart selector），支持直接根据显示的文本来定位各种类型的页面元素，同时还有支持上、下、左、右这种根据某个元素的相对方位去定位元素的API，很好的解决UI测试页面元素定位难的问题。
  - Taiko采用隐式的等待（Wait）方式，也可以手动设置超时时间以防有些访问等待时间过长。这种隐式等待相比其他自动化工具需要手动设置等待时间的显式等待方式要更高效、更稳定。
  - 与Gauge的完美结合：Taiko在REPL里执行的浏览器操作步骤，可以通过一个简单的命令直接生产Gauge支持的Step，只需要再去简单的加上step名称就可以，操作及其简单

```
Spec定义

# Google Search

This is an executable specification file. This file follows markdown syntax.
Every heading in this file denotes a scenario.
Every bullet point denotes a step.
To execute this specification, use
    npm test

## Finding some cheese
* Goto Google search page
* Google for "Cheese!"
* Page title starts with "Cheese"

Steps实现

step("Goto Google search page", async function() {
  await goto("www.google.com");
});

step("Google for <query>", async (query) => {
  await write(query);
  await click("Google 搜尋");
});

step("Page title starts with <content>", async (content) => {
  await title().then((pageTitle) =>{
    assert.ok(pageTitle.startsWith(content));
  });
});
```

## 参考

* [Docs](https://docs.gauge.org/)
* [](https://blog.csdn.net/amoscn/article/details/77713775)
