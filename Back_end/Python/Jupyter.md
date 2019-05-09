# [jupyter/jupyter](https://github.com/jupyter/jupyter)

Jupyter metapackage for installation, docs and chat https://jupyter.readthedocs.io/ http://jupyter.org/

以网页的形式打开，可以在网页页面中直接编写代码和运行代码，代码的运行结果也会直接在代码块下显示。如在编程过程中需要编写说明文档，可在同一个页面中直接编写，便于作及时的说明和解释

## Install

```sh
conda install jupyter notebook
pip install jupyter

# Anaconda，可以在其 Navigator 图形界面中点击打开 Notebook
jupyter notebook
--port <port_number> # set port
--no-browser # 启动Jupyter Notebook的服务器但不打算立刻进入到主页面

conda install -c conda-forge jupyter_contrib_nbextensions
```

## config

/home/henry/.ipython/profile_default

* 把变量名称或没有定义输出结果的语句放在cell的最后一行，无需print语句，Jupyter也会显示变量值。当使用Pandas DataFrames时这一点尤其有用，因为输出结果为整齐的表格

```py
jupyter notebook --generate-config # 获取配置文件所在路径
vim ~/.jupyter/jupyter_notebook_config.py

# ~/.ipython/profile_default/ipython_config.py
c = get_config()
# Run all nodes interactively
c.InteractiveShell.ast_node_interactivity = "all"
```

## 关联Jupyter Notebook和conda的环境和包

对conda环境和包进行一系列操作

```
conda install nb_conda
conda remove nb_conda
```

## content

Notebook 文档是由一系列单元（Cell）构成，主要有两种形式的单元：

* code：这里是你编写代码的地方，通过按 Shift + Enter 运行代码，其结果显示在本单元下方。代码单元左边有 In [1]: 这样的序列标记，方便人们查看代码的执行次序。
* Markdown 单元：在这里对文本进行编辑，采用 markdown 的语法规范，可以设置文本格式、插入链接、图片甚至数学公式。同样使用 Shift + Enter 运行 markdown 单元来显示格式化的文本。
    + 编辑数学公式：LaTeX `$$ z = \frac{x}{y} $$`
    + 幻灯片

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
* %pwd || !pwd
* 查看python版本：!python --version
* 运行python文件：!python myfile.py
* current_path = %pwd

```py
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

## shortcut

* 修改之前的单元格，对其重新计算，这样就可以更新整个文档
* Shift-Enter run cell,自动跳到下一个cell
* Ctrl-Enter  run cell in-place 不自动调转到下一个cell
* Enter: 当前cell进入编辑模式
* ESC: 退出当前cell的编辑模式
* dd:删除当前的cell
* z: 撤销对某个cell的删除
* l:为当前的cell加入line number
* 单1|2|3:当前的cell转化为具有一|二｜三级标题的maskdown
* Alt-Enter   run cell, insert below
* Ctrl-m x    cut cell
* Ctrl-m c    copy cell
* Ctrl-m v    paste cell
* Ctrl-m d    delete cell
* Ctrl-m z    undo last cell deletion
* Ctrl-m –    split cell
* Ctrl-m a    insert cell above
* Ctrl-m b    insert cell below
* Ctrl-m o    toggle output
* Ctrl-m O    toggle output scroll
* Ctrl-m l    toggle line numbers
* Ctrl-m s    save notebook
* Ctrl-m j    move cell down
* Ctrl-m k    move cell up
* Ctrl-m y    code cell
* Ctrl-m m    markdown cell
* Ctrl-m t    raw cell
* Ctrl-m 1-6  heading 1-6 cell
* Ctrl-m p    select previous
* Ctrl-m n    select next
* Ctrl-m i    interrupt kernel
* Ctrl-m .    restart kernel
* Ctrl-m h    show keyboard shortcuts
* Ctrl + /  为一行或者多行添加/取消注释
* Crtl PgUp和Crtl PgDn 浏览器的各个Tab之间切换
* Crtl Home: 快速跳转到首个cell
* Crtl End: 快速跳转到最后一个cell

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

* 一个Markdown单元格里写LaTex时，它将用MathJax呈现公式：如 $$ P(A \mid B) = \frac{P(B \mid A) , P(A)}{P(B)} $$

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

```sh
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
```

## [damianavila/RISE](https://github.com/damianavila/RISE)

RISE: "Live" Reveal.js Jupyter/IPython Slideshow Extension

```
# install
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

## Jupyter-contrib extensions

* Table of Contents(2)

```
conda install -c conda-forge jupyter_contrib_nbextensions

!pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
!pip install jupyter_nbextensions_configurator

!jupyter contrib nbextension install --user
!jupyter nbextensions_configurator enable --user
```

## Shortcuts

Help > Keyboard Shortcuts

* Esc + F 在代码中查找、替换，忽略输出。
* Esc + O 在cell和输出结果间切换。
* 选择多个cell:一旦选定cell，可以批量删除/拷贝/剪切/粘贴/运行
    - Shift + J 或 Shift + Down 选择下一个cell。
    - Shift + K 或 Shift + Up 选择上一个cell。
* Shift + M 合并cell
* 执行当前cell，并自动跳到下一个cell：Shift Enter
* 执行当前cell，执行后不自动调转到下一个cell：Ctrl-Enter
* 当前的cell进入编辑模式：Enter
* 退出当前cell的编辑模式：Esc
* 删除当前的cell：双D
* 为当前的cell加入line number：单L
* 将当前的cell转化为具有一级标题的maskdown：单1
* 将当前的cell转化为具有二级标题的maskdown：单2
* 将当前的cell转化为具有三级标题的maskdown：单3
* 为一行或者多行添加/取消注释：Crtl /
* 撤销对某个cell的删除：z
* 浏览器的各个Tab之间切换：Crtl PgUp和Crtl PgDn
* 快速跳转到首个cell：Crtl Home
* 快速跳转到最后一个cell：Crtl End
* Help 菜单下，可以找到常见库的在线文档链接，包括Numpy，Pandas，Scipy和Matplotlib
* 库、方法或变量的前面打上?，即可打开相关语法的帮助文档

## 参考

* [markusschanta/awesome-jupyter](https://github.com/markusschanta/awesome-jupyter):A curated list of awesome Jupyter projects, libraries and resources

## 工具

* [jupyter/notebook](https://github.com/jupyter/notebook):Jupyter Interactive Notebook https://jupyter-notebook.readthedocs.io/