# [cpython](https://github.com/python/cpython)

The Python programming language, Guido van Rossum 在1989年圣诞节期间，为了打发无聊的圣诞节而编写的一个编程语言

* 优点
  - 网络应用，包括网站、后台服务等等
  - 许多日常需要的小工具，包括系统管理员需要的脚本任务等等
  - 把其他语言开发的程序再包装起来，方便使用
  - 1行代码能实现的功能，决不写5行代码。请始终牢记，代码越少，开发效率越高
* 缺点
  - 代码少的代价是运行速度慢，C程序运行1秒钟，Java程序可能需要2秒，而Python程序可能就需要10秒
* 解释型语言，代码在执行时会一行一行地翻译成CPU能理解的机器码，翻译过程非常耗时。而C程序是运行前直接编译成CPU能执行的机器码，所以非常快

## 解释器

* 编译器首先会进行语法检查，代码检查
* 解释器多开的话，是很难保证线程安全的。为了解决这个问题，Python设计了GIL机制，也就是全局解释器锁，它保证了同一时刻最多只有一个解释器线程在执
  - 保证了线程安全
  - 限制了Python多线程的使用:Python的多线程本质上是伪多线程，因为解释器只有一个线程在跑
* 为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下兼容
* CPython:官方版本的解释器,用C语言开发的，在命令行下运行python就是启动CPython解释器,用>>>作为提示符
* IPython:基于CPython之上的一个交互式解释器.在交互方式上有所增强，执行Python代码的功能和CPython是完全一样的,用In [序号]:作为提示符
* PyPy目标是执行速度。采用JIT技术，对Python代码进行动态编译（注意不是解释），可以显著提高Python代码的执行速度。绝大部分Python代码都可以在PyPy下运行，但是PyPy和CPython有一些是不同的，导致相同的Python代码在两种解释器下执行可能会有不同的结果
* Jython 运行在Java平台上的Python解释器，可以直接把Python代码编译成Java字节码执行

### install

* Mac下的python2.7 默认是安装在／System目录下的。Mac有个Rootless机制，默认不允许直接在／System下作修改。所以要先关闭Rootless机制。关闭有风险
  - 重启电脑, 重启过程中按住command+R, 进入恢复模式
  - 打开terminal，键入: csrutil disable
  - 重启电脑
* 自带版本路径：/System/Library/Frameworks/Python.framework/Versions/Current
* 安装的3.6版本：/usr/local/Cellar/python3/3.6.4_2
* multial version python exist,use anaconda to set depend environment
* Anaconda :/Users/henry/anaconda/bin
* [Using Python on a Macintosh](https://docs.python.org/3/using/mac.html)
* 不同版本的python.exe使用不同的命名，命令行中可以调用的到`python` `python3`.virtualenv 和 virtualenvwrapper 来管理不同项目的依赖环境，通过 workon 、 mkvirtualenv 等命令进行虚拟环境切换

```sh
brew install python3

# 修改 .bash_profil文件，先搜索尾部，找到后停止搜索
export PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH"

# 修改系统默认python版本
export PATH="/usr/local/Cellar/python/3.6.5/bin:$PATH"
alias python="/usr/local/Cellar/python/3.6.5/bin/python3.6"

export PATH="/Users/henry/anaconda/bin:$PATH"  # 优先级最高

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
vim ~/.bash_profile # (只要能编辑就行)插入新的Python路径

pip3 install --upgrade pip setuptools wheel

# Ubuntu
sudo apt-get update
sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx

# centos
yum install python36

# compile
ls -l /usr/bin | grep python
wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
tar -zxvf Python-3.7.6.tgz
./configure --prefix=/usr/local/python3.7.6  --with-ssl --enable-optimizations
make
sudo make install
rm /usr/bin/python

ln -s /usr/local/python3.7.6/bin/python3.7 /usr/bin/python

# windows
pip install scrapy
C:\Users\Administrator\AppData\Local\Programs\Python\Python36 # 路径
pip install pywin32 # No module named win32api

## Ubuntu
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150

sudo update-alternatives --config python #如果要切换到Python2
```

### pyenv

修改系统环境变量 PATH。多版本python共存的环境工具，可以在不改变系统环境的情况下，可以随意切换不同python版本。基于某个版本开发的工具，在更换了不同python版本之后，就会导致工具中的某个模块、代码错误，而不能正常使用。

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

curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
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

### virtualenv

Virtualenv is a tool that creates an isolated Python environment for each of your projects

```sh
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv

cd myproject/
virtualenv venv # create a Python virtual environment
virtualenv --no-site-packages app_env
virtualenv venv --system-site-packages # also inherit globally installed packages

source app_env/bin/activate
deactivate

brew install pyenv-virtualenv  # 集成安装
virtualenv
virtualenv-delete
virtualenv-init
virtualenv-prefix
virtualenvs

pyenv virtualenvs # 看到本地所有的项目环境
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

* Python2.7的安装包中，easy_install.py是默认安装的，而pip需要手动安装

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

# pip 源替换
清华：https://pypi.tuna.tsinghua.edu.cn/simple
阿里云：http://mirrors.aliyun.com/pypi/simple/
中国科技大学 https://pypi.mirrors.ustc.edu.cn/simple/
华中理工大学：http://pypi.hustunique.com/
山东理工大学：http://pypi.sdutlinux.org/
豆瓣：http://pypi.douban.com/simple/
腾讯云：http://mirrors.cloud.tencent.com/pypi/simple

# ~/.pip/pip.conf
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host=mirrors.aliyun.com ## 目标

# 暂时替换
pip install torch -i https://pypi.tuna.tsinghua.edu.cn/simple
```

### [iPython](https://github.com/ipython/ipython)

更强大的python交互shell，支持变量自动补全，自动缩进，支持 bash shell 命令，内置了许多很有用的功能和函数

```sh
pip install ipython

pip install 'ipython[zmq,qtconsole,notebook,test]'
```

### 执行环境

* 命令行模式下
  * 可以直接运行.py文件 `python hello.py`
  * 添加`#!/usr/bin/env python3`,文件添加执行权限`./basic.py`
* 交互模式：`python` `exit()`
* [代码助手](https://raw.githubusercontent.com/michaelliao/learn-python3/master/teach/learning.py)

### 基础 Basic Syntax

* 计算机要根据编程语言执行任务，就必须保证编程语言写出的程序决不能有歧义，所以，任何一种编程语言都有自己的一套语法，编译器或者解释器就是负责把符合语法的程序代码转换成CPU能够执行的机器码，然后执行
* 访问时才执行

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

#### 数据类型与变量 Native Datatypes

在计算机内部，可以把任何数据都看成一个“对象”，而变量就是在程序中用来指向这些数据对象的，对变量赋值就是把数据和变量给关联起来。对变量赋值x = y是把变量x指向真正的对象，该对象是变量y所指向的。随后对变量y的赋值不影响变量x的指向。

* 基本类型
  - 整数 Number:Python可以处理任意大小的整数，当然包括负整数，在程序中的表示方法和数学上的写法一模一样，例如：1，100，-8080，0，等等。二进制、十六进制表示整数比较方便，十六进制用0x前缀和0-9，a-f表示，例如：0xff00，0xa5b4c3d2，等等。
  - 浮点数:浮点数也就是小数，之所以称为浮点数，是因为按照科学记数法表示时，一个浮点数的小数点位置是可变的，比如，1.23x109和12.3x108是完全相等的。浮点数可以用数学写法，如1.23，3.14，-9.01，等等。或者用科学计数法表示，把10用e替代，1.23x10^9就是1.23e9，或者12.3e8，0.000012可以写成1.2e-5，等等。整数和浮点数在计算机内部存储的方式是不同的，整数运算永远是精确的（除法难道也是精确的？是的！），而浮点数运算则可能会有四舍五入的误差。也没有大小限制，但是超出一定范围就直接表示为inf（无限大）
  - 字符串 String:以单引号'或双引号"括起来的任意文本，比如'abc'，"xyz"等等。请注意，''或""本身只是一种表示方式，不是字符串的一部分，因此，字符串'abc'只有a，b，c这3个字符。如果'本身也是一个字符，那就可以用""括起来，比如"I'm OK"包含的字符是I，'，m，空格，O，K这6个字符。
    + 字符串内部既包含'又包含"怎么办？可以用转义字符\来标识.
      + \n表示换行
      + \t表示制表符，字符\本身也要转义，所以\\表示的字符就是\
    + 用r''表示''内部的字符串默认不转义
    + 用'''...'''的格式表示多行内容,输入时换行时添加空格
  - 布尔值 Boolean:只有True、False两种值,可以直接用True、False表示布尔值（请注意大小写）
  - 空值 None:Python里一个特殊的值，用None表示。None不能理解为0，因为0是有意义的，而None是一个特殊的空值。
* 复合元素
  - 列表 List：list是一种有序的集合，可以随时添加和删除其中的元素。元素的数据类型也可以不同。可以嵌套(多维数组).查找元素，全表遍历。list越大，查找越慢。
  - 有序列表叫元组 Tuple tuple和list非常类似，但是tuple一旦初始化就不能修改.
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
* 变量
  - 不仅可以是数字，还可以是任意数据类型
  - 必须是大小写英文、数字和_的组合，且不能用数字开头
  - 等号=是赋值语句，可以把任意数据类型赋值给变量，同一个变量可以反复赋值，而且可以是不同类型的变量
  - 变量本身类型不固定的语言称之为动态语言，与之对应的是静态语言。静态语言在定义变量时必须指定变量类型，如果赋值的时候类型不匹配，就会报错。例如Java是静态语言
  - 变量创建过程：在内存中创建了一个'ABC'的字符串；在内存中创建了一个名为a的变量，并把它指向'ABC'。
  - 深浅拷贝
* *可变对象与不可变对象* （值操作与引用操作）
  - a是变量，而'abc'才是字符串对象！有些时候，经常说，对象a的内容是'abc'，但其实是指，a本身是一个变量，它指向的对象的内容才是'abc'
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
# 字符串拼接
a, b = 'hello', ' world'
a + b
print(a, b)
print('hello''world')
print('%s %s' % ('hello', 'world'))
print('-'.join(['aa', 'bb', 'cc']))
f'{a} {b}'
a * 3

True
3 > 2
True and True
True or False
bool(datetime.time(0, 0)) == False

5 > 3 or 1 > 3
not 1 > 2
int('12345', base=8) # 5349
int('12345', 16) # 74565

# a = 4
a = 2 ** 2

# list
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

##### 控制语句 Flow Control

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

* 最基本的一种代码抽象方式,函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量
  - abs(-10)是函数调用，而abs是函数本身
  - 函数名其实就是指向函数的变量
* 内置函数：调用一个函数，需要知道函数的名称和参数（个数与数据类型），数据类型转换
* Definition 定义一个函数要使用def语句，依次写出函数名、括号、括号中的参数和冒号:，然后，在缩进块中编写函数体，函数的返回值用return语句返回。
  - 一旦执行到return时，函数就执行完毕，并将结果返回
  - 如果没有return语句，函数执行完毕后也会返回结果，只是结果为None。return None可以简写为return
  - 函数引用：把my_abs()的函数定义保存为abstest.py文件了，用from abstest import my_abs来导入my_abs()函数，注意abstest是文件名（不含.py扩展名）
  - pass语句什么都不做，实际上pass可以用来作为占位符，比如现在还没想好怎么写函数的代码，就可以先放一个pass，让代码能运行起来。
  - 多值返回：返回值是一个tuple！但是，在语法上，返回一个tuple可以省略括号，而多个变量可以同时接收一个tuple，按位置赋给对应的值
* 参数 Arguments
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
      Documentation
      @decorator

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

##### 函数是式编程 Functional Programming Lambda

* 一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用

* 特点:允许把函数本身作为参数传入另一个函数，还允许返回一个函数

* Python对函数式编程提供部分支持。由于Python允许使用变量，因此，Python不是纯函数式编程语言。

* 高阶函数：函数参数能够接收别的函数

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

##### 模块 Module

* 提高了代码的可维护性
* 编写代码不必从零开始。当一个模块编写完毕，就可以被其他地方引用。包括Python内置的模块和来自第三方的模块
* 可以避免函数名和变量名冲突。相同名字的函数和变量完全可以分别存在不同的模块中，尽量不要与内置函数名字冲突
* 避免模块名冲突，Python又引入了按目录来组织模块的方法，称为包（Package）
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

#### 面向对象编程 Object Oriented Programming OOP

* 一种程序设计思想。OOP把对象作为程序的基本单元，一个对象包含了数据和操作数据的函数。

* 面向过程的程序设计把计算机程序视为一系列的命令集合，即一组函数的顺序执行。为了简化程序设计，面向过程把函数继续切分为子函数，即把大块函数通过切割成小块函数来降低系统的复杂度。

* 面向对象的程序设计把计算机程序视为一组对象的集合，而每个对象都可以接收其他对象发过来的消息，并处理这些消息，计算机程序的执行就是一系列消息在各个对象之间传递。

* 所有数据类型都可以视为对象，当然也可以自定义对象。自定义的对象数据类型就是面向对象中的类（Class）的概念。

* 采用面向对象的程序设计思想:来自自然界中的类与实例概念

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

* 继承Inheritance：定义一个class的时候，可以从某个现有的class继承，新的class称为子类（Subclass），而被继承的class称为基类、父类或超类（Base class、Super class）

  - 子类获得了父类的全部功能
  - 对子类增加一些方法

* 多态Override：当子类和父类都存在相同的run()方法时，子类的run()覆盖了父类的run()，在代码运行的时候，总是会调用子类的run()

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

## IO

* Input Stream就是数据从外面（磁盘、网络）流进内存，Output Stream就是数据从内存流到外面去

## 进程与线程

* 进程是由若干线程组成的，一个进程至少有一个线程
* 多线程和多进程区别：
  - 多进程中，同一个变量，各自有一份拷贝存在于每个进程中，互不影响，而多线程中，所有变量都由所有线程共享
  - 任何一个变量都可以被任何一个线程修改，因此，线程之间共享数据最大的危险在于多个线程同时改一个变量，把内容给改乱了
* 锁
  - 好处：确保了某段关键代码只能由一个线程从头到尾完整地执行
  - 坏处：
    + 阻止了多线程并发执行，包含锁的某段代码实际上只能以单线程模式执行，效率就大大地下降了
    + 由于可以存在多个锁，不同的线程持有不同的锁，并试图获取对方持有的锁时，可能会造成死锁，导致多个线程全部挂起，既不能执行，也无法结束，只能靠操作系统强制终止。
* 用C、C++或Java来改写相同的死循环，直接可以把全部核心跑满，4核就跑到400%，8核就跑到800%，为什么Python不行
  - Python的线程虽然是真正的线程，但解释器执行代码时，有一个GIL锁：Global Interpreter Lock，任何Python线程执行前，必须先获得GIL锁，然后，每执行100条字节码，解释器就自动释放GIL锁，让别的线程有机会执行
  - 这个GIL全局锁实际上把所有线程的执行代码都给上了锁，所以，多线程在Python中只能交替执行，即使100个线程跑在100核CPU上，也只能用到1个核
  - 要真正利用多核，除非重写一个不带GIL的解释器
  - 可以使用多线程，但不要指望能有效利用多核
* 线程使用 局部变量
  - 只有线程自己能看见，不会影响其他线程，而全局变量的修改必须加锁
  - 问题:函数调用的时候，传递起来很麻烦
* ThreadLocal
  - 全局变量local_school就是一个ThreadLocal对象，每个Thread对它都可以读写student属性(线程的局部变量，可以任意读写而互不干扰)，但互不影响
  - 最常用的地方就是为每个线程绑定一个数据库连接，HTTP请求，用户身份信息等，这样一个线程的所有调用到的处理函数都可以非常方便地访问这些资源。
* 多任务
  - Master-Worker模式，Master负责分配任务，Worker负责执行任务，通常是一个Master，多个Worker
  - 用多进程实现Master-Worker，主进程就是Master，其他进程就是Worker。
    + 优点
      * 稳定性高，因为一个子进程崩溃了，不会影响主进程和其他子进程。（当然主进程挂了所有进程就全挂了，但是Master进程只负责分配任务，挂掉的概率低）
      * 著名的Apache最早就是采用多进程模式
    + 缺点
      * 创建进程的代价大，在Unix/Linux系统下，用fork调用还行，在Windows下创建进程开销巨大
      * 操作系统能同时运行的进程数也是有限的，在内存和CPU的限制下，如果有几千个进程同时运行，操作系统连调度都会成问题
  - 用多线程实现Master-Worker，主线程就是Master，其他线程就是Worker
    + 通常比多进程快一点，但是也快不到哪去
    + 致命的缺点
      * 任何一个线程挂掉都可能直接造成整个进程崩溃，因为所有线程共享进程的内存
      * 在Windows上，如果一个线程执行的代码出了问题，经常可以看到这样的提示：“该程序执行了非法操作，即将关闭”，其实往往是某个线程出了问题，但是操作系统会强制结束整个进程
  - 只要数量一多，效率肯定上不去
    + 切换是有代价的，需要先保存当前执行的现场环境（CPU寄存器状态、内存页等），然后，把新任务的执行环境准备好（恢复上次的寄存器状态，切换内存页等），才能开始执行
    + 如果有几千个任务同时进行，操作系统可能就主要忙着切换任务，根本没有多少时间去执行任务了，这种情况最常见的就是硬盘狂响，点窗口无反应，系统处于假死状态
    + 一旦多到一个限度，就会消耗掉系统所有的资源，结果效率急剧下降，所有任务都做不好
  - 是否采用多任务的第二个考虑是任务的类型
    + 计算密集型：要进行大量的计算，消耗CPU资源，比如计算圆周率、对视频进行高清解码等等，全靠CPU的运算能力
      * 要最高效地利用CPU，计算密集型任务同时进行的数量应当等于CPU的核心数
      * 主要消耗CPU资源，因此，代码运行效率至关重要。Python这样的脚本语言运行效率很低，完全不适合计算密集型任务。对于计算密集型任务，最好用C语言编写。
    + IO密集型
      * 涉及到网络、磁盘IO的任务
      * CPU消耗很少，任务的大部分时间都在等待IO操作完成（因为IO的速度远远低于CPU和内存的速度）
      * 任务越多，CPU效率越高，但也有一个限度。常见的大部分任务都是IO密集型任务，比如Web应用
      * 99%的时间都花在IO上，花在CPU上的时间很少，因此，用运行速度极快的C语言替换用Python这样运行速度极低的脚本语言，完全无法提升运行效率
      * 最合适的语言就是开发效率最高（代码量最少）的语言，脚本语言是首选，C语言最差
  - 异步IO
    + 考虑到CPU和IO之间巨大的速度差异，一个任务在执行的过程中大部分时间都在等待IO操作，单进程单线程模型会导致别的任务无法并行执行，因此，才需要多进程模型或者多线程模型来支持多任务并发执行。
    + 现代操作系统对IO操作已经做了巨大的改进，最大的特点就是支持异步IO
    + 如果充分利用操作系统提供的异步IO支持，就可以用单进程单线程模型来执行多任务，这种全新的模型称为事件驱动模型，Nginx就是支持异步IO的Web服务器，它在单核CPU上采用单进程模型就可以高效地支持多任务。在多核CPU上，可以运行多个进程（数量与CPU核心数相同），充分利用多核CPU。由于系统总的进程数量十分有限，因此操作系统调度非常高效。用异步IO编程模型来实现多任务是一个主要的趋势。
* 分布式进程：multiprocessing模块中managers子模块还支持把多进程分布到多台机器上。一个服务进程可以作为调度者，将任务分布到其他多个进程中，依靠网络通信
  - Queue之所以能通过网络访问，就是通过QueueManager实现的。由于QueueManager管理的不止一个Queue，所以，要给每个Queue的网络调用接口起个名字，比如get_task_queue
  - authkey:为了保证两台机器正常通信，不被其他机器恶意干扰

## DB

db API DRIVER即数据库接口驱动

* [MySQLdb] is a native driver that has been developed and supported for over a decade by Andy Dustman.不支持python3
* [mysqlclient] is a fork of MySQLdb which notably supports Python 3 and can be used as a drop-in replacement for MySQLdb. At the time of this writing, this is the recommended choice for using MySQL with Django.
* [MySQL Connector/Python] is a pure Python driver from Oracle that does not require the MySQL client library or any Python modules outside the standard library.

```sh
sudo apt-get install libmysqlclient-dev
pip install mysqlclient
```

## 正则

* 原理
  - 编译正则表达式，如果正则表达式的字符串本身不合法，会报错；
  - 用编译后的正则表达式去匹配字符串
* \d可以匹配一个数字，\w可以匹配一个字母或数字
* .可以匹配任意字符
* *表示任意个字符（包括0个），用+表示至少一个字符，用?表示0个或1个字符，用{n}表示n个字符，用{n,m}表示n-m个字符
* []表示范围：
  - [0-9a-zA-Z\_]可以匹配一个数字、字母或者下划线；
  - [0-9a-zA-Z\_]+可以匹配至少由一个数字、字母或者下划线组成的字符串，比如'a100'，'0_Z'，'Py3000'等等；
  - [a-zA-Z\_][0-9a-zA-Z\_]*可以匹配由字母或下划线开头，后接任意个由一个数字、字母或者下划线组成的字符串，也就是Python合法的变量；
  - [a-zA-Z\_][0-9a-zA-Z\_]{0, 19}更精确地限制了变量的长度是1-20个字符（前面1个字符+后面最多19个字符）
* A|B可以匹配A或B
* ^表示行的开头，$表示行的结束
* 由于Python的字符串本身也用\转义，建议使用Python的r前缀，就不用考虑转义的问题

## OOP高级

### basic

* map:函数接收两个参数，一个是函数，一个是Iterable，map将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回
* reduce:把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数，reduce把结果继续和序列的下一个元素做累积计算 `reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)`

### docker

* mkdir -p ~/python ~/python/myapp  myapp目录将映射为python容器配置的应用目录
* 创建Dockerfile

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

* 安装 chromedriver
* `python3 -m pip install selenium`

## 问题

```
/System/Library/Frameworks/Python.framework/Versions/2.7/share': Operation not permitted
```

## UWSGI

## GunicornNGINX

```
The Zen of Python
Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!
```

## 图书

* [与孩子一起学编程 Hello World！Computer Programming for Kids and Other Beginners](https://www.amazon.cn/gp/product/B00HECW20S)
* [Python编程快速上手 Automate the Boring Stuff with Python: Practical Programming for Total Beginners](https://automatetheboringstuff.com)
* [Learning with Python 3](http://openbookproject.net/thinkcs/python/english3e/)
* [learn python the hardway](https://learnpythonthehardway.org/python3/)
* Learning Python
* Python编程 从入门到实践 Python Crash Course
* 流畅的Python Fluent Python
* Python 性能分析与优化
* Python 高性能编程
* [pythonbook](https://python.cs.southern.edu/pythonbook/pythonbook.pdf)
* [Introduction to Programming in Python: An Interdisciplinary Approach](https://introcs.cs.princeton.edu/python/home/)
* 《[集体智慧编程](https://www.amazon.cn/gp/product/B00UI93JD8)》
* 《[笨办法学Python](https://www.amazon.cn/gp/product/B00P6OJ0TC)》
* 《[Python基础教程(第3版)](https://www.amazon.cn/Python基础教程-Magnus-Lie-Hetland/dp/B079BJPVFL/ref=dp_ob_title_bk)》
* 《Python源码剖析》
* 《[Head First Python](https://www.amazon.cn/gp/product/B007NB2B4M)》
* 《[Python Cookbook（第3版）](https://www.amazon.cn/gp/product/B00WKR1OKG)》
  - [Python 3 cookbook](https://python3-cookbook.readthedocs.io/zh_CN/latest/):Python3教学手册
* 《[Python参考手册（第4版）](https://www.amazon.cn/gp/product/B01MCUN37Y)》
* 《[Python学习手册（第4版）](https://www.amazon.cn/gp/product/B004TUJ7A6)》
* 《[Python核心编程（第3版）](https://www.amazon.cn/gp/product/B01FQAS0KK)》
* 《[Python科学计算（第2版）](https://www.amazon.cn/gp/product/B01HCVUJFA)》
* 《[利用 Python 进行数据分析](https://www.amazon.cn/gp/product/B00GHGZLWS)》
* 《[Think Python：像计算机科学家一样思考Python（第2版）](https://www.amazon.cn/gp/product/B01ION3W54)》
* 《[Python编程实战:运用设计模式、并发和程序库创建高质量程序](https://www.amazon.cn/gp/product/B00MHDPIJ6)》
* 《[Python绝技：运用Python成为顶级黑客](https://www.amazon.cn/gp/product/B019ZRGBVU)》
* 《用 Python 写网络爬虫》
* 《[深度学习:基于Keras的Python实践](https://www.amazon.cn/gp/product/B07D5855F4)》
* Python与量化投资从基础到实践
* [Think Python: How to Think Like a Computer Scientist](http://greenteapress.com/thinkpython2/html/index.html)

## 教程

* [jackfrued/Python-100-Days](https://github.com/jackfrued/Python-100-Days):Python - 100天从新手到大师
* [Python 中文学习大本营](http://www.pythondoc.com/)
* [Yixiaohan/codeparkshare](https://github.com/Yixiaohan/codeparkshare):Python初学者（零基础学习Python、Python入门）书籍、视频、资料、社区推荐
* [michaelliao/learn-python3](https://github.com/michaelliao/learn-python3): Learn Python 3 Sample Code
* [Python教程 廖雪峰](https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)
* [TwoWater/Python](https://github.com/TwoWater/Python):Python 入门教程：【草根学 Python （基于Python3.6）】 <https://www.readwithu.com/>
* [在 Windows 上用 Python 做开发](https://docs.microsoft.com/zh-cn/windows/python/)
* [简明 Python 教程 A Byte of Python](https://bop.mol.uno)
* [Python最佳实践指南](https://pythonguidecn.readthedocs.io/zh/latest/index.html)
* [Python进阶](https://docs.pythontab.com/interpy/)
* [CODE WITH REPL.IT](https://www.codewithrepl.it/)
* A Byte of Python
* [show-me-the-code](https://github.com/Yixiaohan/show-me-the-code):Python 练习册，每天一个小程序

## 工具

* [requests/requests](https://github.com/requests/requests)Python HTTP Requests for Humans™ ✨🍰✨ <http://python-requests.org>
* [scrapy/scrapy](https://github.com/scrapy/scrapy)Scrapy, a fast high-level web crawling & scraping framework for Python. <https://scrapy.org>
* [keras](https://github.com/fchollet/keras)
* [pyspider](https://github.com/binux/pyspider)A Powerful Spider(Web Crawler) System in Python. <http://docs.pyspider.org/>
* [fabric](https://github.com/fabric/fabric)Simple, Pythonic remote execution and deployment. <http://fabfile.org>
* 插件
  - [xadmin](https://github.com/sshwsfc/xadmin) [文档](https://xadmin.readthedocs.io/en/latest/index.html)
  - [django-bootstrap-toolkit](https://github.com/dyve/django-bootstrap-toolkit)
* [nteract/nteract](https://github.com/nteract/nteract): 📘 Desktop notebook app + packages <https://nteract.io>
* [locustio/locust](https://github.com/locustio/locust):Scalable user load testing tool written in Python <http://locust.io>
* [agronholm/apscheduler](https://github.com/agronholm/apscheduler):Task scheduling library for Python
* [benfred/py-spy](https://github.com/benfred/py-spy):Sampling profiler for Python programs
* [donnemartin/interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges)Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.
* [ipython](https://github.com/ipython/ipython) <https://ipython.org/>  `pip3 install ipython`
* [pypy](http://pypy.org/)
* [pypa/pipenv](https://github.com/pypa/pipenv):Python Development Workflow for Humans. <https://pipenv.kennethreitz.org>
* Server
  - SimpleHTTPServer `python2 -m SimpleHTTPServer 8080`
* 常用系统模块：
  - os,sys,time,datetime,urllib,xml,json,email,csv,collections,math,zipfile,trafile,hashlib
* 常用三方模块：
  - requests,pyquery,django,flask,mysqlclient,paramiko,redis,lxml,dateutils,ipaddr,netaddr

## 参考

* [awesome-python](https://github.com/vinta/awesome-python):A curated list of awesome Python frameworks, libraries, software and resources <https://awesome-python.com/>
  - [awesome-python-cn](https://github.com/jobbole/awesome-python-cn):Python资源大全中文版，包括：Web框架、网络爬虫、模板引擎、数据库、数据可视化、图片处理等，由伯乐在线持续更新。
* [awesome-python-applications](https://github.com/mahmoud/awesome-python-applications):cd Free software that works great, and also happens to be open-source Python. <ftp://you:relookin@it.example.com#readme>
* [wtfpython](https://github.com/satwikkansal/wtfpython):What the f*ck Python?
* [python-cheatsheet](https://github.com/gto76/python-cheatsheet):Comprehensive Python Cheatsheet <https://gto76.github.io/python-cheatsheet/>
* [中文文档](https://docs.python.org/zh-cn/3/)
* [python-guide](https://github.com/kennethreitz/python-guide) Python best practices guidebook, written for humans. <https://docs.python-guide.org/>
* [python-patterns](https://github.com/faif/python-patterns):A collection of design patterns/idioms in Python
* [Python 开源库及示例代码](https://github.com/programthink/opensource/blob/master/libs/python.wiki)
* [kriadmin/30-seconds-of-python-code](https://github.com/kriadmin/30-seconds-of-python-code)
* [coodict/python3-in-one-pic](https://github.com/coodict/python3-in-one-pic):Learn python3 in one picture. <https://git.io/Coo-py3>
* [notes-python](https://github.com/lijin-THU/notes-python):中文 Python 笔记

# Python 资源大全中文版

* 《[Scrapy：Python的爬虫框架](http://hao.jobbole.com/python-scrapy/)》
* 《[Flask：一个使用Python编写的轻量级Web应用框架](http://hao.jobbole.com/flask/)》

## 环境管理

管理 Python 版本和环境的工具

* p：非常简单的交互式 python 版本管理工具。[官网](https://github.com/qw3rtman/p)
* pyenv：简单的 Python 版本管理工具。[官网](https://github.com/yyuu/pyenv)
* Vex：可以在虚拟环境中执行命令。[官网](https://github.com/sashahart/vex)
* virtualenv：创建独立 Python 环境的工具。[官网](https://pypi.python.org/pypi/virtualenv)
* virtualenvwrapper：virtualenv 的一组扩展。[官网](https://pypi.python.org/pypi/virtualenvwrapper)
* [pypa/pipenv](https://github.com/pypa/pipenv):Python Development Workflow for Humans. <https://docs.pipenv.org/>

## 包管理

管理包和依赖的工具。

* pip：Python 包和依赖关系管理工具。[官网](https://pip.pypa.io/)
* pip-tools：保证 Python 包依赖关系更新的一组工具。[官网](https://github.com/nvie/pip-tools)
* conda：跨平台，Python 二进制包管理工具。[官网](https://github.com/conda/conda/)
* Curdling：管理 Python 包的命令行工具。[官网](http://clarete.li/curdling/)
* wheel：Python 分发的新标准，意在取代 eggs。[官网](http://pythonwheels.com/)
* [Pipenv](https://github.com/pypa/pipenv):Python Development Workflow for Humans. <https://docs.pipenv.org/>
* PBR（<https://docs.openstack.org/pbr/latest/>）, Python Build Reasonableness 的缩写，是以一致的方式用于管理 Setuptools 包的库。
* [pypi](https://pypi.python.org/pypi/)：Python第三方库集合
* [unofficial windows binaries for python extension packages](http://www.lfd.uci.edu/~gohlke/pythonlibs/)：windows下Python第三方库的非官方扩展
* [Scipy-Lecture-Notes-zh](https://github.com/jayleicn/scipy-lecture-notes-zh-CN)：这是来自 <http://scipy-lectures.org> 的Python科学计算环境教程的中文版
* 常用包
  - lxml：比Beautiful Soup更快更强的解析库
  - pandas：数据处理神器
  - time：设置爬虫访问间隔防止被抓
  - random：随机数生成工具，配合time使用
  - [mahmoud/boltons](https://github.com/mahmoud/boltons):🔩 Like builtins, but boltons. Constructs/recipes/snippets that would be handy in the standard library. Nothing like Michael Bolton. <https://boltons.readthedocs.org>

```sh
pip install pipenv
brew install pipenv
```

## 包仓库

本地 PyPI 仓库服务和代{过}{滤}理。

* warehouse：下一代 PyPI。[官网](https://github.com/pypa/warehouse)
* Warehouse：PyPA 提供的 PyPI 镜像工具。[官网](https://warehouse.python.org/) [bandersnatch](https://bitbucket.org/pypa/bandersnatch)
* devpi：PyPI 服务和打包/测试/分发工具。[官网](http://doc.devpi.net/)
* localshop：本地 PyPI 服务（自定义包并且自动对 PyPI 镜像）。[官网](https://github.com/mvantellingen/localshop)

## 分发

打包为可执行文件以便分发。

* PyInstaller：将 Python 程序转换成独立的执行文件（跨平台）。[官网](https://github.com/pyinstaller/pyinstaller)
* dh-virtualenv：构建并将 virtualenv 虚拟环境作为一个 Debian 包来发布。[官网](http://dh-virtualenv.readthedocs.org/)
* Nuitka：将脚本、模块、包编译成可执行文件或扩展模块。[官网](http://nuitka.net/)
* py2app：将 Python 脚本变为独立软件包（Mac OS X）。[官网](http://pythonhosted.org/py2app/)
* py2exe：将 Python 脚本变为独立软件包（Windows）。[官网](http://www.py2exe.org/)
* pynsist：一个用来创建 Windows 安装程序的工具，可以在安装程序中打包 Python本身。[官网](http://pynsist.readthedocs.org/)

## 构建工具

将源码编译成软件。

* buildout：一个构建系统，从多个组件来创建，组装和部署应用。[官网](http://www.buildout.org/)
* BitBake：针对嵌入式 Linux 的类似 make 的构建工具。[官网](http://www.yoctoproject.org/docs/1.6/bitbake-user-manual/bitbake-user-manual.html)
* fabricate：对任何语言自动找到依赖关系的构建工具。[官网](https://code.google.com/archive/p/fabricate)
* PlatformIO：多平台命令行构建工具。[官网](https://github.com/platformio/platformio)
* PyBuilder：纯 Python 实现的持续化构建工具。[官网](https://github.com/pybuilder/pybuilder)
* SCons：软件构建工具。[官网](http://www.scons.org/)

## 交互式解析器

交互式 Python 解析器。

* IPython：功能丰富的工具，非常有效的使用交互式 Python。[官网](https://github.com/ipython/ipython)
* [bpython](http://hao.jobbole.com/bpython/)：界面丰富的 Python 解析器。[官网](http://bpython-interpreter.org/)
* ptpython：高级交互式Python解析器， 构建于[python-prompt-toolkit](https://github.com/jonathanslenders/python-prompt-toolkit) 之上。[官网](https://github.com/jonathanslenders/ptpython)

## 文件

文件管理和 MIME（多用途的网际邮件扩充协议）类型检测。

* imghdr：（Python 标准库）检测图片类型。[官网](https://docs.python.org/2/library/imghdr.html)
* mimetypes：（Python 标准库）将文件名映射为 MIME 类型。[官网](https://docs.python.org/2/library/mimetypes.html)
* path.py：对 os.path 进行封装的模块。[官网](https://github.com/jaraco/path.py)
* pathlib：（Python3.4+ 标准库）跨平台的、面向对象的路径操作库。[官网](https://pathlib.readthedocs.org/en/pep428/)
* python-magic：文件类型检测的第三方库 libmagic 的 Python 接口。[官网](https://github.com/ahupp/python-magic)
* Unipath：用面向对象的方式操作文件和目录。[官网](https://github.com/mikeorr/Unipath)
* watchdog：管理文件系统事件的 API 和 shell 工具[官网](https://github.com/gorakhargosh/watchdog)
* [socialcopsdev/camelot](https://github.com/socialcopsdev/camelot):Camelot: PDF Table Extraction for Humans <https://camelot-py.readthedocs.io>
* filecmp:系统自带，可以实现文件，目录，遍历子目录的差异，对比功能

## 日期和时间

操作日期和时间的类库。

* arrow：更好的 Python 日期时间操作类库。[官网](https://github.com/crsmithdev/arrow)
* Chronyk：Python 3 的类库，用于解析手写格式的时间和日期。[官网](https://github.com/KoffeinFlummi/Chronyk)
* dateutil：Python datetime 模块的扩展。[官网](https://pypi.python.org/pypi/python-dateutil)
* delorean：解决 Python 中有关日期处理的棘手问题的库。[官网](https://github.com/myusuf3/delorean/)
* moment：一个用来处理时间和日期的Python库。灵感来自于Moment.js。[官网](https://github.com/zachwill/moment)
* PyTime：一个简单易用的Python模块，用于通过字符串来操作日期/时间。[官网](https://github.com/shinux/PyTime)
* pytz：现代以及历史版本的世界时区定义。将时区数据库引入Python。[官网](https://launchpad.net/pytz)
* when.py：提供用户友好的函数来帮助用户进行常用的日期和时间操作。[官网](https://github.com/dirn/When.py)
* Pendulum：可以轻松地将其与现有代码集成，并且只有在需要时才能使用其功能

## 文本处理

用于解析和操作文本的库。

* 通用
  - [chardet](http://hao.jobbole.com/chardet/)：字符编码检测器，兼容 Python2 和 Python3。[官网](https://github.com/chardet/chardet)
  - [difflib](https://docs.python.org/2/library/difflib.html)(Python 标准库)帮助我们进行差异化比较。
  - ftfy：让Unicode文本更完整更连贯。[官网](https://github.com/LuminosoInsight/python-ftfy)
  - fuzzywuzzy：模糊字符串匹配。[官网](https://github.com/seatgeek/fuzzywuzzy)
  - Levenshtein：快速计算编辑距离以及字符串的相似度。[官网](https://github.com/ztane/python-Levenshtein/)
  - pangu.py：在中日韩语字符和数字字母之间添加空格。[官网](https://github.com/vinta/pangu.py)
  - yfiglet-figlet：[pyfiglet -figlet](https://github.com/pwaller/pyfiglet) 的 Python实现。
  - shortuuid：一个生成器库，用以生成简洁的，明白的，URL 安全的 UUID。[官网](https://github.com/stochastic-technologies/shortuuid)
  - unidecode：Unicode 文本的 ASCII 转换形式 。[官网](https://pypi.python.org/pypi/Unidecode)
  - uniout：打印可读的字符，而不是转义的字符串。[官网](https://github.com/moskytw/uniout)
  - xpinyin：一个用于把汉字转换为拼音的库。[官网](https://github.com/lxneng/xpinyin)
  - simplejson：Python的JSON编码、解码器。[官网](https://simplejson.readthedocs.io/en/latest/)、[GitHub](https://github.com/simplejson/simplejson)
* Slug化
  - awesome-slugify：一个 Python slug 化库，可以保持 Unicode。[官网](https://github.com/dimka665/awesome-slugify)
  - python-slugify：Python slug 化库，可以把 unicode 转化为 ASCII。[官网](https://github.com/un33k/python-slugify)
  - unicode-slugify：一个 slug 工具，可以生成 unicode slugs ,需要依赖 Django 。[官网](https://github.com/mozilla/unicode-slugify)
* 解析器
  - phonenumbers：解析，格式化，储存，验证电话号码。[官网](https://github.com/daviddrysdale/python-phonenumbers)
  - PLY：lex 和 yacc 解析工具的 Python 实现。[官网](http://www.dabeaz.com/ply/)
  - Pygments：通用语法高亮工具。[官网](http://pygments.org/)
  - pyparsing：生成通用解析器的框架。[官网](http://pyparsing.wikispaces.com/)
  - python-nameparser：把一个人名分解为几个独立的部分。[官网](https://github.com/derek73/python-nameparser)
  - python-user-agents：浏览器 user agent 解析器。[官网](https://github.com/selwin/python-user-agents)
  - sqlparse：一个无验证的 SQL 解析器。[官网](https://sqlparse.readthedocs.org/en/latest/)
  - [aaronsw/html2text](https://github.com/aaronsw/html2text):Convert HTML to Markdown-formatted text. <http://www.aaronsw.com/2002/html2text/>
  - [facebookresearch/fastText](https://github.com/facebookresearch/fastText):Library for fast text representation and classification.

## 特殊文本格式处理

一些用来解析和操作特殊文本格式的库。

- 通用
  - tablib：一个用来处理中表格数据的模块。[官网](https://github.com/kennethreitz/tablib)
- Office
  + Marmir：把输入的Python 数据结构转换为电子表单。[官网](https://github.com/brianray/mm)
  + openpyxl：一个用来读写 Excel 2010 xlsx/xlsm/xltx/xltm 文件的库。[官网](https://openpyxl.readthedocs.org/en/latest/)
  + python-docx：读取，查询以及修改 Microsoft Word 2007/2008 docx 文件。[官网](https://github.com/python-openxml/python-docx)
  + unoconv：在 LibreOffice/OpenOffice 支持的任意文件格式之间进行转换。[官网](https://github.com/dagwieers/unoconv)
  + [XlsxWriter](https://xlsxwriter.readthedocs.org/en/latest/)：一个用于创建 Excel .xlsx 文件的 Python 模块。
  + xlwings：一个使得在 Excel 中方便调用 Python 的库（反之亦然），基于 BSD 协议。[官网](http://xlwings.org/)
  + [xlwt](http://hao.jobbole.com/xlwt/)：读写 Excel 文件的数据和格式信息。[官网](https://github.com/python-excel/xlwt) / [xlrd](https://github.com/python-excel/xlrd)
  + relatorio：模板化OpenDocument 文件。[官网](http://relatorio.tryton.org/)
  + rrdtool:用于跟踪对象的变化，生成这些变化的走走势图
- PDF
  + PDFMiner：一个用于从PDF文档中抽取信息的工具。[官网](https://github.com/euske/pdfminer)
  + PyPDF2：一个可以分割，合并和转换 PDF 页面的库。[官网](https://github.com/mstamy2/PyPDF2)
  + ReportLab：快速创建富文本 PDF 文档。[官网](http://www.reportlab.com/opensource/)
- Markdown
  + [lepture/mistune](https://github.com/lepture/mistune)：快速并且功能齐全的纯 Python 实现的 Markdown 解析器。
  + Python-Markdown：John Gruber's Markdown 的 Python 版实现。[官网](https://github.com/waylan/Python-Markdown)
  + Python-Markdiwn2：纯 Python 实现的 Markdown 解析器，比 Python-Markdown 更快，更准确，可扩展。[官网](https://github.com/trentm/python-markdown2)
- YAML
  + PyYAML：Python 版本的 YAML 解析器。[官网](http://pyyaml.org/)
- CSV
  + csvkit：用于转换和操作 CSV 的工具。[官网](https://github.com/wireservice/csvkit)
- Archive
  - unp：一个用来方便解包归档文件的命令行工具。[官网](https://github.com/mitsuhiko/unp)

## 自然语言处理

用来处理人类语言的库。

* [NLTK](http://hao.jobbole.com/nltk/)：一个先进的平台，用以构建处理人类语言数据的 Python 程序。[官网](http://www.nltk.org/)
* jieba：中文分词工具。[官网](https://github.com/fxsjy/jieba)
* langid.py：独立的语言识别系统。[官网](https://github.com/saffsd/langid.py)
* Pattern：Python 网络信息挖掘模块。[官网](http://www.clips.ua.ac.be/pattern)
* [santinic/pampy](https://github.com/santinic/pampy):Pampy: The Pattern Matching for Python you always dreamed of.
* SnowNLP：一个用来处理中文文本的库。[官网](https://github.com/isnowfy/snownlp)
* TextBlob：为进行普通自然语言处理任务提供一致的 API。[官网](http://textblob.readthedocs.org/en/latest/)
* TextGrocery：一简单高效的短文本分类工具，基于 LibLinear 和 Jieba。[官网](https://github.com/2shou/TextGrocery)
* [SpaCy](https://spacy.io/):一个具有优秀示例、API 文档和演示应用程序的自然语言处理库
* [Gensim](https://radimrehurek.com/gensim/):用于健壮语义分析、主题建模和向量空间建模的 Python 库，构建在Numpy和Scipy之上

## 文档

用以生成项目文档的库。

* [Sphinx](http://hao.jobbole.com/sphinx/)：Python 文档生成器。[官网](http://www.sphinx-doc.org/en/latest/)
  - `brew install sphinx`
* awesome-sphinxdoc：[官网](https://github.com/yoloseem/awesome-sphinxdoc)
* MkDocs：对 Markdown 友好的文档生成器。[官网](http://www.mkdocs.org/)
* pdoc：一个可以替换Epydoc 的库，可以自动生成 Python 库的 API 文档。[官网](https://github.com/BurntSushi/pdoc)
* Pycco：文学编程（literate-programming）风格的文档生成器。[官网](https://github.com/pycco-docs/pycco)

## 配置

用来保存和解析配置的库。

* config：[logging](https://docs.python.org/2/library/logging.html) 模块作者写的分级配置模块。[官网](https://www.red-dove.com/config-doc/)
* ConfigObj：INI 文件解析器，带验证功能。[官网](http://www.voidspace.org.uk/python/configobj.html)
* ConfigParser：(Python 标准库) INI 文件解析器。[官网](https://docs.python.org/2/library/configparser.html)
* profig：通过多种格式进行配置，具有数值转换功能。[官网](http://profig.readthedocs.org/en/default/)
* python-decouple：将设置和代码完全隔离。[官网](https://github.com/henriquebastos/python-decouple)

## 命令行工具

用于创建命令行程序的库。

* 命令行程序开发
  - asciimatics：跨平台，全屏终端包（即鼠标/键盘输入和彩色，定位文本输出），完整的复杂动画和特殊效果的高级API。[官网](https://github.com/peterbrittain/asciimatics)
  - cement：Python 的命令行程序框架。[官网](http://builtoncement.com/)
  - click：一个通过组合的方式来创建精美命令行界面的包。[官网](http://click.pocoo.org/dev/)
  - cliff：一个用于创建命令行程序的框架，可以创建具有多层命令的命令行程序。[官网](http://docs.openstack.org/developer/cliff/)
  - clint：Python 命令行程序工具。[官网](https://github.com/kennethreitz/clint)
  - colorama：跨平台彩色终端文本。[官网](https://pypi.python.org/pypi/colorama)
  - docopt：Python 风格的命令行参数解析器。[官网](http://docopt.org/)
  - Gooey：一条命令，将命令行程序变成一个 GUI 程序。[官网](https://github.com/chriskiehl/Gooey)
  - python-prompt-toolkit：一个用于构建强大的交互式命令行程序的库。[官网](https://github.com/jonathanslenders/python-prompt-toolkit)
  - [Pythonpy](http://hao.jobbole.com/pythonpy/)：在命令行中直接执行任何Python指令。[官网](https://github.com/Russell91/pythonpy/wiki)
  - Fire是一个开源的库，可以为任何Python项目自动生成一个CLI
  - [mkaz/termgraph](https://github.com/mkaz/termgraph):a python command-line tool which draws basic graphs in the terminal
* 生产力工具
  - aws-cli：Amazon Web Services 的通用命令行界面。[官网](https://github.com/aws/aws-cli)
  - bashplotlib：在终端中进行基本绘图。[官网](https://github.com/glamp/bashplotlib)
  - caniusepython3：判断是哪个项目妨碍你你移植到 Python 3。[官网](https://github.com/brettcannon/caniusepython3)
  - cookiecutter：从 cookiecutters（项目模板）创建项目的一个命令行工具。[官网](https://github.com/audreyr/cookiecutter)
  - doitlive：一个用来在终端中进行现场演示的工具。[官网](https://github.com/sloria/doitlive)
  - howdoi：通过命令行获取即时的编程问题解答。[官网](https://github.com/gleitz/howdoi)
  - PathPicker：从bash输出中选出文件。[官网](https://github.com/facebook/PathPicker)
  - percol：向UNIX shell 传统管道概念中加入交互式选择功能。[官网](https://github.com/mooz/percol)
  - SAWS：一个加强版的 AWS 命令行。[官网](https://github.com/donnemartin/saws)
  - thefuck：修正你之前的命令行指令。[官网](https://github.com/nvbn/thefuck)
  - mycli：一个 MySQL 命令行客户端，具有自动补全和语法高亮功能。[官网](https://github.com/dbcli/mycli)
  - pgcli：Postgres 命令行工具，具有自动补全和语法高亮功能。[官网](https://github.com/dbcli/pgcli)
  - try：一个从来没有更简单的命令行工具，用来试用python库。[官网](https://github.com/timofurrer/try)
* [tqdm / tqdm](https://github.com/tqdm/tqdm)：A Fast, Extensible Progress Bar for Python and CLI <https://tqdm.github.io>
* [willmcgugan / rich](https://github.com/willmcgugan/rich): a Python library for rich text and beautiful formatting in the terminal. <https://rich.readthedocs.io/en/latest/>

## 下载器

用来进行下载的库.

* s3cmd：一个用来管理Amazon S3 和 CloudFront 的命令行工具。[官网](https://github.com/s3tools/s3cmd)
* s4cmd：超级 S3 命令行工具，性能更加强劲。[官网](https://github.com/bloomreach/s4cmd)
* you-get：一个 YouTube/Youku/Niconico 视频下载器，使用 Python3 编写。[官网](https://www.soimort.org/you-get/)
* youtube-dl：一个小巧的命令行程序，用来下载 YouTube 视频。[官网](http://rg3.github.io/youtube-dl/)

## 图像处理

用来操作图像的库.

* [pillow](http://hao.jobbole.com/pillow/)：Pillow 是一个更加易用版的 [PIL](http://www.pythonware.com/products/pil/)。[官网](http://pillow.readthedocs.org/en/latest/)
* hmap：图像直方图映射。[官网](https://github.com/rossgoodwin/hmap)
* imgSeek：一个使用视觉相似性搜索一组图片集合的项目。[官网](https://sourceforge.net/projects/imgseek/)
* nude.py：裸体检测。[官网](https://github.com/hhatto/nude.py)
* pyBarcode：不借助 PIL 库在 Python 程序中生成条形码。[官网](https://pythonhosted.org/pyBarcode/)
* pygram：类似 Instagram 的图像滤镜。[官网](https://github.com/ajkumar25/pygram)
* python-qrcode：一个纯 Python 实现的二维码生成器。[官网](https://github.com/lincolnloop/python-qrcode)
* Quads：基于四叉树的计算机艺术。[官网](https://github.com/fogleman/Quads)
* scikit-image：一个用于（科学）图像处理的 Python 库。[官网](http://scikit-image.org/)
* thumbor：一个小型图像服务，具有剪裁，尺寸重设和翻转功能。[官网](https://github.com/thumbor/thumbor)
* wand：[MagickWand](http://www.imagemagick.org/script/magick-wand.php)的Python 绑定。MagickWand 是 ImageMagick的 C API 。[官网](https://github.com/dahlia/wand)
* PyVips
* Luminoth：一个使用TensorFlow和Sonnet构建的用于计算机视觉的开源Python工具包。目前，它可以支持被称为Faster R-CNN的模型的形式进行对象检测。

## OCR

光学字符识别库。

* pyocr：Tesseract 和 Cuneiform 的一个封装(wrapper)。[官网](https://github.com/jflesch/pyocr)
* [pytesseract](http://hao.jobbole.com/pytesseract/)：[Google Tesseract OCR](https://github.com/tesseract-ocr) 的另一个封装(wrapper)。[官网](https://github.com/madmaze/pytesseract)
* python-tesseract - [Google Tesseract OCR](https://github.com/tesseract-ocr) 的一个包装类。

## 音频

用来操作音频的库

* audiolazy：Python 的数字信号处理包。[官网](https://github.com/danilobellini/audiolazy)
* audioread：交叉库 (GStreamer + Core Audio + MAD + FFmpeg) 音频解码。[官网](https://github.com/beetbox/audioread)
* beets：一个音乐库管理工具及 [MusicBrainz](https://musicbrainz.org/) 标签添加工具[官网](http://beets.io/)
* dejavu：音频指纹提取和识别[官网](https://github.com/worldveil/dejavu)
* [django-elastic-transcoder](http://hao.jobbole.com/django-elastic-transcoder/)：Django + [Amazon Elastic Transcoder](http://aws.amazon.com/elastictranscoder/)。[官网](https://github.com/StreetVoice/django-elastic-transcoder)
* eyeD3：一个用来操作音频文件的工具，具体来讲就是包含 ID3 元信息的 MP3 文件。[官网](http://eyed3.nicfit.net/)
* id3reader：一个用来读取 MP3 元数据的 Python 模块。[官网](http://nedbatchelder.com/code/modules/id3reader.py)
* m3u8：一个用来解析 m3u8 文件的模块。[官网](https://github.com/globocom/m3u8)
* mutagen：一个用来处理音频元数据的 Python 模块。[官网](https://bitbucket.org/lazka/mutagen)
* pydub：通过简单、简洁的高层接口来操作音频文件。[官网](https://github.com/jiaaro/pydub)
* pyechonest：[Echo Nest](http://developer.echonest.com/) API 的 Python 客户端[官网](https://github.com/echonest/pyechonest)
* talkbox：一个用来处理演讲/信号的 Python 库[官网](http://scikits.appspot.com/talkbox)
* TimeSide：开源 web 音频处理框架。[官网](https://github.com/Parisson/TimeSide)
* [tinytag](https://github.com/devsnd/tinytag)：一个用来读取MP3, OGG, FLAC 以及 Wave 文件音乐元数据的库。
* [mingus](http://bspaans.github.io/python-mingus/)：一个高级音乐理论和曲谱包，支持 MIDI 文件和回放功能。

## Video

用来操作视频和GIF的库。

* moviepy：一个用来进行基于脚本的视频编辑模块，适用于多种格式，包括动图 GIFs。[官网](http://zulko.github.io/moviepy/)
* scikit-video：SciPy 视频处理常用程序。[官网](https://github.com/aizvorski/scikit-video)
* [streamlink/streamlink](https://github.com/streamlink/streamlink):CLI for extracting streams from various websites to a video player of your choosing <https://streamlink.github.io/>

## 地理位置

地理编码地址以及用来处理经纬度的库。

* GeoDjango：世界级地理图形 web 框架。[官网](https://docs.djangoproject.com/en/dev/ref/contrib/gis/)
* GeoIP：MaxMind GeoIP Legacy 数据库的 Python API。[官网](https://github.com/maxmind/geoip-api-python)
* geojson：GeoJSON 的 Python 绑定及工具。[官网](https://github.com/frewsxcv/python-geojson)
* geopy：Python 地址编码工具箱。[官网](https://github.com/geopy/geopy)
* pygeoip：纯 Python GeoIP API。[官网](https://github.com/appliedsec/pygeoip)
* django-countries：一个 Django 应用程序，提供用于表格的国家选择功能，国旗图标静态文件以及模型中的国家字段。[官网](https://github.com/SmileyChris/django-countries)

## HTTP

使用HTTP的库。

* [requests/requests](https://github.com/requests/requests)：Python HTTP Requests for Humans™ sparklescakesparkles <http://python-requests.org>
* [psf / requests](https://github.com/psf/requests/):A simple, yet elegant HTTP library. <https://requests.readthedocs.io>
* [grequests](https://github.com/kennethreitz/grequests)：requests 库 + gevent ，用于异步 HTTP 请求.
* [httplib2](https://github.com/jcgregorio/httplib2)：全面的 HTTP 客户端库
* [treq](https://github.com/twisted/treq)：类似 requests 的Python API 构建于 Twisted HTTP 客户端之上。
* [urllib3](https://github.com/shazow/urllib3)：一个具有线程安全连接池，支持文件 post，清晰友好的 HTTP 库。
* [kennethreitz/responder](https://github.com/kennethreitz/responder):a familiar HTTP Service Framework for Python <https://python-responder.org>
* [pycurl](http://pycurl.sourceforge.net)是一个用C语言写的libcurl Python实现，功能强大，支持的协议有：FTP,HTTP,HTTPS,TELNET等，可以理解为Linux下curl命令功能的Python封装
* [scapy](http://www.wecdev.org/projects/scapy/)是一个强大的交互式数据包处理程序，它能够对数据包进行伪造或解包，包括发送数据包，包嗅探，应答和反馈等功能。
* [requests/httpbin](https://github.com/requests/httpbin):HTTP Request & Response Service, written in Python + Flask. <https://httpbin.org>
* [kennethreitz/requests-html](https://github.com/kennethreitz/requests-html):下载完网页之后,内置了html网页的解析
* [request/request-promise](https://github.com/request/request-promise):The simplified HTTP request client 'request' with Promise support. Powered by Bluebird.
* [httpstat](https://github.com/reorx/httpstat):curl statistics made simple
* [encode/httpx](https://github.com/encode/httpx):A next generation HTTP client for Python. butterfly <https://www.encode.io/httpx>

## 数据库

Python实现的数据库。

* pickleDB：一个简单，轻量级键值储存数据库。[官网](https://pythonhosted.org/pickleDB/)
* PipelineDB：流式 SQL 数据库。[官网](https://www.pipelinedb.com/)
* TinyDB：一个微型的，面向文档型数据库。[官网](https://github.com/msiemens/tinydb)
* ZODB：一个 Python 原生对象数据库。一个键值和对象图数据库。[官网](http://www.zodb.org/en/latest/)

## 数据库驱动

用来连接和操作数据库的库。

* MySQL：[awesome-mysql](http://shlomi-noach.github.io/awesome-mysql/)系列
* mysql-python：Python 的 MySQL 数据库连接器。[官网](https://sourceforge.net/projects/mysql-python/)
* ysqlclient：[mysql-python](https://github.com/PyMySQL/mysqlclient-python) 分支，支持 Python 3。
* oursql：一个更好的 MySQL 连接器，支持原生预编译指令和 BLOBs.[官网](https://pythonhosted.org/oursql/)
* PyMySQL：纯 Python MySQL 驱动，兼容 mysql-python。[官网](https://github.com/PyMySQL/PyMySQL)
* PostgreSQL
* psycopg2：Python 中最流行的 PostgreSQL 适配器。[官网](http://initd.org/psycopg/)
* queries：psycopg2 库的封装，用来和 PostgreSQL 进行交互。[官网](https://github.com/gmr/queries)
* txpostgres：基于 Twisted 的异步 PostgreSQL 驱动。[官网](http://txpostgres.readthedocs.org/en/latest/)
* [influxdata/influxdb-python](https://github.com/influxdata/influxdb-python):Python client for InfluxDB
* 其他关系型数据库
  - apsw：另一个 Python SQLite封装。[官网](http://rogerbinns.github.io/apsw/)
  - dataset：在数据库中存储Python字典
  - pymssql：一个简单的Microsoft SQL Server数据库接口。[官网](http://www.pymssql.org/en/latest/)
* NoSQL 数据库
  - cassandra-python-driver：Cassandra 的 Python 驱动。[官网](https://github.com/datastax/python-driver)
  - HappyBase：一个为 Apache HBase 设计的，对开发者友好的库。[官网](http://happybase.readthedocs.org/en/latest/)
  - Plyvel：一个快速且功能丰富的 LevelDB 的 Python 接口。[官网](https://plyvel.readthedocs.org/en/latest/)
  - py2neo：Neo4j restful 接口的Python 封装客户端。[官网](http://py2neo.org/2.0/)
  - pycassa：Cassandra 的 Python Thrift 驱动。[官网](https://github.com/pycassa/pycassa)
  - PyMongo：MongoDB 的官方 Python 客户端。[官网](https://docs.mongodb.org/ecosystem/drivers/python/)
  - redis-py：Redis 的 Python 客户端。[官网](https://github.com/andymccurdy/redis-py)
  - telephus：基于 Twisted 的 Cassandra 客户端。[官网](https://github.com/driftx/Telephus)
  - txRedis：基于 Twisted 的 Redis 客户端。[官网](https://github.com/deldotdr/txRedis)
* [graphql-python/graphene](https://github.com/graphql-python/graphene):GraphQL framework for Python <http://graphene-python.org/>

## ORM

实现对象关系映射或数据映射技术的库。

* 关系型数据库
  - Django Models：Django 的一部分。[官网](https://docs.djangoproject.com/en/dev/topics/db/models/)
  - SQLAlchemy：Python SQL 工具以及对象关系映射工具。[官网](http://www.sqlalchemy.org/)
  - [awesome-sqlalchemy](https://github.com/dahlia/awesome-sqlalchemy)系列
  - [Peewee](http://hao.jobbole.com/peewee/)：一个小巧，富有表达力的 ORM。[官网](https://github.com/coleifer/peewee)
  - PonyORM：提供面向生成器的 SQL 接口的 ORM。[官网](https://ponyorm.com/)
  - python-sql：编写 Python 风格的 SQL 查询。[官网](https://pypi.python.org/pypi/python-sql)
* NoSQL 数据库
  - django-mongodb-engine：Django MongoDB 后端。[官网](https://github.com/django-nonrel/mongodb-engine)
  - PynamoDB：[Amazon DynamoDB](https://aws.amazon.com/dynamodb/) 的一个 Python 风格接口。[官网](https://github.com/jlafon/PynamoDB)
  - flywheel：Amazon DynamoDB 的对象映射工具。[官网](https://github.com/mathcamp/flywheel)
  - MongoEngine：一个Python 对象文档映射工具，用于 MongoDB。[官网](http://mongoengine.org/)
  - hot-redis：为 Redis 提供 Python 丰富的数据类型。[官网](https://github.com/stephenmcd/hot-redis)
  - redisco：一个 Python 库，提供可以持续存在在 Redis 中的简单模型和容器。[官网](https://github.com/kiddouk/redisco)
* 其他
  - butterdb：Google Drive 电子表格的 Python ORM。[官网](https://github.com/Widdershin/butterdb)

## Web 框架

* [Django](https://www.djangoproject.com/)：Python 界最流行的 web 框架
  - [awesome-django](https://github.com/rosarior/awesome-django)系列
* [Flask](http://flask.pocoo.org/)：一个 Python 微型框架
  - [awesome-flask](https://github.com/humiaozuzu/awesome-flask)系列
* pyramid：一个小巧，快速，接地气的开源Python web 框架。
  - [awesome-pyramid](https://github.com/uralbash/awesome-pyramid)系列
* [Bottle](http://bottlepy.org/docs/dev/index.html/)：一个快速小巧，轻量级的 WSGI 微型 web 框架。
* [CherryPy](http://www.cherrypy.org/)：一个极简的 Python web 框架，服从 HTTP/1.1 协议且具有WSGI 线程池。
* [TurboGears](http://www.turbogears.org/)：一个可以扩展为全栈解决方案的微型框架。
* [web.py](http://webpy.org/)：一个 Python 的 web 框架，既简单，又强大。
* [web2py](http://www.web2py.com/)：一个全栈 web 框架和平台，专注于简单易用。
* [Tornado](http://www.tornadoweb.org/en/latest/)：一个web 框架和异步网络库。
* [tiangolo / fastapi](https://github.com/tiangolo/fastapi):FastAPI framework, high performance, easy to learn, fast to code, ready for production <https://fastapi.tiangolo.com/>

## 权限

允许或拒绝用户访问数据或功能的库。

* Carteblanche：Module to align code with thoughts of users and designers. Also magically handles navigation and permissions.[官网](https://github.com/neuman/python-carteblanche/)
* django-guardian：Django 1.2+ 实现了单个对象权限。[官网](https://github.com/django-guardian/django-guardian)
* django-rules：一个小巧但是强大的应用，提供对象级别的权限管理，且不需要使用数据库。[官网](https://github.com/dfunckt/django-rules)

## CMS

内容管理系统

* odoo-cms: 一个开源的，企业级 CMS，基于odoo。[官网](http://www.odoo.com)
* django-cms：一个开源的，企业级 CMS，基于 Django。[官网](http://www.django-cms.org/en/)
* djedi-cms：一个轻量级但却非常强大的 Django CMS ，考虑到了插件，内联编辑以及性能。[官网](http://djedi-cms.org/)
* FeinCMS：基于 Django 构建的最先进的内容管理系统之一。[官网](http://www.feincms.org/)
* Kotti：一个高级的，Python 范的 web 应用框架，基于 Pyramid 构建。[官网](http://kotti.pylonsproject.org/)
* Mezzanine：一个强大的，持续的，灵活的内容管理平台。[官网](http://mezzanine.jupo.org/)
* Opps：一个为杂志，报纸网站以及大流量门户网站设计的 CMS 平台，基于 Django。[官网](http://opps.github.io/opps/)
* Plone：一个构建于开源应用服务器 Zope 之上的 CMS。[官网](https://plone.org/)
* Quokka：灵活，可扩展的小型 CMS，基于 Flask 和 MongoDB。[官网](http://quokkaproject.org/)
* [Wagtail](http://hao.jobbole.com/wagtail/)：一个 Django 内容管理系统。[官网](https://wagtail.io/)
* Widgy：最新的 CMS 框架，基于 Django。[官网](https://wid.gy/)

## 电子商务

用于电子商务以及支付的框架和库。

* django-oscar：一个用于 Django 的开源的电子商务框架。[官网](http://oscarcommerce.com/)
* django-shop：一个基于 Django 的店铺系统。[官网](https://github.com/awesto/django-shop)
* Cartridge：一个基于 Mezzanine 构建的购物车应用。[官网](https://github.com/stephenmcd/cartridge)
* shoop：一个基于 Django 的开源电子商务平台。[官网](https://www.shoop.io/en/)
* alipay：非官方的 Python 支付宝 API。[官网](https://github.com/lxneng/alipay)
* merchant：一个可以接收来自多种支付平台支付的 Django 应用。[官网](https://github.com/agiliq/merchant)
* money：货币类库with optional CLDR-backed locale-aware formatting and an extensible currency exchange solution.[官网](https://github.com/carlospalol/money)
* python-currencies：显示货币格式以及它的数值。[官网](https://github.com/Alir3z4/python-currencies)

## RESTful API

用来开发RESTful APIs的库

* Django
  - [django-rest-framework](http://hao.jobbole.com/django-rest-framework/)：一个强大灵活的工具，用来构建 web API。[官网](http://www.django-rest-framework.org/)
  - django-tastypie：为Django 应用开发API。[官网](http://tastypieapi.org/)
  - django-formapi：为 Django 的表单验证，创建 JSON APIs 。[官网](https://github.com/5monkeys/django-formapi)
* Flask
  - flask-api：为 flask 开发的，可浏览 Web APIs 。[官网](http://www.flaskapi.org/)
  - flask-restful：为 flask 快速创建REST APIs 。[官网](http://flask-restful.readthedocs.org/en/latest/)
  - flask-restless：为 SQLAlchemy 定义的数据库模型创建 RESTful APIs 。[官网](https://flask-restless.readthedocs.org/en/latest/)
  - flask-api-utils：为 Flask 处理 API 表示和验证。[官网](https://github.com/marselester/flask-api-utils)
  - eve：REST API 框架，由 Flask, MongoDB 等驱动。[官网](https://github.com/nicolaiarocci/eve)
* Pyramid
  - cornice：一个Pyramid 的 REST 框架 。[官网](https://cornice.readthedocs.org/en/latest/)
* 与框架无关的
  - falcon：一个用来建立云 API 和 web app 后端的高性能框架。[官网](http://falconframework.org/)
  - sandman：为现存的数据库驱动系统自动创建 REST APIs 。[官网](https://github.com/jeffknupp/sandman)
  - restless：框架无关的 REST 框架 ，基于从 Tastypie 学到的知识。[官网](http://restless.readthedocs.org/en/latest/)
  - ripozo：快速创建 REST/HATEOAS/Hypermedia APIs。[官网](https://github.com/vertical-knowledge/ripozo)

## 验证

实现验证方案的库。

* OAuth
  - Authomatic：简单但是强大的框架，身份验证/授权客户端。[官网](http://peterhudec.github.io/authomatic/)
  - django-allauth：Django 的验证应用。[官网](https://github.com/pennersr/django-allauth)
  - django-oauth-toolkit：为 Django 用户准备的 OAuth2。[官网](https://github.com/evonove/django-oauth-toolkit)
  - django-oauth2-provider：为 Django 应用提供 OAuth2 接入。[官网](https://github.com/caffeinehit/django-oauth2-provider)
  - Flask-OAuthlib：OAuth 1.0/a, 2.0 客户端实现，供 Flask 使用。[官网](https://github.com/lepture/flask-oauthlib)
  - OAuthLib：一个 OAuth 请求-签名逻辑通用、 完整的实现。[官网](https://github.com/IDAn/oauthlib)
  - python-oauth2：一个完全测试的抽象接口。用来创建 OAuth 客户端和服务端。[官网](https://github.com/joestump/python-oauth2)
  - python-social-auth：一个设置简单的社会化验证方式。[官网](https://github.com/omab/python-social-auth)
  - rauth：OAuth 1.0/a, 2.0, 和 Ofly 的 Python 库。[官网](https://github.com/litl/rauth)
  - sanction：一个超级简单的OAuth2 客户端实现。[官网](https://github.com/demianbrecht/sanction)
* 其他
  - jose：JavaScript 对象签名和加密草案的实现。[官网](https://github.com/demonware/jose)
  - PyJWT：JSON Web 令牌草案 01。[官网](https://github.com/jpadilla/pyjwt)
  - python-jws：JSON Web 签名草案 02 的实现。[官网](https://github.com/brianloveswords/python-jws)
  - python-jwt：一个用来生成和验证 JSON Web 令牌的模块。[官网](https://github.com/davedoesdev/python-jwt)

## 模板引擎

模板生成和词法解析的库和工具。

* [Jinja2](https://github.com/pallets/jinja)：一个现代的，对设计师友好的模板引擎。
* [Chameleon](https://chameleon.readthedocs.org/en/latest/)：一个 HTML/XML 模板引擎。 模仿了 ZPT（Zope Page Templates）, 进行了速度上的优化。
* [Genshi](https://genshi.edgewall.org/)：Python 模板工具，用以生成 web 感知的结果。
* [Mako](http://www.makotemplates.org/)：Python 平台的超高速轻量级模板。

## Queue

处理事件以及任务队列的库。

* [celery](http://www.celeryproject.org/)：Distributed Task Queue 一个异步任务队列/作业队列，基于分布式消息传递 <https://docs.celeryproject.org/en/stable/index.html>
* [huey](https://github.com/coleifer/huey)：小型多线程任务队列。
* [mrq](https://github.com/pricingassistant/mrq)：Mr. Queue -一个 Python 的分布式 worker 任务队列， 使用 Redis 和 gevent。
* [rq](http://python-rq.org/)：简单的 Python 作业队列。
* [simpleq](https://github.com/rdegges/simpleq)：一个简单的，可无限扩张的，基于亚马逊 SQS 的队列。

## 搜索

对数据进行索引和执行搜索查询的库和软件。

* [django-haystack](https://github.com/django-haystack/django-haystack)：Django 模块化搜索。
* [elasticsearch-py](https://www.elastic.co/guide/en/elasticsearch/client/python-api/current/index.html)：Elasticsearch 的官方底层 Python 客户端。
* [elasticsearch-dsl-py](https://github.com/elastic/elasticsearch-dsl-py)：Elasticsearch 的官方高级 Python 客户端。
* [solrpy](https://github.com/edsu/solrpy)：[solr](http://lucene.apache.org/solr/)的 Python 客户端。
* [Whoosh](http://whoosh.readthedocs.org/en/latest/)：一个快速的纯 Python 搜索引擎库。

## 动态消息

用来创建用户活动的库。

* [django-activity-stream](https://github.com/justquick/django-activity-stream)：从你的站点行为中生成通用活动信息流。
* [Stream-Framework](https://github.com/tschellenbach/Stream-Framework)：使用 Cassandra 和 Redis 创建动态消息和通知系统。

## 资源管理

管理、压缩、缩小网站资源的工具。

* django-compressor：将链接和内联的 JavaScript 或 CSS 压缩到一个单独的缓存文件中。[官网](https://github.com/django-compressor/django-compressor)
* django-storages：一个针对 Django 的自定义存储后端的工具集合。[官网](http://django-storages.readthedocs.org/en/latest/)
* fanstatic：打包、优化，并且把静态文件依赖作为 Python 的包来提供。[官网](http://www.fanstatic.org/en/latest/)
* File Conveyor：一个后台驻留的程序，用来发现和同步文件到 CDNs, S3 和 FTP。[官网](http://fileconveyor.org/)
* Flask-Assets：帮你将 web 资源整合到你的 Flask app 中。[官网](http://flask-assets.readthedocs.org/en/latest/)
* jinja-assets-compressor：一个 Jinja 扩展，用来编译和压缩你的资源。[官网](https://github.com/jaysonsantos/jinja-assets-compressor)
* webassets：为你的静态资源打包、优化和管理生成独一无二的缓存 URL。[官网](http://webassets.readthedocs.org/en/latest/)

## 缓存

缓存数据的库。

* Beaker：一个缓存和会话库，可以用在 web 应用和独立 Python脚本和应用上。[官网](http://beaker.readthedocs.org/en/latest/)
* django-cache-machine：Django 模型的自动缓存和失效。[官网](https://github.com/django-cache-machine/django-cache-machine)
* django-cacheops：具有自动颗粒化事件驱动失效功能的 ORM。[官网](https://github.com/Suor/django-cacheops)
* django-viewlet：渲染模板，同时具有额外的缓存控制功能。[官网](https://github.com/5monkeys/django-viewlet)
* dogpile.cache：dogpile.cache 是 Beaker 的下一代替代品，由同一作者开发。[官网](http://dogpilecache.readthedocs.org/en/latest/)
* HermesCache：Python 缓存库，具有基于标签的失效和 dogpile effect 保护功能。[官网](https://pypi.python.org/pypi/HermesCache)
* johnny-cache：django应用缓存框架。[官网](https://github.com/jmoiron/johnny-cache)
* pylibmc：[libmemcached](http://libmemcached.org/libMemcached.html) 接口的 Python 封装。[官网](https://github.com/lericson/pylibmc)

## 电子邮件

用来发送和解析电子邮件的库。

* django-celery-ses：带有 AWS SES 和 Celery 的 Django email 后端。[官网](https://github.com/StreetVoice/django-celery-ses)
* envelopes：供人类使用的电子邮件库。[官网](http://tomekwojcik.github.io/envelopes/)
* flanker：一个 email 地址和 Mime 解析库。[官网](https://github.com/mailgun/flanker)
* imbox：Python IMAP 库[官网](https://github.com/martinrusev/imbox)
* inbox.py：Python SMTP 服务器。[官网](https://github.com/kennethreitz/inbox.py)
* inbox：一个开源电子邮件工具箱。[官网](https://github.com/nylas/sync-engine)
* lamson：Python 风格的 SMTP 应用服务器。[官网](https://github.com/zedshaw/lamson)
* mailjet：Mailjet API 实现，用来提供批量发送邮件，统计等功能。[官网](https://github.com/WoLpH/mailjet)
* marrow.mailer：高性能可扩展邮件分发框架。[官网](https://github.com/marrow/mailer)
* modoboa：一个邮件托管和管理平台，具有现代的、简约的 Web UI。[官网](https://github.com/tonioo/modoboa)
* pyzmail：创建，发送和解析电子邮件。[官网](http://www.magiksys.net/pyzmail/)
* Talon：Mailgun 库，用来抽取信息和签名。[官网](https://github.com/mailgun/talon)
* smtplib：发送电子邮件模块

## 国际化

用来进行国际化的库。

* Babel：一个Python 的国际化库。[官网](http://babel.pocoo.org/en/latest/)
* Korean：一个韩语词态库。[官网](https://korean.readthedocs.org/en/latest/)

## URL处理

解析URLs的库

* [furl](https://github.com/gruns/furl)：一个让处理 URL 更简单小型 Python 库。
* [purl](https://github.com/codeinthehole/purl)：一个简单的，不可变的URL类，具有简洁的 API 来进行询问和处理。
* [pyshorteners](https://github.com/ellisonleao/pyshorteners)：一个纯 Python URL 缩短库。
* [shorturl](https://github.com/Alir3z4/python-shorturl)：生成短小 URL 和类似 bit.ly 短链的Python 实现。
* [webargs](https://github.com/sloria/webargs)：一个解析 HTTP 请求参数的库，内置对流行 web 框架的支持，包括 Flask, Django, Bottle, Tornado和 Pyramid。
* [amitt001/pygmy](https://github.com/amitt001/pygmy):An open-source, feature rich & extensible url shortener + analytics written in Python 🍪 <https://pygy.co/pygmy>

## HTML处理

处理 HTML和XML的库。

* BeautifulSoup：以 Python 风格的方式来对 HTML 或 XML 进行迭代，搜索和修改。[官网](http://www.crummy.com/software/BeautifulSoup/bs4/doc/)
* bleach：一个基于白名单的 HTML 清理和文本链接库。[官网](http://bleach.readthedocs.org/en/latest/)
* cssutils：一个 Python 的 CSS 库。[官网](https://pypi.python.org/pypi/cssutils/)
* html5lib：一个兼容标准的 HTML 文档和片段解析及序列化库。[官网](https://github.com/html5lib/html5lib-python)
* lxml：一个非常快速，简单易用，功能齐全的库，用来处理 HTML 和 XML。[官网](http://lxml.de/)
* MarkupSafe：为Python 实现 XML/HTML/XHTML 标记安全字符串。[官网](https://github.com/pallets/markupsafe)
* pyquery：一个解析 HTML 的库，类似 jQuery。[官网](https://github.com/gawel/pyquery)
* untangle：将XML文档转换为Python对象，使其可以方便的访问。[官网](https://github.com/stchris/untangle)
* xhtml2pdf：HTML/CSS 转 PDF 工具。[官网](https://github.com/xhtml2pdf/xhtml2pdf)
* xmltodict：像处理 JSON 一样处理 XML。[官网](https://github.com/martinblech/xmltodict)

## 爬虫

* [Scrapy](http://scrapy.org/)：一个快速高级的屏幕爬取及网页采集框架。
* cola：一个分布式爬虫框架。[官网](https://github.com/chineking/cola)
* Demiurge：基于PyQuery 的爬虫微型框架。[官网](https://github.com/matiasb/demiurge)
* feedparser：通用 feed 解析器。[官网](http://pythonhosted.org/feedparser/)
* Grab：站点爬取框架。[官网](http://grablib.org/)
* MechanicalSoup：用于自动和网络站点交互的 Python 库。[官网](https://github.com/hickford/MechanicalSoup)
* portia：Scrapy 可视化爬取。[官网](https://github.com/scrapinghub/portia)
* pyspider：一个强大的爬虫系统。[官网](https://github.com/binux/pyspider)
* RoboBrowser：一个简单的，Python 风格的库，用来浏览网站，而不需要一个独立安装的浏览器。[官网](https://github.com/jmcarp/robobrowser)
* Requestium：从请求开始并无缝地切换到使用Selenium，它可以作为一个请求的直接替换
* [s0md3v/Photon](https://github.com/s0md3v/Photon):Incredibly fast crawler designed for reconnaissance.
* [Anorov/cloudflare-scrape](https://github.com/Anorov/cloudflare-scrape):A Python module to bypass Cloudflare's anti-bot page.

## 网页内容提取

用于进行网页内容提取的库。

* Haul：一个可以扩展的图像爬取工具。[官网](https://github.com/vinta/Haul)
* html2text：将 HTML 转换为 Markdown 格式文本[官网](https://github.com/Alir3z4/html2text)
* lassie：人性化的网页内容检索库。[官网](https://github.com/michaelhelmick/lassie)
* micawber：一个小型网页内容提取库，用来从 URLs 提取富内容。[官网](https://github.com/coleifer/micawber)
* [newspaper](http://hao.jobbole.com/python-newspaper/)：使用 Python 进行新闻提取，文章提取以及内容策展。[官网](https://github.com/codelucas/newspaper)
* opengraph：一个用来解析开放内容协议(Open Graph Protocol)的 Python模块。[官网](https://github.com/erikriver/opengraph)
* [python-goose](http://hao.jobbole.com/python-goose/)：HTML内容/文章提取器。[官网](https://github.com/grangier/python-goose)
* python-readability：arc90 公司 readability 工具的 Python 高速端口。[官网](https://github.com/buriy/python-readability)
* sanitize：为杂乱的数据世界带来调理性。[官网](https://github.com/Alir3z4/python-sanitize)
* sumy：一个为文本文件和 HTML 页面进行自动摘要的模块。[官网](https://github.com/miso-belica/sumy)
* textract：从任何格式的文档中提取文本，Word，PowerPoint，PDFs 等等。[官网](https://github.com/deanmalmgren/textract)
* [socialcopsdev/camelot](https://github.com/socialcopsdev/camelot):Camelot: PDF Table Extraction for Humans <https://camelot-py.readthedocs.io>
* [danburzo/percollate](https://github.com/danburzo/percollate):🌐 → 📖 A command-line tool to turn web pages into beautifully formatted PDFs

## 表单

进行表单操作的库。

* Deform：Python HTML 表单生成库，受到了 formish 表单生成库的启发。[官网](http://deform.readthedocs.org/en/latest/)
* django-bootstrap3：集成了 Bootstrap 3 的 Django。[官网](https://github.com/dyve/django-bootstrap3)
* django-crispy-forms：一个 Django 应用，他可以让你以一种非常优雅且 DRY（Don't repeat yourself） 的方式来创建美观的表单。[官网](http://django-crispy-forms.readthedocs.org/en/latest/)
* django-remote-forms：一个平台独立的 Django 表单序列化工具。[官网](https://github.com/WiserTogether/django-remote-forms)
* WTForms：一个灵活的表单验证和呈现库。[官网](http://wtforms.readthedocs.org/en/latest/)
* WTForms-JSON：一个 WTForms 扩展，用来处理 JSON 数据。[官网](http://wtforms-json.readthedocs.org/en/latest/)

## 数据验证

数据验证库。多用于表单验证。

* Cerberus：A mappings-validator with a variety of rules, normalization-features and simple customization that uses a pythonic schema-definition.[官网](http://docs.python-cerberus.org/en/stable/)
* colander：一个用于对从 XML, JSON，HTML 表单获取的数据或其他同样简单的序列化数据进行验证和反序列化的系统。[官网](http://docs.pylonsproject.org/projects/colander/en/latest/)
* kmatch：一种用于匹配/验证/筛选 Python 字典的语言。[官网](https://github.com/ambitioninc/kmatch)
* schema：一个用于对 Python 数据结构进行验证的库。[官网](https://github.com/keleshev/schema)
* Schematics：数据结构验证。[官网](https://github.com/schematics/schematics)
* valideer：轻量级可扩展的数据验证和适配库。[官网](https://github.com/podio/valideer)
* voluptuous：一个 Python 数据验证库。主要是为了验证传入 Python的 JSON，YAML 等数据。[官网](https://github.com/alecthomas/voluptuous)

## 反垃圾技术

帮助你和电子垃圾进行战斗的库。

* django-simple-captcha：一个简单、高度可定制的Django 应用，可以为任何Django表单添加验证码。[官网](https://github.com/mbi/django-simple-captcha)
* django-simple-spam-blocker：一个用于Django的简单的电子垃圾屏蔽工具。[官网](https://github.com/moqada/django-simple-spam-blocker)

## 标记

用来进行标记的库。

* django-taggit：简单的 Django 标记工具。[官网](https://github.com/alex/django-taggit)

## 管理面板

管理界面库。

* Ajenti：一个你的服务器值得拥有的管理面板。[官网](https://github.com/Eugeny/ajenti)
* django-suit：Django 管理界面的一个替代品 (仅对于非商业用途是免费的)。[官网](http://djangosuit.com/)
* django-xadmin：Django admin 的一个替代品，具有很多不错的功能。[官网](https://github.com/sshwsfc/django-xadmin)
* flask-admin：一个用于 Flask 的简单可扩展的管理界面框架。[官网](https://github.com/flask-admin/flask-admin)
* flower：一个对 Celery 集群进行实时监控和提供 web 管理界面的工具。[官网](https://github.com/mher/flower)
* Grappelli：Django 管理界面的一个漂亮的皮肤。[官网](http://grappelliproject.com/)
* Wooey：一个 Django 应用，可以为 Python 脚本创建 web 用户界面。[官网](https://github.com/wooey/wooey)

## 静态站点生成器

静态站点生成器是一个软件，它把文本和模板作为输入，然后输出HTML文件。

* Pelican：使用 Markdown 或 ReST 来处理内容， Jinja 2 来制作主题。支持 DVCS, Disqus.。AGPL 许可。[官网](http://blog.getpelican.com/)
* Cactus：为设计师设计的静态站点生成器。[官网](https://github.com/koenbok/Cactus/)
* Hyde：基于 Jinja2 的静态站点生成器。[官网](http://hyde.github.io/)
* Nikola：一个静态网站和博客生成器。[官网](https://www.getnikola.com/)
* Tinkerer：Tinkerer 是一个博客引擎/静态站点生成器，由Sphinx驱动。[官网](http://tinkerer.me/)
* Lektor：一个简单易用的静态 CMS 和博客引擎。[官网](https://www.getlektor.com/)

## 进程

操作系统进程启动及通信库。

* envoy：比 Python [subprocess](https://docs.python.org/2/library/subprocess.html) 模块更人性化。[官网](https://github.com/kennethreitz/envoy)
* sarge：另一 种 subprocess 模块的封装。[官网](http://sarge.readthedocs.org/en/latest/)
* [amoffat/sh](https://github.com/amoffat/sh)：一个完备的 subprocess 替代库。Python process launching <http://amoffat.github.com/sh>

## 并发和并行

用以进行并发和并行操作的库。

* multiprocessing：(Python 标准库) 基于进程的"线程"接口。[官网](https://docs.python.org/2/library/multiprocessing.html)
* threading：(Python 标准库)更高层的线程接口。[官网](https://docs.python.org/2/library/threading.html)
* eventlet：支持 WSGI 的异步框架。[官网](http://eventlet.net/)
* [gevent/gevent](https://github.com/python-greenlet/greenlet)：Coroutine-based concurrency library for Python <http://gevent.org>
* Tomorrow：用于产生异步代码的神奇的装饰器语法实现。[官网](https://github.com/madisonmay/Tomorrow)
* uvloop：在libuv之上超快速实现asyncio事件循环。[官网](https://github.com/MagicStack/uvloop)
* [ray-project/ray](https://github.com/ray-project/ray):A high-performance distributed execution engine

## 网络

用于网络编程的库。

* asyncio：(Python 标准库) 异步 I/O, 事件循环, 协程以及任务。[官网](https://docs.python.org/3/library/asyncio.html)
* [Twisted](http://hao.jobbole.com/twisted/)：一个事件驱动的网络引擎。[官网](https://twistedmatrix.com/trac/)
* pulsar：事件驱动的并发框架。[官网](https://github.com/quantmind/pulsar)
* diesel：基于Greenlet 的事件 I/O 框架。[官网](https://github.com/dieseldev/diesel)
* pyzmq：一个 ZeroMQ 消息库的 Python 封装。[官网](http://zeromq.github.io/pyzmq/)
* txZMQ：基于 Twisted 的 ZeroMQ 消息库的 Python 封装。[官网](https://github.com/smira/txZMQ)

## WebSocket

帮助使用WebSocket的库。

* AutobahnPython：给 Python 、使用的 WebSocket & WAMP 基于 Twisted 和 [asyncio](https://docs.python.org/3/library/asyncio.html)。[官网](https://github.com/crossbario/autobahn-python)
* Crossbar：开源统一应用路由(Websocket & WAMP for Python on Autobahn).[官网](https://github.com/crossbario/crossbar/)
* django-socketio：给 Django 用的 WebSockets。[官网](https://github.com/stephenmcd/django-socketio)
* WebSocket-for-Python：为Python2/3 以及 PyPy 编写的 WebSocket 客户端和服务器库。[官网](https://github.com/Lawouach/WebSocket-for-Python)

## WSGI 服务器

兼容 WSGI 的 web 服务器

* gunicorn：Pre-forked, 部分是由 C 语言编写的。[官网](https://pypi.python.org/pypi/gunicorn)
* uwsgi：uwsgi 项目的目的是开发一组全栈工具，用来建立托管服务， 由 C 语言编写。[官网](https://uwsgi-docs.readthedocs.org/en/latest/)
* [bjoern](http://hao.jobbole.com/bjoern/)：异步，非常快速，由 C 语言编写。[官网](https://pypi.python.org/pypi/bjoern)
* fapws3：异步 (仅对于网络端)，由 C 语言编写。[官网](http://www.fapws.org/)
* meinheld：异步，部分是由 C 语言编写的。[官网](https://pypi.python.org/pypi/meinheld)
* netius：异步，非常快速。[官网](https://github.com/hivesolutions/netius)
* paste：多线程，稳定，久经考验。[官网](http://pythonpaste.org/)
* rocket：多线程。[官网](https://pypi.python.org/pypi/rocket)
* waitress：多线程, 是它驱动着 Pyramid 框架。[官网](https://waitress.readthedocs.org/en/latest/)
* Werkzeug：一个 WSGI 工具库，驱动着 Flask ，而且可以很方便大嵌入到你的项目中去。[官网](http://werkzeug.pocoo.org/)

## RPC 服务器

兼容 RPC 的服务器。

* SimpleJSONRPCServer：这个库是 JSON-RPC 规范的一个实现。[官网](https://github.com/joshmarshall/jsonrpclib/)
* SimpleXMLRPCServer：(Python 标准库) 简单的 XML-RPC 服务器实现，单线程。[官网](https://docs.python.org/2/library/simplexmlrpcserver.html)
* zeroRPC：zerorpc 是一个灵活的 RPC 实现，基于 ZeroMQ 和 MessagePack。[官网](https://github.com/0rpc/zerorpc-python)

## 密码学

* cryptography：这个软件包意在提供密码学基本内容和方法提供给 Python 开发者。[官网](https://cryptography.io/en/latest/)
* hashids：在 Python 中实现 [hashids](http://hashids.org/) 。[官网](https://github.com/davidaurelio/hashids-python)
* Paramiko：SSHv2 协议的 Python (2.6+, 3.3+) ，提供客户端和服务端的功能。[官网](http://www.paramiko.org/)
* Passlib：安全密码存储／哈希库，[官网](https://pythonhosted.org/passlib/)
* PyCrypto：Python 密码学工具箱。[官网](https://www.dlitz.net/software/pycrypto/)
* PyNacl：网络和密码学(NaCl) 库的 Python 绑定。[官网](https://github.com/pyca/pynacl)

## 图形用户界面

用来创建图形用户界面程序的库。

* curses：内建的 [ncurses](http://www.gnu.org/software/ncurses/) 封装，用来创建终端图形用户界面。[官网](https://docs.python.org/2/library/curses.html#module-curses)
* enaml：使用类似 QML 的Declaratic语法来创建美观的用户界面。[官网](https://github.com/nucleic/enaml)
* [kivy](http://hao.jobbole.com/kivy/)：一个用来创建自然用户交互（NUI）应用程序的库，可以运行在 Windows, Linux, Mac OS X, Android 以及 iOS平台上。[官网](https://kivy.org/)
* pyglet：一个Python 的跨平台窗口及多媒体库。[官网](https://bitbucket.org/pyglet/pyglet/wiki/Home)
* PyQt：跨平台用户界面框架 [Qt](http://www.qt.io/) 的 Python 绑定 ，支持Qt v4 和 Qt v5。[官网](https://riverbankcomputing.com/software/pyqt/intro)
* PySide：P跨平台用户界面框架 [Qt](http://www.qt.io/) 的 Python 绑定 ，支持Qt v4。[官网](https://wiki.qt.io/PySide)
* Tkinter：Tkinter 是 Python GUI 的一个事实标准库。[官网](https://wiki.python.org/moin/TkInter)
* Toga：一个 Python 原生的, 操作系统原生的 GUI工具包。[官网](https://github.com/pybee/toga)
* urwid：一个用来创建终端 GUI 应用的库，支持组件，事件和丰富的色彩等。[官网](http://urwid.org/)
* wxPython：wxPython 是 wxWidgets C++ 类库和 Python 语言混合的产物。[官网](http://wxpython.org/)
* PyGObject：GLib/GObject/GIO/GTK+ (GTK+3) 的 Python 绑定[官网](https://wiki.gnome.org/Projects/PyGObject)
* Flexx：Flexx 是一个纯 Python 语言编写的用来创建 GUI 程序的工具集，它使用 web 技术进行界面的展示。[官网](https://github.com/zoofIO/flexx)
* CEF Python:基于Google Chromium。其主要用于在第三方应用程序中嵌入式浏览器的使用上。
* Dabo:底层框架是WxPython。这是一个三层框架。总的来说，Dabo是一个跨平台的应用程序开发框架。
* Pyforms:用于开发GUI应用程序的Python 2.7/ 3.x多运行环境框架
* PyGUI:尽可能轻松地融入Python生态系统。
* libavg:以Python语言内置变量类型显示元素,事件处理系统,计时器,支持日志
* PyGTK | PyGObject

## 游戏开发

超赞的游戏开发库。

* Cocos2d：cocos2d 是一个用来开发 2D 游戏， 示例和其他图形/交互应用的框架。基于 pyglet。[官网](http://cocos2d.org/)
* Panda3D：由迪士尼开发的 3D 游戏引擎，并由卡内基梅陇娱乐技术中心负责维护。使用C++编写, 针对 Python 进行了完全的封装。[官网](https://www.panda3d.org/)
* Pygame：Pygame 是一组 Python 模块，用来编写游戏。[官网](http://www.pygame.org/news.html)
* PyOgre：Ogre 3D 渲染引擎的 Python 绑定，可以用来开发游戏和仿真程序等任何 3D 应用。[官网](http://www.ogre3d.org/tikiwiki/PyOgre)
* PyOpenGL：OpenGL 的 Python 绑定及其相关 APIs。[官网](http://pyopengl.sourceforge.net/)
* PySDL2：SDL2 库的封装，基于 ctypes。[官网](http://pysdl2.readthedocs.org/en/latest/)
* RenPy：一个视觉小说（visual novel）引擎。[官网](https://www.renpy.org/)

## 日志

用来生成和操作日志的库。

* logging：(Python 标准库) 为 Python 提供日志功能。[官网](https://docs.python.org/2/library/logging.html)
* logbook：Logging 库的替代品。[官网](http://pythonhosted.org/Logbook/)
* Eliot：为复杂的和分布式系统创建日志。[官网](https://eliot.readthedocs.org/en/latest/)
* Raven：Sentry的 Python 客户端。[官网](http://raven.readthedocs.org/en/latest/)
* Sentry：实时记录和收集日志的服务器。[官网](https://pypi.python.org/pypi/sentry)

## Testing

进行代码库测试和生成测试数据的库。

* 测试框架
  - [unittest](https://docs.python.org/2/library/unittest.html)：(Python 标准库) 单元测试框架。
  - [nose](https://nose.readthedocs.org/en/latest/) 扩展了 unittest 的功能。
  - contexts：一个 Python 3.3+ 的 BDD 框架。受到C# – Machine.Specifications的启发。[官网](https://github.com/benjamin-hodgson/Contexts)
  - hypothesis：Hypothesis 是一个基于先进的 Quickcheck 风格特性的测试库。[官网](https://github.com/DRMacIver/hypothesis)
  - mamba：Python 的终极测试工具， 拥护BDD。[官网](http://nestorsalceda.github.io/mamba/)
  - PyAutoGUI：PyAutoGUI 是一个人性化的跨平台 GUI 自动测试模块。[官网](https://github.com/asweigart/pyautogui)
  - pyshould：Should 风格的断言，基于 [PyHamcrest](https://github.com/hamcrest/PyHamcrest)。[官网](https://github.com/drslump/pyshould)
  - pytest：一个成熟的全功能 Python 测试工具。[官网](http://pytest.org/latest/)
  - green：干净，多彩的测试工具。[官网](https://github.com/CleanCut/green)
  - pyvows：BDD 风格的测试工具，受Vows.js的启发。[官网](http://heynemann.github.io/pyvows/)-
  - Robot Framework：一个通用的自动化测试框架。[官网](https://github.com/robotframework/robotframework)
  - [RedwoodHQ]()
* Web 测试
  - Selenium：[Selenium](http://www.seleniumhq.org/) WebDriver 的 Python 绑定。[官网](https://pypi.python.org/pypi/selenium)
  - locust：使用 Python 编写的，可扩展的用户加载测试工具。[官网](https://github.com/locustio/locust)
  - sixpack：一个和语言无关的 A/B 测试框架。[官网](https://github.com/seatgeek/sixpack)
  - splinter：开源的 web 应用测试工具。[官网](https://splinter.readthedocs.org/en/latest/)
* Mock测试
  - mock：(Python 标准库) 一个用于伪造测试的库。[官网](https://docs.python.org/3/library/unittest.mock.html)
  - doublex：Python 的一个功能强大的 doubles 测试框架。[官网](https://pypi.python.org/pypi/doublex)
  - freezegun：通过伪造日期模块来生成不同的时间。[官网](https://github.com/spulec/freezegun)
  - httmock：针对 Python 2.6+ 和 3.2+ 生成 伪造请求的库。[官网](https://github.com/patrys/httmock)
  - httpretty：Python 的 HTTP 请求 mock 工具。[官网](http://falcao.it/HTTPretty/)
  - [getsentry/responses](https://github.com/getsentry/responses)：utility for mocking out the Python Requests library.
  - [VCR.py](https://github.com/kevin1024/vcrpy)：在测试中记录和重放 HTTP 交互。
* 对象工厂
  - factoryboy：一个 Python 用的测试固件 (test fixtures) 替代库。[官网](https://github.com/rbarrois/factoryboy)
  - mixer：另外一个测试固件 (test fixtures) 替代库，支持 Django, Flask, SQLAlchemy, Peewee 等。[官网](https://github.com/klen/mixer)
  - modelmommy：为 Django 测试创建随机固件[官网](https://github.com/vandersonmota/modelmommy)
* 代码覆盖率
  - coverage：代码覆盖率测量。[官网](https://pypi.python.org/pypi/coverage)
* 伪数据
  - [joke2k/faker](http://www.joke2k.net/faker/):Faker is a Python package that generates fake data for you. <http://faker.rtfd.org>
  - fake2db：伪数据库生成器。[官网](https://github.com/emirozer/fake2db)
  - radar：生成随机的日期/时间。[官网](https://pypi.python.org/pypi/radar)
* 错误处理
  - [FuckIt.py](https://github.com/ajalt/fuckitpy)：FuckIt.py 使用最先进的技术来保证你的 Python 代码无论对错都能继续运行。
* 自动化
  - [theacodes / nox](https://github.com/theacodes/nox):Flexible test automation for Python <https://nox.thea.codes>
  - [tox-dev/tox](https://github.com/tox-dev/tox):Command line driven CI frontend and development task automation tool <https://tox.readthedocs.io>
  - [pyinvoke / invoke](https://github.com/pyinvoke/invoke):Pythonic task management & command execution. <http://pyinvoke.org>

## 代码分析和Lint工具

进行代码分析，解析和操作代码库的库和工具。

* 代码分析
  - coala：语言独立和易于扩展的代码分析应用程序。[官网](http://coala-analyzer.org/)
  - code2flow：把你的 Python 和 JavaScript 代码转换为流程图。[官网](https://github.com/scottrogowski/code2flow)
  - [pycallgraph](https://github.com/gak/pycallgraph)：这个库可以把你的Python 应用的流程(调用图)进行可视化
  - pysonar2：Python 类型推断和检索工具。[官网](https://github.com/yinwang0/pysonar2)
* Lint工具
  - Flake8：模块化源码检查工具: pep8, pyflakes 以及 co。[官网](https://pypi.python.org/pypi/flake8)
  - [Pylint](https://www.pylint.org/)：一个完全可定制的源码分析器 `sudo apt-get install pylint`
  - pylama：Python 和 JavaScript 的代码审查工具。[官网](https://pylama.readthedocs.org/en/latest/)
* 代码格式化
  - [autopep8](https://github.com/hhatto/autopep8)：自动格式化 Python 代码，以使其符合 PEP8 规范。
  - [psf / black](https://github.com/psf/black):The uncompromising Python code formatter <https://black.readthedocs.io/en/stable/>
* 代码质量
  - Codacy：自动化代码审查，更加快速的发布高质量代码。对于开源项目是免费的。[官网](https://www.codacy.com/)
  - QuantifiedCode：一个数据驱动、自动、持续的代码审查工具。[官网](https://www.quantifiedcode.com/)

## Debugging Tools

用来进行代码调试的库。

* 调试器
  - ipdb：IPython 启用的 [pdb](https://docs.python.org/2/library/pdb.html)。[官网](https://pypi.python.org/pypi/ipdb)
  - pudb：全屏，基于控制台的 Python 调试器。[官网](https://pypi.python.org/pypi/pudb)
  - pyringe：可以在 Python 进程中附加和注入代码的调试器。[官网](https://github.com/google/pyringe)
  - wdb：一个奇异的 web 调试器，通过 WebSockets 工作。[官网](https://github.com/Kozea/wdb)
  - winpdb：一个具有图形用户界面的 Python 调试器，可以进行远程调试，基于 rpdb2。[官网](http://winpdb.org/)
  - django-debug-toolbar：为 Django 显示各种调试信息。[官网](https://github.com/django-debug-toolbar/django-debug-toolbar)
  - django-devserver：一个 Django 运行服务器的替代品。[官网](https://github.com/dcramer/django-devserver)
  - flask-debugtoolbar：django-debug-toolbar 的 flask 版。[官网](https://github.com/mgood/flask-debugtoolbar)
* 性能分析器
  - lineprofiler：逐行性能分析。[官网](https://github.com/rkern/lineprofiler)
  - [Memory Profiler](http://hao.jobbole.com/memory_profiler/)：监控 Python 代码的内存使用。[官网](http://pypi.python.org/pypi/memory_profiler)、[内存](https://github.com/fabianp/memoryprofiler)
  - [what-studio/profiling](https://github.com/what-studio/profiling)：一个交互式 Python 性能分析工具。
* 其他
  - pyelftools：解析和分析 ELF 文件以及 DWARF 调试信息。[官网](https://github.com/eliben/pyelftools)
  - python-statsd：[statsd](https://github.com/etsy/statsd/) 服务器的 Python 客户端。[官网](https://github.com/WoLpH/python-statsd)

## Science and Data Analysis

用来进行科学计算和数据分析的库。

* astropy：一个天文学 Python 库。[官网](http://www.astropy.org/)
* [bcbio-nextgen](http://hao.jobbole.com/bcbio-nextgen/)：这个工具箱为全自动高通量测序分析提供符合最佳实践的处理流程。[官网](https://github.com/chapmanb/bcbio-nextgen)
* bccb：生物分析相关代码集合[官网](https://github.com/chapmanb/bcbb)
* Biopython：Biopython 是一组可以免费使用的用来进行生物计算的工具。[官网](http://biopython.org/wiki/MainPage)
* [blaze](http://hao.jobbole.com/blaze/)：NumPy 和 Pandas 的大数据接口。[官网](http://blaze.readthedocs.org/en/latest/index.html)
* [cclib](http://hao.jobbole.com/cclib/)：一个用来解析和解释计算化学软件包输出结果的库。[官网](http://cclib.github.io/)
* NetworkX：一个为复杂网络设计的高性能软件。[官网](https://networkx.github.io/)
* Neupy：执行和测试各种不同的人工神经网络算法。[官网](http://neupy.com/pages/home.html)
* Numba：Python JIT (just in time) 编译器，针对科学用的 Python ，由Cython 和 NumPy 的开发者开发。[官网](http://numba.pydata.org/)
* [NumPy](http://hao.jobbole.com/numpy/)：使用 Python 进行科学计算的基础包。[官网](http://www.numpy.org/)
* Open Babel：一个化学工具箱，用来描述多种化学数据。[官网](http://openbabel.org/wiki/MainPage)
* [Open Mining](http://hao.jobbole.com/open-mining/)：使用 Python 挖掘商业情报 (BI) (Pandas web 接口)。[官网](https://github.com/mining/mining)
* [orange](http://hao.jobbole.com/orange/)：通过可视化编程或 Python 脚本进行数据挖掘，数据可视化，分析和机器学习。[官网](http://orange.biolab.si/)
* Pandas：提供高性能，易用的数据结构和数据分析工具。[官网](http://pandas.pydata.org/)
* PyDy：PyDy 是 Python Dynamics 的缩写，用来为动力学运动建模工作流程提供帮助， 基于 NumPy, SciPy, IPython 和 matplotlib。[官网](http://www.pydy.org/)
* [PyMC](http://hao.jobbole.com/pymc/)：马尔科夫链蒙特卡洛采样工具。[官网](https://github.com/pymc-devs/pymc3)
* RDKit：化学信息学和机器学习软件。[官网](http://www.rdkit.org/)
* [SciPy](http://hao.jobbole.com/scipy/)：由一些基于 Python ，用于数学，科学和工程的开源软件构成的生态系统。[官网](http://www.scipy.org/)
* [statsmodels](http://hao.jobbole.com/statsmodels/)：统计建模和计量经济学。[官网](https://github.com/statsmodels/statsmodels)
* SymPy：一个用于符号数学的 Python 库。[官网](https://github.com/sympy/sympy)
* zipline：一个 Python 算法交易库。[官网](https://github.com/quantopian/zipline)
* [Bayesian-belief-networks](http://hao.jobbole.com/bayesian-belief-networks/)：优雅的贝叶斯信念网络框架。[官网](https://github.com/eBay/bayesian-belief-networks)
* PyFlux：一个专门为时间序列而开发的 Python开源库
* [sympy/sympy](https://github.com/sympy/sympy):A computer algebra system written in pure Python <https://sympy.org/>

## 数据可视化

* matplotlib：一个 Python 2D 绘图库。[官网](http://matplotlib.org/)
* bokeh：用 Python 进行交互式 web 绘图。[官网](https://github.com/bokeh/bokeh)
* ggplot：ggplot2 给 R 提供的 API 的 Python 版本。[官网](https://github.com/yhat/ggplot)
* plotly：协同 Python 和 matplotlib 工作的 web 绘图库。[官网](https://plot.ly/python/)
* pygal：一个 Python SVG 图表创建工具。[官网](http://www.pygal.org/en/latest/)
* pygraphviz：Graphviz 的 Python 接口。[官网](https://pypi.python.org/pypi/pygraphviz)
* PyQtGraph：交互式实时2D/3D/图像绘制及科学/工程学组件。[官网](http://www.pyqtgraph.org/)
* SnakeViz：一个基于浏览器的 Python's cProfile 模块输出结果查看工具。[官网](http://jiffyclub.github.io/snakeviz/)
* vincent：把 Python 转换为 Vega 语法的转换工具。[官网](https://github.com/wrobstory/vincent)
* VisPy：基于 OpenGL 的高性能科学可视化工具。[官网](http://vispy.org/)
* [Seaborn](https://seaborn.pydata.org/):基于 matplotlib 库的高级 API
* Dash近：一个用于构建Web应用程序的开源库，尤其是在纯Python语言中利用数据可视化的Web应用程序。它建立在Flask，Plotly.js和React 之上，并提供了接口

## 计算机视觉

计算机视觉库。

* OpenCV：开源计算机视觉库。[官网](http://opencv.org/)
* pyocr：Tesseract和Cuneiform的包装库。[官网](https://github.com/jflesch/pyocr)
* pytesseract：[Google Tesseract OCR](https://github.com/tesseract-ocr)的另一包装库。[官网](https://github.com/madmaze/pytesseract)
* [SimpleCV](http://hao.jobbole.com/simplecv/)：一个用来创建计算机视觉应用的开源框架。[官网](http://simplecv.org/)

## 机器学习

机器学习库。 参见: [awesome-machine-learning](https://github.com/josephmisiti/awesome-machine-learning#python).

* Crab：灵活、快速的推荐引擎。[官网](https://github.com/muricoca/crab)
* gensim：人性化的话题建模库。[官网](https://github.com/piskvorky/gensim)
* hebel：GPU 加速的深度学习库。[官网](https://github.com/hannes-brt/hebel)
* NuPIC：智能计算 Numenta 平台。[官网](https://github.com/numenta/nupic)
* pattern：Python 网络挖掘模块。[官网](https://github.com/clips/pattern)
* [PyBrain](http://hao.jobbole.com/pybrain/)：另一个 Python 机器学习库。[官网](https://github.com/pybrain/pybrain)
* [Pylearn2](http://hao.jobbole.com/pylearn2/)：一个基于 [Theano](https://github.com/Theano/Theano) 的机器学习库。[官网](https://github.com/lisa-lab/pylearn2)
* [python-recsys](http://hao.jobbole.com/python-recsys/)：一个用来实现推荐系统的 Python 库。[官网](https://github.com/ocelma/python-recsys)
* scikit-learn：基于 SciPy 构建的机器学习 Python 模块。[官网](http://scikit-learn.org/)
* pydeep：Python 深度学习库。[官网](https://github.com/andersbll/deeppy)
* vowpalporpoise：轻量级 [Vowpal Wabbit](https://github.com/JohnLangford/vowpalwabbit/) 的 Python 封装。[官网](https://github.com/josephreisinger/vowpalporpoise)
* skflow：一个 [TensorFlow](https://github.com/tensorflow/tensorflow) 的简化接口(模仿 scikit-learn)。[官网](https://github.com/tensorflow/skflow)

## 深度学习

* [TensorFlow](https://www.tensorflow.org/)
* [PyTorch](https://pytorch.org/)：更适合研究
* 分布式
  - [Dist-keras](http://joerihermans.com/work/distributed-keras/)
  - [elephas](https://pypi.org/project/elephas/)
  - [spark-deep-learnin](https://databricks.github.io/spark-deep-learning/site/index.html)
* Caffe2：支持分布式训练、部署，支持最新的CPU和CUDA的硬件，适合大规模部署
* skorch：一个封装，可以通过类似sklearn的接口提供PyTorch编程

## MapReduce

MapReduce 框架和库。

* [dpark](http://hao.jobbole.com/dpark/)：Spark 的 Python 克隆版，一个类似 MapReduce 的框架。[官网](https://github.com/douban/dpark)
* dumbo：这个 Python 模块可以让人轻松的编写和运行 Hadoop 程序。[官网](https://github.com/klbostee/dumbo)
* luigi：这个模块帮你构建批处理作业的复杂流水线。[官网](https://github.com/spotify/luigi)
* mrjob：在 Hadoop 或 Amazon Web Services 上运行 MapReduce 任务。[官网](https://github.com/Yelp/mrjob)
* PySpark：Spark 的 Python API 。[官网](http://spark.apache.org/docs/latest/programming-guide.html)
* streamparse：运行针对事实数据流的 Python 代码。集成了[Apache Storm](http://storm.apache.org/)。[官网](https://github.com/Parsely/streamparse)

## 函数式编程

使用 Python 进行函数式编程。

* CyToolz：Toolz 的 Cython 实现 : 高性能函数式工具。[官网](https://github.com/pytoolz/cytoolz/)
* fn.py：在 Python 中进行函数式编程 : 实现了一些享受函数式编程缺失的功能。[官网](https://github.com/kachayev/fn.py)
* funcy：炫酷又实用的函数式工具。[官网](https://github.com/Suor/funcy)
* Toolz：一组用于迭代器，函数和字典的函数式编程工具。[官网](https://github.com/pytoolz/toolz)
* [evhub/coconut](https://github.com/evhub/coconut):Simple, elegant, Pythonic functional programming. <http://coconut-lang.org>

## 第三方 API

用来访问第三方 API的库。 参见： [List of Python API Wrappers and Libraries](https://github.com/realpython/list-of-python-api-wrappers)。

* apache-libcloud：一个为各种云设计的 Python 库。[官网](https://libcloud.apache.org/)
* boto：Amazon Web Services 的 Python 接口。[官网](https://github.com/boto/boto)
* django-wordpress：WordPress models and views for Django.[官网](https://github.com/sunlightlabs/django-wordpress/)
* facebook-sdk：Facebook 平台的 Python SDK.[官网](https://github.com/mobolic/facebook-sdk)
* facepy：Facepy 让和 Facebook's Graph API 的交互变得更容易。[官网](https://github.com/jgorset/facepy)
* gmail：Gmail 的 Python 接口。[官网](https://github.com/charlierguo/gmail)
* google-api-python-client：Python 用的 Google APIs 客户端库。[官网](https://github.com/google/google-api-python-client)
* gspread：Google 电子表格的 Python API.[官网](https://github.com/burnash/gspread)
* twython：Twitter API 的封装。[官网](https://github.com/ryanmcgrath/twython)

## DevOps 工具

用于 DevOps 的软件和库。

* [Ansible](https://github.com/ansible/ansible)：一个非常简单的 IT 自动化平台。
* [SaltStack](https://github.com/saltstack/salt)：基础设施自动化和管理系统。
* [OpenStack](http://www.openstack.org/)：用于构建私有和公有云的开源软件。
* [Docker Compose](https://docs.docker.com/compose/)：快速，分离的开发环境，使用 Docker。
* [Fabric](http://www.fabfile.org/)：一个简单的，Python 风格的工具，用来进行远程执行和部署。
* [cuisine](https://github.com/sebastien/cuisine)：为 Fabric 提供一系列高级函数。
* [Fabtools](https://github.com/ronnix/fabtools)：一个用来编写超赞的 Fabric 文件的工具。
* [gitapi](https://bitbucket.org/haard/gitapi)：Git 的纯 Python API。
* [hgapi](https://bitbucket.org/haard/hgapi)：Mercurial 的纯 Python API。
* [honcho](https://github.com/nickstenning/honcho)：[Foreman](https://github.com/ddollar/foreman)的 Python 克隆版，用来管理基于[Procfile](https://devcenter.heroku.com/articles/procfile)的应用。
* [pexpect](https://github.com/pexpect/pexpect)：Controlling interactive programs in a pseudo-terminal like 在一个伪终端中控制交互程序，就像 GNU expect 一样。
* [giampaolo/psutil](https://github.com/giampaolo/psutil)：一个跨平台进程和系统工具模块。
* [supervisor](https://github.com/Supervisor/supervisor)：UNIX 的进程控制系统。

## 任务调度

任务调度库。

* APScheduler：轻巧但强大的进程内任务调度，使你可以调度函数。[官网](http://apscheduler.readthedocs.org/en/latest/)
* django-schedule：一个 Django 排程应用。[官网](https://github.com/thauber/django-schedule)
* doit：一个任务执行和构建工具。[官网](http://pydoit.org/)
* gunnery：分布式系统使用的多用途任务执行工具 ，具有 web 交互界面。[官网](https://github.com/gunnery/gunnery)
* Joblib：一组为 Python 提供轻量级作业流水线的工具。[官网](http://pythonhosted.org/joblib/index.html)
* Plan：如有神助地编写 crontab 文件。[官网](https://github.com/fengsp/plan)
* schedule：人性化的 Python 任务调度库。[官网](https://github.com/dbader/schedule)
* Spiff：使用纯 Python 实现的强大的工作流引擎。[官网](https://github.com/knipknap/SpiffWorkflow)
* TaskFlow：一个可以让你方便执行任务的 Python 库，一致并且可靠。[官网](http://docs.openstack.org/developer/taskflow/)
* [invoke](https://github.com/pyinvoke/invoke):Pythonic task management & command execution. <http://pyinvoke.org>

## 外来函数接口

使用外来函数接口的库。

* cffi：用来调用 C 代码的外来函数接口。[官网](https://pypi.python.org/pypi/cffi)
* [ctypes](http://hao.jobbole.com/ctypes/)：(Python 标准库) 用来调用 C 代码的外来函数接口。[官网](https://docs.python.org/2/library/ctypes.html)
* PyCUDA：Nvidia CUDA API 的封装。[官网](https://mathema.tician.de/software/pycuda/)
* SWIG：简化的封装和接口生成器。[官网](http://www.swig.org/Doc1.3/Python.html)

## 高性能

让 Python 更快的库。

* Cython：优化的 Python 静态编译器。使用类型混合使 Python 编译成 C 或 C++ 模块来获得性能的极大提升。[官网](http://cython.org/)
* PeachPy：嵌入 Python 的 x86-64 汇编器。可以被用作 Python 内联的汇编器或者是独立的汇编器，用于 Windows, Linux, OS X, Native Client 或者 Go 。[官网](https://github.com/Maratyszcza/PeachPy)
* [PyPy](https://pypy.org)：使用 Python 实现的 Python。解释器使用黑魔法加快 Python 运行速度且不需要加入额外的类型信息。[官网](http://pypy.org/)
* [Pyston](http://hao.jobbole.com/pyston-llvm-jit/)：使用 LLVM 和现代 JIT 技术构建的 Python 实现，目标是为了获得很好的性能。[官网](https://github.com/dropbox/pyston)
* Stackless Python：一个强化版的 Python。[官网](https://bitbucket.org/stackless-dev/stackless/overview)

## 微软的 Windows平台

在 Windows 平台上进行 Python 编程。

* Python(x,y)：面向科学应用的 Python 发行版，基于 Qt 和 Spyder。[官网](http://python-xy.github.io/)
* pythonlibs：非官方的 Windows 平台 Python 扩展二进制包。[官网](http://www.lfd.uci.edu/~gohlke/pythonlibs/)
* PythonNet：Python 与 .NET 公共语言运行库 (CLR)的集成。[官网](https://github.com/pythonnet/pythonnet)
* PyWin32：针对 Windows 的Python 扩展。[官网](https://sourceforge.net/projects/pywin32/)
* WinPython：Windows 7/8 系统下便携式开发环境。[官网](https://winpython.github.io/)

## 网络可视化和SDN

用来进行网络可视化和SDN(软件定义网络)的工具和库。

* Mininet：一款流行的网络模拟器以及用 Python 编写的 API。[官网](http://mininet.org/)
* POX：一个针对基于 Python 的软件定义网络应用（例如 OpenFlow SDN 控制器）的开源开发平台。[官网](https://github.com/noxrepo/pox)
* Pyretic：火热的 SDN 编程语言中的一员，为网络交换机和模拟器提供强大的抽象能力。[官网](http://frenetic-lang.org/pyretic/)
* SDX Platform：基于 SDN 的 IXP 实现，影响了 Mininet, POX 和 Pyretic。[官网](https://github.com/sdn-ixp/internet2award)
* [IPy](http://github.com/haypo/python-ipy):辅助IP规划
* [dnspython](http://dnspython.org):Python实现的一个DNS工具包

## 硬件

用来对硬件进行编程的库。

* ino：操作[Arduino](https://www.arduino.cc/)的命令行工具。[官网](http://inotool.org/)
* Pyro：Python 机器人编程库。[官网](http://pyrorobotics.com/)
* PyUserInput：跨平台的，控制鼠标和键盘的模块。[官网](https://github.com/SavinaRoja/PyUserInput)
* [secdev/scapy](https://github.com/secdev/scapy)：Scapy: the Python-based interactive packet manipulation program & library. Supports Python 2 & Python 3. <https://scapy.net>
* wifi：一个 Python 库和命令行工具用来在 Linux 平台上操作WiFi。[官网](https://wifi.readthedocs.org/en/latest/)
* Pingo：Pingo 为类似Raspberry Pi，pcDuino， Intel Galileo等设备提供统一的API用以编程。[官网](http://www.pingo.io/)

## 兼容性

帮助从 Python 2 向 Python 3迁移的库。

* Python-Future：这就是 Python 2 和 Python 3 之间丢失的那个兼容性层。[官网](http://python-future.org/index.html)
* Python-Modernize：使 Python 代码更加现代化以便最终迁移到 Python 3。[官网](https://github.com/mitsuhiko/python-modernize)
* Six：Python 2 和 3 的兼容性工具。[官网](https://pypi.python.org/pypi/six)

## 杂项

不属于上面任何一个类别，但是非常有用的库。

* blinker：一个快速的 Python 进程内信号/事件分发系统。[官网](https://github.com/jek/blinker)
* itsdangerous：一系列辅助工具用来将可信的数据传入不可信的环境。[官网](https://github.com/pallets/itsdangerous)
* pluginbase：一个简单但是非常灵活的 Python 插件系统。[官网](https://github.com/mitsuhiko/pluginbase)
* Pychievements：一个用来创建和追踪成就的 Python 框架。[官网](https://github.com/PacketPerception/pychievements)
* [Tryton](http://hao.jobbole.com/tryton/)：一个通用商务框架。[官网](http://www.tryton.org/)

## 算法和设计模式

Python 实现的算法和设计模式。

* [algorithms](https://github.com/nryoung/algorithms)：一个 Python 算法模块。
* [python-patterns](https://github.com/faif/python-patterns)：Python 设计模式的集合。
* [sortedcontainers](http://www.grantjenks.com/docs/sortedcontainers/)：快速，纯 Python 实现的SortedList，SortedDict 和 SortedSet 类型。

## 编辑器插件

* Emacs
  - Elpy：Emacs Python 开发环境。[官网](https://github.com/jorgenschaefer/elpy)
* Sublime Text
  - SublimeJEDI：一个 Sublime Text 插件，用来使用超赞的自动补全库 Jedi。[官网](https://github.com/srusskih/SublimeJEDI)
  - Anaconda：Anaconda 把你的 Sublime Text 3 变成一个功能齐全的 Python IDE。[官网](https://github.com/DamnWidget/anaconda)
* Vim
  - [YouCompleteMe](http://hao.jobbole.com/youcompleteme/)：引入基于 [Jedi](https://github.com/davidhalter/jedi) 的 Python 自动补全引擎。[官网](https://github.com/Valloric/YouCompleteMe)
  - Jedi-vim：绑定 Vim 和 Jedi 自动补全库对 Python 进行自动补全。[官网](https://github.com/davidhalter/jedi-vim)
  - Python-mode：将 Vim 变成 Python IDE 的一款多合一插件。[官网](https://github.com/klen/python-mode)
* Visual Studio
  - PTVS：Visual Studio 的 Python 工具[官网](https://github.com/Microsoft/PTVS)

## 集成开发环境

流行的 Python 集成开发环境。

* PyCharm：商业化的 Python IDE ，由 JetBrains 开发。也有免费的社区版提供。[官网](https://www.jetbrains.com/pycharm/)
* LiClipse：基于 Eclipse 的免费多语言 IDE 。使用 PyDev 来支持 Python 。[官网](http://www.liclipse.com/)
* Spyder：开源 Python IDE。[官网](https://github.com/spyder-ide/spyder)

## 自动聊天工具

用于开发聊天机器人的库

* [Errbot](http://errbot.io/en/latest/)：最简单和最流行的聊天机器人用来实现自动聊天工具。
* [Lector](https://github.com/BasioMeusPuga/Lector):基于 Qt 的电子书阅读器
* [Asciinema](https://github.com/asciinema/asciinema):Python 编写的终端会话录制器

## 持续集成

参见: [awesome-CIandCD](https://github.com/ciandcd/awesome-ciandcd#online-build-system).

* Travis CI：一个流行的工具，为你的开源和[私人](https://travis-ci.com/)项目提供持续集成服务。(仅支持 GitHub)[官网](https://travis-ci.org/)
* CircleCI：一个持续集成工具，可以非常快速的进行并行测试。 (仅支持 GitHub)[官网](https://circleci.com/)
* Vexor CI：一个为私人 app 提供持续集成的工具，支持按分钟付费。[官网](https://vexor.io/)
* Wercker：基于 Docker 平台，用来构建和部署微服务。[官网](http://wercker.com/)

## 网站

* [r/Python](https://www.reddit.com/r/python)
* [CoolGithubProjects](https://www.coolgithubprojects.com/)
* [Django Packages](https://www.djangopackages.com/)
* [Full Stack Python](http://www.fullstackpython.com/)
* [Python 3 Wall of Superpowers](http://python3wos.appspot.com/)
* [Python Hackers](http://pythonhackers.com/open-source/)
* [Python ZEEF](https://python.zeef.com/alan.richmond)
* [Trending Python repositories on GitHub today](https://github.com/trending?l=python)
* [PyPI Ranking](http://pypi-ranking.info/alltime)

## 周刊

* [Import Python Newsletter](http://importpython.com/newsletter/)
* [Pycoder's Weekly](http://pycoders.com/)
* [Python Weekly](http://www.pythonweekly.com/)

## 学习指南

* [Scipy-lecture-notes](http://hao.jobbole.com/scipy-lecture-notes/)：如何用Python来做学术？[官网](https://github.com/scipy-lectures/scipy-lecture-notes)
* [SScientific-python-lectures](http://hao.jobbole.com/scientific-python-lectures/)：Python科学计算的资料。[官网](https://github.com/jrjohansson/scientific-python-lectures)
* [Mario-Level-1](http://hao.jobbole.com/mario-level-1/)：用Python和Pygame写的超级马里奥第一关。[官网](https://github.com/justinmeister/Mario-Level-1)
* [Python Koans](http://hao.jobbole.com/python-koans/)：Python的交互式学习工具。[官网](https://github.com/gregmalcolm/python_koans)
* [Minecraft](http://hao.jobbole.com/minecraft-python/)：用python写的Minecraft游戏。[官网](https://github.com/fogleman/Minecraft)
* [pycrumbs](http://hao.jobbole.com/python-pycrumbs/)：Python资源大全。[官网](https://github.com/kirang89/pycrumbs/blob/master/pycrumbs.md)
* [python-patterns](http://hao.jobbole.com/python-patterns/)：使用python实现设计模式。[官网](https://github.com/faif/python-patterns)
* [Projects](http://hao.jobbole.com/python-projects/)：Python项目大集合。[官网](https://github.com/karan/Projects)
* [The Hitchhiker's Guide to Python](http://hao.jobbole.com/the-hitchhikers-guide-to-python/)：旅行者的Python学习指南。[官网](http://docs.python-guide.org/en/latest/)
* [Code Like a Pythonista: Idiomatic Python](http://top.jobbole.com/18767/)：如何像Python高手(Pythonista)一样编程。[官网](http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html)
* [Python-Guide-CN](https://github.com/Prodesire/Python-Guide-CN):Python最佳实践指南
* [OnlinePythonTutor](https://github.com/pgbovine/OnlinePythonTutor):Visualize Python, Java, JavaScript, TypeScript, Ruby, C, and C++ code execution in your Web browser <http://pythontutor.com/>
* [Python fundamentals](https://www.python-tutorial.net/)
* [awesome-functional-python](https://github.com/sfermigier/awesome-functional-python)
* [python_data_analysis_and_mining_action](https://github.com/apachecn/python_data_analysis_and_mining_action):《python数据分析与挖掘实战》的代码笔记
* [python-cheatsheet](https://github.com/gto76/python-cheatsheet):Comprehensive Python Cheatsheet <https://gto76.github.io/python-cheatsheet/>
* 面试
  - [python_interview_question](https://github.com/kenwoodjw/python_interview_question):关于python的面试题
* 图书
  - [Test-Driven Web Development with Python](https://www.obeythetestinggoat.com/pages/book.html#toc)
* More Python for Beginners
* Even More Python for Beginners： Data Tools
* [c9-python-getting-started](https://github.com/microsoft/c9-python-getting-started):Sample code for Channel 9 Python for Beginners course
* [essential-python-resources/](https://x-team.com/blog/essential-python-resources/)

## Algorithmic Trading

* [zipline](https://github.com/quantopian/zipline):Zipline, a Pythonic Algorithmic Trading Library <http://www.zipline.io/>

## Font

* [fonttools](https://github.com/fonttools/fonttools):A library to manipulate font files from Python.

## 源码

* [python3-source-code-analysis](https://github.com/flaggo/python3-source-code-analysis):《Python 3 源码剖析》

## 知识点

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
    - 1、项目环境自动化部署；s
    - 2、项目代码自动化发布；
    - 3、项目生命周期理解；
* 数据结构
  - 时间和空间复杂度、链表、桟和队列、排序、二叉树、python内建数据结构类型；
