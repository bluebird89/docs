### Anaconda

专注于数据分析的Python发行版本，包含了conda、Python等190多个科学包及其依赖项。适用于企业级大数据分析的Python工具。其包含了720多个数据科学相关的开源包，在数据可视化、机器学习、深度学习等多方面都有涉及。不仅可以做数据分析，甚至可以用在大数据和人工智能领域。

conda 是开源包（packages）和虚拟环境（environment）的管理系统。

- packages 管理： 可以使用 conda 来安装、更新 、卸载工具包 ，并且它更关注于数据科学相关的工具包。在安装 anaconda 时就预先集成了像 Numpy、Scipy、 pandas、Scikit-learn 这些在数据分析中常用的包。另外值得一提的是，conda 并不仅仅管理Python的工具包，它也能安装非python的包。比如在新版的 Anaconda 中就可以安装R语言的集成开发环境 Rstudio。
- 虚拟环境管理： 在conda中可以建立多个虚拟环境，用于隔离不同项目所需的不同版本的工具包，以防止版本上的冲突。

#### 使用

- Anaconda Navigator ：用于管理工具包和环境的图形用户界面，后续涉及的众多管理命令也可以在 Navigator 中手工实现。
- qtconsole ：一个可执行 IPython 的仿终端图形界面程序，相比 Python Shell 界面，qtconsole 可以直接显示代码生成的图形，实现多行代码输入执行，以及内置许多有用的功能和函数。
- spyder ：一个使用Python语言、跨平台的、科学运算集成开发环境。

```sh

bash Anaconda2-5.0.0.1-Linux-x86_64.sh
#  更改镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes

echo 'export PATH="~/User/henry/anaconda/bin:$PATH"' >> ~/.zshrc # 添加环境变量
source ~/.zshrc

conda info
conda search search_term

conda update conda
conda upgrade --all   # 升级工具包

conda env list # 显示所有的环境
conda list --revisions

conda create --name env_name  list of packages # 默认的环境是 root，你也可以创建一个新环境,-n 代表 name，env_name 是需要创建的环境名称，list of packages 则是列出在新环境中需要安装的工具包。
conda create --name | -n  py35 python=3.5 pandas

conda install numpy scipy pandas
conda install numpy=1.10
conda install -n python34 numpy
conda update | remove package_name
conda install --name bio-env toolz
conda install --channel conda-forge

source activate env_name # 进入名为 env_name 的环境
source deactivate  # 退出当前环境

python --version #查看版本
which -a python

conda env remove -n env_name  # 删除名为 env_name 的环境
conda remove --name bio-env toolz

conda list -n python34
conda env export > environment.yaml  # 分享代码的时候，同时也需要将运行环境分享给大家，执行如下命令可以将当前环境下的 package 信息存入名为 environment 的 YAML 文件中
conda env create -f environment.yaml #  用对方分享的 YAML 文件来创建一摸一样的运行环境。
```
