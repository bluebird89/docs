#/bin/bash
#日志文件
logfile=/usr/local/var/log/nginx
last_minutes=1
#开始时间
start_time=`date -d"$last_minutes minutes ago" +"%H:%M:%S"`
echo $start_time
#结束时间
stop_time=`date +"%H:%M:%S"`
echo $stop_time
#过滤出单位之间内的日志并统计最高ip数
tac $logfile/access.log | awk -v st="$start_time" -v et="$stop_time" '{t=substr($4,RSTART+14,21);if(t>=st && t<=et) {print $0}}' \
| awk '{print $1}' | sort | uniq -c | sort -nr > $logfile/log_ip_top10
ip_top=`cat $logfile/log_ip_top10 | head -1 | awk '{print $1}'`
ip=`cat $logfile/log_ip_top10 | awk '{if($1>20)print $2}'`
# 单位时间[1分钟]内单ip访问次数超过200次的ip通过ipset封锁
for line in $ip
do
echo $line >> $logfile/black.log
ipset add blacklist $line
done
