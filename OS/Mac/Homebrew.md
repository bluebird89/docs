# [Homebrew/homebrew-cask](https://github.com/Homebrew/homebrew-cask)

🍻 A CLI workflow for the administration of macOS applications distributed as binaries https://brew.sh

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

# 使用brew的国内镜像
cd "$(brew --repo)" && git remote set-url origin https://git.coding.net/homebrew/homebrew.git
cd $home && brew update

echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile(.zshrc)
brew doctor
brew -v|version
brew config

brew tap homebrew/services # brew 服务管理
brew tap caskroom/cask
brew tap caskroom/versions
brew untap Homebrew/homebrew-versions # Remove a tapped repository

brew list --versions # 列出本机通过brew安装的所有软件

brew install caskroom/cask/brew-cask
brew install brew-cask-completion
brew install -vd FORMULA
brew install tig
brew install bash-completion

brew search name| /wget*/ # 搜索brew 支持的软件（支持模糊搜索

brew (info|home|options) [FORMULA...]

brew deps name * # 显示包依赖
brew server * # 启动web服务器，可以通过浏览器访问http://localhost:4567/ 来同网页来管理包

brew update
brew outdated # 查看哪些程序需要更新  brew update && brew upgrade

brew upgrade name  #更新安装过的软件(如果不加软件名，就更新所有可以更新的软件)
brew uninstall --force name # 卸载软件
brew remove  name # 卸载软件

brew cleanup #清除下载的缓存
brew update && brew upgrade && brew cleanup ; say mission complete

brew link --force openssl # 链接新的openssl到环境变量中
brew link --overwrite docker

brew services [-v|--verbose] [list | run | start | stop | restart| reload | cleanup] formula|--all
brew services start postgresql

# 卸载
cd `brew –prefix`
rm -rf Cellar
brew prune
rm -rf Library .git .gitignore bin/brew README.md share/man/man1/brew
rm -rf ~/Library/Caches/Homebrew

brew cask search # 列出所有可以被安装的软件
brew cask search name # 查找所有和 name相关的应用
brew cask install name
brew cask info app # 下载安装软件(报错的话用bash)
brew cask uninstall name
brew cask list # 列出应用的信息

brew cask cleanup

# plugins
brew cask install \
    qlcolorcode \
    qlstephen \
    qlmarkdown \
    quicklook-json \
    qlprettypatch \
    quicklook-csv \
    betterzipql \
    webpquicklook \
    suspicious-package

# app
brew cask install \
    alfred \
    android-file-transfer \
    appcleaner \
    caffeine \
    cheatsheet \
    docker \
    doubletwist \
    flux \
    google-chrome \
    iterm2 \
    mou \
    qq \
    spectacle \
    sublime-text \
    superduper \
    transmission \
    valentina-studio \
    vlc \
    virtualbox \
    the-unarchiver \
    thunder \
    evernote \

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

> Error: undefined method `core_tap?' for nil:NilClass

brew update --force

## 软件

bash_completion
zsh_completion

## 工具

* [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core):🍻 Default formulae for the missing package manager for macOS https://brew.sh
