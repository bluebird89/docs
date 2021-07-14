# programming paradigm 编程范式

## procedural programming 过程式编程

## [面向对象编程 Object Oriented Programming OOP](../architect/oop.md)

## 泛型编程

## [函数式编程](./functional_programming.md)

## Declarative Programming vs Imperative Programming

* Imperative Programming 指令式编程 过程式编程范式
  - 过程式编程：过重上下文，理解沉重
  - 拆分函数
    + 把代码逻辑封装成了函数后，就相当于给每个相对独立的程序逻辑取了个名字，于是代码成了自解释的
    + 函数间必需知道其它函数是怎么修改它们之间的共享变量的，所以，这些函数是有状态的
* Declarative Programming 声明式编程
  - 它们之间没有共享的变量。
  - 函数间通过参数和返回值来传递数据。
  - 在函数里没有临时变量。

```python
from random import random

def move_cars(car_positions):
    return map(lambda x: x + 1 if random() > 0.3 else x,
               car_positions)

def output_car(car_position):
    return '-' * car_position

def run_step_of_race(state):
    return {'time': state['time'] - 1,
            'car_positions': move_cars(state['car_positions'])}

def draw(state):
    print ''
    print '\n'.join(map(output_car, state['car_positions']))

def race(state):
    draw(state)
    if state['time']:
        race(run_step_of_race(state))

race({'time': 5,
      'car_positions': [1, 1, 1]})
```

## 教程

* [Stanford CS107 Programming Paradigms 编程范式](https://see.stanford.edu/course/cs107)
  - [视频](https://www.youtube.com/playlist?list=PL9D558D49CA734A02)
  - [国内视频](https://www.bilibili.com/video/av36373995)

## 图书

* 冒号课堂
* 七周七语言
