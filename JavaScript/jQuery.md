# jQuery

* 消除浏览器差异：你不需要自己写冗长的代码来针对不同的浏览器来绑定事件，编写AJAX等代码；
* 简洁的操作DOM的方法：写$('#test')肯定比document.getElementById('test')来得简洁；
* 轻松实现动画、修改CSS等各种操作。

jQuery把所有功能全部封装在一个全局变量jQuery中，而$也是一个合法的变量名，它是变量jQuery的别名：
`$`本质上就是一个函数，但是函数也是对象，于是`$`除了可以直接调用外，也可以有很多其他属性。`$`函数名可能不是j`Query(selector, context)`，因为很多JavaScript压缩工具可以对函数名和参数改名，所以压缩过的jQuery源码$函数可能变成`a(b, c)`。

```javascript
$.fn.jQuery; // 查看版本

window.jQuery; // jQuery(selector, context)
window.$; // jQuery(selector, context)
$ === jQuery; // true
typeof($); // 'function'
```

## 扩展

- [blueimp/jQuery-File-Upload](https://github.com/blueimp/jQuery-File-Upload)
- [Studio-42/elFinder](https://github.com/Studio-42/elFinder):Open-source file manager for web, written in JavaScript using jQuery and jQuery UI https://studio-42.github.io/elFinder/

## 参考

* [oneuijs/You-Dont-Need-jQuery](https://github.com/oneuijs/You-Dont-Need-jQuery):Examples of how to do query, style, dom, ajax, event etc like jQuery with plain javascript.
