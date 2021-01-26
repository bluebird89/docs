# [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components)

* 由 W3C 维护的技术概念集
  - Shadow DOM:对服务端渲染的高度破坏
  - Custom Elements
  - HTML Templates
  - CSS changes
* 否定涉及到两个层面：
  - 作为交互中间层的场景下，Shadow DOM、Custom Elements 和 HTML Templates 解决的问题是完全独立的：Shadow DOM 用于辅助样式隔离，Custom Elements 用于简化启动代码，而 HTML Templates 用于内部实现对中间层封装毫无帮助。作为技术选型而言，每个问题的解决方案也是相互正交的，因此 Web Components 这个伪概念在此并不能发挥任何整体价值；
  - Shadow DOM、Custom Elements 分别都不是相应问题的有效解决方案
