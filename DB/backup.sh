#!/bin/sh
##########################################
#this scripts create by root of mingongge
#create at 2016-11-11
#######################################
ip=`grep 'IPADDR' /etc/ysconfig/network-scripts/ifcfg-eth0|awk -F "=" '{print $2}'`
 #定义服务器IP变量
BAKDIR=/backup
  #定义备份路径
[ ! -d $BAKDIR/${ip} ] && mkdir -p $BAKDIR/${ip}
 #判断如果不存在这个路径就创建一个，为了服务器多的时候方便看
DB_PWD="mingongge"
DB_USER="root"
MYSQL="/application/mysql/bin/mysql"
MYSQL_DUMP="/application/mysql/bin/mysqldump"
DATA=`date +%F`
####bak data of test's databses####
DB_NAME=`$MYSQL -u$DB_USER -p$DB_PWD -e "show databases;"|sed '1,5d'`
  #定义数据库变量
for name in $DB_NAME
#for循环语句取库名
do
  $MYSQL_DUMP -u$DB_USER -p$DB_PWD -B ${name} |gzip >$BAKDIR/${ip}/${name}_$DATA.sql.gz
 #全库备份
  [ ! -d $BAKDIR/${ip}/${name} ] && mkdir -p  $BAKDIR/${ip}/${name}
#判断这个路径，为了区别哪个库的备份文件
  for tablename in `$MYSQL -u$DB_USER -p$DB_PWD -e "show tables from ${name};"|sed '1d'`
#for循环语句取表名
  do
   $MYSQL_DUMP -u$DB_USER -p$DB_PWD ${name} ${tablename} |gzip >$BAKDIR/${ip}/${name}/${tablename}_$DATA.sql.gz
#分表备份
  done
done
