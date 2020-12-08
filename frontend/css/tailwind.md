## [tailwindcss](https://github.com/tailwindcss/tailwindcss)

A utility-first CSS framework for rapid UI development.  <https://tailwindcss.com/>

* 实用优先的工具集 CSS 框架
* 使用 PostCSS 处理最终输出

## Tailwind vs Bootstrap

* Bootstrap 开箱提供了丰富的布局、组件和样式库，可以不做任何调整直接拿来使用，这在构建一些内部项目或者验证原型的时候非常方便，但是如果需要定制自定义的样式风格，则需要覆盖默认的样式属性，这可能会导致大量无效样式属性的加载
* Tailwind 恰恰相反，开箱什么组件和样式库都没有提供，一切都需要自己DIY：需要自行去为每个页面元素设计样式，然后组合使用 Tailwind 提供的工具集 class（每个 class 通常只负责设置单个属性，而不是像 Bootstrap 那样包含一堆属性）达到最终的渲染效果
  - 使用 Tailwind 每个 HTML 元素的 class 属性通常会有一连串值，这看起来好像很麻烦
  - Tailwind 的优点正好弥补了 Bootstrap 的不足：对于一些长期维护的、面向用户的、需要有定制样式风格的项目，不需要去加载和覆盖框架内置的样式属性，就可以轻松设计定制出自己独特风格的样式代码
* Tailwind 不是银弹，你需要按照自己的项目需求去选择合适的 CSS 框架，对于内部系统、管理后台、原型项目，使用 Bootstrap 可能更合适，而对于需要长期维护的前端界面、或者需要定制设计样式风格的项目，则使用 Tailwind 可能更合适
* 要自定义扩展页面样式，Bootstrap 使用的是继承的方式实现，而 Tailwind 则使用的是组合的方式实现

## 工具

* [tailblocks](https://github.com/mertJF/tailblocks): tada Ready-to-use Tailwind CSS blocks. <https://mertjf.github.io/tailblocks/>
