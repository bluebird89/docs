#!/bin/bash
# 设置 crontab -e 为每日凌晨 3 点
#0 3 * * * /root/OMCS/script/nginx_log.sh

for ngix_i in `ls /app/local`
do
     # 设置临时变量
     nginx_dir=`basename ${ngix_i}`
     if ( echo "$nginx_dir"|grep "nginx" > /dev/null ); then
          # echo $nginx_dir
          # 设置日志文件存放目录
          logs_path="/app/local/$nginx_dir/logs/"
          # 设置备份日志存放目录
          logs_bak="/app/local/$nginx_dir/logs/bak/"
          # 设置 pid 文件
          pid_path="/app/local/$nginx_dir/logs/nginx.pid"

          # 判断目录是否存在
          if  [ ! -d  "$logs_path" ]; then
               continue
          fi
          # 判断文件是否存在
          if  [ ! -e  "$pid_path" ]; then
               continue
          fi

          # 判断目录是否存在
          if  [ ! -d  "$logs_bak" ]; then
               mkdir -p "$logs_bak"
          fi

          cd ${logs_path}
          logfiles=(`ls *.log`)

          array_i=0
          # 迁移日志循环模块
          for i in ${logfiles[@]};
          do
               # 设置临时变量
               j=`basename ${i}`
               # 重命名并迁移日志文件
               baklogname=${j}_$(date -d "yesterday" +"%Y%m%d%H%M%S")
               baklognames[$array_i]=$baklogname
               mv ${i} ${logs_bak}${baklogname}
               array_i=`expr $array_i + 1`
          done

          # 向 nginx 主进程发信号重新打开日志
          kill -USR1 `cat ${pid_path}`

          cd ${logs_bak}
          # 压缩日志循环模块
          for i in ${baklognames[@]};
          do
               # 压缩并删除原日志
               tar -zcvf ${i}.tar.gz ${i} --remove-files > /dev/null 2>&1
          done

          # 清理 7 天前的日志
          find ${logs_bak} -name '*'  -mtime +90 | xargs rm -rf {}

     fi

done
