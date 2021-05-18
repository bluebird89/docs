#!/bin/bash
# 处理时间[14/Mar/2015:01:12:59成2015-Mar-14 01:12:59
function unixtime()
{
    if [ -n "$!"] ;
    then
        TIME=`echo ${1:1} | awk -F'[:\b/]' '{print $3"-"$2"-"$1" "$4":"$5":"$6}'`
        echo $TIME
    fi
}

#存放日志的路径
LOG_PATH='/var/log/nginx/'

#有那些日志
LOGS=('test')

#处理昨天的日志
YESTERDAY=`date -d "yesterday" +"%Y-%m-%d"`

#连接数据库的账号密码及其数据库
SQLCNT='/usr/local/mysql/bin/mysql -uroot -p123456 test'
SQL="INSERT INTO log(ip,url,time,date)VALUES"

#获取当前的时间
DATE=`date -d "yesterday" +"%Y%m%d"`

#循环读取所有的日志 ， 并进行读取
for LOG in ${LOGS[@]} ;
do
    #读取后缀为/ .或者.html 或php的访问文件
    DATA=`/bin/cat "$LOG_PATH$LOG-$YESTERDAY.log" | awk '$7 ~ /(\/$|\.html.*|\.php.*)/ {print $1"--"$4"--"$7}'  `
    #计算器 , 插入的数据超过1000条先提前插入
    I=1
    QRYSQL=''
    for D in ${DATA[@]} ;
    do
          #将上面时间获取ip—时间—访问的url进行转化为数组
          DD=(`echo ${D//--/ }`)
          QRYSQL=$QRYSQL"('${DD[0]}','${DD[2]}','`unixtime ${DD[1]}`','$DATE'),"
          #超过1000条先插入
          if [ $I == 1000 ] ;
          then
                QRYSQL=$SQL${QRYSQL%%,}";"
                echo $QRYSQL | $SQLCNT &> /dev/null
                I=0
                QRYSQL=''
          fi
          I=`expr $I+1`
    done
    if [ -n $WRYSQL ] ; then
          QRYSQL=$SQL${QRYSQL%%,}";"
          echo $QRYSQL | $SQLCNT &> /dev/null
    fi
done
