# [jquery/jquery](https://github.com/jquery/jquery)

jQuery JavaScript Library https://jquery.com/

* 消除浏览器差异：你不需要自己写冗长的代码来针对不同的浏览器来绑定事件，编写AJAX等代码；
* 简洁的操作DOM的方法：写$('#test')肯定比document.getElementById('test')来得简洁；
* 轻松实现动画、修改CSS等各种操作。

jQuery把所有功能全部封装在一个全局变量jQuery中，而$也是一个合法的变量名，它是变量jQuery的别名：
`$`本质上就是一个函数，但是函数也是对象，于是`$`除了可以直接调用外，也可以有很多其他属性。`$`函数名可能不是j`Query(selector, context)`，因为很多JavaScript压缩工具可以对函数名和参数改名，所以压缩过的jQuery源码$函数可能变成`a(b, c)`。

$_分离出来，如果_$这个变量不幸地被占用了，而且还不能改，那我们就只能让jQuery把$变量交出来，然后就只能使用jQuery这个变量

```html
<script type="text/javascript" src="jquery.js"></script>

<script>
$.fn.jQuery; // 查看版本

window.jQuery; // jQuery(selector, context)
window.$; // jQuery(selector, context)
$; // jQuery(selector, context)
jQuery.noConflict();
$; // undefined
jQuery; // jQuery(selector, context)
$ === jQuery; // true
typeof($); // 'function'

// 为了防止文档在完全加载（就绪）之前运行 jQuery 代码:试图隐藏一个不存在的元素   获得未完全加载的图像的大小
$(document).ready(function(){

--- jQuery functions go here ----

});
</script>
```

## 特点

* 语法糖：链式调用、实用函数
* 选择元素：基于各种标准选择符和库自定义的选择符，以及通过回调进行筛选
* 操作DOM：创建和操作元素，乃至各种属性操作
* 处理事件：ready事件及各种注册和触发事件的方法，乃至委托
* 动画：基于animate的CSS属性动画，以及内置动画方法
* Ajax：封装原生的XMLHttpRequest API，简化请求方法及回调处理

## 功能

* HTML元素选取与操作
* HTML事件函数
* CSS操作
* JavaScript特效和动画
* HTML DOM遍历和修改
* AJAX

### 选择器

返回的对象是jQuery对象(类似数组，它的每个元素都是一个引用了DOM节点的对象),不会返回undefined或者null，这样的好处是你不必在下一行判断if (div === undefined)。
jQuery对象和DOM对象之间可以互相转化:拿到了一个DOM对象，那可以简单地调用$(aDomObject)把它变成jQuery对象

* 按元素查找 $("button")、$("h1")
* 按ID查找 $("#target1")
* 按tag查找
* 按class查找 $(".target")
* 按属性查找：除了id和class外还可以有很多属性，很多时候按属性查找会非常方便
    - 当属性的值包含空格等特殊字符时，需要用双引号括起来。
    - 按属性查找还可以使用前缀查找或者后缀查找：
* 组合查找：就是把上述简单选择器组合起来使用
* 多项选择器:就是把多个选择器用,组合起来一块选：选出来的元素是按照它们在HTML中出现的顺序排列的，而且不会有重复元素。例如，`<p class="red green">`不会被上面的$('p.red,p.green')选择两次。
* 层级选择器（Descendant Selector）: `$('ancestor descendant')`层级之间用空格隔开.层级选择器相比单个的选择器好处在于，它缩小了选择范围，因为首先要定位父节点，才能选择相应的子节点，这样避免了页面其他不相关的元素。多层选择也是允许
* 子选择器（Child Selector）:$('parent>child')类似层级选择器，但是限定了层级关系必须是父子关系，就是<child>节点必须是<parent>节点的直属子节点
* 过滤器一般不单独使用，它通常附加在选择器上，帮助我们更精确地定位元素.
* 表单元素，jQuery还有一组特殊的选择器
    - :input：可以选择<input>，<textarea>，<select>和<button>；
    - :file：可以选择<input type="file">，和input[type=file]一样；
    - :checkbox：可以选择复选框，和input[type=checkbox]一样；    - radio：可以选择单选框，和input[type=radio]一样；
    - :focus：可以选择当前输入焦点的元素，例如把光标放到一个<input>上，用$('input:focus')就可以选出；
    - :checked：选择当前勾上的单选框和复选框，用这个选择器可以立刻获得用户选择的项目，如$('input[type=radio]:checked')；
    - :enabled：可以选择可以正常输入的<input>、<select>等，也就是没有灰掉的输入；
    - disabled：和:enabled正好相反，选择那些不能输入的。
* 查找：拿到一个jQuery对象后，还可以以这个对象为基准，进行查找find(),从当前节点开始向上查找，使用parent()方法,对于位于同一层级的节点，可以通过next()和prev()方法
* 过滤:filter()方法可以过滤掉不符合选择器条件的节点.map()方法把一个jQuery对象包含的若干DOM节点转化为其他对象.一个jQuery对象如果包含了不止一个DOM节点，first()、last()和slice()方法可以返回一个新的jQuery对象，把不需要的DOM节点去掉：

```html
<!-- HTML结构 -->
<ul class="lang">
    <li class="js dy">JavaScript</li>
    <li class="dy">Python</li>
    <li id="swift">Swift</li>
    <li class="dy">Scheme</li>
    <li name="haskell">Haskell</li>
</ul>
```

```js
$(this)

var ps = $('p'); // 返回所有<p>节点
$("p.intro") // 选取所有 class="intro" 的 <p> 元素。
ps.length; // 数一数页面有多少个<p>节点

var div = $('#abc');
var divDom = div.get(0); // 假设存在div，获取第1个DOM元素
var another = $(divDom); // 重新把DOM包装为jQuery对象

var a = $('.red'); // 所有节点包含`class="red"`都将返回
var a = $('.red.green'); // 同时包含red和green的节点 注意没有空格！

$("[href]") // 选取所有带有 href 属性的元素
var email = $('[name=email]'); // 找出<??? name="email">
var a = $('[items="A B"]'); // 找出<??? items="A B">
var icons = $('[name^=icon]'); // 找出所有name属性值以icon开头的DOM name="icon-1", name="icon-2"
var names = $('[name$=with]'); // 找出所有name属性值以with结尾的DOM

var emailInput = $('input[name=email]'); // 不会找出<div name="email">

$('p,div'); // 把<p>和<div>都选出来
$('p.red,p.green'); // 把<p class="red">和<p class="green">都选出来

$('ul.lang li.lang-javascript');
$('form.test p input'); // 在form表单选择被<p>包含的<input>

$('ul.lang>li.lang-javascript'); // 可以选出[<li class="lang-javascript">JavaScript</li>]

$('ul.lang li:first-child'); // 仅选出JavaScript
$('ul.lang li:last-child'); // 仅选出Lua
$('ul.lang li:nth-child(2)'); // 选出第N个元素，N从1开始
$('ul.lang li:nth-child(even)'); // 选出序号为偶数的元素
$('ul.lang li:nth-child(odd)'); // 选出序号为奇数的元素

$('div:visible'); // 所有可见的div
$('div:hidden'); // 所有隐藏的div

var ul = $('ul.lang'); // 获得<ul>
var dy = ul.find('.dy'); // 获得JavaScript, Python, Scheme
var swf = ul.find('#swift'); // 获得Swift
var hsk = ul.find('[name=haskell]'); // 获得Haskell

var swf = $('#swift'); // 获得Swift
var parent = swf.parent(); // 获得Swift的上层节点<ul>
var a = swf.parent('.red'); // 获得Swift的上层节点<ul>，同时传入过滤条件。如果ul不符合条件，返回空jQuery对象

var swift = $('#swift');

swift.next(); // Scheme
swift.next('[name=haskell]'); // 空的jQuery对象，因为Swift的下一个元素Scheme不符合条件[name=haskell]

swift.prev(); // Python
swift.prev('.dy'); // Python，因为Python同时符合过滤器条件.dy

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var a = langs.filter('.dy'); // 拿到JavaScript, Python, Scheme

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
langs.filter(function () {
    return this.innerHTML.indexOf('S') === 0; // 返回S开头的节点
}); // 拿到Swift, Scheme

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var arr = langs.map(function () {
    return this.innerHTML;
}).get(); // 用get()拿到包含string的Array：['JavaScript', 'Python', 'Swift', 'Scheme', 'Haskell']

var langs = $('ul.lang li'); // 拿到JavaScript, Python, Swift, Scheme和Haskell
var js = langs.first(); // JavaScript，相当于$('ul.lang li:first-child')
var haskell = langs.last(); // Haskell, 相当于$('ul.lang li:last-child')
var sub = langs.slice(2, 4); // Swift, Scheme, 参数和数组的slice()方法一致

$('ul.lang li.lang-javascript'); // 每个 <ul> 的第一个 <li> 元素
```

### 操作DOM

* 修改Text和HTML：一个jQuery对象可以包含0个或任意个DOM对象，它的方法实际上会作用在对应的每个DOM节点上.可以执行一个操作，作用在对应的一组DOM节点上。即使选择器没有返回任何DOM节点，调用jQuery对象的方法仍然不会报错.免去了许多if语句
    - 通过html方法添加内容，可以让你在元素中添加HTML标签和文字，而元素中之前的内容都会被方法中的内容所替换掉，示例：$("h3").html("<em>jQuery Playground</em>");
    - jQuery 还有一个类似的方法叫.text()，它只能改变文本但不能添加标签。换句话说，这个方法只会把任何传进来的HTML标签当成你想替换现有内容的文本；
* 修改CSS: $("#target1").css("color","red");
* 显示和隐藏DOM
    * 隐藏一个DOM，我们可以设置CSS的display属性为none，利用css()方法就可以实现.
    * 恢复原有的display属性，这就得先记下来原有的display属性到底是block还是inline还是别的值。
* 获取DOM信息
    * attr()和removeAttr()方法用于操作DOM节点的属性.
    * prop()方法和attr()类似，但是HTML5规定有一种属性在DOM节点中可以没有值，只有出现与不出现两种.prop()返回值更合理一些。不过，用is()方法判断更好(checked selected) $("button").prop("disabled",true);
* 操作表单：对于表单元素，jQuery对象统一提供val()方法获取和设置对应的value属性
* 修改DOM结构：
    - append（）把DOM添加到最后。可以传入原始的DOM对象，jQuery对象和函数对象。传入函数时，要求返回一个字符串、DOM对象或者jQuery对象。因为jQuery的append()可能作用于一组DOM节点，只有传入函数才能针对每个DOM生成不同的子节点。
    - prepend()则把DOM添加到最前
    - appendTo()方法，可以让你把选中的HTML元素附加到其他元素中
    - 如果要添加的DOM节点已经存在于HTML文档中，它会首先从文档移除，然后再添加，也就是说，用append()，你可以移动一个DOM节点。
    - 要把新节点插入到指定位置，例如，JavaScript和Python之间，那么，可以先定位到JavaScript，然后用after()方法。同级节点可以用after()或者before()方法
    - 要删除DOM节点，拿到jQuery对象后直接调用remove()方法就可以了。如果jQuery对象包含若干DOM节点，实际上可以一次删除多个DOM节点：remove()的方法，可以彻底删除一个HTML元素
* 类属性操作
    - 通过addClass("myClass")方法给元素增加类
    - 通过removeClass("myClass")方法移除相应的类
* 复制元素：clone()
* 子元素、父元素、奇偶元素
    - parent()方法，可以允许你访问选定元素的父元素；
    - children()方法，可以让你访问选定元素的子元素；
    - 用CSS选择器来获取元素，target:nth-child(n)CSS选择器允许你通过目标类或元素类型选择目标元素的所有子元素；
    - jQuery里的索引是从0开始的，也就意味着会与直觉相反：:odd选择的是第2、4、6……个元素，因为索引是1、3、5……

```html
<ul id="test-ul">
    <li class="js">JavaScript</li>
    <li name="book">Java &amp; JavaScript</li>
</ul>

<ul id="test-css">
    <li class="lang dy"><span>JavaScript</span></li>
    <li class="lang"><span>Java</span></li>
    <li class="lang dy"><span>Python</span></li>
    <li class="lang"><span>Swift</span></li>
    <li class="lang dy"><span>Scheme</span></li>
</ul>

<input id="test-radio" type="radio" name="test" checked="checked" value="1">

<input id="test-input" name="email" value="">
<select id="test-select" name="city">
    <option value="BJ" selected>Beijing</option>
    <option value="SH">Shanghai</option>
    <option value="SZ">Shenzhen</option>
</select>
<textarea id="test-textarea">Hello</textarea>

<div id="test-div">
    <ul>
        <li><span>JavaScript</span></li>
        <li><span>Python</span></li>
        <li><span>Swift</span></li>
    </ul>
</div>

<script>
    $('#test-ul li[name=book]').text(); // 'Java & JavaScript'
    $('#test-ul li[name=book]').html(); // 'Java &amp; JavaScript'

    $('#test-ul li').text('JS'); // 是不是两个节点都变成了JS？

    $('#test-css li.dy>span').css('background-color', '#ffd351').css('color', 'red');

    var div = $('#test-div');
    div.css('color'); // '#000033', 获取CSS属性
    div.css('color', '#336699'); // 设置CSS属性
    div.css('color', ''); // 清除CSS属性

    var a = $('a[target=_blank]');
    a.hide(); // 隐藏
    a.show(); // 显示

    var div = $('#test-div');
    div.width(); // 600
    div.height(); // 300
    div.width(400); // 设置CSS属性 width: 400px，是否生效要看CSS是否有效
    div.height('200px'); // 设置CSS属性 height: 200px，是否生效要看CSS是否有效

    // <div id="test-div" name="Test" start="1">...</div>
    var div = $('#test-div');
    div.attr('data'); // undefined, 属性不存在
    div.attr('name'); // 'Test'
    div.attr('name', 'Hello'); // div的name属性变为'Hello'
    div.removeAttr('name'); // 删除name属性
    div.attr('name'); // undefined

    var radio = $('#test-radio');
    radio.attr('checked'); // 'checked'
    radio.prop('checked'); // true

    var radio = $('#test-radio');
    radio.is(':checked'); // true

    var
        input = $('#test-input'),
        select = $('#test-select'),
        textarea = $('#test-textarea');

    input.val(); // 'test'
    input.val('abc@example.com'); // 文本框的内容已变为abc@example.com

    select.val(); // 'BJ'
    select.val('SH'); // 选择框已变为Shanghai

    textarea.val(); // 'Hello'
    textarea.val('Hi'); // 文本区域已更新为'Hi'

    var ul = $('#test-div>ul');
    ul.append('<li><span>Haskell</span></li>');

    // 创建DOM对象:
    var ps = document.createElement('li');
    ps.innerHTML = '<span>Pascal</span>';
    // 添加DOM对象:
    ul.append(ps);

    // 添加jQuery对象:
    ul.append($('#scheme'));

    // 添加函数对象:
    ul.append(function (index, html) {
        return '<li><span>Language - ' + index + '</span></li>';
    });

    // 要把新节点插入到指定位置
    var js = $('#test-div>ul>li:first-child');
    js.after('<li><span>Lua</span></li>');

    var li = $('#test-div>ul>li');
    li.remove(); // 所有<li>全被删除

    // 获 取一组radio被选中项的值
    var item = $('input[name=items][checked]').val();
    // 获 取select被选中项的文本
    var item = $("select[name=items] option[selected]").text();
    // select下拉框的第二个元素为当前选中值
    $('#select_id')[0].selectedIndex = 1;
    // radio单选组的第二个元素为当前选中值
    $('input[name=items]').get(1).checked = true;
    // 获取值：
    //文本框，文本区域：
    $("#txt").attr("value")；
    // 多选框 checkbox：
    $("#checkbox_id").attr("value")；
    // 单选组radio：
    $("input[type=radio][checked]").val();
    // 下拉框select：
    $('#sel').val();
    // 控制表单元素：
    // 文本框，文本区域：
    $("#txt").attr("value",'');//清空内容
    $("#txt").attr("value",'11');//填充内容
    // 多选框checkbox：
    $("#chk1").attr("checked",'');//不打勾
    $("#chk2").attr("checked",true);//打勾
    if($("#chk1").attr('checked')==undefined) //判断是否已经打勾
    // 单选组 radio：
    $("input[type=radio]").attr("checked",'2');//设置value=2的项目为当前选中项
    // 下拉框 select：
    $("#sel").attr("value",'-sel3');//设置value=-sel3的项目为当前选中项
    $("<option value='1'>1111</option><option value='2'>2222</option>").appendTo("#sel")//添加下拉框的option
    $("#sel").empty()；//清空下拉框
</script>
```

### 事件

JavaScript在浏览器中以单线程模式运行，页面加载后，一旦页面上所有的JavaScript代码被执行完后，就只能依赖触发事件来执行JavaScript代码。

浏览器在接收到用户的鼠标或键盘输入后，会自动在对应的DOM节点上触发相应的事件。如果该节点已经绑定了对应的JavaScript处理函数，该函数就会自动调用。

由于不同的浏览器绑定事件的代码都不太一样，所以用jQuery来写代码，就屏蔽了不同浏览器的差异，我们总是编写相同的代码。

* on方法用来绑定一个事件，我们需要传入事件名称和对应的处理函数.
* 鼠标事件：
    - click: 鼠标单击时触发；
    - dblclick：鼠标双击时触发；
    - mouseenter：鼠标进入时触发；
    - mouseleave：鼠标移出时触发；
    - mousemove：鼠标在DOM内部移动时触发；
    - hover：鼠标进入和退出时触发两个函数，相当于mouseenter加上mouseleave。
* 键盘事件：
    - keydown：键盘按下时触发；
    - keyup：键盘松开时触发；
    - keypress：按一次键后触发
* 其他事件
    - focus：当DOM获得焦点时触发；
    - blur：当DOM失去焦点时触发；
    - change：当<input>、<select>或<textarea>的内容改变时触发；
    - submit：当<form>提交时触发；
    - ready：当页面被载入并且DOM树完成初始化后触发。*ready仅作用于document对象。由于ready事件在DOM完成初始化后触发，且只触发一次，所以非常适合用来写其他的初始化代码。* `$(function () {...})`的使用
* 有些事件，如mousemove和keypress，我们需要获取鼠标位置和按键的值，否则监听这些事件就没什么意义了。所有事件都会传入Event对象作为参数，可以从Event对象上获取到更多的信息
* 取消绑定：一个已被绑定的事件可以解除绑定，通过off('click', function)实现。可以使用off('click')一次性移除已绑定的click事件的所有处理函数。无参数调用off()一次性移除已绑定的所有类型的事件处理函数。
* 事件触发条件：事件的触发总是由用户操作引发的。比如：用户在文本框中输入时，就会触发change事件。但是，如果用JavaScript代码去改动文本框的值，将不会触发change事件
    - 浏览器安全限制:浏览器中，有些JavaScript代码只有在用户触发下才能执行，例如，window.open()函数

```html
<a id="test-link" href="#0">点我试试</a>

<script>

var a = $('#test-link');

a.on('click', function () {
    alert('Hello!');
});

a.click(function () {
    alert('Hello!');
});

function hello() {
    alert('hello!');
}
a.click(hello); // 绑定事件

// 10秒钟后解除绑定:
setTimeout(function () {
    a.off('click', hello);
}, 10000);

// 解除绑定: 无效的。因为两个匿名函数虽然长得一模一样，但是它们是两个不同的函数对象，off('click', function () {...})无法移除已绑定的第一个匿名函数。
// 解除绑定:
a.off('click', function () {
    alert('hello!');
});

var input = $('#test-input');  // 通过代码触发事件，直接调用无参数的change()方法来触发该事件
input.val('change it!');
input.change(); // 触发change事件

// 无法弹出新窗口，将被浏览器屏蔽:
$(function () {
    window.open('/');
});
</script>

<html>
<head>
    <script>
        $(document).on('ready', function () {
            $('#testForm).on('submit', function () {
                alert('submit!');
            });
        });

        // 简化
        $(document).ready(function () {
            // on('submit', function)也可以简化:
            $('#testForm).submit(function () {
                alert('submit!');
            });
        });
        // 是document对象的ready事件处理函数。完全可以反复绑定事件处理函数，它们会依次执行
        $(function () {
            // init...
        });

        $(function () {
            $('#testMouseMoveDiv').mousemove(function (e) {
                $('#testMouseMoveSpan').text('pageX = ' + e.pageX + ', pageY = ' + e.pageY);
            });
        });
    </script>
</head>
<body>
    <form id="testForm">
        ...
    </form>
</body>
```

### 动画

* show()和hide()，会显示和隐藏DOM元素从左上角逐渐展开或收缩的.toggle()方法则根据当前状态决定是show()还是hide()
* slideUp()和slideDown()则是在垂直方向逐渐展开或收缩的。slideToggle()则根据元素是否可见来决定下一步动作
* fadeIn()和fadeOut()的动画效果是淡入淡出，也就是通过不断设置DOM元素的opacity属性来实现，而fadeToggle()则根据元素是否可见来决定下一步动作
* animate()，可以实现任意动画效果，需要传入的参数就是DOM元素最终的CSS状态和时间，jQuery在时间段内不断调整CSS直到达到设定的值.还可以再传入一个函数，当动画结束时，该函数将被调用
* 动画效果还可以串行执行，通过delay()方法还可以实现暂停，这样，我们可以实现更复杂的动画效果.必须不断返回新的Promise对象才能后续执行操作
* 有的动画如slideUp()根本没有效果。这是因为jQuery动画的原理是逐渐改变CSS的值，如height从100px逐渐变为0。但是很多不是block性质的DOM元素，对它们设置height根本就不起作用，所以动画也就没有效果
* jQuery也没有实现对background-color的动画效果，用animate()设置background-color也没有效果。这种情况下可以使用CSS3的transition实现动画效果。

```js
var div = $('#test-show-hide');

div.hide(3000); //
div.show('slow');
div.toggle('slow'); // $(selector).toggle(speed,callback); speed 参数规定隐藏/显示的速度，可以取以下值："slow"、"fast" 或毫秒。可选的 callback 参数是 toggle() 方法完成后所执行的函数名称。

div.slideUp(3000); // $(selector).slideDown(speed,callback); 在3秒钟内逐渐向上消失
div.slideDown(3000);
div.slideToggle('slow');

div.fadeIn(3000);  // $(selector).fadeIn(speed,callback);  speed 参数规定效果的时长。它可以取以下值："slow"、"fast" 或毫秒。 可选的 callback 参数是 fading 完成后所执行的函数名称。
div.fadeOut(3000);
div.fideToggle('slow');
div.fadeTo("slow",0.15); // $(selector).fadeTo(speed,opacity,callback); 允许渐变为给定的不透明度（值介于 0 与 1 之间）

var div = $('#test-animate'); // $(selector).animate({params},speed,callback); 必需的 params 参数定义形成动画的 CSS 属性。 callback 参数是动画完成后所执行的函数名称。在3秒钟内CSS过渡到设定值
div.animate({
    opacity: 0.25,
    width: '256px',
    height: '256px'
}, 3000, function () {
    console.log('动画已结束');
    // 恢复至初始状态:
    $(this).css('opacity', '1.0').css('width', '128px').css('height', '128px');
});
div.animate({ // 使用相对值
    left:'250px',
    height:'+=150px',
    width:'+=150px'
  });

var div = $('#test-animates');
// 动画效果：slideDown - 暂停 - 放大 - 暂停 - 缩小
div.slideDown(2000)
   .delay(1000)
   .animate({
       width: '256px',
       height: '256px'
   }, 2000)
   .delay(1000)
   .animate({
       width: '128px',
       height: '128px'
   }, 2000);
```

### AJAX

在全局对象jQuery（也就是$）绑定了ajax()函数，可以处理AJAX请求。ajax(url, settings)函数需要接收一个URL和一个可选的settings对象，常用的选项如下：
* async：是否异步执行AJAX请求，默认为true，千万不要指定为false；
* method：发送的Method，缺省为'GET'，可指定为'POST'、'PUT'等；
* contentType：发送POST请求的格式，默认值为'application/x-www-form-urlencoded; charset=UTF-8'，也可以指定为text/plain、application/json；
* data：发送的数据，可以是字符串、数组或object。如果是GET请求，data将被转换成query附加到URL上，如果是POST请求，根据contentType把data序列化成合适的格式；
* headers：发送的额外的HTTP头，必须是一个object；
* dataType：接收的数据格式，可以指定为'html'、'xml'、'json'、'text'等，缺省情况下根据响应的Content-Type猜测。
    * $.ajax()
    * $.get()
    * $.post():传入的第二个参数默认被序列化为application/x-www-form-urlencoded
    * $.getJSON()
* 用promise实现链式写法
* 使用JSONP，可以在ajax()中设置jsonp: 'callback'，让jQuery实现JSONP跨域加载数据

```js
var jqxhr = $.ajax('/api/categories', {
    dataType: 'json'
});

function ajaxLog(s) {
    var txt = $('#test-response-text');
    txt.val(txt.val() + '\n' + s);
}

$('#test-response-text').val('');
var jqxhr = $.ajax('/api/categories', {
    dataType: 'json'
}).done(function (data) {
    ajaxLog('成功, 收到的数据: ' + JSON.stringify(data));
}).fail(function (xhr, status) {
    ajaxLog('失败: ' + xhr.status + ', 原因: ' + status);
}).always(function () {
    ajaxLog('请求完成: 无论成功或失败都会调用');
});

var jqxhr = $.get('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
});

var jqxhr = $.post('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
});

var jqxhr = $.getJSON('/path/to/resource', {
    name: 'Bob Lee',
    check: 1
}).done(function (data) {
    // data已经被解析为JSON对象了
});
```

## 遍历

```js
var arr = new Array(13.5,3,4,5,6);
for(var i=0;i<arr.length;i++){
 arr[i] = arr[i]/2.0;
}

var x
var mycars = new Array()
mycars[0] = "Saab"
mycars[1] = "Volvo"
mycars[2] = "BMW"
for (x in mycars)
{
  document.write(mycars[x] + "<br />")
}

var arr=new Array();
arr=["aaa","bbb","ccc"];
$.each(arr,function(index,value){
     alert(i+"..."+value);
});

$(function () {
    $.each([["aaa", "bbb", "ccc"], ["ddd", "eee", "fff"], ["ggg", "hhh", "iii"]], function (index, item) {
         alert(index + "..." + item);
         //输出0...aaa,bbb,ccc  1...ddd,eee,fff  2...ggg,hhh,iii   这时的index为数组下标,item相当于取这二维数组中的每一个数组
         $.each(item, function (index, itemobj) {
              alert(index + "....." + itemobj);
         });
    });
     //输出0...aaa,bbb,ccc  0...aaa 1...bbb 2...cccc  1...ddd,eee,fff  0...ddd 1...eee 2...fff  2...ggg,hhh,iii 0...ggg 1...hhh 2...iii
 });
```

### 插件

* 给jQuery对象绑定一个新方法是通过扩展给$.fn绑定函数，实现插件的代码逻辑.返回`return this`,jQuery对象支持链式操作，自己写的扩展方法也要能继续链式下去
* `$.extend(target, obj1, obj2, ...)`，它把多个object对象的属性合并到第一个target对象中，遇到同名属性，总是使用靠后的对象的值，也就是越往后优先级越高.插件函数要有默认值，绑定在$.fn.<pluginName>.defaults上；用户在调用时可传入设定值以便覆盖默认值。
* 针对特定元素的扩展: jQuery对象的有些方法只能作用在特定DOM元素上，比如submit()方法只能针对form。如果我们编写的扩展只能针对某些类型的DOM元素.

```html
<div id="test-external">
    <p>如何学习<a href="http://jquery.com">jQuery</a>？</p>
    <p>首先，你要学习<a href="/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000">JavaScript</a>，并了解基本的<a href="https://developer.mozilla.org/en-US/docs/Web/HTML">HTML</a>。</p>
</div>

<script>
$.fn.highlight1 = function () {
    // this已绑定为当前jQuery对象:
    this.css('backgroundColor', '#fffceb').css('color', '#d85030');
    return this;
}
$('#test-highlight1 span').highlight1();

$.fn.highlight2 = function (options) {
    // 要考虑到各种情况:
    // options为undefined
    // options只有部分key
    var bgcolor = options && options.backgroundColor || '#fffceb';
    var color = options && options.color || '#d85030';
    this.css('backgroundColor', bgcolor).css('color', color);
    return this;
}
$('#test-highlight2 span').highlight2({
    backgroundColor: '#00a8e6',
    color: '#ffffff'
});

$.fn.highlight = function (options) {
    // 合并默认值和用户设定值:
    var opts = $.extend({}, $.fn.highlight.defaults, options); // $.extend
    this.css('backgroundColor', opts.backgroundColor).css('color', opts.color);
    return this;
}
// 设定默认值:
$.fn.highlight.defaults = {
    color: '#d85030',
    backgroundColor: '#fff8de'
}

// 现在我们要给所有指向外链的超链接加上跳转提示
$.fn.external = function () {
    // return返回的each()返回结果，支持链式调用:
    return this.filter('a').each(function () {
        // 注意: each()内部的回调函数的this绑定为DOM本身!
        var a = $(this);
        var url = a.attr('href');
        if (url && (url.indexOf('http://')===0 || url.indexOf('https://')===0)) {
            a.attr('href', '#0')
             .removeAttr('target')
             .append(' <i class="uk-icon-external-link"></i>')
             .click(function () {
                if(confirm('你确定要前往' + url + '？')) {
                    window.open(url);
                }
            });
        }
    });
}
$('#test-external a').external();
</script>
```

## [blueimp/jQuery-File-Upload](https://github.com/blueimp/jQuery-File-Upload)

File Upload widget with multiple file selection, drag&drop support, progress bar, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads. Works with any server-side platform (Google App Engine, PHP, Python, Ruby on Rails, Java, etc.) that supports standard HTML form file uploads. [https://blueimp.github.io/jQuery-File...](https://blueimp.github.io/jQuery-File…)

### 冲突

```js
var jq=jQuery.noConflict();
```

## 扩展

- [blueimp/jQuery-File-Upload](https://github.com/blueimp/jQuery-File-Upload)
- [Studio-42/elFinder](https://github.com/Studio-42/elFinder):Open-source file manager for web, written in JavaScript using jQuery and jQuery UI https://studio-42.github.io/elFinder/
- [mumuy/widget](https://github.com/mumuy/widget):A set of widgets based on jQuery&&javascript. 一套基于jquery或javascript的插件库 ：轮播、标签页、滚动条、下拉框、对话框、搜索提示、城市选择(城市三级联动)、日历等 http://jquerywidget.com/
- [js-cookie/js-cookie](https://github.com/js-cookie/js-cookie):A simple, lightweight JavaScript API for handling browser cookies
- [DataTables/DataTables](https://github.com/DataTables/DataTables):Tables plug-in for jQuery http://www.datatables.net/
- [jquery-validation](https://github.com/jquery-validation/jquery-validation):clone本地，grunt安装，编译;test中的index.html会有测试断言

## 参考

* [oneuijs/You-Dont-Need-jQuery](https://github.com/oneuijs/You-Dont-Need-jQuery):Examples of how to do query, style, dom, ajax, event etc like jQuery with plain javascript.
* [plugin](http://www.jq22.com/)
