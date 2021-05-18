# Functional Programming 函数式编程

* 没有副作用：一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的
* 有副作用：允许使用变量的程序设计语言，由于函数内部变量状态不确定，同样的输入，可能得到不同的输出
* types are not classes:类型实际上是一种接口，它是数据和数据可以产生的行为间的一座桥梁,「类」是「类型」的一种实现方式
  - 会飞（flyable） 是一个类型，「鸟」实现了 flyable，而「鸭子」无法实现 flyable，所以「鸭子」并不是「鸟」的子类型
* 不依赖于外部数据，而且也不改变外部数据值，而是返回一个新值
* describe what to do, rather than how to do it 把函数当成变量来用，关注于描述问题而不是怎么实现
* 递归本质就是描述问题是什么

## 特点

* immutable data 不可变数据
  - 默认上变量是不可变的
* first class functions 函数就像变量一样来使用
  - 可以像变量一样被创建，修改，并当成变量一样传递，返回或是在函数中嵌套函数
  - 高阶函数:允许把函数本身作为参数传入另一个函数
  - 允许返回一个函数,实现闭包或者惰性计算
* 尾递归优化
  - 递归害处，那就是如果递归很深的话，stack受不了，并会导致性能大幅度下降
  - 使用尾递归优化技术——每次递归时都会重用stack，这样一来能够提升性能，当然，这需要语言或编译器的支持。Python就不支持。

## map & reduce

* 使用Map & Reduce，不要使用循环
* 比起过程式的语言来说，在代码上要更容易阅读。（传统过程式的语言需要使用for/while循环，然后在各种变量中把数据倒过来倒过去的）这个很像C++中的STL中的foreach，find_if，count_if之流的函数的玩法。

## pipeline

* 把函数实例成一个一个的action，然后，把一组action放到一个数组或是列表中，然后把数据传给这个action list，数据就像一个pipeline一样顺序地被各个函数所操作，最终得到想要的结果。

```python
def even_filter(nums):
    return filter(lambda x: x%2==0, nums)
def multiply_by_three(nums):
    return map(lambda x: x*3, nums)
def convert_to_string(nums):
    return map(lambda x: 'The Number: %s' % x,  nums)
def pipeline_func(data, fns):
    return reduce(lambda a, x: x(a),
                  fns,
                  data)

nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
pipeline_func(nums, [even_filter,
                     multiply_by_three,
                     convert_to_string])
```

```sh
# shell风格的python pipeline
class Pipe(object):
    def __init__(self, func):
        self.func = func
    def __ror__(self, other):
        def generator():
            for obj in other:
                if obj is not None:
                    yield self.func(obj)
        return generator()
@Pipe
def even_filter(num):
    return num if num % 2 == 0 else None
@Pipe
def multiply_by_three(num):
    return num*3
@Pipe
def convert_to_string(num):
    return 'The Number: %s' % num
@Pipe
def echo(item):
    print item
    return item
def force(sqs):
    for item in sqs: pass
nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
force(nums | even_filter | multiply_by_three | convert_to_string | echo)
```

## recursing 递归

* 递归最大的好处就简化代码，可以把一个复杂的问题用很简单的代码描述出来。注意：递归的精髓是描述问题，而这正是函数式编程的精髓。

## currying

* 把一个函数的多个参数分解成多个函数，然后把函数多层封装起来，每层函数都返回一个函数去接收下一个参数这样，可以简化函数的多个参数。在C++中，这个很像STL中的bind_1st或是bind2nd。

## higher order function 高阶函数

* 把函数当参数，把传入函数做一个封装，然后返回这个封装函数。现象上就是函数传进传出

## 优点

* parallelization 并行：所谓并行的意思就是在并行环境下，各个线程之间不需要同步或互斥。
* lazy evaluation 惰性求值：需要编译器支持
  - 表达式不在它被绑定到变量之后就立即求值，而是在该值被取用的时候求值，也就是说，语句如x:=expression; (把一个表达式的结果赋值给一个变量)明显的调用这个表达式被计算并把结果放置到 x 中，但是先不管实际在 x 中的是什么，直到通过后面的表达式中到 x 的引用而有了对它的值的需求的时候，而后面表达式自身的求值也可以被延迟，最终为了生成让外界看到的某个符号而计算这个快速增长的依赖树。
* determinism 确定性
  - 函数的确定性：像数学那样 f(x) = y ，这个函数无论在什么场景下，都会得到同样的结果
  - 而不是像程序中的很多函数那样，同一个参数，却会在不同的场景下计算出不同的结果
  - 不同场景：函数会根据一些运行中的状态信息的不同而发生变化。


## Monad

* 一种设计模式，表示将一个运算过程，通过函数拆解成互相连接的多个步骤。只要提供下一步运算所需的函数，整个运算就会自动进行下去。

## lambda

* [docker-lambda](https://github.com/lambci/docker-lambda):Docker images and test runners that replicate the live AWS Lambda environment

## 资源

* [mostly-adequate-guide](https://github.com/MostlyAdequate/mostly-adequate-guide):Mostly adequate guide to FP (in javascript)
* [JS 函数式编程指南](https://www.gitbook.com/book/llh911001/mostly-adequate-guide-chinese/details)
