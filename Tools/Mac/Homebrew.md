# Homebrew

包管理工具

* brew（意为酿酒）的命名很有意思，全部都使用了酿酒过程中采用的材料/器具，名词对应以下的概念：
* Formula（配方） 程序包定义，本质上是一个rb文件
* Keg（桶）程序包的安装路径
* Cellar（地窖）所有程序包（桶）的根目录
* Tap（水龙头）程序包的源
* Bottle （瓶子）编译打包好的程序包
* 增加一个程序源（新增一个水龙头） brew tap homebrew/php

## vs macports

下载source并在本地编译安装，与macports差别

* homebrew的理念是尽量使用系统现有的库。这样可以大大的减少编译时间。
* package都安装到/usr/local下面。
* 资源包管理：Homebrew(安装完brew时，brew-cask已经安装好了，无需额外安装）

### 文件路径

* 程序文件 /usr/local/etc/
* 应用文件 /usr/local/Cellar/
* 日志文件/usr/local/var
* 链接文件 /usr/local/opt

### brew vs brew cask

* brew:从下载源码解压后。／.configure&& make install ,同时包含相关以来库，并自动配置好各种环境变量，易于卸载。
* brew cask：已经编译好的应用包（.dmg/.pkg）,仅仅下载解压，放到同】统一目录（／opt/homebrew-cask/caskroom）

```shell
# 安装homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile(.zshrc)

brew config
brew doctor
brew install -vd FORMULA

brew -v 

brew tap homebrew/services

brew (info|home|options) [FORMULA...]
brew install name # 安装源码 brew info svn 显示软件的各种信息（包括版本、源码地址、依赖等等）
brew uninstall name # 卸载软件
brew search name # 搜索brew 支持的软件（支持模糊搜索
brew home maven # 用浏览器打开
brew list --versions # 列出本机通过brew安装的所有软件
brew outdated # 查看哪些程序需要更新  brew update && brew upgrade
brew update # brew自身更新 
brew upgrade name  #更新安装过的软件(如果不加软件名，就更新所有可以更新的软件)
brew cleanup #清除下载的缓存
brew info * # 显示软件内容信息
brew deps * # 显示包依赖
brew server * # 启动web服务器，可以通过浏览器访问http://localhost:4567/ 来同网页来管理包
brew link --force openssl # 链接新的openssl到环境变量中

brew install tig

# 卸载
cd `brew –prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew

brew install caskroom/cask/brew-cask
brew tap caskroom/cask
brew tap caskroom/versions
brew cask install sublime-text

brew cask search
# 列出所有可以被安装的软件
$brew cask search name
# 查找所有和 name相关的应用
$brew cask install name
# 下载安装软件(报错的话用bash)
brew cask uninstall name

brew cask install alfred
brew cask install the-unarchiver
brew cask install qq
brew cask install line
brew cask install skype
brew cask install thunder
brew cask install mplayerx
brew cask install evernote
brew cask install skitch
brew cask install dropbox
brew cask install google-chrome
brew cask install google-chrome
brew cask install mou
brew cask install iterm2
brew cask install virtualbox

brew cask info app
# 列出应用的信息 $brew cask list
# 列出本机安装过的软件列表
$brew cask cleanup
# 清除下载的缓存以及各种链接信息
$brew cask uninstall name && brew cask install name
# 查看已安装的 composer 的位置
brew info composerpubunut
brew install caskroom/cask/brew-cask
Cask 'brew-cask' is unavailable: '/usr/local/Homebrew/Library/Taps/caskroom/homebrew-cask/Casks/brew-cask.rb' does not exist.
brew install brew-cask-completion

brew tap homebrew/services // brew 服务管理
brew services start postgresql

brew update && brew upgrade && brew cleanup ; say mission complete

brew link --overwrite docker

echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.zshrc
brew services [-v|--verbose] [list | run | start | stop | restart | cleanup]

brew install bash-completion
subl ~/.bash_profile

##
# Homebrew
##
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

##
# Homebrew bash completion
##
if [ -f $(brew --prefix)/etc/bash_completion ]; then
source $(brew --prefix)/etc/bash_completion
fi
```

> brew postinstall node  brew postinstall php@7.1 安装权限问题

cd /usr/local && sudo chown -R $(whoami) bin etc include lib sbin share var Frameworks



_brew cask install \
    alfred \
    android-file-transfer \
    appcleaner \
    caffeine \
    cheatsheet \
    docker \
    doubletwist \
    dropbox \
    google-hangouts \
    flux \
    1password \
    spectacle \
    sublime-text \
    superduper \
    transmission \
    valentina-studio \
    vlc
