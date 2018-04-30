# MacPORTS

[MacPORTS](https://guide.macports.org/)an open-source community initiative to design an easy-to-use system for compiling, installing, and upgrading either command-line, X11 or Aqua based open-source software on the Mac operating system.

Mac算是BSD的一个变种吧。所以，BSD的包管理软件port被移植到Mac上就显的理所当然了。 macports的工作方式是下载source code然后在本地编译。macport的理念是尽量减少对系统现有库的依赖。 所以，第一次用macport的时候，需要很长时间让macport重新build整个基本库。代价是较长的编译时间，较多的依赖关系下载。好处是不怎么依赖系统，也就是说，更新Mac OS不会破坏你现有的 package。 另外，macports安装所有的package到/opt/local下面。这样不会和系统现有的/usr/local有什么冲突。
通过rsync维持数据索引一致

## 使用

```shell
wget http://distfiles.macports.org/MacPorts/MacPorts-1.9.2.tar.gz
tar zxvf MacPorts-1.9.2.tar.gz
cd MacPorts-1.9.2
./configure && make && sudo make install
cd ../
rm -rf MacPorts-1.9.2*

# 添加 /etc/profile
export PATH=/opt/local/bin:$PATH
export PATH=/opt/local/sbin:$PATH

sudo port -v selfupdate  # 更新 MacPorts 索引
port search NAME
sudo port install NAME
sudo port uninstall NAME
port outdated
sudo port upgrade outdated
port help selfupdate
port list

port search --name --glob 'php*'
port search --name --line --glob 'php*'
port search --name --line --regex '^php\d*$'

port info yubico-pam
port deps apache2 +openldap
port contents xorg-renderproto
port installed

# 卸载
sudo port -fp uninstall installed
sudo rm -rf \
        /opt/local \
        /Applications/DarwinPorts \
        /Applications/MacPorts \
        /Library/LaunchDaemons/org.macports.* \
        /Library/Receipts/DarwinPorts*.pkg \
        /Library/Receipts/MacPorts*.pkg \
        /Library/StartupItems/DarwinPortsStartup \
        /Library/Tcl/darwinports1.0 \
        /Library/Tcl/macports1.0 \
        ~/.macports
```

#### 问题

Failed to initialize MacPorts, OS platform mismatch 重新安装