# [scheme](https://schemers.org/)

* 诞生于1975年的MIT,作为Lisp 变体，Scheme 是一门非常简洁的计算语言，使用它的编程人员可以摆脱语言本身的复杂性，把注意力集中到更重要的问题上，从而使语言真正成为解决问题的工具
* 在国外的计算机教育领域内却是有着广泛应用的，有很多人学的第一门计算机语言就是Scheme语言
* 特色
  - 词法定界（Lexical Scoping）
  - 动态类型（Dynamic Typing）
  - 良好的可扩展性
  - 尾递归（Tail Recursive）
  - 函数可以作为值返回
  - 支持一流的计算连续
  - 传值调用（passing-by-value）
  - 算术运算相对独立
* Scheme语言的语法规则的第5次修正稿，1998年制定，即Scheme语言的现行标准，目前大多数Scheme语言的实现都将达到或遵循此标准，并且几乎都加入了一些属于自己的扩展特色

## 语法

* 注释
  - 单行注释，以分号[;]开始一直到行尾结束
  - 多行注释：标准的Scheme语言定义中没有，Guile中 以符号组合"#!"开始，以相反的另一符号组合"!#"结束
* 块(form)是Scheme语言中的最小程序单元，一个Scheme语言程序是由一个或多个form构成。没有特殊说明的情况下 form 都由小括号括起来
  - 允许form的嵌套
* 变量
  - 定义 `(define 变量名 值)`
  - `(set! 变量名 值) `
* 变量和过程绑定
  - 全局变量都用define来定义，并放在过程代码的外部
  - 局部变量则用let等绑定到过程内部使用 `(let ((…)…) …)`
  - letrec帮助局部过程实现递归的操作，这不仅在letrec绑定的过程内，而且还包括所有初始化的东西
* apply的功能是为数据赋予某一操作过程，第一个参数必需是一个过程，随后的其它参数必需是列表
* map的功能:第一个参数也必需是一个过程，随后的参数必需是多个列表，返回的结果是此过程来操作列表后的值
* eval，delay，for-each，force，call-with-current-continuation

```scheme
(letrec ((even?
        (lambda(x)
        (if (= x 0)
            (odd? (- x 1)))))
    (odd?
        (lambda(x)
        (if (= x 0) #f
                (even? (- x 1))))))
(even? 88))

(apply + (list 2 3 4))
(map car '((a . b)(c . d)(e . f)))
```

## 数据类型

* 简单数据类型
  - 逻辑型(boolean) #t #f
    + 只有一种操作：not 只要not后面的参数不是逻辑型，其返回值均为#f
  - 数字型(number):四种子类型,二进制的 #b1010 ，八进制的 #o567，十进制的123或 #d123，十六进制的 #x1afc
    + 复数型(complex) 可以定义为 (define c 3+2i)
    + 实数型（real）可以定义为 (define f 22/7)
    + 有理数型（rational）可以定义为 (define p 3.1415)
    + 整数型(integer) 可以定义为 (define i 123)
  - 字符型(char):以符号组合 "#\" 开始，表示单个字符，可以是字母、数字或"[ ! $ % & * + - . / : %lt; = > ? @ ^ _ ~ ]"等等其它字符
  - 符号型(symbol):可以是单词，用括号括起来的多个单词，也可以是无意义的字母组合或符号组合，它在某种意义上可以理解为C中的枚举类型
    + 单引号' 与quote是等价的
    + 不同的是符号类型不能象字符串那样可以取得长度或改变其中某一成员字符的值，但二者之间可以互相转换
* 复合数据类型
  - 字符串(string) 由多个字符组成的数据类型,由双引号括起的内容
  - 点对(pair):由一个点和被它分隔开的两个所值组成的。形如： (1 . 2) 或 (a . b)，注意的是点的两边有空格 `(define p (cons 4 5))   => (4 . 5)`
  - 列表(list) 由多个相同或不同的数据连续组成的数据类型  `(define la (list 1 2 3 4 ))`
    + list是pair的子类型，list一定是一个pair，而pair不是list
    + cadr，cdddr等过程是专门对PAIR型数据再复合形成的数据操作的过程，最多可以支持在中间加四位a或d
  - 向量（vector）:一种元素按整数来索引的对象，异源的数据结构，在占用空间上比同样元素的列表要少 `(define v (vector 1 2 3 4 5))`

## 操作符

* 类型判断:`(boolean? #t)`
* 比较:(= 34 34)
  - equal?则是判断两个对象是否具有相同的结构并且结构中的内容是否相同
  - eq?是判断两个参数是否指向同一个对象
* 算术
  - `(- 4)`
  - `(max 8 89 90 213)`
* 转换:`(symbol->string 'better)`

## 过程（Procedure）

* 相当于C语言中的函数，不同的是Scheme语言过程是一种数据类型
* 用lambda来定义过程:`(define add5 (lambda (x) (+ x 5)))` `(add5 11)`
  - `(define (add6 x) (+ x 6))`

## 控制

* 顺序结构:用begin来将多个form放在一对小括号内，最终形成一个form
* if结构: (if 测试 过程1 过程2)
* cond结构 (cond ((测试) 操作) … (else 操作))
* case结构 (case (表达式) ((值) 操作)) ... (else 操作)))
  - 值可以是复合类型数据
* and结构与逻辑与运算操作类似，and后可以有多个参数，只有它后面的参数的表达式的值都为#t时，它的返回值才为#t，否则为#f
* or结构与逻辑或运算操作类似，or后可以有多个参数，只要其中有一个参数的表达式值为#t，其结果就为#t，只有全为#f时其结果才为#f
* 循环:可以用递归来很轻松的实现
* 递归

```scheme
(define  factoral (lambda (x)
    (if (<= x 1) 1
        (* x (factoral (- x 1))))))

(define (factoral n)
    (define (iter product counter)
        (if (> counter n)
            product
            (iter (* counter product) (+ counter 1))))
    (iter 1 1))
(display (factoral 4))

(define loop
    (lambda(x y)
    (if (<= x y)
        (begin (display x) (display #\\space) (set! x (+ x 1))
            (loop x y)))))
```

## 输入输出

* 输入输出中用到了端口的概念，相当于C中的文件指针，也就是Linux中的设备文件
* 查看：`(current-input-port)` `(current-output-port)`
* 判断是否为：`input-port? ` `output-port?`
* 打开：`open-input-file`，`open-output-file`  参数是文件名字符串
* 关闭：`close-input-port`，`close-output-port` 参数是打开的端口
* 输入
  - 打开一个输入文件后，返回的是输入端口，可以用read过程来输入文件的内容 `(define name (read))`
* 输出
  - display
  - `(write "hello\\nworld" port1)`

## 工具

* IDE
  * Guile
  * [ cisco / ChezScheme ](https://github.com/cisco/ChezScheme)
    - `sudo apt install uuid-dev ncurses-dev`
  * [racket](https://racket-lang.org/)

## reference

* [The Scheme Programming Language](https://www.scheme.com/tspl4/)
* [Scheme 语言概要](https://www.ibm.com/developerworks/cn/linux/l-schm/index1.html)
