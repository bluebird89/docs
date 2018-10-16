# Bash

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
