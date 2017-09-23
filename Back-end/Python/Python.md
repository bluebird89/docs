# Python

编译器首先会进行语法检查，代码检查

为了不带入过多的累赘，Python 3.0在设计的时候没有考虑向下兼容。不同版本的python.exe使用不同的命名，命令行中可以调用的到`python` `python3`.virtualenv 和 virtualenvwrapper 来管理不同项目的依赖环境，通过 workon 、 mkvirtualenv 等命令进行虚拟环境切换

## 环境控制

### 版本管理工具pyenv:修改系统环境变量 PATH

多版本python共存的环境工具，可以在不改变系统环境的情况下，可以随意切换不同python版本。基于某个版本开发的工具，在更换了不同python版本之后，就会导致工具中的某个模块、代码错误，而不能正常使用。

```
brew install pyenv

pyenv versions   // 查看当前系统中所有可用的 Python 版本
pyenv commands  
pyenv install -l  //可使用版本列表
pyenv install 3.5.1 // 安装
pyenv uninstall 3.5.1
pyenv which python // 显示路径
pyenv global 3.5.2  // 从三个维度来管理 Python 环境，简称为： 当前系统 、 当前目录 、 当前shell 。这三个维度的优先级从左到右依次升高，即 当前系统 的优先级最低、 当前shell 的优先级最高。
pyenv local 3.5.2
pyenv shell 3.5.2

$ curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
export PATH=$HOME/.pyenv/bin:$PATH  //加进系统的环境变量 ～／.zshrc
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)" 

pyenv -v
pyenv doctor
pyenv update
pyenv install --list
cat ~/.pyenv/version
pyenv version
```

### 虚拟沙盒virtualenv

virtualenv为应用提供了隔离的Python运行环境，解决了不同应用间多版本的冲突问题。

```
pip install virtualenv
virtualenv --no-site-packages app_env
source app_env/bin/activate
deactivate

brew install pyenv-virtualenv  // 集成安装
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
- [Anaconda](https://github.com/DamnWidget/anaconda):有命令行与图形界面两种方式,Anaconda turns your Sublime Text 3 in a full featured Python development IDE including autocompletion, code linting, IDE features, autopep8 formating, McCabe complexity checker Vagrant and Docker support for Sublime Text 3 using Jedi, PyFlakes, pep8, MyPy, PyLint, pep257 and McCabe that will never freeze your Sublime Text 3
- jupyter

## 框架

- [django/django](https://github.com/django/django)The Web framework for perfectionists with deadlines. <https://www.djangoproject.com/>
- [pallets/flask](https://github.com/pallets/flask)A microframework based on Werkzeug, Jinja2 and good intentions <http://flask.pocoo.org/>
- [tornadoweb/tornado](https://github.com/tornadoweb/tornado)Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed. <http://www.tornadoweb.org/>

### 通过pip安装Django

```
sudo apt-get install python-pip
pip install --upgrade pip
pip install Django==1.11.3

pip3 install Django
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
- 运行服务：python manage.py runserver
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
- [vinta/awesome-python](https://github.com/vinta/awesome-python)
- []()
- [keon/algorithms](https://github.com/keon/algorithms)Minimal examples of data structures and algorithms in Python

## 工具

- ipython:`pip3 install ipython`
- [nvbn/thefuck](https://github.com/nvbn/thefuck):Magnificent app which corrects your previous console command.
- [donnemartin/interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges)Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.

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

```
// 更改镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ 
conda config --set show_channel_urls yes

echo 'export PATH="~/User/henry/anaconda/bin:$PATH"' >> ~/.zshrc // 添加环境变量
source ~/.zshrc
conda upgrade --all   //升级工具包
conda install numpy scipy pandas
conda install numpy=1.10   conda install -n python34 numpy
conda remove package_name
conda update package_name
conda list -n python34
conda  search search_term
conda update conda
conda update anaconda

conda create -n env_name  list of packages // 默认的环境是 root，你也可以创建一个新环境,-n 代表 name，env_name 是需要创建的环境名称，list of packages 则是列出在新环境中需要安装的工具包。
conda create -n py2 python=2.7 pandas
source activate env_name // 进入名为 env_name 的环境
source deactivate  // 退出当前环境
python --version //查看版本
conda env remove -n env_name  // 删除名为 env_name 的环境
conda env list // 显示所有的环境
conda env export > environment.yaml  // 分享代码的时候，同时也需要将运行环境分享给大家，执行如下命令可以将当前环境下的 package 信息存入名为 environment 的 YAML 文件中
conda env create -f environment.yaml //  用对方分享的 YAML 文件来创建一摸一样的运行环境。
```

#### Jupyter Notebook

[官网](http://jupyter.org/)

```
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
