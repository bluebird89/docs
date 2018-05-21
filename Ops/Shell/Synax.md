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


```sh
find / -name *.conf -type f -print | xargs file

find / -name *.conf -type f -print | xargs tar cjf test.tar.gz

ssh -p 22 -C -f -N -g -L 9200:192.168.1.19:9200 ihavecar@192.168.1.19

netstat -anlp|grep 80|grep tcp|awk '{print $5}'|awk -F: '{print $1}'|sort|uniq -c|sort -nr|head -n20

netstat -nat |awk ‘{print $6}’|sort|uniq -c|sort -rn


ping api.jpush.cn | awk ‘{ print $0”    “ strftime(“%Y-%m-%d %H:%M:%S”,systime()) } ‘ >> /tmp/jiguang.log &

wget ftp://ftp.is.co.za/mirror/ftp.rpmforge.net/redhat/el6/en/x86_64/dag/RPMS/multitail-5.2.9-1.el6.rf.x86_64.rpm
yum -y localinstall multitail-5.2.9-1.el6.rf.x86_64.rpm
multitail -e "Accepted" /var/log/secure -l "ping baidu.com"

ps -aux | sort -rnk 3 | head -20

ps -aux | sort -rnk 4 | head -20
```
