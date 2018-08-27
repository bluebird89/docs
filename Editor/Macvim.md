# Macvim


## 安装

```sh
brew install macvim --env-std --with-override-system-vim
mvim # 启动

# 插件管理
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Launch vim and run :PluginInstall # 修改配置文件~/.vimrc，安装插件
To install from command line: vim +PluginInstall +qall
```

## 使用

* :version

## Bundle

* NERD_tree : 一个文件管理插件，一些常用命令: 打开一个目录树( :NERDTree <启动目录> | <bookmark>  )  关闭目录树栏(:NERDTreeClose)；切换目录树栏（:NERDTreeToggle）;  　　  定义标签（:Bookmark <name>）；定义Root标签（:BookmarkToRoot <bookmark>)。。。。。。更多命令和用法见 :help NERD_tree。
* word_complete  :代码自动补全
* SuperTab :省去Ctrl-n或Ctrl-p快捷键，通过按tab键快速显示补全代码.
* xptemplate: 快速自动完成一些if、switch、for、while结构模板代码，支持c、c++、Lua、Ruby、PHP、html、css、JavaScript等多种语言。一般是输入结构体的关键字后，再按Ctrl-\组合键即可完成代码补全，然后按Tab键跳转到不同的位置替换模板内容。比如:输入for后按Ctrl-\组合键即可快速完成for结构的模板代码。
* ctags : 一个扫描记录代码的语法元素，并记录为tag，方便代码定位跳转等操作，MacVim自带，但是据说有点问题，笔者用Vundle安装的貌似也有问题，推荐用MacPorts安装，然后在　　        　　　~/.gvimrc配置中加入:  let Tlist_Ctags_Cmd="/opt/local/bin/ctags"。用法:在终端 cd 进入到你的项目根目录，输入语句即可将项目所有代码文件打上tag: ctags -R --c++-kinds=+px --fields=+iaS --extra=+q .
* taglist : 可以用Vundle安装，在编辑代码文件时，输入命令":TlistToggle"在右边就会出现当前类的函数或变量列表。输入命令“:tag <函数名或变量、类>”，如果只有一个文件定义了该函数或变量、类，vim打开该文件并将光标定位到对应的位置；如果多个文件有这个函数名或变量、类的tag，将给提示，并可输入“:tselect” ,显示可选的文件。快捷键跳转Ctrl+],Ctrl-o。
* Cscope :功能跟ctags差不多，不过更加强大，MacVim默认已经支持，输入“:version”命令查看.
* OmniCppComplete : 功能跟taglist差不多。
* a.vim :在.cpp文件和.h头文件间快速切换的插件。
* grep.vim : 在工程中查找词汇的插件。
* minibufexplorerpp : 操作缓存buffer窗口。
* quickfix :MacVim内置安装好了，不需要重新安装。显示一些命令查询结果以及编译错误等信息。
* Command-t :用Commad-t命令快速查找切换文件。如果是用Vundle安装的话，还不能使用，在MacVim中输入“:CommandT”命令会报错。用Vundle安装好打开终端，输入如下命令，等待   　　    编译完毕后就可以使用了:
* NERD_commenter.vim : 注释插件。
* DoxygenToolkit.vim : 用于快速生成注释，并由注释生成文档。
* winmanager : 可以用Vundle安装，管理窗口的插件，可以跟NERD_tree、Taglist插件结合，打造一个类似IDE的界面。只需要在NERD_tree.vim中加入如下代码:

## 参考

* [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim):Vundle, the plug-in manager for Vim http://github.com/VundleVim/Vundle.Vim
* [square/maximum-awesome](git@github.com:square/maximum-awesome.git):Config files for vim and tmux.
