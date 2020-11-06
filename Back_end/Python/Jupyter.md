# [jupyter](https://github.com/jupyter/jupyter)

* Jupyter metapackage for installation, docs and chat https://jupyter.readthedocs.io/ http://jupyter.org/
* 以网页的形式打开，可以在网页页面中直接编写代码和运行代码，代码的运行结果也会直接在代码块下显示。如在编程过程中需要编写说明文档，可在同一个页面中直接编写，便于作及时的说明和解释

## [notebook](https://github.com/jupyter/notebook)

* Jupyter Interactive Notebook https://jupyter-notebook.readthedocs.io/
* 保存为后缀名为.ipynb的JSON格式文件，便于版本控制，方便与他人共享
* 可以导出为：HTML、LaTeX、PDF等格式
* 编程时具有语法高亮、缩进、tab补全的功能。
* 可直接通过浏览器运行代码，同时在代码块下方展示运行结果
* 以富媒体格式展示计算结果。富媒体格式包括：HTML，LaTeX，PNG，SVG等
* 对代码编写说明文档或语句时，支持Markdown语法。
* 支持使用LaTeX编写数学性说明
* Notebook 文档是由一系列单元（Cell）构成，主要有两种形式的单元：
  - code：这里是你编写代码的地方，通过按 Shift + Enter 运行代码，其结果显示在本单元下方。代码单元左边有 In [1]: 这样的序列标记，方便人们查看代码的执行次序。
  - Markdown 单元：在这里对文本进行编辑，采用 markdown 的语法规范，可以设置文本格式、插入链接、图片甚至数学公式。同样使用 Shift + Enter 运行 markdown 单元来显示格式化的文本。
    * 编辑数学公式：LaTeX `$$ z = \frac{x}{y} $$`
    * 幻灯片

## Install

```sh
conda install jupyter notebook
pip install jupyter

# Anaconda，可以在其 Navigator 图形界面中点击打开 Notebook
jupyter notebook
--port <port_number> # set port
--no-browser # 启动Jupyter Notebook的服务器但不打算立刻进入到主页面

# 可以用于查看配置文件所在的路径，主要用途是是否将这个路径下的配置文件替换为默认配置文件
jupyter notebook --generate-config
jupyter notebook --port <port_number>
jupyter notebook --no-browser
```

## config

* windows: `C:\Users\<user_name>\.jupyter\jupyter_notebook_config.py`
* Linux/macOS：`/Users/<user_name>/.jupyter/jupyter_notebook_config.py` 或 ` ~/.jupyter/jupyter_notebook_config.py`
* `/home/henry/.ipython/profile_default`
* 把变量名称或没有定义输出结果的语句放在cell的最后一行，无需print语句，Jupyter也会显示变量值。当使用Pandas DataFrames时这一点尤其有用，因为输出结果为整齐的表格
* `~/.jupyter/nbconfig/notebook.json`

```py
vim ~/.jupyter/jupyter_notebook_config.py

# ~/.ipython/profile_default/ipython_config.py
c = get_config()
# Run all nodes interactively
c.InteractiveShell.ast_node_interactivity = "all"
```

## 使用

* 文件
  - Terminal:支持 bash
  - Markdown
* 与　vim 类似
* 命令模式:当前cell侧边为蓝色时
  - H：显示快捷键帮助
  - F：查找和替换
  - P：打开命令面板
  - Enter切换为编辑模式
  - Ctrl-Enter：运行当前cell
  - Shift-Enter：运行当前cell并跳转到下一cell
  - Alt-Enter：运行当前cell并在下方新建cell
  - Y：把当前cell内容转换为代码形式
  - M：把当前cell内容转换为markdown形式
  - R 将单元格切换至raw状态
  - 1~6：把当前cell内容设置为标题1~6格式
  - Shift+上下键|K|J：按住Shift进行上下键操作可复选多个cell
  - ↑|K   选中上方单元格
  - ↓|J   选中下方单元格
  - A：在上方新建cell
  - B：在下方新建cell
  - X/C/Shift-V/V：剪切/复制/上方粘贴/下方粘贴
  - D, D：删除当前cell
  - ⇧M    合并选中单元格，若直选中一个则与下一个单元格合并
  - Z：撤销删除
  - S：保存notebook
  - L   转换行号
  - O   转换输出 在cell和输出结果间切换
  - ⇧O  转换滚动输出
  - H   显示快捷键帮助
  - I, I    中断Notebook内核
  - O, O    重启Notebook内核
  - Shift-L：为所有cell的代码添加行编号
  - Shift-M：合并所选cell或合并当前cell和下方的cell
  - Q 关闭页面
* 编辑模式：前cell侧边为绿色
  - Esc 切换为命令模式
  - Tab：代码补全
  - Ctrl-A：全选
  - Ctrl-Z：撤销
  - Ctrl-Home：将光标移至cell最前端
  - Ctrl-End：将光标移至cell末端
  - Ctrl + /  为一行或者多行添加/取消注释
  - Alt Multicursor support
* 输出
  - 只执行到光标处，print 可以执行多行
* 修改之前的单元格，对其重新计算，这样就可以更新整个文档
* 主题:重启生效
* 扩展: 通过　NJupyter-contrib extensions　安装
    -　Hinterland功能可以让你每敲完一个键，就出现下拉菜单，可以直接选中你需要的词汇
    -　Snippets在工具栏里加了一个下拉菜单，可以非常方便的直接插入代码段，完全不用手动敲
    -　拆分笔记本中的单元格，改成相邻的模式，看起来就像分了两栏
    -　Table of Contents：可以自动找到所有的标题，生成目录
    -　折叠一个标题下的全部内容
    -　Autopep8:顶部工具栏 "木槌"按钮",可以修改快捷键
    -　Variable inspector：显示在Notebook中创建的所有变量的名称，以及类型、大小、形状和值
    -　ExecuteTime
    -　Hide input
  *　shift+tab: 查看函数解释

```sh
conda install|remove nb_conda　# conda创建的环境与Jupyter Notebook相关联，便于在Jupyter Notebook的使用中，在不同的环境下创建笔记本进行工作
pip install jupyterthemes
jt -l
jt -t chesterish
jt -r # 恢复默认

conda install -c conda-forge jupyter_nbextensions_configurator
pip install jupyter_nbextensions_configurator
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user

conda install -c conda-forge jupyter_contrib_nbextensions
pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install
# pip
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension

# Conda
conda install -c conda-forge ipywidgets

pip install qgrid
jupyter nbextension enable --py --sys-prefix qgrid
# only required if you have not enabled the ipywidgets nbextension yet
jupyter nbextension enable --py --sys-prefix widgetsnbextension
```

## 公式

## 幻灯片

## plot

* tool
  - matplotlib （事实标准），可通过%matplotlib inline 激活
  - %matplotlib notebook 提供交互性操作，但可能会有点慢，因为响应是在服务器端完成的。
  - mpld3 提供matplotlib代码的替代性呈现（通过d3），虽然不完整，但很好。
  - bokeh 生成可交互图像的更好选择。
* 不让末句的函数输出结果比较方便，比如在作图的时候，此时，只需在该函数末尾加上一个分号即可

## [magic](https://ipython.readthedocs.io/en/stable/interactive/magics.html)

* %lsmagic
* %env:设置环境变量
* %run file 运行.py格式的python代码.使用%run 与导入一个python模块是不同的
  * `ln [*]`: 正在运行状态
* %load file：从外部脚本中插入代码 用外部脚本替换当前cell.也可以使用URL
* %store: 在notebook文件之间传递变量
* %who: 列出所有的全局变量
* 用于计时
  - %%time 会告诉你cell内代码的单次运行时间信息
  - %%timeit 使用了Python的 timeit 模块，该模块运行某语句100，000次（默认值），然后提供最快的3次的平均值作为结果
* %%write file:导出cell内容
* %pycat file:显示外部脚本的内容
* %prun: 告诉程序中每个函数消耗的时间
* %pdb:调试程序.调试界面The Python Debugger (pdb)，使得进入函数内部检查错误
* %pwd 或者 !pwd：获取当前所在位置的绝对路径
* 查看python版本：!python --version
* 运行python文件：!python myfile.py
* current_path = %pwd
* %load URL

```
# one file
data = 'this is the string I want to pass to different notebook'
%store data
del data  # This has deleted the variable

# new file
%store -r data
print(data)

%%time
import time
for _ in range(1000):
    time.sleep(0.01)

import numpy
%timeit numpy.random.normal(size=100)
```

## terminal

* can new terminal
* !ls ../: 行shell命令

## output

本身以HTML的形式显示，单元格输出也可以是HTML形式的，所以你可以输出任何东西：视频/音频/图像

```
import os
from IPython.display import display, Image
names = [f for f in os.listdir('../images/ml_demonstrations/') if f.endswith('.png')]
for name in names[:5]:
    display(Image('../images/ml_demonstrations/' + name, width=100))

names = !ls ../images/ml_demonstrations/*.png
names[:5]
```

## LaTex

* 一个Markdown单元格里写LaTex时，它将用MathJax呈现公式：如` $$ P(A \mid B) = \frac{P(B \mid A) , P(A)}{P(B)} $$`

## kernal

对内核的操作，比如中断、重启、连接、关闭、切换内核

* 用不同的内核运行代码
  - %%bash
  - %%HTML
  - %%python2
  - %%python3
  - %%ruby
  - %%perl
* 用其他语言写函数
  - 在cython或fortran里写函数，然后在python代码里直接调用

```python
!python myfile.py  # 在Jupyter Notebook中执行shell命令的语法
!python3

# 通过Anaconda安装R内核
conda install -c r r-essentials

# 同一个notebook里运行R和Python
pip install rpy2

%load_ext rpy2.ipython
In [2]: %R require(ggplot2)
Out[2]: array([1], dtype=int32)
In [3]: import pandas as pd
        df = pd.DataFrame({ 'Letter': ['a', 'a', 'a', 'b', 'b', 'b', 'c', 'c', 'c'], 'X': [4, 3, 5, 2, 1, 7, 7, 5, 9], 'Y': [0, 4, 3, 6, 7, 10, 11, 9, 13], 'Z': [1, 2, 3, 1, 2, 3, 1, 2, 3] })
In [4]: %%R -i df
        ggplot(data = df) + geom_point(aes(x = X, y= Y, color = Letter, size = Z))

pip install cython fortran-magic

In [ ]: %load_ext Cython
In [ ]: %%cython
        def myltiply_by_2(float x):
            return 2.0 * x
In [ ]: myltiply_by_2(23.)

$$\int_0^{+\infty} x^2 dx$$ # 公式
```

## [damianavila/RISE](https://github.com/damianavila/RISE)

RISE: "Live" Reveal.js Jupyter/IPython Slideshow Extension

```
conda install -c damianavila82 rise
pip install RISE  # install

jupyter-nbextension install rise --py --sys-prefix
jupyter-nbextension enable rise --py --sys-prefix
```

## link

需要添加链接的文字（an internal hyperlink to the destination），即点击该处可以跳转到the destination，在需要添加链接的文字后面加入

```ipython
[jump to destionation](#the_destination)

<a id="the_destination">to destination</a>
```

## data analysis

* ipyparallel（之前叫 ipython cluster） 是一个在python中进行简单的map-reduce运算的良好选择。我们在rep中使用它来并行训练很多机器学习模型。
* pyspark
* spark-sql magic %%sql

## [JupyterLab](https://github.com/jupyterlab/jupyterlab)

JupyterLab computational environment. https://jupyterlab.readthedocs.io/

```sh
conda install -c conda-forge jupyterlab
jupyter serverextension enable --py jupyterlab --sys-prefix

jupyter lab
```

## Debugger

* Xeus 是 Jupyter kernel protocol 的 C++实现，它本身并不是一个内核，而是能帮助构建内核的库。当开发者希望构建 Python、Lua 等拥有 C、C++ API 的语言内核时，它非常有用
  - 具有可插拔的并发模型，它允许在不同的线程中运行 Control channel 的处理过程
  - 有非常轻量级的代码库，因此迭代与更新都非常方便

```sh
jupyter labextension install @jupyterlab/debugger
conda install xeus-python -c conda-forge #  kernel 需要实现 Jupyter Debug Protocol，因此暂时只能用xeus-python
```

## 参考

* [markusschanta/awesome-jupyter](https://github.com/markusschanta/awesome-jupyter):A curated list of awesome Jupyter projects, libraries and resources
* [The IPython notebook](http://ipython.org/ipython-doc/dev/notebook/index.html)

## 工具

* [Colaboratory](https://colab.research.google.com/notebooks/intro.ipynb)
* [deepnote](https://beta.deepnote.com)
