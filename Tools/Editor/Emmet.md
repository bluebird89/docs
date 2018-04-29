# Emmet


html:5 或!：用于HTML5文档类型
html:xt：用于XHTML过渡文档类型
html:4s：用于HTML4严格文档类型

p#foo 补充ID
p.foo 补充类
h1{foo} 和 a[href=#] 为h1和a标签

`>`：子元素符号，表示嵌套的元素
+：同级标签符号
^：可以使该符号前的标签提升一行

(.foo>h1)+(.bar>h2) 
ul>li*3
ul>li.item$*3

((h4>a[rel=external])+p>img[width=500 height=320])*12

## 参考

* [Emmet Documentation](https://docs.emmet.io/cheat-sheet/)
