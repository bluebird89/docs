# Python

Guido van Rossum在1989年圣诞节期间，为了打发无聊的圣诞节而编写的一个编程语言。

编译器首先会进行语法检查，代码检查

为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下兼容。不同版本的python.exe使用不同的命名，命令行中可以调用的到`python` `python3`.virtualenv 和 virtualenvwrapper 来管理不同项目的依赖环境，通过 workon 、 mkvirtualenv 等命令进行虚拟环境切换

* 网络应用，包括网站、后台服务等等；
* 许多日常需要的小工具，包括系统管理员需要的脚本任务等等；
* 把其他语言开发的程序再包装起来，方便使用。
* 1行代码能实现的功能，决不写5行代码。请始终牢记，代码越少，开发效率越高。

缺点

* 代码少的代价是运行速度慢，C程序运行1秒钟，Java程序可能需要2秒，而Python程序可能就需要10秒。Python是解释型语言，你的代码在执行时会一行一行地翻译成CPU能理解的机器码，这个翻译过程非常耗时，所以很慢。而C程序是运行前直接编译成CPU能执行的机器码，所以非常快。

## 解释器

* 官方版本的解释器：CPython。这个解释器是用C语言开发的，所以叫CPython。在命令行下运行python就是启动CPython解释器。
* Python是基于CPython之上的一个交互式解释器，也就是说，IPython只是在交互方式上有所增强，但是执行Python代码的功能和CPython是完全一样的。CPython用>>>作为提示符，而IPython用In [序号]:作为提示符。
* 目标是执行速度。PyPy采用JIT技术，对Python代码进行动态编译（注意不是解释），所以可以显著提高Python代码的执行速度。绝大部分Python代码都可以在PyPy下运行，但是PyPy和CPython有一些是不同的，这就导致相同的Python代码在两种解释器下执行可能会有不同的结果。
* Jython是运行在Java平台上的Python解释器，可以直接把Python代码编译成Java字节码执行。

## 环境管理

### MAC

* Mac下的python2.7 默认是安装在／System目录下的。但是～～～Mac有个Rootless机制，默认不允许直接在／System下作修改。所以要先关闭Rootless机制。关闭有风险
    - 重启电脑, 重启过程中按住command+R, 进入恢复模式 
    - 打开terminal，键入: csrutil disable 
    - 重启电脑
* 自带版本路径：/System/Library/Frameworks/Python.framework/Versions/Current
* 安装的3.6版本：/usr/local/Cellar/python3/3.6.4_2 
* Anaconda :/Users/henry/anaconda/bin

```shell
brew install python3

# 修改 .bash_profil文件，先搜索尾部，找到后停止搜索
export PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"

# 修改系统默认python版本
export PATH="/usr/local/Cellar/python/3.6.5/bin:$PATH"
alias python="/usr/local/Cellar/python/3.6.5/bin/python3.6"

export PATH="/Users/henry/anaconda/bin:$PATH" # 优先级最高

sudo rm -R /System/Library/Frameworks/Python.framework/Versions/2.7
sudo mv /Library/Frameworks/Python.framework/Versions/3.6 /System/Library/Frameworks/Python.framework/Versions
sudo chown -R root:wheel /System/Library/Frameworks/Python.framework/Versions/3.6
sudo rm /System/Library/Frameworks/Python.framework/Versions/Current
sudo ln -s /System/Library/Frameworks/Python.framework/Versions/3.6 /System/Library/Frameworks/Python.framework/Versions/Current
sudo rm /usr/bin/pydoc
sudo rm /usr/bin/python
sudo rm /usr/bin/pythonw
sudo rm /usr/bin/python-config
sudo ln -s /System/Library/Frameworks/Python.framework/Versions/3.6/bin/pydoc3.6 /usr/bin/pydoc
sudo ln -s /System/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6 /usr/bin/python
sudo ln -s /System/Library/Frameworks/Python.framework/Versions/3.6/bin/pythonw3.6 /usr/bin/pythonw
sudo ln -s /System/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6m-config /usr/bin/python-config
vim ~/.bash_profile # (只要能编辑就行) 插入新的Python路径

pip3 install --upgrade pip setuptools wheel
```

[Using Python on a Macintosh](https://docs.python.org/3/using/mac.html)

> windows

```sh
pip install scrapy
C:\Users\Administrator\AppData\Local\Programs\Python\Python36 # 路径
pip install pywin32 # No module named win32api
```

### 版本管理工具pyenv:修改系统环境变量 PATH

多版本python共存的环境工具，可以在不改变系统环境的情况下，可以随意切换不同python版本。基于某个版本开发的工具，在更换了不同python版本之后，就会导致工具中的某个模块、代码错误，而不能正常使用。

```sh
brew install pyenv

pyenv versions   #  查看当前系统中所有可用的 Python 版本
pyenv commands
pyenv install -l  # 可使用版本列表
pyenv install 3.5.1 #  安装
pyenv uninstall 3.5.1
pyenv which python #  显示路径
pyenv global 3.5.2  #  从三个维度来管理 Python 环境，简称为： 当前系统 、 当前目录 、 当前shell 。这三个维度的优先级从左到右依次升高，即 当前系统 的优先级最低、 当前shell 的优先级最高。
pyenv global 2.7.12 3.5.2 # prefer 2.7.12 over 3.5.2
pyenv local 3.5.2
pyenv shell 3.5.2

$ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH=$HOME/.pyenv/bin:$PATH  //加进系统的环境变量 ～／.zshrc
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
echo 'eval "$(pyenv init -)"' >> ~/Projects/config/env.sh

pyenv -v
pyenv doctor
pyenv update
cat ~/.pyenv/version
pyenv version
```

### 虚拟沙盒virtualenv

Virtualenv is a tool that creates an isolated Python environment for each of your projects

```sh
pip install virtualenv

cd myproject/
virtualenv venv
virtualenv --no-site-packages app_env
virtualenv venv --system-site-packages # also inherit globally installed packages

source app_env/bin/activate
deactivate

brew install pyenv-virtualenv  #集成安装
virtualenv
virtualenv-delete
virtualenv-init
virtualenv-prefix
virtualenvs

pyenv virtualenvs // 看到本地所有的项目环境
pyenv virtualenv 3.5.0 v_env_3.5.0
pyenv activate v_env_3.5.0
pyenv deactivate
pyenv uninstall v_env_3.5.0
pyenv virtualenv PYTHON_VERSION PROJECT_NAME

virtualenv -p /usr/local/bin/python3.6 ENV3.6
source ENV3.6/bin/activate
```

## wheel

Wheels are the new standard of python distribution and are intended to replace eggs.`pip install wheel`

## 包管理工具easy_install.py和pip(pip3 python3)第三方包的安装管理

Python2.7的安装包中，easy_install.py是默认安装的，而pip需要我们手动安装

```sh
curl https://bootstrap.pypa.io/get-pip.py > get-pip.py

sudo python get-pip.py
python get-pip.py   # windows

sudo apt-get install python-pip

sudo easy_install pip

pip search Package              # 搜索软件包
pip install 'Markdown<2.0'
pip install 'Markdown>2.0,<2.0.3'
pip install selenium   # 安装模块包

pip install --upgrade/-U Package        # 升级软件包
pip install --upgrade pip
pip show --files SomePackage

pip list                        # 列出已安装的包
pip list --outdated             # 查看哪些软件需要更新
pip show --files Package        # 查看安装包时安装了哪些文件
pip uninstall Package           # 卸载软件包

pip freeze > requirements.txt        # 导出 //Requirements文件 一般记录的是依赖软件列表，通过pip可以一次性安装依赖软件包:
pip install -r requirements.txt         # 安装

pip completion --bash >> ~/.profile # Bash  pip命令自动补全
~/.profile

pip completion --zsh >> ~/.zprofile  # 对于zsh
 ~/.profile
```

### [iPython](https://github.com/ipython/ipython)

更强大的python交互shell，支持变量自动补全，自动缩进，支持 bash shell 命令，内置了许多很有用的功能和函数

```sh
pip install ipython

pip install 'ipython[zmq,qtconsole,notebook,test]'
```

### [Anaconda](https://github.com/DamnWidget/anacond)

有命令行与图形界面两种方式,Anaconda turns your Sublime Text 3 in a full featured Python development IDE including autocompletion, code linting, IDE features, autopep8 formating, McCabe complexity checker Vagrant and Docker support for Sublime Text 3 using Jedi, PyFlakes, pep8, MyPy, PyLint, pep257 and McCabe that will never freeze your Sublime Text 3

###  jupyter

## 教程

### 执行环境

* 命令行模式下
    * 可以直接运行.py文件 `python hello.py`
    * 添加`#!/usr/bin/env python3`,文件添加执行权限`./basic.py`
* 交互模式：`python` `exit()`
*  (代码助手)[https://raw.githubusercontent.com/michaelliao/learn-python3/master/teach/learning.py]

### 基础

计算机要根据编程语言执行任务，就必须保证编程语言写出的程序决不能有歧义，所以，任何一种编程语言都有自己的一套语法，编译器或者解释器就是负责把符合语法的程序代码转换成CPU能够执行的机器码，然后执行

#### 输入与输出

* `#开头的语句是注释`
* print()在括号中加上字符串，就可以向屏幕上输出指定的文字
* 可以接受多个字符串，用逗号“,”隔开，就可以连成一串输出（会依次打印每个字符串，遇到逗号“,”会输出一个空格）
* 输入计算过程
* input()，可以让用户输入字符串，并存放到一个变量里

```python
print('hello, world')
print('The quick brown fox', 'jump over', 'the lazy dog')
print('100 + 200 =', 100 + 200)
name = input('please enter your name: ') // 有提示框
print('hello,', name)
```

#### 数据类型与变量

在计算机内部，可以把任何数据都看成一个“对象”，而变量就是在程序中用来指向这些数据对象的，对变量赋值就是把数据和变量给关联起来。对变量赋值x = y是把变量x指向真正的对象，该对象是变量y所指向的。随后对变量y的赋值不影响变量x的指向。

* 基本类型
    - 整数:Python可以处理任意大小的整数，当然包括负整数，在程序中的表示方法和数学上的写法一模一样，例如：1，100，-8080，0，等等。二进制、十六进制表示整数比较方便，十六进制用0x前缀和0-9，a-f表示，例如：0xff00，0xa5b4c3d2，等等。
    - 浮点数:浮点数也就是小数，之所以称为浮点数，是因为按照科学记数法表示时，一个浮点数的小数点位置是可变的，比如，1.23x109和12.3x108是完全相等的。浮点数可以用数学写法，如1.23，3.14，-9.01，等等。或者用科学计数法表示，把10用e替代，1.23x10^9就是1.23e9，或者12.3e8，0.000012可以写成1.2e-5，等等。整数和浮点数在计算机内部存储的方式是不同的，整数运算永远是精确的（除法难道也是精确的？是的！），而浮点数运算则可能会有四舍五入的误差。也没有大小限制，但是超出一定范围就直接表示为inf（无限大）
    - 字符串:以单引号'或双引号"括起来的任意文本，比如'abc'，"xyz"等等。请注意，''或""本身只是一种表示方式，不是字符串的一部分，因此，字符串'abc'只有a，b，c这3个字符。如果'本身也是一个字符，那就可以用""括起来，比如"I'm OK"包含的字符是I，'，m，空格，O，K这6个字符。
        + 字符串内部既包含'又包含"怎么办？可以用转义字符\来标识.\n表示换行，\t表示制表符，字符\本身也要转义，所以\\表示的字符就是\
        + 用r''表示''内部的字符串默认不转义
        + 用'''...'''的格式表示多行内容,输入时换行时添加空格
    - 布尔值:只有True、False两种值,可以直接用True、False表示布尔值（请注意大小写）
    - 空值:Python里一个特殊的值，用None表示。None不能理解为0，因为0是有意义的，而None是一个特殊的空值。
* 复合元素
    - 列表：list是一种有序的集合，可以随时添加和删除其中的元素。元素的数据类型也可以不同。可以嵌套(多维数组).查找元素，全表遍历。list越大，查找越慢。
    - 有序列表叫元组：tuple。tuple和list非常类似，但是tuple一旦初始化就不能修改.
        + 当定义一个tuple时，在定义的时候，tuple的元素就必须被确定下来
        + 可以嵌套list：可以修改
    - dict全称dictionary，在其他语言中也称为map，使用键-值（key-value）存储，具有极快的查找速度.无论这个表有多大，查找速度都不会变慢.先在字典的索引表里（比如部首表）查这个字对应的页码（索引遍历）。通过key计算位置的算法称为哈希算法（Hash），要保证hash的正确性，作为key的对象就不能变。字符串、整数等都是不可变的，因此，可以放心地作为key。而list是可变的，就不能作为key
        + 一个key只能对应一个value，所以，多次对一个key放入value，后面的值会把前面的值冲掉
        + dict的key必须是不可变对象
        + 如果获取的key不存在，dict就会报错：两种方法判断
        + dict内部存放的顺序和key放入的顺序是没有关系的
    - dict与list比较：用空间来换取时间的一种方法
        + 查找和插入的速度极快，不会随着key的增加而变慢；
        + 需要占用大量的内存，内存浪费多。
    - set和dict类似，也是一组key的集合，但不存储value。由于key不能重复，所以，在set中，没有重复的key
        + 提供一个list作为输入集合
        + 重复元素在set中自动被过滤
        + 数学意义上的无序和无重复元素的集合，因此，两个set可以做数学意义上的交集、并集
        + set和dict的唯一区别仅在于没有存储对应的value，但是，set的原理和dict一样，所以，同样不可以放入可变对象，因为无法判断两个可变对象是否相等，也就无法保证set内部“不会有重复元素”。
* 变量不仅可以是数字，还可以是任意数据类型 
    - 必须是大小写英文、数字和_的组合，且不能用数字开头
    - 等号=是赋值语句，可以把任意数据类型赋值给变量，同一个变量可以反复赋值，而且可以是不同类型的变量
    - 变量本身类型不固定的语言称之为动态语言，与之对应的是静态语言。静态语言在定义变量时必须指定变量类型，如果赋值的时候类型不匹配，就会报错。例如Java是静态语言
    - 变量创建过程：在内存中创建了一个'ABC'的字符串；在内存中创建了一个名为a的变量，并把它指向'ABC'。
* *可变对象与不可变对象* （值操作与引用操作）
    - a是变量，而'abc'才是字符串对象！有些时候，我们经常说，对象a的内容是'abc'，但其实是指，a本身是一个变量，它指向的对象的内容才是'abc'
    - replace方法创建了一个新字符串'Abc'并返回
    - 对于不变对象来说，调用对象自身的任意方法，也不会改变该对象自身的内容。相反，这些方法会创建新的对象并返回，这样，就保证了不可变对象本身永远是不可变的。
    - 因为不变对象一旦创建，对象内部的数据就不能修改，这样就减少了由于修改数据导致的错误。此外，由于对象不变，多任务环境下同时读取对象不需要加锁，同时读一点问题都没有。我们在编写程序时，如果可以设计一个不变对象，那就尽量设计成不变对象。
* 常量：用全部大写的变量名表示常量。不能变的变量。事实上PI仍然是一个变量，Python根本没有任何机制保证PI不会被改变，所以，用全部大写的变量名表示常量只是一个习惯上的用法

```python
print('I\'m ok.')
print('I\'m learning\nPython.')
print('\\\n\\')
print(r'\\\t\\')
print('''line1
line2
line3''')
print(r'''hello,\n
world''')
True
3 > 2
True and True
True or False
5 > 3 or 1 > 3
not 1 > 2
int('12345', base=8) # 5349
int('12345', 16) # 74565

classmates = ['Michael', 'Bob', 'Tracy']
classmates[0] #  'Michael'  获取元素
classmates[-1] # 'Tracy' 
classmates.append('Adam')  # ['Michael', 'Bob', 'Tracy', 'Adam']
classmates.insert(1, 'Jack') # ['Michael', 'Jack', 'Bob', 'Tracy', 'Adam']
classmates.pop() # 'Adam'   删除list末尾的元素
classmates.pop(1)  # 'Jack' 删除指定索引
classmates[1] = 'Sarah' # 元素赋值

s = ['python', 'java', ['asp', 'php'], 'scheme']
len(s) # 4
s[2][1]
L = []

d = {'Michael': 95, 'Bob': 75, 'Tracy': 85}
d['Adam'] = 67 # 添加
'Thomas' in d # 判断是否存在
d.get('Thomas', -1) # 添加默认值
d.pop('Bob') # 删除

s = set([1, 2, 3])
s.add(4)
s.remove(4)
s1 = set([1, 2, 3])
s2 = set([2, 3, 4])
s1 & s2
s1 | s2

a = 'ABC'
b = a.replace('A', 'a')
a # 'ABC'
b # 'aBC'
```

#### 高级特性

* 切片（slice）：取一个list或tuple的部分元素.倒数第一个元素的索引是-1 L[begin:end:foot].还支持tuple str
* 迭代：通过for循环来遍历这个list或tuple，这种遍历我们称为迭代（Iteration）。只要是可迭代对象(list、tuple、dict、set、str)，无论有无下标，都可以迭代.enumerate函数可以把一个list变成索引-元素对，这样就可以在for循环中同时迭代索引和元素本身
* 列表生成式即List Comprehensions，是Python内置的非常简单却强大的可以用来创建list的生成式.运用列表生成式，可以快速生成list，可以通过一个list推导出另一个list
* 生成器generator:通过列表生成式，我们可以直接创建一个列表。但是，受到内存限制，列表容量肯定是有限的。而且，创建一个包含100万个元素的列表，不仅占用很大的存储空间，如果我们仅仅需要访问前面几个元素，那后面绝大多数元素占用的空间都白白浪费了。是否可以在循环的过程中不断推算出后续的元素.
    - generator保存的是算法，每次调用next(g)，就计算出g的下一个元素的值，直到计算到最后一个元素，没有更多的元素时，抛出StopIteration的错误。
    - 只要把一个列表生成式的[]改成()，就创建了一个generator.通过next()函数获得generator的下一个返回值,通过for循环来迭代
    - 一个函数定义中包含yield关键字，那么这个函数就不再是一个普通函数，而是一个generator.遇到yield就中断，下次又继续执行
* 迭代器Iterator：可以被next()函数调用并不断返回下一个值的对象称为迭代器：Iterator。
    - Iterator对象表示的是一个数据流，Iterator对象可以被next()函数调用并不断返回下一个数据，直到没有数据时抛出StopIteration错误。可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过next()函数实现按需计算下一个数据，所以Iterator的计算是惰性的，只有在需要返回下一个数据时它才会计算。
* 可迭代对象Iterable：可以直接作用于for循环的对象统称为可迭代对象：一类是集合数据类型，如list、tuple、dict、set、str等；一类是generator，包括生成器和带yield的generator function。
    - 生成器都是Iterator对象，但list、dict、str虽然是Iterable，却不是Iterator。把list、dict、str等Iterable变成Iterator可以使用iter()函数

```python
s = ['python', 'java', ['asp', 'php'], 'scheme']
s[0:3] # ['python', 'java', ['asp', 'php']]
s[:3] # ['python', 'java', ['asp', 'php']]
s[1:3] # ['java', ['asp', 'php']]
s[-2:] # [['asp', 'php'], 'scheme']

L = list(range(100))
L[:10]
L[-10:] # [90, 91, 92, 93, 94, 95, 96, 97, 98, 99]
L[10:20] # [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
L[:10:2] # [0, 2, 4, 6, 8]
L[::5] # [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
L[:] # [0, 1, 2, 3, ..., 99] 原样复制一个list
(0, 1, 2, 3, 4, 5)[:3] # (0, 1, 2)
'ABCDEFG'[::2] # 'ACEG'
'ABCDEFG'[:3] # 'ABC'
classmates = ('Michael', 'Bob', 'Tracy'，['A', 'B'])
t[2][1] = 'Y'
t = () # 定义一个空的tuple
t = (1,) # 只有1个元素的tuple定义时必须加一个逗号

from collections import Iterable
isinstance('abc', Iterable) # str是否可迭代

d = {'a': 1, 'b': 2, 'c': 3}
for key in d
for value in d.values()
for k, v in d.items()
for ch in 'ABC'

for i, value in enumerate(['A', 'B', 'C']):
    print(i, value)

for x, y in [(1, 1), (2, 4), (3, 9)]:
    print(x, y)

[x * x for x in range(1, 11)]
[x * x for x in range(1, 11) if x % 2 == 0]
[m + n for m in 'ABC' for n in 'XYZ'] # ['AX', 'AY', 'AZ', 'BX', 'BY', 'BZ', 'CX', 'CY', 'CZ']

import os # 导入os模块，模块的概念后面讲到
[d for d in os.listdir('.')] # os.listdir可以列出文件和目录

d = {'x': 'A', 'y': 'B', 'z': 'C' }
[k + '=' + v for k, v in d.items()]  # ['y=B', 'x=A', 'z=C']

g = (x * x for x in range(10))
for n in g:
    print(n)

def fib(max):
    n, a, b = 0, 0, 1
    while n < max:
        yield b
        a, b = b, a + b
        n = n + 1
    return 'done'
g = fib(5)
next(g)
next(g)
next(g)

while True:
     try:
         x = next(g)
         print('g:', x)
     except StopIteration as e:
         print('Generator return value:', e.value)
         break

from collections import Iterator
isinstance([], Iterable) # True

from collections import Iterator
isinstance((x for x in range(10)), Iterator) # True
isinstance([], Iterator) # False
isinstance(iter([]), Iterator) # True
```

##### 运算符

* /除法计算结果是浮点数，即使是两个整数恰好整除，结果也是浮点数
* //，称为地板除，两个整数的除法仍然是整数
* 余数运算，可以得到两个整数相除的余数

```python
10 / 3
10 // 3
10 % 3
```

##### 编码

字符与字节的转换 *区分字符与字节*

* Python 3版本中，字符串是以Unicode编码的
* 把Unicode编码转化为“可变长编码”的UTF-8编码。UTF-8编码把一个Unicode字符根据不同的数字大小编码成1-6个字节，常用的英文字母被编码成1个字节，汉字通常是3个字节，只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符，用UTF-8编码就能节省空间
* 单个字符的编码，Python提供了ord()函数获取字符的整数表示，chr()函数把编码转换为对应的字符(单字符与码的转换)
* 字符串类型是str，在内存中以Unicode表示，一个字符对应若干个字节。如果要在网络上传输，或者保存到磁盘上，就需要把str变为以字节为单位的bytes。
* bytes类型的数据用带b前缀的单引号或双引号表示：'ABC'和b'ABC'，前者是str，后者虽然内容显示得和前者一样，但bytes的每个字符都只占用一个字节
* 纯英文的str可以用ASCII编码为bytes，内容是一样的，含有中文的str可以用UTF-8编码为bytes。含有中文的str无法用ASCII编码，因为中文编码的范围超过了ASCII编码的范围，Python会报错。
* 在bytes中，无法显示为ASCII字符的字节，用\x##显示。
* 从网络或磁盘上读取了字节流，那么读到的数据就是bytes。要把bytes变为str，就需要用decode()方法
* bytes中包含无法解码的字节，decode()方法会报错
* 如果bytes中只有一小部分无效的字节，可以传入errors='ignore'忽略错误的字节
* len()函数计算的是str的字符数，如果换成bytes，len()函数就计算字节数
* 遇到str和bytes的互相转换。为了避免乱码问题，应当始终坚持使用UTF-8编码对str和bytes进行转换。
* `#!/usr/bin/env python3` 告诉Linux/OS X系统，这是一个Python可执行程序，Windows系统会忽略这个注释
* 由于Python源代码也是一个文本文件，所以，当你的源代码中包含中文的时候，在保存源代码时，就需要务必指定保存为UTF-8编码。`# -*- coding: utf-8 -*-`当Python解释器读取源代码时，为了让它按UTF-8编码读取，申明了UTF-8编码并不意味着你的.py文件就是UTF-8编码的，必须并且要确保文本编辑器正在使用UTF-8 without BOM编码
* 格式化输出：%运算符就是用来格式化字符串的。在字符串内部，有几个%?占位符，后面就跟几个变量或者值，顺序要对应好。如果只有一个%?，括号可以省略。格式化整数和浮点数还可以指定是否补0和整数与小数的位数
    - %s表示用字符串替换
    - %d表示用整数替换
    - %f    浮点数
    - %x    十六进制整数
    - 不太确定应该用什么，%s永远起作用，它会把任何数据类型转换为字符串
    - 字符串里面的%是一个普通字符怎么办？这个时候就需要转义，用%%来表示一个%
* 另一种格式化字符串的方法是使用字符串的format()方法，它会用传入的参数依次替换字符串内的占位符{0}、{1}……

```python
ord('A')
ord('中')
chr(66)
chr(25991)
'\u4e2d\u6587' # '中文'
x = b'ABC'
'ABC'.encode('ascii')   # b'ABC'
'中文'.encode('utf-8') # b'\xe4\xb8\xad\xe6\x96\x87'

b'ABC'.decode('ascii')  # 'ABC'
b'\xe4\xb8\xad\xe6\x96\x87'.decode('utf-8') #  '中文'
b'\xe4\xb8\xad\xff'.decode('utf-8', errors='ignore') # '中'

len('ABC') # 3
len('中文') # 2

len(b'ABC') # 3
len(b'\xe4\xb8\xad\xe6\x96\x87') # 6
len('中文'.encode('utf-8')) # 6

#!/usr/bin/env python3  
# -*- coding: utf-8 -*-

'Hi, %s, you have $%d.' % ('Michael', 1000000)
print('%2d-%02d' % (3, 1)) # 3-01
print('%.2f' % 3.1415926) # 3.14

'Age: %s. Gender: %s' % (25, True) # 'Age: 25. Gender: True'

'growth rate: %d %%' % 7 # 'growth rate: 7 %'

'Hello, {0}, 成绩提升了 {1:.1f}%'.format('小明', 17.125)  # 'Hello, 小明, 成绩提升了 17.1%'
```

##### 控制语句

* 判断语句
* 循环:for while
* break语句可以提前退出循环
* continue语句，跳过当前的这次循环，直接开始下一次循环

```python
age = 3
if age >= 18:
    print('adult')
elif age >= 6:
    print('teenager')
else:
    print('kid')

if x:  # 只要x是非零数值、非空字符串、非空list等，就判断为True，否则为False。
    print('True')

s = input('birth: ') # input()返回的数据类型是str，str不能直接和整数比较，必须先把str转换成整数
birth = int(s)

sum = 0
for x in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]:
    sum = sum + x
print(sum)
for x in range(11):
    sum = sum + x
print(sum)

sum = 0
n = 99
while n > 0:
    sum = sum + n
    n = n - 2
print(sum)

n = 1
while n <= 100:
    if n > 10: # 当n = 11时，条件满足，执行break语句
        break # break语句会结束当前循环
    print(n)
    n = n + 1
print('END')

n = 0
while n < 10:
    n = n + 1
    if n % 2 == 0: # 如果n是偶数，执行continue语句
        continue # continue语句会直接继续下一轮循环，后续的print()语句不会执行
    print(n)
```

##### 函数

函数就是最基本的一种代码抽象的方式。

* 函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量
    - abs(-10)是函数调用，而abs是函数本身
    - 函数名其实就是指向函数的变量
* 内置函数：调用一个函数，需要知道函数的名称和参数（个数与数据类型），数据类型转换
* 定义一个函数要使用def语句，依次写出函数名、括号、括号中的参数和冒号:，然后，在缩进块中编写函数体，函数的返回值用return语句返回。
    - 一旦执行到return时，函数就执行完毕，并将结果返回
    - 如果没有return语句，函数执行完毕后也会返回结果，只是结果为None。return None可以简写为return
    - 函数引用：把my_abs()的函数定义保存为abstest.py文件了，用from abstest import my_abs来导入my_abs()函数，注意abstest是文件名（不含.py扩展名）
    - pass语句什么都不做，实际上pass可以用来作为占位符，比如现在还没想好怎么写函数的代码，就可以先放一个pass，让代码能运行起来。
    - 多值返回：返回值是一个tuple！但是，在语法上，返回一个tuple可以省略括号，而多个变量可以同时接收一个tuple，按位置赋给对应的值
* 参数
    - 位置参数：power(x, n)函数有两个参数：x和n，这两个参数都是位置参数，调用函数时，传入的两个值按照位置顺序依次赋给参数x和n
    - 默认参数：含有默认值，调用时可以省略赋值。能降低调用函数的难度（减少对默认参数的顾虑）
        + 必选参数在前，默认参数在后。
        + 变化大的参数放前面，变化小的参数放后面。变化小的参数就可以作为默认参数。
        + 也可以不按顺序提供部分默认参数。当不按顺序提供部分默认参数时，需要把参数名写上。比如调用enroll('Adam', 'M', city='Tianjin')
        + 因为默认参数L也是一个变量，它指向对象[]，每次调用该函数，如果改变了L的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的[]了。(作用域)
    - 可变参数：传入的参数个数是可变的。`*nums`表示把nums这个list的所有元素作为可变参数传进去。`*args`是可变参数，args接收的是一个tuple；可变参数既可以直接传入：func(1, 2, 3)，又可以先组装list或tuple，再通过`*args`传入：func(*(1, 2, 3))
    - 关键字参数：扩展函数的功能，如果调用者愿意提供更多的参数，也能收到，`**kw`是关键字参数，kw接收的是一个dict.可以直接传入：func(a=1, b=2)，又可以先组装dict，再通过**kw传入：func(**{'a': 1, 'b': 2})
    - 命名关键字参数：限制关键字参数的名字，例如，只接收city和job作为关键字参数。必须传入参数名，这和位置参数不同。如果没有传入参数名，调用将报错
        + 命名关键字参数需要一个特殊分隔符*，*后面的参数被视为命名关键字参数
        + 如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符*了
        + 命名关键字参数必须传入参数名，这和位置参数不同。如果没有传入参数名，调用将报错
    - 以上参数方法可以相互组合：参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数。
* 递归函数：如果一个函数在内部调用自身本身，这个函数就是递归函数
    - 定义简单，逻辑清晰。理论上，所有的递归函数都可以写成循环的方式，但循环的逻辑不如递归清晰。
    - 注意防止栈溢出。在计算机中，函数调用是通过栈（stack）这种数据结构实现的，每当进入一个函数调用，栈就会加一层栈帧，每当函数返回，栈就会减一层栈帧。由于栈的大小不是无限的，所以，递归调用的次数过多，会导致栈溢出。
    - 解决栈溢出：尾递归优化，事实上尾递归和循环的效果是一样的，所以，把循环看成是一种特殊的尾递归函数也是可以的。
        + 尾递归是指，在函数返回的时候，调用自身本身，并且，return语句不能包含表达式。这样，编译器或者解释器就可以把尾递归做优化，使递归本身无论调用多少次，都只占用一个栈帧，不会出现栈溢出的情况。(算法优化)
        + 大多数编程语言没有针对尾递归做优化，Python解释器也没有做优化，所以，即使把上面的fact(n)函数改成尾递归方式，也会导致栈溢出。

```python
abs(-10) # 函数调用
abs # 函数本身

abs(100)
help(abs)
max(2, 3, 1, -5)
int('123')
int(12.34) # 12
float('12.34')
str(100)
bool(1) # True
bool('') # False
a = abs # 变量a指向abs函数
a(-1) # 所以也可以通过a调用abs函数
hex(100) # 一个整数转换成十六进制表示的字符串

def my_abs(x):
    if not isinstance(x, (int, float)):  # 参数检测
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x

def nop():  #空函数
    pass

import math

def move(x, y, step, angle=0):
    nx = x + step * math.cos(angle)
    ny = y - step * math.sin(angle)
    return nx, ny
x, y = move(100, 100, 60, math.pi / 6)

def power(x, n=2):
    s = 1
    while n > 0:
        n = n - 1
        s = s * x
    return s

def enroll(name, gender, age=6, city='Beijing'):
    print('name:', name)
    print('gender:', gender)
    print('age:', age)
    print('city:', city)
enroll('Adam', 'M', city='Tianjin')

def add_end(L=[]):
    L.append('END')
    return L
add_end()
add_end() # ['END', 'END']
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L

def calc(numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
calc([1, 2, 3]) # 14
calc(1, 2, 3) # 报错

def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
nums = [1, 2, 3]
calc(*nums)

def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
person('Adam', 45, gender='M', job='Engineer') # name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}
extra = {'city': 'Beijing', 'job': 'Engineer'}
person('Jack', 24, **extra)

def person(name, age, *, city='Beijing', job):
    print(name, age, city, job)
person('Jack', 24, city='Beijing', job='Engineer')
person('Jack', 24, job='Engineer')
def person(name, age, *args, city, job):
    print(name, age, args, city, job)

def f1(a, b, c=0, *args, **kw):
    print('a =', a, 'b =', b, 'c =', c, 'args =', args, 'kw =', kw)
f1(1, 2, 3, 'a', 'b', x=99) # a = 1 b = 2 c = 3 args = ('a', 'b') kw = {'x': 99}
def f2(a, b, c=0, *, d, **kw):
    print('a =', a, 'b =', b, 'c =', c, 'd =', d, 'kw =', kw)

args = (1, 2, 3, 4)
kw = {'d': 99, 'x': '#'}
f1(*args, **kw) # a = 1 b = 2 c = 3 args = (4,) kw = {'d': 99, 'x': '#'}

args = (1, 2, 3)
kw = {'d': 88, 'x': '#'}
f2(*args, **kw) # a = 1 b = 2 c = 3 d = 88 kw = {'x': '#'}

def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)

def fact(n):
    return fact_iter(n, 1)

def fact_iter(num, product):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product)
```

##### 函数是式编程 Functional Programming

函数式编程就是一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用
一个特点就是，允许把函数本身作为参数传入另一个函数，还允许返回一个函数！Python对函数式编程提供部分支持。由于Python允许使用变量，因此，Python不是纯函数式编程语言。

* 高阶函数：函数的参数能够接收别的函数
    - map()函数接收两个参数，一个是函数，一个是Iterable，map将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回.
    - reduce把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数，reduce把结果继续和序列的下一个元素做累积计算
    - filter()把传入的函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素.关键在于正确实现一个“筛选”函数
    - 排序算法 sorted（），可以接收一个key函数来实现自定义的排序
* 返回函数：把函数作为结果值返回
    - 闭包
    - 在函数lazy_sum中又定义了函数sum，并且，内部函数sum可以引用外部函数lazy_sum的参数和局部变量，当lazy_sum返回函数sum时，相关参数和变量都保存在返回的函数中，这种称为“闭包（Closure）”
    - 调用lazy_sum()时，每次调用都会返回一个新的函数，即使传入相同的参数
* 匿名函数
    - 关键字lambda表示匿名函数，冒号前面的x表示函数参数
    - 有个限制，就是只能有一个表达式，不用写return，返回值就是该表达式的结果
* 装饰器
    - decorator就是一个返回函数的高阶函数
    - 接受一个函数作为参数，并返回一个函数。借助Python的@语法，把decorator置于函数的定义处
    - 将函数包裹重新指向原函数变量名
    - 装饰器本身需要传入参数
    - 内置的functools.wraps的使用，不需要编写wrapper.__name__ = func.__name__
    - 在面向对象（OOP）的设计模式中，decorator被称为装饰模式。OOP的装饰模式需要通过继承和组合来实现，而Python除了能支持OOP的decorator外，直接从语法层次支持decorator。Python的decorator可以用函数实现，也可以用类实现。
* 偏函数：functools模块提供了很多有用的功能，其中一个就是偏函数（Partial function）
    - functools.partial的作用就是，把一个函数的某些参数给固定住（也就是设置默认值），返回一个新的函数，调用这个新函数会更简单。
    - 创建偏函数时，实际上可以接收函数对象、*args和**kw这3个参数
    - 将自第二位起的参数作为*args和**kw自动加到函数里面参数的左边

```python
def add(x, y, f):
    return f(x) + f(y)
print(add(-5, 6, abs))

def f(x):
     return x * x
r = map(f, [1, 2, 3, 4, 5, 6, 7, 8, 9])
list(r) # [1, 4, 9, 16, 25, 36, 49, 64, 81]  由于结果r是一个Iterator，Iterator是惰性序列，因此通过list()函数让它把整个序列都计算出来并返回一个list
def normalize(name):
        return  name.capitalize()
L1 = ['adam', 'LISA', 'barT']
L2 = list(map(normalize, L1))
print(L2)

from functools import reduce
def fn(x, y):
     return x * 10 + y
reduce(fn, [1, 3, 5, 7, 9]) # 13579

def str2int(s):
    def fn(x, y):
        return x * 10 + y
    def char2num(s):
        return {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}[s]
    return reduce(fn, map(char2num, s)) # 13579

def char2num(s):   # lambda 写法
    return {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}[s]
def str2int(s):
    return reduce(lambda x, y: x * 10 + y, map(char2num, s))

def not_empty(s):
    return s and s.strip()
list(filter(not_empty, ['A', '', 'B', None, 'C', '  ']))

def _odd_iter():  # 构造素数
    n = 1
    while True:
        n = n + 2
        yield n
def _not_divisible(n):
    return lambda x: x % n > 0
def primes():
    yield 2
    it = _odd_iter() # 初始序列
    while True:
        n = next(it) # 返回序列的第一个数
        yield n
        it = filter(_not_divisible(n), it) # 构造新序列
for n in primes():
    if n < 1000:
        print(n)
    else:
        break

sorted([36, 5, -12, 9, -21])
sorted([36, 5, -12, 9, -21], key=abs)
sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower)
sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)

def lazy_sum(*args):
    def sum():
        ax = 0
        for n in args:
            ax = ax + n
        return ax
    return sum
f1 = lazy_sum(1, 3, 5, 7, 9)
f2 = lazy_sum(1, 3, 5, 7, 9)
f1==f2 # False
f1 # <function lazy_sum.<locals>.sum at 0x101c6ed90>
f1() #

def count():
    fs = []
    for i in range(1, 4):
        def f():
             return i*i
        fs.append(f)
    return fs

f1, f2, f3 = count()
f1() # 9
f2() # 9
f3() # 9

def count():
    def f(j):
        def g():
            return j*j
        return g
    fs = []
    for i in range(1, 4):
        fs.append(f(i)) # f(i)立刻被执行，因此i的当前值被传入f()
    return fs

list(map(lambda x: x * x, [1, 2, 3, 4, 5, 6, 7, 8, 9])) # [1, 4, 9, 16, 25, 36, 49, 64, 81]
f = lambda x: x * x
f(5)

def log(func):
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper
@log  # @log放到now()函数的定义处，相当于执行了语句 now = log(now)
def now():
    print('2015-3-25')

import functools
def log(func):
    @functools.wraps(func)
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper

def log(text):
    def decorator(func):
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
@log('execute') # now = log('execute')(now)
def now():
    print('2015-3-25')

import functools
def log(text):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator

import functools
int2 = functools.partial(int, base=2) 
int2('100000') # 32 int('100000', **{ 'base':2 })

max2 = functools.partial(max, 10)
max(*(10, 5, 6, 7))
```

##### 模块

* 大大提高了代码的可维护性。
* 其次，编写代码不必从零开始。当一个模块编写完毕，就可以被其他地方引用。包括Python内置的模块和来自第三方的模块
* 可以避免函数名和变量名冲突。相同名字的函数和变量完全可以分别存在不同的模块中，尽量不要与内置函数名字冲突
* 避免模块名冲突，Python又引入了按目录来组织模块的方法，称为包（Package）。
    - 一个abc.py的文件就是一个名字叫abc的模块
    - 通过包来组织模块，避免冲突。方法是选择一个顶层包名，比如mycompany文件下的abc.py（mycompany.abc）。只要顶层的包名不与别人冲突，那所有模块都不会与别人冲突
    - 还可以扩展多级目录mycompany.web.www
* 命名
    - 模块名要遵循Python变量命名规范，不要使用中文、特殊字符；
    - 模块名不要和系统模块名冲突，最好先查看系统是否已存在该模块，检查方法是在Python交互环境执行import abc，若成功则说明系统存在此模块。
    - 任何模块代码的第一个字符串都被视为模块的文档注释；
    - __author__变量把作者写进去，这样当你公开源代码后别人就可以瞻仰你的大名；
    - 当我们在命令行运行hello模块文件时，Python解释器把一个特殊变量__name__置为__main__，而如果在其他地方导入该hello模块时，if判断将失败，因此，这种if测试可以让一个模块通过命令行运行时执行一些额外的代码，最常见的就是运行测试。
    - 作用域
        + 函数和变量给外部使用，通过_实现
        + 正常的函数和变量名是公开的（public），可以被直接引用，比如：abc，x123，PI等
        + 似__xxx__这样的变量是特殊变量，可以被直接引用，但是有特殊用途，比如上面的__author__，__name__就是特殊变量，hello模块定义的文档注释也可以用特殊变量__doc__访问，我们自己的变量一般不要用这种变量名；
        + 类似_xxx和__xxx这样的函数或变量就是非公开的（private），不应该被直接引用，比如_abc，__abc等；
        + 在模块里公开greeting()函数，而把内部逻辑用private函数隐藏起来了，这样，调用greeting()函数不用关心内部的private函数细节，这也是一种非常有用的代码封装和抽象的方法，即：
        + 外部不需要引用的函数全部定义成private，只有外部需要引用的函数才定义为public。
    - 第三方模块：通过包管理工具pip完成(windows勾选了pip和Add python.exe to Path)
        + 直接使用Anaconda，这是一个基于Python的数据处理和科学计算平台，它已经内置了许多非常有用的第三方库，我们装上Anaconda，就相当于把数十个第三方模块自动安装好了，非常简单易用
        + 从Anaconda官网下载GUI安装包，安装包有500~600M，所以需要耐心等待下载。下载后直接安装，Anaconda会把系统Path中的python指向自己自带的Python，并且，Anaconda安装的第三方模块会安装在Anaconda自己的路径下，不影响系统已安装的Python目录。直接import
        + 默认情况下，Python解释器会搜索当前目录、所有已安装的内置模块和第三方模块，搜索路径存放在sys模块的path变量中。添加自己的搜索目录
            * 修改sys.path，添加要搜索的目录
            * 设置环境变量PYTHONPATH，该环境变量的内容会被自动添加到模块搜索路径中。设置方式与设置Path环境变量类似。注意只需要添加你自己的搜索路径，Python自己本身的搜索路径不受影响。

```python
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Michael Liao'

import sys

def test():
    args = sys.argv
    if len(args)==1:
        print('Hello, world!')
    elif len(args)==2:
        print('Hello, %s!' % args[1])
    else:
        print('Too many arguments!')

if __name__=='__main__':
    test()

python hello.py
import hello
hello.test()

def _private_1(name):
    return 'Hello, %s' % name

def _private_2(name):
    return 'Hi, %s' % name

def greeting(name):
    if len(name) > 3:
        return _private_1(name)
    else:
        return _private_2(name)

pip install Pillow

import sys
sys.path.append('/Users/michael/my_py_scripts')
```

#### 面向对象编程

面向对象编程——Object Oriented Programming，简称OOP，是一种程序设计思想。OOP把对象作为程序的基本单元，一个对象包含了数据和操作数据的函数。

面向过程的程序设计把计算机程序视为一系列的命令集合，即一组函数的顺序执行。为了简化程序设计，面向过程把函数继续切分为子函数，即把大块函数通过切割成小块函数来降低系统的复杂度。

而面向对象的程序设计把计算机程序视为一组对象的集合，而每个对象都可以接收其他对象发过来的消息，并处理这些消息，计算机程序的执行就是一系列消息在各个对象之间传递。

所有数据类型都可以视为对象，当然也可以自定义对象。自定义的对象数据类型就是面向对象中的类（Class）的概念。

采用面向对象的程序设计思想:来自自然界中的类与实例概念

* 首选思考的不是程序的执行流程，而是Student这种数据类型应该被视为一个对象，这个对象拥有name和score这两个属性（Property）
* Class是一种抽象概念，比如我们定义的Class——Student，是指学生这个概念，而实例（Instance）则是一个个具体的Student
* 抽象出Class，根据Class创建Instance。
* 类是创建实例的模板
    - 通过class关键字
    - 类名通常是大写开头的单词
    - 紧接着是(object)，表示该类是从哪个类继承下来的，没有合适的继承类，就使用object类，这是所有类最终都会继承的类
    - 将必须绑定的属性强制填写进去。通过定义一个特殊的__init__方法，在创建实例的时候，就把name，score等属性绑上去
        + 第一个参数永远是self，表示创建的实例本身，因此，在__init__方法内部，就可以把各种属性绑定到self，因为self就指向创建的实例本身。
        + 在创建实例的时候，就不能传入空的参数了，必须传入与__init__方法匹配的参数，但self不需要传，Python解释器自己会把实例变量传进去
    - 允许对实例变量绑定任何数据
* 封装
    - 类中定义的函数只有一点不同，就是第一个参数永远是实例变量self，并且，调用时，不用传递该参数。除此之外，类的方法和普通函数没有什么区别，所以，你仍然可以用默认参数、可变参数、关键字参数和命名关键字参数。
    - 类的方法：在类的内部定义访问数据的函数，这样，就把“数据”给封装起来了。这些封装数据的函数是和类本身是关联起来的，可以直接访问与操作实例的数据；
    - 从外部看Student类，就只需要知道，创建实例需要给出name和score，而如何打印，都是在Student类的内部定义的，这些数据和逻辑被“封装”起来了，调用就直接操作了对象内部的数据，但无需知道方法内部的实现细节。
* 实例是根据类创建出来的一个个具体的“对象”，每个对象都拥有相同的方法，但各自的数据可能不同，互相独立，互不影响。
* 访问限制
    - 让内部属性不被外部访问，可以把属性的名称前加上两个下划线__，实例的变量名如果以__开头，就变成了一个私有变量（private），只有内部可以访问，外部不能访问。解释器对外把__name变量改成了_Student__name，所以，仍然可以通过_Student__name来访问__name变量（不同版本的Python解释器可能会把__name改成不同的变量名）
    - 外部代码不能随意访问与修改对象内部的状态，这样通过访问限制的保护，代码更加健壮
    - set方法可以做参数
    - 特殊变量：以双下划线开头，并且以双下划线结尾的。可以直接访问
    - _name，这样的实例变量外部是可以访问的，但是，按照约定俗成的规定，意思就是，“虽然我可以被访问，但是，请把我视为私有变量，不要随意访问”。
* 继承：定义一个class的时候，可以从某个现有的class继承，新的class称为子类（Subclass），而被继承的class称为基类、父类或超类（Base class、Super class）
    - 子类获得了父类的全部功能
    - 对子类增加一些方法
* 多态：当子类和父类都存在相同的run()方法时，子类的run()覆盖了父类的run()，在代码运行的时候，总是会调用子类的run()
    - 定义一个class的时候，实际上就定义了一种数据类型，与自带的数据类型一样
    - 子类也是父类的实例
    - run_twice()调用方只管调用，不管对象细节（只要确保run()方法编写正确，不用管原来的代码是如何调用的）
        + 对扩展开放：允许新增Animal子类；
        + 对修改封闭：不需要修改依赖Animal类型的run_twice()等函数。
    - 静态语言 vs 动态语言
        + 对于静态语言（例如Java）来说，如果需要传入Animal类型，则传入的对象必须是Animal类型或者它的子类，否则，将无法调用run()方法。(对象检查)
        + 对于Python这样的动态语言来说，则不一定需要传入Animal类型。我们只需要保证传入的对象有一个run()方法就可以了（方法检查）。“鸭子类型”，它并不要求严格的继承体系，一个对象只要“看起来像鸭子，走起路来像鸭子”，那它就可以被看做是鸭子
* 判断对象类型
    - 使用type()函数
    - 使用types模块中定义的常量
    - 判断class的类型，可以使用isinstance()函数,优先使用
    - 获得一个对象的所有属性和方法，可以使用dir()函数，它返回一个包含字符串的list,可以给对象封装类似的方法
    - 类属性与方法是否存在、获取与设置
    - 要判断该对象是否存在read方法，如果存在，则该对象是一个流，如果不存在，则无法读取。hasattr()就派上了用场。
* 类属性：定义了一个类属性后，这个属性归类所有，类的所有实例都可以访问到
    - 给实例绑定属性的方法是通过实例变量，或者通过self变量
    - 不要对实例属性和类属性使用相同的名字，因为相同名称的实例属性将屏蔽掉类属性，但是当你删除实例属性后，再使用相同的名称，访问到的将是类属性。

```python
std1 = { 'name': 'Michael', 'score': 98 }
std2 = { 'name': 'Bob', 'score': 81 }

def print_score(std):
    print('%s: %s' % (std['name'], std['score']))

class Student(object):
    name = 'Student'
    def __init__(self, name, score):
        self.__name = name
        self.__score = score
    def print_score(self):
        print('%s: %s' % (self.name, self.score))
    def get_name(self):
        return self.__name
    def get_score(self):
        return self.__score
    def set_score(self, score):
        if 0 <= score <= 100:
            self.__score = score
        else:
            raise ValueError('bad score')
bart = Student('Bart Simpson', 59)
bart.print_score()
lisa = Student('Lisa Simpson', 87)
bart.age = 8
lisa.age # 报错

class Animal(object):
    def run(self):
        print('Animal is running...')

class Dog(Animal):

    def run(self):
        print('Dog is running...')

class Cat(Animal):

    def run(self):
        print('Cat is running...')
b = Animal() # b是Animal类型
c = Dog() # c是Dog类型
isinstance(c, Animal) # True

def run_twice(animal):
    animal.run()
    animal.run()

run_twice(Animal())
run_twice(Dog())

type(123) # class 'int'>
type(abs) # <class 'builtin_function_or_method'>
type(a) # <class '__main__.Animal'>
type('abc')==str # True
type('abc')==type(123) # False

import types
    def fn():
        pass
type(fn)==types.FunctionType # True
type(abs)==types.BuiltinFunctionType # True
type(lambda x: x)==types.LambdaType # True
type((x for x in range(10)))==types.GeneratorType # True

isinstance('a', str)
isinstance(c, Animal)
isinstance(b'a', bytes) # True
isinstance((1, 2, 3), (list, tuple)) # True

dir('ABC')

class MyDog(object):
    def __len__(self):
        return 100
dog = MyDog()
len(dog)

class MyObject(object):
    def __init__(self):
        self.x = 9
    def power(self):
        return self.x * self.x
obj = MyObject()
hasattr(obj, 'x') # 有属性'x'吗？ True
hasattr(obj, 'y') # 有属性'y'吗？ False
setattr(obj, 'y', 19) # 设置一个属性'y'
getattr(obj, 'y') # 获取属性'y'
getattr(obj, 'z', 404) # 获取属性'z'，如果不存在，返回默认值404 404
obj.y # 获取属性'y'
hasattr(obj, 'power') # 有属性'power'吗？ True
```

##### OOP高级

## 框架

* [django/django](https://github.com/django/django)The Web framework for perfectionists with deadlines. <https://www.djangoproject.com/>
* [pallets/flask](https://github.com/pallets/flask)A microframework based on Werkzeug, Jinja2 and good intentions <http://flask.pocoo.org/>
* [tornadoweb/tornado](https://github.com/tornadoweb/tornado)Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed. <http://www.tornadoweb.org/>

## 搭建服务器todo

## 教程

- [python3](http://www.runoob.com/python3)
- [Python教程 廖雪峰](https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)
- [TwoWater/Python](https://github.com/TwoWater/Python):Python 入门教程：【草根学 Python （基于Python3.6）】 https://www.readwithu.com/
- <http://www.cnblogs.com/linhaifeng/p/7278389.html>

## basic

- map:函数接收两个参数，一个是函数，一个是Iterable，map将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回

- reduce:把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数，reduce把结果继续和序列的下一个元素做累积计算 `reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)`

## 插件

- [xadmin](https://github.com/sshwsfc/xadmin) [文档](https://xadmin.readthedocs.io/en/latest/index.html)
- [django-bootstrap-toolkit](https://github.com/dyve/django-bootstrap-toolkit)

## 库

- numpy
- scipy
- matplotlib
- scikit-learn
- pandas

## 扩展

- [faif/python-patterns](https://github.com/faif/python-patterns)A collection of design patterns/idioms in Python
- [requests/requests](https://github.com/requests/requests)Python HTTP Requests for Humans™ ✨🍰✨ <http://python-requests.org>
- [scrapy/scrapy](https://github.com/scrapy/scrapy)Scrapy, a fast high-level web crawling & scraping framework for Python. <https://scrapy.org>
- [fchollet/keras](https://github.com/fchollet/keras)
- [kennethreitz/python-guide](https://github.com/kennethreitz/python-guide)
- [ipython/ipython](https://github.com/ipython/ipython)
- [binux/pyspider](https://github.com/binux/pyspider)A Powerful Spider(Web Crawler) System in Python. <http://docs.pyspider.org/>
- [fabric/fabric](https://github.com/fabric/fabric)Simple, Pythonic remote execution and deployment. <http://fabfile.org>
- [vinta/awesome-python](https://github.com/vinta/awesome-python):A curated list of awesome Python frameworks, libraries, software and resources https://awesome-python.com/
- [keon/algorithms](https://github.com/keon/algorithms)Minimal examples of data structures and algorithms in Python

## 工具

- ipython:`pip3 install ipython`
- [nvbn/thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
- [donnemartin/interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges)Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.
- [requests/requests](https://github.com/requests/requests):Python HTTP Requests for Humans™ ✨🍰✨ http://python-requests.org
- [syl20bnr/spacemacs](https://github.com/syl20bnr/spacemacs#macos):A community-driven Emacs distribution - The best editor is neither Emacs nor Vim, it's Emacs *and* Vim! http://spacemacs.org

### Anaconda

专注于数据分析的Python发行版本，包含了conda、Python等190多个科学包及其依赖项。适用于企业级大数据分析的Python工具。其包含了720多个数据科学相关的开源包，在数据可视化、机器学习、深度学习等多方面都有涉及。不仅可以做数据分析，甚至可以用在大数据和人工智能领域。

conda 是开源包（packages）和虚拟环境（environment）的管理系统。

- packages 管理： 可以使用 conda 来安装、更新 、卸载工具包 ，并且它更关注于数据科学相关的工具包。在安装 anaconda 时就预先集成了像 Numpy、Scipy、 pandas、Scikit-learn 这些在数据分析中常用的包。另外值得一提的是，conda 并不仅仅管理Python的工具包，它也能安装非python的包。比如在新版的 Anaconda 中就可以安装R语言的集成开发环境 Rstudio。
- 虚拟环境管理： 在conda中可以建立多个虚拟环境，用于隔离不同项目所需的不同版本的工具包，以防止版本上的冲突。

#### 使用

- Anaconda Navigator ：用于管理工具包和环境的图形用户界面，后续涉及的众多管理命令也可以在 Navigator 中手工实现。
- Jupyter notebook ：基于web的交互式计算环境，可以编辑易于人们阅读的文档，用于展示数据分析的过程。
- qtconsole ：一个可执行 IPython 的仿终端图形界面程序，相比 Python Shell 界面，qtconsole 可以直接显示代码生成的图形，实现多行代码输入执行，以及内置许多有用的功能和函数。
- spyder ：一个使用Python语言、跨平台的、科学运算集成开发环境。

```sh
#  更改镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ 
conda config --set show_channel_urls yes

echo 'export PATH="~/User/henry/anaconda/bin:$PATH"' >> ~/.zshrc # 添加环境变量
source ~/.zshrc

conda info
conda search search_term
conda update conda
conda upgrade --all   # 升级工具包
conda install numpy scipy pandas
conda install numpy=1.10   
conda update package_name
conda remove package_name

conda create --name env_name  list of packages # 默认的环境是 root，你也可以创建一个新环境,-n 代表 name，env_name 是需要创建的环境名称，list of packages 则是列出在新环境中需要安装的工具包。
conda create --name py35 python=3.5
conda create -n py2 python=2.7 pandas
source activate env_name # 进入名为 env_name 的环境
activate py35
source deactivate  # 退出当前环境
python --version #查看版本
which -a python
conda env remove -n env_name  # 删除名为 env_name 的环境

conda env list # 显示所有的环境
conda list --revisions 
conda install -n python34 numpy
conda list -n python34
conda env export > environment.yaml  # 分享代码的时候，同时也需要将运行环境分享给大家，执行如下命令可以将当前环境下的 package 信息存入名为 environment 的 YAML 文件中
conda env create -f environment.yaml #  用对方分享的 YAML 文件来创建一摸一样的运行环境。

conda install --name bio-env toolz
conda install --channel conda-forge
boltons
conda remove --name bio-env toolz boltons
```

#### Jupyter Notebook

[官网](http://jupyter.org/)

```shell
conda install jupyter notebook
pip install jupyter notebook

Anaconda，可以在其 Navigator 图形界面中点击打开 Notebook。
jupyter notebook
```

Notebook 文档是由一系列单元（Cell）构成，主要有两种形式的单元：

代码单元：这里是你编写代码的地方，通过按 Shift + Enter 运行代码，其结果显示在本单元下方。代码单元左边有 In [1]: 这样的序列标记，方便人们查看代码的执行次序。

Markdown 单元：在这里对文本进行编辑，采用 markdown 的语法规范，可以设置文本格式、插入链接、图片甚至数学公式。同样使用 Shift + Enter 运行 markdown 单元来显示格式化的文本。

- 编辑数学公式：LaTeX `$$ z = \frac{x}{y} $$`
- 幻灯片

#### IPython

[官网](https://ipython.org/)

### [pypy](http://pypy.org/)


### docker
- mkdir -p ~/python ~/python/myapp  myapp目录将映射为python容器配置的应用目录
- 创建Dockerfile

```
FROM buildpack-deps:jessie

# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# gpg: key F73C700D: public key "Larry Hastings <larry@hastings.org>" imported
ENV GPG_KEY 97FC712E4C024BBEA48A61ED3A5CA953F73C700D

ENV PYTHON_VERSION 3.5.1

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 8.1.2

RUN set -ex \
        && curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
        && curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
        && export GNUPGHOME="$(mktemp -d)" \
        && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
        && gpg --batch --verify python.tar.xz.asc python.tar.xz \
        && rm -r "$GNUPGHOME" python.tar.xz.asc \
        && mkdir -p /usr/src/python \
        && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
        && rm python.tar.xz \
        \
        && cd /usr/src/python \
        && ./configure --enable-shared --enable-unicode=ucs4 \
        && make -j$(nproc) \
        && make install \
        && ldconfig \
        && pip3 install --no-cache-dir --upgrade --ignore-installed pip==$PYTHON_PIP_VERSION \
        && find /usr/local -depth \
                \( \
                    \( -type d -a -name test -o -name tests \) \
                    -o \
                    \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
                \) -exec rm -rf '{}' + \
        && rm -rf /usr/src/python ~/.cache

# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
        && ln -s easy_install-3.5 easy_install \
        && ln -s idle3 idle \
        && ln -s pydoc3 pydoc \
        && ln -s python3 python \
        && ln -s python3-config python-config

CMD ["python3"]
```

- docker build -t python:3.5 .
- docker run  -v $PWD/myapp:/usr/src/myapp  -w /usr/src/myapp python:3.5 python helloworld.py

## selenium

`python3 -m pip install selenium`

安装 chromedriver

## 课程

* Python核心编程
    - 掌握Python基础编程语法；
    - 建立起编程思维和面向对象思想；
    - 可解决的现实问题：字符串排序、切割、逆置，猜数字，对问题的面向对象抽象，飞机大战游戏；
    - 计算机组成原理和开发环境：认识操作系统、认识python、开发环境pycharm；
    - 基础语法
        + 注释、变量以及类型、标识符和关键字、输出/输入、运算符、数据类型转换、if判断语句、比较和关系运算符、if-else语句、if-elif语句、if嵌套、if应用：猜拳游戏、while循环语句、while循环应用、while嵌套、for循环、break和continue、字符串介绍、字符串的输出/输入、下标和切片、字符串常见操作、列表的操作、元组操作、字典操作；
        + 函数  函数的概念、函数的定义和调用、函数的文档说明、函数参数、函数的返回值、4种函数的类型、函数的嵌套调用、局部变量、全局变量、函数应用案例、引用、递归函数、匿名函数、列表推导式
        + 文件操作    文件介绍、文件的打开与关闭、文件的读写、应用案例1：文件拷贝、文件重命名、删除、文件夹的相关操作、应用案例2:批量修改文件名、文件综合案例:学生管理系统(文件版)；
        + 面向对象    面向对象编程介绍、类和对象、类的定义、创建对象、魔法方法 __init__方法、魔法方法 __str__方法、魔法方法 __del__方法、self的作用、对象成员访问控制权限、单继承
        + 多继承、重写方法以及调用被重写的方法、多态、类属性和实例属性、类方法、实例方法和静态方法、单例模式、__new__()方法；
        + 异常处理    异常介绍、捕获异常、异常的传递、自定义异常、异常处理中抛出异常；
        + 模块  模块介绍、模块中的__all__、模块的导入, import语句、模块的导入, from ... import语句、模块的导入, from ... import *语句、包介绍、包的导入和使用；
        + 项目：飞机大战 pygame介绍、界面搭建、键盘检测、显示、控制飞机、飞机发射子弹、显示敌机、移动敌机、敌机进攻发射子弹、面向对象完成代码的封装；
* python和Linux高级编程
    - Linux基本命令：Ubuntu操作系统使用、Ubuntu软件安装与卸载、文件和目录操作命令、文件属性修改命令、查找与检索命令、压缩包管理、其他命令、常用服务器ftp/ssh、编辑器vim/sublime/gedit/pycharm； 
    - 网络编程    多任务-进程、多任务-线程、多任务-协程、网络-UDP、网络-TCP、正则表达式；
    - 项目：网络web服务器 mini-web 服务器
    - 数据库编程   MySQL基本使用、MySQL查询操作、MySQL与Python交互、MySQL高级特性；
    - 项目：综合web框架  python 高级语法、mini web框架；
    - 可掌握的核心能力：
        1、掌握python高级编程，能进行面向对象设计；
        2、了解Linux系统编程原理，认知程序运行的本质，方便后期开发出高质量的程序；
        3、掌握网络编程协议，实现网络间点对点通信；
        4、掌握关系型数据库MySql开发，熟练编写SQL语句；
        5、掌握正则表达式，进行字符串模糊匹配；
        6、掌握了web服务器的运行原理；
        7、MySQL数据库操作和设计；
        8、掌握元类对数据库封装的设计思想；
    - 可解决的现实问题：能够面向对象分析和设计程序，进行网络通信开发，实现基于Linux系统高并发异步web服务器；
* web开发
    - Flask web框架 Flask入门、模板与表单、数据库使用、单元测试、第三方扩展和部署
    - 项目：新经资讯网    Redis缓存、GIT版本控制、前后端不分离开发、Flask+Mysql实现、容联云、七牛云、图片验证码；
    - 项目：运维管理平台   前后端分离开发、Flask+Vue+SaltStack、Celery异步操作、RESTful接口开发、WebSSH
    - Django 框架   Django入门、Django模型、视图、模板、Django框架ORM使用、Django中间件、Django REST framework；
    - 项目：美多商城 购物电商平台项目编码、Django高级第三方模块、FastDFS分布式文件存储、MySQL读写分离、在线支付、Nginx配置和uWSGI部署；
    - 可掌握的核心能力：
        1、 可根据产品原型图，开发web网站的前端界面；
        2、 可根据业务流程图，开发web网站的后台业务；
        3、 可根据web框架设计，开发对应的数据库；
        4、 缓存服务器的操作和设计；
        5、 异步任务的实现。
    - 可解决的现实问题：
        1、 高并发全功能的web网站开发；
        2、 提供数据响应速度灵活运用缓存；
        3、 根据实际问题设计出相应数据库表；
* 爬虫开发
    - 可掌握的核心能力
        1、掌握爬虫的工作原理和设计思想；
        2、掌握反爬虫机制；
        3、掌握分布式数据采集；
    - 可解决的现实问题：
        1、定向抓取互联网中指定领域的海量信息；
        2、运用分布式爬虫，实现规模化数据采集；
        3、能够根据实际开发需求，定制爬虫采集系统；
    - 爬虫知识体系与相关工具、请求处理urllib/urllib2、Requests模块、数据提取re、lxml、bs4、jsonpath模块、爬虫并发控制和动态页面处理、Selenium+PhantomJS/Chrome；   可掌握的核心能力：
    - Mongodb应用开发：基本使用增删改查操作、高级查询和分组聚合操作、索引操作、备份和恢复处理、Mongodb和Python交互；
    - Scrapy框架和scrapy-redis
    - 分布式组件   scrapy框架、scrapy-redis分布式组件、项目：全国空气质量数据采集爬虫；
    - 项目：定制化爬虫框架TaskSpider   定制化的爬虫采集系统、处理数据的抓取和解析存储、项目：国内主流职位招聘网站数据采集爬虫；
* 人工智能
    - 数据挖掘基础：科学计算numpy、pandas、数据可视化matpalotlib、金融数据的分析和处理
    - 机器学习：特征工程、监督学习分类算法、监督学习回归算法、非监督学习、Scikit-learn使用、模型选择与调优；
    - 项目：自动量化交易平台    历史数据、实时数据；股票、期货数据指标；多因子模型；量化交易策略；回测框架；交易框架；
    - 深度学习：TensorFlow框架开发、Tensorflow IO操作、神经网络基础、全连接神经网络实现、卷积神经网络网络与实现、项目：图像识别、检测；
    - 可掌握的核心能力：
        1、掌握数据挖掘基础工具使用；
        2、掌握数据挖掘处理数据方法；
        3、了解常见机器学习算法原理；
        4、根据量化交易规则设计策略；
        5、掌握深度学习算法和框架；
        6、图像识别、检测的实现；
    - 可解决的现实问题：
        1、从数据支持到策略开发；
        2、实现自动量化交易平台；
        3、深度学习模型的训练过程；
        4、图像识别、检测任务；
* 自动化运维 
    - shell基本语法及脚本开发规范、shell变量、表达式、shell脚本常见符号和命令、shell流程控制、shell编程综合演练、项目生命周期、自动化代码发布、django项目生产环境部署、手工代码发布、简单脚本编写流程及提高、大型脚本编写流程及提高； 可掌握的核心能力：
        + 1、掌握shell编程基础和开发技巧；
        + 2、掌握shell编程常用表达式和流程控制语句；
        + 3、掌握项目发布的流程规范；
        + 4、掌握生产脚本的编写流程规范；
        + 5、了解项目生命周期及项目常见开发模式；
    - 可解决的现实问题：
        - 1、项目环境自动化部署；
        - 2、项目代码自动化发布；
        - 3、项目生命周期理解；
* 数据结构
    - 时间和空间复杂度、链表、桟和队列、排序、二叉树、python内建数据结构类型；

## 问题

```
/System/Library/Frameworks/Python.framework/Versions/2.7/share': Operation not permitted
```

## 参考

- [python/cpython](https://github.com/python/cpython):The Python programming language
- [donnemartin/data-science-ipython-notebooks](https://github.com/donnemartin/data-science-ipython-notebooks):Data science Python notebooks: Deep learning (TensorFlow, Theano, Caffe, Keras), scikit-learn, Kaggle, big data (Spark, Hadoop MapReduce, HDFS), matplotlib, pandas, NumPy, SciPy, Python essentials, AWS, and various command lines.
- [kennethreitz/python-guide](https://github.com/kennethreitz/python-guide):Python best practices guidebook, written for Humans. http://docs.python-guide.org
- [faif/python-patterns](https://github.com/faif/python-patterns):A collection of design patterns/idioms in Python
- [kennethreitz/httpbin](https://github.com/kennethreitz/httpbin):HTTP Request & Response Service, written in Python + Flask. https://httpbin.org

## 工具

* [nteract/nteract](https://github.com/nteract/nteract): 📘 Desktop notebook app + packages https://nteract.io
