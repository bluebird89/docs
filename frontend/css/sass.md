## [sass](https://github.com/sass/sass)

* Sass makes CSS fun again. <http://sass-lang.com>
* 两种不同的后缀名分别对应两套语法
  - 最早 Sass 使用的是缩进式语法，使用缩进来区分代码块，并通过分号将具体样式分开，这种语法以 .sass 作为后缀
  - 使用了和 CSS 一样的块语法，这种语法以 .scss 作为后缀。后者更加兼容原生 CSS 语法
* 编写好 Sass 文件后，需要将其编译为 CSS 文件才能在项目中使用.NPM 扩展包 node-sass 就封装了对 libSass 的实现
* 语法
  - 变量
  - 数据结构包括数字、字符串、数组、颜色、布尔值、null、List、Map、函数引用
  - 嵌套
  - 混合（Mixin）：有一段 CSS 样式代码需要在多个地方使用，这可以通过 Sass 提供的混合（Mixin）功能来实现
    + 定义混合代码的时候需要在选择器前面加上 @mixin 标识
    + 引用混合代码的时候需要通过 @include 来引入
  - 函数：
    + 可以传入参数并实现运算功能
    + 函数通过 @function 标识声明
    + 函数名允许出现短划线 -
    + 函数体内可以使用在函数声明之前定义的所有变量，同时计算时会带上变量声明时的单位
  - 控制结构
  - 导入:支持通过 @import 指令导入其它 Sass 文件，既可以导入本地开发文件，也可以导入前端依赖库中的文件，还可以导入网络字体文件
  - 继承:通过 % 前缀指定用于继承的样式，然后在需要继承的地方提供 @extend 指令继承相应的父类样式


## 问题

```sh
# install node-sass “ERROR:root:code for hash md5 was not found” when using any hg mercurial commands
wget https://raw.githubusercontent.com/Homebrew/homebrew-core/86a44a0a552c673a05f11018459c9f5faae3becc/Formula/python@2.rb
brew install python@2.rb
rm python@2.rb
```

## 教程

- [Sass 基础教程](http://www.sasschina.com/guide/)

## 资源

* [gridlex](https://github.com/devlint/gridlex):Just a CSS Flexbox Grid System <http://gridlex.devlint.fr>
* [alexwolfe/Buttons](https://github.com/alexwolfe/Buttons):A CSS button library built using Sass and Compass <http://unicorn-ui.com/buttons/builder/>
* [include-media](https://github.com/eduardoboucas/include-media/):📐 Simple, elegant and maintainable media queries in Sass <http://include-media.com>
* [bourbon](https://github.com/thoughtbot/bourbon/):A Lightweight Sass Tool Set <https://www.bourbon.io/> <https://github.com/thoughtbot/bourbon>

## 参考

* <https://www.jianshu.com/p/e2c23a74636d>
