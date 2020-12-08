# UE

* IxD(Interaction design):定义了两个或多个互动的个体之间交流的结构和行为
* UID(User Interface Design)
  - 输入控件：按钮、文本框、选取框、单选按钮、下拉列表、列表框、开关按钮、
  - 导航控件：面包削导航、滑块、搜索栏、分页、标签、
  - 图标信息控件：文本提示框、图标、进度条、提示、消息框、模式窗口
  - 行业工具：Photoshop, Sketch, Illustrator, Fireworks, InVision
* UED(User Expericence Design):用户体验设计（也可叫做UXD、UED、XD)，是指通过提高产品的可用性、易用性、以及人与产品交互过程中的愉悦程度，从而来提高用户满意度的过程。用户体验设计包括传统的人机交互（HCI），并且延伸到解决所有与用户感受相关的问题。
  - 交付物：线框图、原型图、网站地图、说明文档
  - 行业工具: Sketch、 Mockplus、Axure、Fireworks、UXPin
* UCD(User Centered Design):Business Technique User
* IA(Infomation Architect):网站、App的结构安排以及内容是如何组织的，目的是帮助用户快速找到信息并且完成操作。包括设计网站地图、层次结构、分类、导航和元数据

## 验证类型

验证
后续动作
边界条件

* 输入
* 表单

### 交互

```html
<!-- 取消分享 -->
<meta name="xiaoheiban_disable_share" content="true">
<!-- 微信分享链接显示 -->
<meta name="sharecontent" data-msg-img="你的缩略图地址" data-msg-title="你的标题" data-msg-content="你的简介" data-msg-callBack="" data-line-img="你的缩略图地址" data-line-title="你的标题" data-line-callBack=""/>
<!-- 字符长度限制 -->
<input type="text" maxlength="10"/>
<!-- 输入处理：keyup -->
<input class="correct2" id="password" type = "password" name="text" maxlength="16" onchange="value=value.replace(/[^\d]/g,'')" oninput="value=value.replace(/[^\a-\z\A-\Z0-9]/g,'')"  onbeforepaste="clipboardData.setData()"/>
<script src="">
// 页面重载
    location.reload();
    location.replace("http://www.runoob.com")
    // 每隔5秒刷新一次页面。
    <meta http-equiv="refresh" content="5">
</script>
```

## UED 用户体验设计

* 设计（风格，颜色，搭配，各种 Icon 的设计，灵感来源，展现的小心思）
* 交互（从上到下的引导以及用户本身培养的习惯；交互涉及到的信息展现方式，如轮播，闪动，变色，变大小，弹出……）
* 流量结构到购买路径分析，流量的每一个动作的动机和需求
* 需要很多专业研究，多次试验，通过数据和用户调查，加以迭代
* 淘宝的UED还只能算是基础，更加专业的垂直网站设计才叫给力。不过更加专业基本就可以做产品经理了。
