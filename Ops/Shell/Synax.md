# shell

```sh
# 命令失败，往往需要脚本停止执行，防止错误累积
set -e
command || { echo "command failed"; exit 1; }
if ! command; then echo "command failed"; exit 1; fi
command
if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi
```

## 端口占用

```sh
netstat -an | grep 3306
lsof -i:80 # -i参数表示网络链接，:80指明端口号
```
