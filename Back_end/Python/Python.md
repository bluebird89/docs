# [python/cpython](https://github.com/python/cpython)

The Python programming language,Guido van Rossum 在1989年圣诞节期间，为了打发无聊的圣诞节而编写的一个编程语言
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
vim ~/.bash_profile # (只要能编辑就行) 插入新的Python路径

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
*  (代码助手)[https://raw.githubusercontent.com/michaelliao/learn-python3/master/teach/learning.py]

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

* 基础知识：日常的重复训练
    - 变量
    - 语句
    - 数据类型
    - 数值类型
    - 字符串
    - 布尔类型
    - 列表
    - 字典
    - 元组
    - 条件语句
    - 循环语句
    - 函数
    - 装饰器
    - 面向对象
    - 网络socket
    - 爬虫
* 基础库
* 模块
* 模块
    - 将多个代码块（按功能）定义到同一个文件中。别的文件中使用时则先导入模块，在调用模块内变量或函数。
    - 模块命名规范
        + 建议全小写英文字母和数字
        + 避免与常用模块或第三方模块名称冲突
    - 控制模块内代码在使用python mod.py时执行，在导入时不执行
        + 通过Global内变量__name__进行判断
        + 当以python mod.py运行脚本时__name__变量为__main__字符串
        + 当以模块导入时__name__为模块名称字符串
* 系统模块
* 三方模块
* 包
    - 将不同模块文件放在不同文件夹内，包文件夹下面需要有__init__.py文件用以声明该文件为Python包。
    - 使用时需要从包内导入模块后调用模块中变量和函数。

* 文件处理（读、写、执行、）
* 字符
    - 统计
    - 排序
* 数据排序
* 网络编程
* 掌握最基础的姿势，就可以骑上车出发了，实际联系几天，摔几跤，基本就学会了
* Python基础语法都学会了，但不知如何写项目进阶？

1.给你一个字符串“come baby,python rocks!” 如何统计里面字母o出现的次数！
思路：遍历字符串，定义一个变量，每次o出现，都+1

2.给你一个字符串“come baby,python rocks!” 如何统计这里面所有字母出现的次数！（普通变量肯定无法完成。）
思路：需要使用字典这类复杂的数据结构处理，字母当key，出现的次数当value，每个key出现，对应的value+1

3.给你一个字符串“come baby,python rocks!” 如何统计这里面字母出现次数的前三名！
思路：排序，取出前三

1.给你一个字符串“come baby,python rocks!” 怎么统计出现次数前三的字母。
2.一个nginx日志文件，怎么统计IP出现次数前三的url。
3.一个nginx日志文件，统计IP出现前三后，如何存入MySQL数据库。
4.存入MySQL中的日志文件，如何输出给浏览器端显示。
5.如何美化前端表格等等。

* 全栈Web开发学习路线
    - 基础入门（入门、数据类型、条件表达、循环语句）
    - 基础进阶（文件操作、函数、装饰器、模块、面向对象、网络编程）
    - 前端知识（Html、Css、Js、Jquery、Bootstrap、）
    - 高级用法（Django、Flask、数据库操作、MVC、ORM、Admin、template）
    - 项目实战（电商项目、爬虫项目、常用组件、运维项目、代码调优）
    - 高级进阶（数据算法、代码规范、面试技巧）

并发
了解线程、进程，它们如何运行，以及它们在Python中的弱点。
了解Sockets，Network库，异步功能
了解解释器的设计和运行原理：为什么有这么多不同的Python实现。（Python是用英语编写的，不是C语言），这个概念非常重要。
了解Python生态
PyCharm
PEP8
PIP
setuptools
virtualenv

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

* [Automate the Boring Stuff with Python](https://automatetheboringstuff.com)
* [Learning with Python 3](http://openbookproject.net/thinkcs/python/english3e/)
* [learn python the hardway](https://learnpythonthehardway.org/python3/)
* [Think Python: How to Think Like a Computer Scientist](http://greenteapress.com/thinkpython2/html/index.html)
* Python性能分析与优化
* Python高性能编程
* [pythonbook](https://python.cs.southern.edu/pythonbook/pythonbook.pdf)
* [Introduction to Programming in Python: An Interdisciplinary Approach](https://introcs.cs.princeton.edu/python/home/)

* 《[集体智慧编程](https://www.amazon.cn/gp/product/B00UI93JD8)》
* 《[笨办法学Python](https://www.amazon.cn/gp/product/B00P6OJ0TC)》
* 《[Python基础教程(第3版)](https://www.amazon.cn/Python基础教程-Magnus-Lie-Hetland/dp/B079BJPVFL/ref=dp_ob_title_bk)》
* 《Python源码剖析》
* 《[Head First Python](https://www.amazon.cn/gp/product/B007NB2B4M)》
* 《[与孩子一起学编程](https://www.amazon.cn/gp/product/B00HECW20S)》
* 《[Python学习手册（第4版）](https://www.amazon.cn/gp/product/B004TUJ7A6)》
* 《[Python Cookbook（第3版）](https://www.amazon.cn/gp/product/B00WKR1OKG)》
* 《[Python参考手册（第4版）](https://www.amazon.cn/gp/product/B01MCUN37Y)》
* 《[Python核心编程（第3版）](https://www.amazon.cn/gp/product/B01FQAS0KK)》
* 《[Python科学计算（第2版）](https://www.amazon.cn/gp/product/B01HCVUJFA)》
* 《[利用 Python 进行数据分析](https://www.amazon.cn/gp/product/B00GHGZLWS)》
* 《[Think Python：像计算机科学家一样思考Python（第2版）](https://www.amazon.cn/gp/product/B01ION3W54)》
* 《[Python编程实战:运用设计模式、并发和程序库创建高质量程序](https://www.amazon.cn/gp/product/B00MHDPIJ6)》
* 《[Python绝技：运用Python成为顶级黑客](https://www.amazon.cn/gp/product/B019ZRGBVU)》
* 《[Flask Web开发:基于Python的Web应用开发实战](https://www.amazon.cn/gp/product/B0153177A6)》
* 《用 Python 写网络爬虫》
* 《[深度学习:基于Keras的Python实践](https://www.amazon.cn/gp/product/B07D5855F4)》
* Python与量化投资从基础到实践
* Learning Python, 5th Edition
* Python编程 从入门到实践
* 流畅的Python Fluent Python
* [Flask Web开发实战：入门、进阶与原理解析](https://item.jd.com/12430774.html)

## 教程

* [jackfrued/Python-100-Days](https://github.com/jackfrued/Python-100-Days):Python - 100天从新手到大师
* [Python 中文学习大本营](http://www.pythondoc.com/)
* [Yixiaohan/codeparkshare](https://github.com/Yixiaohan/codeparkshare):Python初学者（零基础学习Python、Python入门）书籍、视频、资料、社区推荐
* [kennethreitz/python-guide](https://github.com/kennethreitz/python-guide):Python best practices guidebook, written for Humans. http://docs.python-guide.org
* [michaelliao/learn-python3](https://github.com/michaelliao/learn-python3): Learn Python 3 Sample Code
* [Python教程 廖雪峰](https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)
* [TwoWater/Python](https://github.com/TwoWater/Python):Python 入门教程：【草根学 Python （基于Python3.6）】 https://www.readwithu.com/
* [Python 3 cookbook](https://python3-cookbook.readthedocs.io/zh_CN/latest/):Python3教学手册
* [在 Windows 上用 Python 做开发](https://docs.microsoft.com/zh-cn/windows/python/)
* [简明 Python 教程 A Byte of Python](https://bop.mol.uno)
* [Python最佳实践指南](https://pythonguidecn.readthedocs.io/zh/latest/index.html)
* [Python进阶](https://docs.pythontab.com/interpy/)
* [CODE WITH REPL.IT](https://www.codewithrepl.it/)
* A Byte of Python

* https://www.shiyanlou.com/courses/31
* https://www.shiyanlou.com/courses/487
* https://www.shiyanlou.com/courses/552
* [python3](http://www.runoob.com/python3)

## 工具

* [faif/python-patterns](https://github.com/faif/python-patterns)A collection of design patterns/idioms in Python
* [requests/requests](https://github.com/requests/requests)Python HTTP Requests for Humans™ ✨🍰✨ <http://python-requests.org>
* [scrapy/scrapy](https://github.com/scrapy/scrapy)Scrapy, a fast high-level web crawling & scraping framework for Python. <https://scrapy.org>
* [fchollet/keras](https://github.com/fchollet/keras)
* [binux/pyspider](https://github.com/binux/pyspider)A Powerful Spider(Web Crawler) System in Python. <http://docs.pyspider.org/>
* [fabric/fabric](https://github.com/fabric/fabric)Simple, Pythonic remote execution and deployment. <http://fabfile.org>
* 插件
    - [xadmin](https://github.com/sshwsfc/xadmin) [文档](https://xadmin.readthedocs.io/en/latest/index.html)
    - [django-bootstrap-toolkit](https://github.com/dyve/django-bootstrap-toolkit)
* [nteract/nteract](https://github.com/nteract/nteract): 📘 Desktop notebook app + packages https://nteract.io
* [locustio/locust](https://github.com/locustio/locust):Scalable user load testing tool written in Python http://locust.io
* [agronholm/apscheduler](https://github.com/agronholm/apscheduler):Task scheduling library for Python
* [benfred/py-spy](https://github.com/benfred/py-spy):Sampling profiler for Python programs
* [donnemartin/interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges)Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.
* [ipython/ipython](https://github.com/ipython/ipython) https://ipython.org/  `pip3 install ipython`
* [pypy](http://pypy.org/)
* [pypa/pipenv](https://github.com/pypa/pipenv):Python Development Workflow for Humans. https://pipenv.kennethreitz.org
* Server
    - SimpleHTTPServer `python2 -m SimpleHTTPServer 8080`
* 常用系统模块：
    - os,sys,time,datetime,urllib,xml,json,email,csv,collections,math,zipfile,trafile,hashlib
* 常用三方模块：
    - requests,pyquery,django,flask,mysqlclient,paramiko,redis,lxml,dateutils,ipaddr,netaddr

## 参考

* [vinta/awesome-python](https://github.com/vinta/awesome-python):A curated list of awesome Python frameworks, libraries, software and resources https://awesome-python.com/
* [jobbole/awesome-python-cn](https://github.com/jobbole/awesome-python-cn):Python资源大全中文版，包括：Web框架、网络爬虫、模板引擎、数据库、数据可视化、图片处理等，由伯乐在线持续更新。
* [mahmoud/awesome-python-applications](https://github.com/mahmoud/awesome-python-applications):cd Free software that works great, and also happens to be open-source Python. ftp://you:relookin@it.example.com#readme
* [wtfpython](https://github.com/satwikkansal/wtfpython):What the f*ck Python?
* [ gto76 / python-cheatsheet ](https://github.com/gto76/python-cheatsheet):Comprehensive Python Cheatsheet https://gto76.github.io/python-cheatsheet/
* [中文文档](https://docs.python.org/zh-cn/3/)
* [kennethreitz/python-guide](https://github.com/kennethreitz/python-guide)
* [faif/python-patterns](https://github.com/faif/python-patterns):A collection of design patterns/idioms in Python
* [Python 开源库及示例代码](https://github.com/programthink/opensource/blob/master/libs/python.wiki)
* [kriadmin/30-seconds-of-python-code](https://github.com/kriadmin/30-seconds-of-python-code)
* [coodict/python3-in-one-pic](https://github.com/coodict/python3-in-one-pic):Learn python3 in one picture. https://git.io/Coo-py3
* [lijin-THU/notes-python](https://github.com/lijin-THU/notes-python):中文 Python 笔记
