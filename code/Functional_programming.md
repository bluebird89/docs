# 函数式编程

* 一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用

* 允许使用变量的程序设计语言，由于函数内部的变量状态不确定，同样的输入，可能得到不同的输出，因此，这种函数是有副作用的。

* 特点

  - 允许把函数本身作为参数传入另一个函数，还允许返回一个函数

* types are not classes:类型实际上是一种接口，它是数据和数据可以产生的行为间的一座桥梁,「类」是「类型」的一种实现方式

  - 会飞（flyable） 是一个类型，「鸟」实现了 flyable，而「鸭子」无法实现 flyable，所以「鸭子」并不是「鸟」的子类型。

* 可以把函数作为参数传递给另一个函数，也就是所谓的高阶函数

* 可以返回一个函数，这样就可以实现闭包或者惰性计算

## lambda

* [lambci/docker-lambda](https://github.com/lambci/docker-lambda):Docker images and test runners that replicate the live AWS Lambda environment

## 资源

* [MostlyAdequate/mostly-adequate-guide](https://github.com/MostlyAdequate/mostly-adequate-guide):Mostly adequate guide to FP (in javascript)
* [JS 函数式编程指南](https://www.gitbook.com/book/llh911001/mostly-adequate-guide-chinese/details)
* [timoxley/functional-javascript-workshop](https://github.com/timoxley/functional-javascript-workshop):A functional javascript workshop. No libraries required (i.e. no underscore), just ES5.
