# shell

```sh
# 命令失败，往往需要脚本停止执行，防止错误累积
set -e
command || { echo "command failed"; exit 1; }
if ! command; then echo "command failed"; exit 1; fi
command
if [ "$?" -ne 0 ]; then echo "command failed"; exit 1; fi
```
