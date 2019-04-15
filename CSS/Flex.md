# Flexbox

2009年，W3C 提出了一种新的方案----Flex 布局，可以简便、完整、响应式地实现各种页面布局.是 Flexible Box 的缩写，意为"弹性布局"，用来为盒状模型提供最大的灵活性。设为 Flex 布局以后，子元素的float、clear和vertical-align属性将失效

## container

所有子元素自动成为容器成员，称为 flex item

* 水平的主轴（main axis）和垂直的交叉轴（cross axis）
    - 主轴的开始位置（与边框的交叉点）叫做main start，结束位置叫做main end
    - 交叉轴的开始位置叫做cross start，结束位置叫做cross end
    - 项目默认沿主轴排列。单个项目占据的主轴空间叫做main size，占据的交叉轴空间叫做cross size
* 属性
    - flex-direction：决定主轴的方向（即项目的排列方向）
        + row（默认值）：主轴为水平方向，起点在左端。
        + row-reverse：主轴为水平方向，起点在右端。
        + column：主轴为垂直方向，起点在上沿。
        + column-reverse：主轴为垂直方向，起点在下沿
    - flex-wrap：定义如果一条轴线排不下，如何换行
        + nowrap（默认）：不换行。
        + wrap：换行，第一行在上方。
        + wrap-reverse：换行，第一行在下方
    - flex-flow：flex-direction属性和flex-wrap属性的简写形式，默认值为row nowrap
    - justify-content：定义了项目在主轴上的对齐方式
        + lex-start（默认值）：左对齐
        + flex-end：右对齐
        + center： 居中
        + space-between：两端对齐，项目之间的间隔都相等。
        + space-around：每个项目两侧的间隔相等。所以，项目之间的间隔比项目与边框的间隔大一倍。
    - align-items：定义项目在交叉轴（单行）上如何对齐
        + flex-start：交叉轴的起点对齐。
        + flex-end：交叉轴的终点对齐。
        + center：交叉轴的中点对齐。
        + baseline: 项目的第一行文字的基线对齐。
        + stretch（默认值）：如果项目未设置高度或设为auto，将占满整个容器的高度。
    - align-content：定义了多根轴线的对齐方式。如果项目只有一根轴线，该属性不起作用
        + flex-start：与交叉轴的起点对齐。
        + flex-end：与交叉轴的终点对齐。
        + center：与交叉轴的中点对齐。
        + space-between：与交叉轴两端对齐，轴线之间的间隔平均分布。
        + space-around：每根轴线两侧的间隔都相等。所以，轴线之间的间隔比轴线与边框的间隔大一倍。
        + stretch（默认值）：轴线占满整个交叉轴。
    - 对称的思想
    - display:inline-flex解决display:inline-block空格问题

## item

* order:定义项目的排列顺序。数值越小，排列越靠前，默认为0
* flex-grow:定义空间剩余项目的放大比例，默认为0，即如果存在剩余空间，也不放大
* flex-shrink:定义空间不足项目的缩小比例，默认为1，当不够分配时，元素都将等比例缩小，占满整个宽度
    - 所有项目的flex-shrink属性都为1，当空间不足时，都将等比例缩小。
    - 如果一个项目的flex-shrink属性为0，其他项目都为1，则空间不足时，前者不缩小
* flex-basis:定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为auto，即项目的本来大小.可以设为跟width或height属性一样的值（比如350px），则项目将占据固定空间
* flex:flex-grow, flex-shrink 和 flex-basis的简写，默认值为0 1 auto。后两个属性可选。该属性有两个快捷值：auto (1 1 auto) 和 none (0 0 auto)
* align-self:允许单个项目有与其他项目不一样的对齐方式，可覆盖align-items属性。默认值为auto，表示继承父元素的align-items属性，如果没有父元素，则等同于stretch

## 参考

* [philipwalton/solved-by-flexbox](https://github.com/philipwalton/solved-by-flexbox):A showcase of problems once hard or impossible to solve with CSS alone, now made trivially easy with Flexbox. https://philipwalton.github.io/solved-by-flexbox/
* [CSS Flexible Box Layout Module Level 1](https://www.w3.org/TR/css-flexbox-1/)
* [Flex 布局教程：语法篇](https://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)
* [CSS Flexible Box Layout Module Level 1](https://www.w3.org/TR/css-flexbox-1)
* [30分钟彻底弄懂flex布局](https://cloud.tencent.com/developer/article/1354252)
