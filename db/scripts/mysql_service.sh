# 脚本文件
#!/bin/sh
init port=3307
mysql_user="root"
mysql_pwd="migongge"
CmdPath="/application/mysql/bin"
mysql_sock="/data/${port}/mysql.sock"

#startup
function_start_mysql() {
    if [ ! -e "$mysql_sock" ];then
      printf "Starting MySQL...\n"
      /bin/sh ${CmdPath}/mysqld_safe --defaults-file=/data/${port}/my.cnf 2>&1 > /dev/null &
    else
      printf "MySQL is running...\n"
      exit
    fi
}
#stop function
function_stop_mysql() {
    if [ ! -e "$mysql_sock" ];then
      printf "MySQL is stopped...\n"
      exit
    else
      printf "Stoping MySQL...\n"
      ${CmdPath}/mysqladmin -u ${mysql_user} -p${mysql_pwd} -S /data/${port}/mysql.sock shutdown
    fi
}
#restart function
function_restart_mysql() {
   printf "Restarting MySQL...\n"
   function_stop_mysql
   sleep 2
   function_start_mysql
}

case $1 in
start)
function_start_mysql
;;
stop)
function_stop_mysql
;;
restart)
function_restart_mysql
;;
*)
printf "Usage: /data/${port}/mysql {start|stop|restart}\n"
esac
