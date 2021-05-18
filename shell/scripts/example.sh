# 处理命令行参数的一个样例：
while [ "$1" != "" ]; do
    case $1 in
        -s  )   shift
    SERVER=$1 ;;
        -d  )   shift
    DATE=$1 ;;
  --paramter|p ) shift
    PARAMETER=$1;;
        -h|help  )   usage # function call
                exit ;;
        * )     usage # All other parameters
                exit 1
    esac
    shift
done

#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

#!/bin/bash
#

#==================
start_mysql() {
    printf "Starting MySQL...\n"
    /etc/rc.d/mysqld start
}
stop_mysql() {
    printf "Stopping MySQL...\n"
    /etc/rc.d/mysqld stop
}
restart_mysql() {
    printf "Restarting MySQL...\n"
    /etc/rc.d/mysqld restart
}
start_php() {
    printf "Starting PHP-FPM...\n"
    ulimit -SHn 65535
    /etc/rc.d/php-fpm start
}
stop_php() {
    printf "Stopping PHP-FPM...\n"
    /etc/rc.d/php-fpm stop
}
restart_php() {
    printf "Restarting PHP-FPM...\n"
    /etc/rc.d/php-fpm restart
}
start_apache2() {
    printf "Starting Apache2...\n"
    /etc/rc.d/httpd start
}
stop_apache2() {
    printf "Stopping Apache2...\n"
    /etc/rc.d/httpd stop
}
restart_apache2() {
    printf "Restarting Apache2...\n"
    /etc/rc.d/httpd restart
}
start_nginx() {
    printf "Starting Nginx...\n"
    /etc/rc.d/nginx start
}
stop_nginx() {
    printf "Stopping Nginx...\n"
    /etc/rc.d/nginx stop
}
restart_nginx() {
    printf "Restarting Nginx...\n"
    /etc/rc.d/nginx restart
}
start_lighttpd() {
    printf "Starting LigHttpd...\n"
    /etc/rc.d/lighttpd start
}
stop_lighttpd() {
    printf "Stopping LigHttpd...\n"
    /etc/rc.d/lighttpd stop
}
restart_lighttpd() {
    printf "Restarting LigHttpd...\n"
    /etc/rc.d/lighttpd restart
}
#==================

echo "Choose instance:"
echo "1. nginx + php-fpm + mysqld + postfix"
echo "2. lighttpd + php-fpm + mysqld + postfix"
echo "3. apache2 + php + mysql + postfix"
read num
    case $num in
        1)
            echo "nginx + php-fpm + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_php
                        start_nginx
                        ;;
                    2)
                        stop_mysql
                        stop_php
                        stop_nginx
                        ;;
                    3)
                        restart_mysql
                        restart_php
                        restart_nginx
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        2)
            echo "lighttpd + php-fastcgi + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_lighttpd
                        ;;
                    2)
                        stop_mysql
                        stop_lighttpd
                        ;;
                    3)
                        restart_mysql
                        restart_lighttpd
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        3)
            echo "apache2 + php + mysqld"
            echo "Choose instance:"
            echo "1. start"
            echo "2. stop"
            echo "3. restart"
            read num
                case $num in
                    1)
                        start_mysql
                        start_apache2
                        ;;
                    2)
                        stop_mysql
                        stop_apache2
                        ;;
                    3)
                        restart_mysql
                        restart_apache2
                        ;;
                    *)
                        echo "Wrong number, please re-run and choose again."
                        ;;
                esac
            exit 0
            ;;
        *)
            echo " Wrong number, please re-run and choose again."
            ;;
    esac
exit 0
