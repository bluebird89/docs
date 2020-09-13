# [Anaconda](https://www.anaconda.com/)

一个包含180+的科学包及其依赖项的发行版本。其包含的科学包包括：conda, numpy, scipy, ipython notebook等

* 环境管理： 可以建立多个虚拟环境，用于隔离不同项目所需的不同版本的工具包，以防止版本上的冲突
* packages 管理： 可以使用 conda 来安装、更新 、卸载工具包 ，并且它更关注于数据科学相关的工具包。预先集成了像 Numpy、Scipy、 pandas、Scikit-learn 在数据分析中常用的包,也能安装非python的包,比如可以安装R语言的集成开发环境 Rstudio

## packages

* Anaconda Navigator ：用于管理工具包和环境的图形用户界面，后续涉及的众多管理命令也可以在 Navigator 中手工实现。
* qtconsole ：一个可执行 IPython 的仿终端图形界面程序，相比 Python Shell 界面，qtconsole 可以直接显示代码生成的图形，实现多行代码输入执行，以及内置许多有用的功能和函数。
* spyder ：一个使用Python语言、跨平台的、科学运算集成开发环境
* [tsinghua mirror](https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/)

## install

```sh
# download file from reference
bash Anaconda2-5.0.0.1-Linux-x86_64.sh

echo 'export PATH="/home/henry/anaconda3/bin:$PATH"' >> ~/.zshrc # bin目录加入PATH: ~/.bashrc /etc/profile 系统变量PATH
source ~/.zshrc

conda init zsh
conda config --show
# 更改镜像
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/

# ~/.condarc
channels:
  - defaults
show_channel_urls: true
channel_alias: https://mirrors.tuna.tsinghua.edu.cn/anaconda
default_channels:
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/pro
  - https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/msys2

  - https://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/msys2/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
  - https://mirrors.ustc.edu.cn/anaconda/cloud/menpo/
custom_channels:
  conda-forge: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  msys2: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  bioconda: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  menpo: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  pytorch: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud
  simpleitk: https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud

# 设置搜索时显示通道地址
conda config --set show_channel_urls yes
conda config --set auto_activate_base false

# The environment is inconsistent, please check the package plan carefully
conda install anaconda
conda update --all

# 10 possible package resolutions (only showing differing packages)
conda update conda
```

## 使用

*　虚拟环境：按需部署

```sh
conda info -e|--envs # 显示已创建环境
conda update conda|anaconda|python

# package
conda search [--full-name] <package_full_name>

# env
conda env list # 显示所有的环境
conda list [-n python34|--revisions] # 查看某个指定环境的已安装包
conda create --name|n  py35 python=3.5 numpy pandas
conda env create -f environment.yaml #  用对方分享的 YAML 文件来创建一摸一样的运行环境。
conda create --name <new_env_name> --clone <copied_env_name> # 复制环境

conda install|update|remove [--name | -n  py35] numpy=1.10 scipy pandas
conda install --channel|-c conda-forge
conda upgrade|update --all   # 升级all
conda env export > environment.yaml  # 分享代码的时候，同时也需要将运行环境分享给大家，执行如下命令可以将当前环境下的 package 信息存入名为 environment 的 YAML 文件中

conda activate env_name # 进入名为 env_name 的环境
source activate <env_name>
conda deactivate [env_name] # 退出当前环境
source deactivate

activate env_name # for Windows
deactivate [env_name] # for Windows

conda env remove -n env_name --all # 删除名为 env_name 的环境

python --version|V #查看版本
which -a python

# remove
rm -rf ~/anaconda3
rm -rf ~/.condarc ~/.conda ~/.continuum
```

## reference

* [source address](https://repo.continuum.io/archive/index.html)
* [conda](https://conda.io/docs/index.html)
* [conda-cheatsheet](https://conda.io/docs/_downloads/conda-cheatsheet.pdf)
