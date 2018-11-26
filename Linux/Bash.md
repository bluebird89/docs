# Bash

## 命令

* ag：比grep、ack更快的递归搜索文件内容。
* tig：字符模式下交互查看git项目，可以替代git命令。
* mycli：mysql客户端，支持语法高亮和命令补全，效果类似ipython，可以替代mysql命令。
* jq: json文件处理以及格式化显示，支持高亮，可以替换python -m json.tool。
* shellcheck：shell脚本静态检查工具，能够识别语法错误以及不规范的写法。
* yapf：Google开发的python代码格式规范化工具，支持pep8以及Google代码风格。
* mosh：基于UDP的终端连接，可以替代ssh，连接更稳定，即使IP变了，也能自动重连。
* fzf：命令行下模糊搜索工具，能够交互式智能搜索并选取文件或者内容，配合终端ctrl-r历史命令搜索简直完美。
* PathPicker(fpp):在命令行输出中自动识别目录和文件，支持交互式，配合git非常有用
* htop: 提供更美观、更方便的进程监控工具，替代top命令。
* axel：多线程下载工具，下载文件时可以替代curl、wget。
* sz/rz：交互式文件传输，在多重跳板机下传输文件非常好用，不用一级一级传输。
* cloc：代码统计工具，能够统计代码的空行数、注释行、编程语言。
* ccache：高速C/C++编译缓存工具，反复编译内核非常有用。使用起来也非常方便
* tmux：终端复用工具，替代screen、nohup
* neovim: 替代vim。
* script/scriptreplay: 终端会话录制。
* you-get: 非常强大的媒体下载工具，支持youtube、google+、优酷、芒果TV、腾讯视频、秒拍等视频下载。
* thefuck：用途是每次命令行打错了以后，打一句fuck就会自动更正命令。比如apt-get打成了aptget。fuck以后自动变成apt-get。但还是没加sudo。再fuck，成功！
* tldr: 如果你经常不想详读man文档，那么你应该试试这个小工具。

```sh
cat demo.json | jq '.id,.name,.status,.attachments'

axel -n 20 http://centos.ustc.edu.cn/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso
ccache gcc foo.c
```

## Alias

```sh
alias untar='tar -zxvf '
alias wget='wget -c ' # 下载的东西，但如果出现问题可以恢复
alias getpass="openssl rand -base64 20" # 新的网络帐户生成随机的 20 个字符的密码
alias sha='shasum -a 256 ' # 下载文件并需要测试校验和
alias ping='ping -c 5' #  限制在五个 ping
alias www='python -m SimpleHTTPServer 8000' # 在任何你想要的文件夹中启动 Web 服务器。
alias speed='speedtest-cli --server 2406 --simple' # 网络有多快？只需下载 Speedtest-cli 并使用此别名即可。你可以使用 speedtest-cli --list 命令选择离你所在位置更近的服务器。
alias ipe='curl ipinfo.io/ip' # 需要知道你的外部 IP 地址
alias ipi='ipconfig getifaddr en0' # 知道你的本地 IP 地址
alias c='clear'
```

## 工具

* [tartley/colorama](https://github.com/tartley/colorama):Simple cross-platform colored terminal text in Python
* [dylanaraps/fff](https://github.com/dylanaraps/fff):🚀 fucking fast file-manager
* [jmacdonald/amp](https://github.com/jmacdonald/amp):A complete text editor for your terminal. https://amp.rs
