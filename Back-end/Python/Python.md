# Python

编译器首先会进行语法检查，代码检查

为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下兼容。不同版本的python.exe使用不同的命名，命令行中可以调用的到`python` `python3`

## 版本管理工具pyenv virtualenv

### 虚拟沙盒virtualenv

### pyenv

virtualenv为应用提供了隔离的Python运行环境，解决了不同应用间多版本的冲突问题。

```
brew install pyenv
```

## wheel

Wheels are the new standard of python distribution and are intended to replace eggs.`pip install wheel`

## 包管理工具easy_install.py和pip(pip3 python3)第三方包的安装管理

Python2.7的安装包中，easy_install.py是默认安装的，而pip需要我们手动安装

```
python get-pip.py   //windows

sudo apt-get install python-pip

sudo easy_install pip
pip install 'Markdown<2.0'
pip install 'Markdown>2.0,<2.0.3
pip show --files SomePackage
pip install selenium   # 安装模块包
pip list                        # 列出已安装的包
pip list --outdated             # 查看哪些软件需要更新
pip show --files Package        # 查看安装包时安装了哪些文件
pip uninstall Package           # 卸载软件包
pip search Package              # 搜索软件包
pip install --upgrade/-U Package        # 升级软件包

pip freeze > requirements.txt        # 导出 //Requirements文件 一般记录的是依赖软件列表，通过pip可以一次性安装依赖软件包:
pip install -r requirements.txt         # 安装

$ pip completion --bash >> ~/.profile // Bash  pip命令自动补全
$ . ~/.profile

$ pip completion --zsh >> ~/.zprofile  //对于zsh
$ . ~/.profile
```

## 工具

- iPython - 更强大的python交互shell，支持变量自动补全，自动缩进，支持 bash shell 命令，内置了许多很有用的功能和函数
- Anaconda:有命令行与图形界面两种方式

## 框架

### 通过pip安装Django

```
sudo apt-get install python-pip
pip install --upgrade pip
pip install Django==1.11.3
```

- 建立项目： `django-admin.py startproject app`
- 修改数据配置（默认sqlite）：修改setting.py

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 数据库名,
        'USER': '用户名,
        'PASSWORD': '密码',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```

- 数据库迁移到mysql准备：sudo apt-get install python-mysqldb
- 数据迁移：python manage.py migrate
- 运行服务：python manage.py runserver 127.0.0.1:8080
- 进入管理页面：127.0.0.1：8080/admin

## 搭建服务器todo

## 教程

- [python3](http://www.runoob.com/python3)
- [Python教程 廖雪峰](https://www.liaoxuefeng.com/wiki/0014316089557264a6b348958f449949df42a6d3a2e542c000)
- <http://www.cnblogs.com/linhaifeng/p/7278389.html>
- <http://www.cnblogs.com/linhaifeng/p/7278389.html>

## basic

- map:函数接收两个参数，一个是函数，一个是Iterable，map将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回

- reduce:把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数，reduce把结果继续和序列的下一个元素做累积计算 `reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)`

## 插件

- [xadmin](https://github.com/sshwsfc/xadmin) [文档](https://xadmin.readthedocs.io/en/latest/index.html)
- [django-bootstrap-toolkit]()

## 库

- numpy
- scipy
- matplotlib
- scikit-learn
- pandas
