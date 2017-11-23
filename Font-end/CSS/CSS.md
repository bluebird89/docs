# 自适应网页设计（Responsive Web Design)

一次设计，普遍适用，可以自动识别屏幕宽度、并做出相应调整的网页设计。

## 显示

- 像素（pixels）：显示器上的图像是由许多点构成的，这些点称为像素，意思就是"构成图像的元素"。500×300像素，是分辨率的尺寸单位。是指在由一个数字序列表示的图像中的一个最小单位
- 像素每英寸PPI（pixels per inch）为单位来表示影像分辨率的大小。

## 设备：

- mobile
- PC

- 实现：

  - 头部添加标签，viewport是网页默认的宽度和高度，上面这行代码的意思是，网页宽度默认等于屏幕宽度（width=device-width），原始缩放比例（initial-scale=1）为1.0，即网页初始大小占屏幕面积的100%。网页会根据屏幕宽度调整布局，所以不能使用绝对宽度的布局，也不能使用具有绝对宽度的元素，使用百分比或auto，字体使用相对大小（em）；

    ```html
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    ```

  - 流动布局：各个区块的位置都是浮动的，不是固定不变的。如果宽度太小，放不下两个元素，后面的元素会自动滚动到前面元素的下方，不会在水平方向overflow（溢出），避免了水平滚动条的出现。

  - "自适应网页设计"的核心，就是CSS3引入的Media Query模块。它的意思就是，自动探测屏幕宽度，然后加载相应的CSS文件。

    ```html
    <link rel="stylesheet" type="text/css"
    　　　　media="screen and (min-width: 400px) and (max-device-width: 600px)"
    　　　　href="smallScreen.css" />
    @import url("tinyScreen.css") screen and (max-device-width: 400px);
    ```

  - CSS实现

    ```css
    @media screen and (max-device-width: 400px) {
    　　　　.column {
    　　　　　　float: none;
    　　　　　　width:auto;
    　　　　}
    　　　　#sidebar {
    　　　　　　display:none;
    　　　　}
    　　}
    ```

  - 图片 视频的自动缩放

    ```html
    img, object { max-width: 100%;}

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
    <style>
      .red-text {
        color: red;
      }
      h2{
        font-family: Lobster;
      }
      p {
        font-size: 16px;
        font-family: Monospace;
      }
    </style>
    ```

## 框架

自适应

- 方法：
- 组件：表单 、表格、图标、面包屑、菜单、导航、Modal 窗口
- 修改源代码

## 扩展

- [scottjehl/Respond](https://github.com/scottjehl/Respond):A fast & lightweight polyfill for min/max-width CSS3 Media Queries (for IE 6-8, and more)
- [IanLunn/Hover](https://github.com/IanLunn/Hover):A collection of CSS3 powered hover effects to be applied to links, buttons, logos, SVG, featured images and so on. Easily apply to your own elements, modify or just use for inspiration. Available in CSS, Sass, and LESS. http://ianlunn.github.io/Hover/
- [basscss/basscss](https://github.com/basscss/basscss):Low-level CSS Toolkit http://basscss.com
- [daneden/animate.css](https://github.com/daneden/animate.css):🍿 A cross-browser library of CSS animations. As easy to use as an easy thing. http://daneden.github.io/animate.css
- [necolas/normalize.css](https://github.com/necolas/normalize.css):A collection of HTML element and attribute style-normalizations http://necolas.github.io/normalize.css/
