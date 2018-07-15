# LNMP

## Linux

### Nginx

/etc/nginx
/var/www/html

```sh
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list

echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list  // Nginx1.9以上的版本可以在packages后添加/mainline，这是主线版本
echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.listen

sudo apt-get update
sudo apt-get install nginx

apt-get install python-software-properties
add-apt-repository ppa:nginx/stable
apt-get update
apt-get install nginx

sudo systemctl stop nginx.service
sudo systemctl start nginx.service
sudo systemctl restart nginx.service
sudo systemctl reload nginx.service
```

root目录显示文件列表

```
# 在http添加
autoindex on;
autoindex_exact_size off;
autoindex_localtime on;
```

### MySQL

```sh
sudo apt-get install mysql-server(mariadb-server mariadb-client)  mysql-client
sudo mysql_secure_installation

There are three levels of password validation policy:
# LOW    Length >= 8
# MEDIUM Length >= 8, numeric, mixed case, and special characters
# STRONG Length >= 8, numeric, mixed case, special characters and dictionary

wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
apt-get update
apt-get install percona-server-server-5.7


sudo service mysql status
sudo mysqladmin -p -u root version
```

### PHP

把PHP请求都发送到同一个文件上，然后在此文件里通过解析「REQUEST_URI」实现路由

```sh
sudo apt-get install python-software-properties software-properties-common
sudo apt-get install software-properties-common # ubuntu 18.04
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.1\
php7.1-fpm\
php7.1-mysql php7.1-common php7.1-curl php7.1-cli php7.1-mcrypt php7.1-mbstring php7.1-dom
php7.2-bcmath
```

- 修改配置文件sudo vim /etc/php/7.1/fpm/php.ini：`cgi.fix_pathinfo=0`
- sudo phpenmod mcrypt // 启用 mcrypt
- sudo service php7.1-fpm restart
- php -v

### Modules

* 默认安装模块
* 手动安装模块
  - curl
  - GD
  - pear
  - mcrypt
  - mbstring:php7.1-mbstring
  - intl
  - dom:php7.1-dom

```sh
sudo apt-cache search php7.1*

sudo apt-get install php7.1-mysql \
php7.1-curl \
php7.1-json \
php7.1-cgi \
php7.1-mbstring \
php7.1-xml \
php7.1-common \
php7.1-gd \
php7.1-cli \
php-pear \ # to ues pecl
php7.1-intl
php7.2-soap
php7.2-xdebug
php-xdebug

sudo apt-get install -y php-pear php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip
```

- Configure Nginx to Use the PHP Processor

  - default

```
# /etc/php/7.0/fpm/pool.d 修改 www.conf
listen = [::]:9000
fastcgi_pass 127.0.0.1:9000;  # /run/php/php7.2-fpm.sock

server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;
  index index.php index.html index.htm index.nginx-debian.html;

  server_name \_;

  location / {
      try_files $uri $uri/ =404;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.1-fpm.sock;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
  }
}
```

  - 自定义

    ```
     server {
      listen   80;
      root /home/vagrant/www/example.local;
      index index.php index.html index.htm;
      server_name example.local;

      location / {
          try_files $uri $uri/ /index.php?$args;
      }

      location ~ \.php$ {
          try_files $uri =404;
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass unix:/var/run/php/php5.6-fpm.sock;
          fastcgi_index index.php;
          include fastcgi_params;
          fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
      }
    ```

    }

- 语法检测：`sudo nginx -t`
- 服务重启：`sudo nginx -s reload`
- 添加域名
- 新建文件：`sudo vi /var/www/html/info.php`，并访问<http://server_domain_or_IP/info.php>

```php
phpinfo();
```

### phpunit

```sh
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
```

- 使用：

  - code : src/Email.php

    ```php
    declare(strict_types=1);

    final class Email
    {
    private $email;

    private function \__construct(string $email)
    {
        $this->ensureIsValidEmail($email);

        $this->email = $email;
    }

    public static function fromString(string $email): self
    {
        return new self($email);
    }

    public function \__toString(): string
    {
        return $this->email;
    }

    private function ensureIsValidEmail(string $email): void
    {
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidArgumentException(
                sprintf(
                    '"%s" is not a valid email address',
                    $email
                )
            );
        }
    }

    }
    ```
- Test Code: tests/EmailTest.php

  ```php
  declare(strict_types=1);

  use PHPUnit\Framework\TestCase;

  /**
  * @covers Email
  */
  final class EmailTest extends TestCase
  {
  public function testCanBeCreatedFromValidEmailAddress(): void
  {
    $this->assertInstanceOf(
        Email::class,
        Email::fromString('user@example.com')
    );
  }

  public function testCannotBeCreatedFromInvalidEmailAddress(): void
  {
    $this->expectException(InvalidArgumentException::class);

    Email::fromString('invalid');
  }

  public function testCanBeUsedAsString(): void
  {
    $this->assertEquals(
        'user@example.com',
        Email::fromString('user@example.com')
    );
  }
  }
  ```

- 使用`phpunit --bootstrap src/Email.php tests/EmailTest`

#### 网站搭建

- 域名申请:

  - 获取一级域名 example.com，
  - 域名认证(身份证)
  - 添加域名解析记录，默认两条记录，自由配置二级域名
  - 修改域名解析服务器，最长需要72个小时

- 购买服务器 : 获取ip，搭建LNMP环境

- https配置

  - 申请证书，下载并放到服务器
  - 分配到域名（会添加一条新记录到域名解析）
  - 修改配置文件

    ```
      ssl on;
      ssl_certificate conf.d/1_www.example.com_bundle.crt;
      ssl_certificate_key conf.d/2_www.example.com.key;
      ssl_session_timeout 5m;
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2; #按照这个协议配置
      ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;#按照这个套件配置
      ssl_prefer_server_ciphers on;
    ```

## 编译安装

* 软件源代码包存放位置：/usr/local/src
* 源码包编译安装位置：/usr/local/软件名字

### 下载

* 下载nginx：http://nginx.org/download/nginx-1.6.0.tar.gz
* 下载MySQL：http://cdn.mysql.com/Downloads/MySQL-5.6/mysql-5.6.19.tar.gz
* 下载php：http://cn2.php.net/distributions/php-5.5.14.tar.gz
* 下载pcre （支持nginx伪静态）：ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.35.tar.gz
* 下载openssl（nginx扩展）：http://www.openssl.org/source/openssl-1.0.1h.tar.gz
* 下载zlib（nginx扩展）：http://zlib.net/zlib-1.2.8.tar.gz
* 下载cmake（MySQL编译工具）：http://www.cmake.org/files/v2.8/cmake-2.8.11.2.tar.gz
* 下载libmcrypt（php扩展）：http://nchc.dl.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz
* 下载yasm（php扩展）：http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz：
* t1lib（php扩展）：ftp://sunsite.unc.edu/pub/Linux/libs/graphics/t1lib-5.1.2.tar.gz：
* 下载gd库安装包：https://bitbucket.org/libgd/gd-libgd/downloads/libgd-2.1.0.tar.gz：
* libvpx（gd库需要）：https://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2：
* tiff（gd库需要）：http://download.osgeo.org/libtiff/tiff-4.0.3.tar.gz：
* libpng（gd库需要）：ftp://ftp.simplesystems.org/pub/png/src/libpng16/libpng-1.6.12.tar.gz：
* freetype（gd库需要）：http://ring.u-toyama.ac.jp/archives/graphics/freetype/freetype2/freetype-2.5.3.tar.gz：
* jpegsrc（gd库需要）：http://www.ijg.org/files/jpegsrc.v9a.tar.gz

```sh
yum install -y apr* autoconf automake bison cloog-ppl compat* cpp curl curl-devel fontconfig fontconfig-devel freetype freetype* freetype-devel gcc gcc-c++ gtk+-devel gd gettext gettext-devel glibc kernel kernel-headers keyutils keyutils-libs-devel krb5-devel libcom_err-devel libpng* libjpeg* libsepol-devel libselinux-devel libstdc++-devel libtool* libgomp libxml2 libxml2-devel libXpm* libtiff libtiff* make mpfr ncurses* ntp openssl openssl-devel patch pcre-devel perl php-common php-gd policycoreutils telnet nasm nasm* wget zlib-devel

# 安装cmake
cd /usr/local/src
tar zxvf cmake-2.8.11.2.tar.gz
cd cmake-2.8.11.2
./configure
make
make install

# 安装MySQL
groupadd mysql #添加mysql组
useradd -g mysql mysql -s /bin/false #创建用户mysql并加入到mysql组，不允许mysql用户直接登录系统
mkdir -p /data/mysql #创建MySQL数据库存放目录
chown -R mysql:mysql /data/mysql #设置MySQL数据库存放目录权限
mkdir -p /usr/local/mysql #创建MySQL安装目录
cd /usr/local/src #进入软件包存放目录
tar zxvf mysql-5.6.19.tar.gz #解压
cd mysql-5.6.19 #进入目录
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/data/mysql -DSYSCONFDIR=/etc #配置
make #编译
make install #安装

rm -rf /etc/my.cnf #删除系统默认的配置文件（如果默认没有就不用删除）
cd /usr/local/mysql #进入MySQL安装目录
./scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql #生成mysql系统数据库
ln -s /usr/local/mysql/my.cnf  /etc/my.cnf #添加到/etc目录的软连接
cp ./support-files/mysql.server  /etc/rc.d/init.d/mysqld #把Mysql加入系统启动
chmod 755 /etc/init.d/mysqld #增加执行权限
chkconfig mysqld on #加入开机启动

vi /etc/rc.d/init.d/mysqld #编辑
basedir=/usr/local/mysql #MySQL程序安装路径
datadir=/data/mysql #MySQl数据库存放目录
service mysqld start #启动
vi /etc/profile #把mysql服务加入系统环境变量：在最后添加下面这一行
export PATH=$PATH:/usr/local/mysql/bin
:wq! #保存退出

source /etc/profile  #使配置立即生效

#下面这两行把myslq的库文件链接到系统默认的位置，这样你在编译类似PHP等软件时可以不用指定mysql的库文件地址。

ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
mkdir /var/lib/mysql #创建目录
ln -s /tmp/mysql.sock /var/lib/mysql/mysql.sock #添加软链接
mysql_secure_installation #设置Mysql密码，根据提示按Y 回车输入2次密码
```

安装Nginx

```sh
# 安装pcre
cd /usr/local/src
mkdir /usr/local/pcre
tar zxvf pcre-8.35.tar.gz
cd pcre-8.35
./configure --prefix=/usr/local/pcre
make
make install

# 安装openssl
cd /usr/local/src
mkdir /usr/local/openssl
tar zxvf openssl-1.0.1h.tar.gz
cd openssl-1.0.1h
./config --prefix=/usr/local/openssl
make
make install

vi /etc/profile #把openssl服务加入系统环境变量：在最后添加下面这一行
export PATH=$PATH:/usr/local/openssl/bin
:wq! #保存退出

source /etc/profile #使配置立即生效

# 安装zlib
cd /usr/local/src
mkdir /usr/local/zlib
tar zxvf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=/usr/local/zlib
make
make install

# 安装Nginx
groupadd www
useradd -g www www -s /bin/false
cd /usr/local/src
tar zxvf nginx-1.6.0.tar.gz
cd nginx-1.6.0
./configure --prefix=/usr/local/nginx --without-http_memcached_module --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-openssl=/usr/local/src/openssl-1.0.1h --with-zlib=/usr/local/src/zlib-1.2.8 --with-pcre=/usr/local/src/pcre-8.35
# 注意：--with-openssl=/usr/local/src/openssl-1.0.1h --with-zlib=/usr/local/src/zlib-1.2.8 --with-pcre=/usr/local/src/pcre-8.35 # 指向的是源码包解压的路径，而不是安装的路径，否则会报错
make
make install
/usr/local/nginx/sbin/nginx  #启动Nginx
```

设置nginx开机启动,`vi /etc/rc.d/init.d/nginx`  #编辑启动文件添加下面内容

```
############################################################

#!/bin/sh

#

# nginx - this script starts and stops the nginx daemon

#

# chkconfig: - 85 15

# description: Nginx is an HTTP(S) server, HTTP(S) reverse \

# proxy and IMAP/POP3 proxy server

# processname: nginx

# config: /etc/nginx/nginx.conf

# config: /usr/local/nginx/conf/nginx.conf

# pidfile: /usr/local/nginx/logs/nginx.pid

# Source function library.

. /etc/rc.d/init.d/functions

# Source networking configuration.

. /etc/sysconfig/network

# Check that networking is up.

[ "$NETWORKING" = "no" ] && exit 0

nginx="/usr/local/nginx/sbin/nginx"

prog=$(basename $nginx)

NGINX_CONF_FILE="/usr/local/nginx/conf/nginx.conf"

[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx

lockfile=/var/lock/subsys/nginx

make_dirs() {

# make required directories

user=`$nginx -V 2>&1 | grep "configure arguments:" | sed 's/[^*]*--user=\([^ ]*\).*/\1/g' -`

if [ -z "`grep $user /etc/passwd`" ]; then

useradd -M -s /bin/nologin $user

fi

options=`$nginx -V 2>&1 | grep 'configure arguments:'`

for opt in $options; do

if [ `echo $opt | grep '.*-temp-path'` ]; then

value=`echo $opt | cut -d "=" -f 2`

if [ ! -d "$value" ]; then

# echo "creating" $value

mkdir -p $value && chown -R $user $value

fi

fi

done

}

start() {

[ -x $nginx ] || exit 5

[ -f $NGINX_CONF_FILE ] || exit 6

make_dirs

echo -n $"Starting $prog: "

daemon $nginx -c $NGINX_CONF_FILE

retval=$?

echo

[ $retval -eq 0 ] && touch $lockfile

return $retval

}

stop() {

echo -n $"Stopping $prog: "

killproc $prog -QUIT

retval=$?

echo

[ $retval -eq 0 ] && rm -f $lockfile

return $retval

}

restart() {

#configtest || return $?

stop

sleep 1

start

}

reload() {

#configtest || return $?

echo -n $"Reloading $prog: "

killproc $nginx -HUP

RETVAL=$?

echo

}

force_reload() {

restart

}

configtest() {

$nginx -t -c $NGINX_CONF_FILE

}

rh_status() {

status $prog

}

rh_status_q() {

rh_status >/dev/null 2>&1

}

case "$1" in

start)

rh_status_q && exit 0

$1

;;

stop)

rh_status_q || exit 0

$1

;;

restart|configtest)

$1

;;

reload)

rh_status_q || exit 7

$1

;;

force-reload)

force_reload

;;

status)

rh_status

;;

condrestart|try-restart)

rh_status_q || exit 0

;;

*)

echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"

exit 2

esac

############################################################
:wq! #保存退出

chmod 775 /etc/rc.d/init.d/nginx #赋予文件执行权限
chkconfig nginx on #设置开机启动
/etc/rc.d/init.d/nginx restart #重启
```
php 安装

```php
# 安装yasm
cd /usr/local/src
tar zxvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
./configure
make
make install

# 安装libmcrypt
cd /usr/local/src
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure
make
make install

# 安装libvpx
cd /usr/local/src
tar xvf libvpx-v1.3.0.tar.bz2
cd libvpx-v1.3.0
./configure --prefix=/usr/local/libvpx --enable-shared --enable-vp9
make
make install

# 安装tiff
cd /usr/local/src
tar zxvf tiff-4.0.3.tar.gz
cd tiff-4.0.3
./configure --prefix=/usr/local/tiff --enable-shared
make
make install

# 安装libpng
cd /usr/local/src
tar zxvf libpng-1.6.12.tar.gz
cd libpng-1.6.12
./configure --prefix=/usr/local/libpng --enable-shared
make
make install

# 安装freetype
cd /usr/local/src
tar zxvf freetype-2.5.3.tar.gz
cd freetype-2.5.3
./configure --prefix=/usr/local/freetype --enable-shared
make #编译
make install #安装

# 安装jpeg
cd /usr/local/src
tar zxvf jpegsrc.v9a.tar.gz
cd jpeg-9a
./configure --prefix=/usr/local/jpeg --enable-shared
make #编译
make install #安装

# 安装libgd
cd /usr/local/src
tar zxvf libgd-2.1.0.tar.gz #解压
cd libgd-2.1.0 #进入目录
./configure --prefix=/usr/local/libgd --enable-shared --with-jpeg=/usr/local/jpeg --with-png=/usr/local/libpng --with-freetype=/usr/local/freetype --with-fontconfig=/usr/local/freetype --with-xpm=/usr/ --with-tiff=/usr/local/tiff --with-vpx=/usr/local/libvpx #配置
make #编译
make install #安装

# 安装t1lib
cd /usr/local/src
tar zxvf t1lib-5.1.2.tar.gz
cd t1lib-5.1.2
./configure --prefix=/usr/local/t1lib --enable-shared
make without_doc
make install

# 安装php
# 注意：如果系统是64位，请执行以下两条命令，否则安装php会出错（32位系统不需要执行）
ln -s /usr/lib64/libltdl.so /usr/lib/libltdl.so
\cp -frp /usr/lib64/libXpm.so* /usr/lib/

cd /usr/local/src
tar -zvxf php-5.5.14.tar.gz
cd php-5.5.14
export LD_LIBRARY_PATH=/usr/local/libgd/lib
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --with-mysql=/usr/local/mysql --with-mysqli=/usr/local/mysql/bin/mysql_config --with-mysql-sock=/tmp/mysql.sock --with-pdo-mysql=/usr/local/mysql --with-gd --with-png-dir=/usr/local/libpng --with-jpeg-dir=/usr/local/jpeg --with-freetype-dir=/usr/local/freetype --with-xpm-dir=/usr/ --with-vpx-dir=/usr/local/libvpx/ --with-zlib-dir=/usr/local/zlib --with-t1lib=/usr/local/t1lib --with-iconv --enable-libxml --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-opcache --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --enable-session --with-mcrypt --with-curl --enable-ctype  #配置
make  #编译
make install  #安装

cp php.ini-production /usr/local/php/etc/php.ini  #复制php配置文件到安装目录
rm -rf /etc/php.ini  #删除系统自带配置文件
ln -s /usr/local/php/etc/php.ini /etc/php.ini   #添加软链接到 /etc目录
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf  #拷贝模板文件为php-fpm配置文件
ln -s /usr/local/php/etc/php-fpm.conf  /etc/php-fpm.conf  #添加软连接到 /etc目录

vi /usr/local/php/etc/php-fpm.conf #编辑

user = www #设置php-fpm运行账号为www
group = www #设置php-fpm运行组为www
pid = run/php-fpm.pid #取消前面的分号
:wq!

# 设置 php-fpm开机启动
cp /usr/local/src/php-5.5.14/sapi/fpm/init.d.php-fpm /etc/rc.d/init.d/php-fpm #拷贝php-fpm到启动目录
chmod +x /etc/rc.d/init.d/php-fpm #添加执行权限
chkconfig php-fpm on #设置开机启动
```

编辑配置文件 `vi /usr/local/php/etc/php.ini`

```
找到：disable_functions =
修改为：disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,escapeshellcmd,dll,popen,disk_free_space,checkdnsrr,checkdnsrr,getservbyname,getservbyport,disk_total_space,posix_ctermid,posix_get_last_error,posix_getcwd, posix_getegid,posix_geteuid,posix_getgid, posix_getgrgid,posix_getgrnam,posix_getgroups,posix_getlogin,posix_getpgid,posix_getpgrp,posix_getpid, posix_getppid,posix_getpwnam,posix_getpwuid, posix_getrlimit, posix_getsid,posix_getuid,posix_isatty, posix_kill,posix_mkfifo,posix_setegid,posix_seteuid,posix_setgid, posix_setpgid,posix_setsid,posix_setuid,posix_strerror,posix_times,posix_ttyname,posix_uname

#列出PHP可以禁用的函数，如果某些程序需要用到这个函数，可以删除，取消禁用。

找到：;date.timezone =
修改为：date.timezone = PRC #设置时区

找到：expose_php = On
修改为：expose_php = Off #禁止显示php版本的信息

找到：short_open_tag = Off
修改为：short_open_tag = ON #支持php短标签

找到opcache.enable=0
修改为opcache.enable=1 #php支持opcode缓存

找到：opcache.enable_cli=1 #php支持opcode缓存
修改为：opcache.enable_cli=0

在最后一行添加：zend_extension=opcache.so #开启opcode缓存功能
```

```
配置nginx支持php

vi /usr/local/nginx/conf/nginx.conf

修改/usr/local/nginx/conf/nginx.conf 配置文件,需做如下修改

user www www; #首行user去掉注释,修改Nginx运行组为www www；必须与/usr/local/php/etc/php-fpm.conf中的user,group配置相同，否则php运行出错
index index.html index.htm index.php; #添加index.php

# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000

location ~ \.php$ {
    root html;
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

#取消FastCGI server部分location的注释,注意fastcgi_param行的参数,改为$document_root$fastcgi_script_name,或者使用绝对路径
/etc/init.d/nginx restart #重启nginx
service php-fpm start #启动php-fpm
```

前后端分离配置：后端配置代理

```
server {
    listen      8082;
    server_name localhost;
    root        /Users/henry/Workspace/ShareFolder/Front/dist;
    index       index.html index.htm
    charset     utf-8;

    access_log      /usr/local/var/log/nginx/front-test.access.log;
    error_log       /usr/local/var/log/nginx/front-test.error.log;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~ /api/ {
        proxy_pass  http://tp5.app.local:8080;
    }
}
```

### 测试

```
测试篇

cd /usr/local/nginx/html/ #进入nginx默认网站根目录
rm -rf /usr/local/nginx/html/* #删除默认测试页
vi index.php #新建index.php文件

<?php
phpinfo();
?>
:wq! #保存退出

chown www.www /usr/local/nginx/html/ -R #设置目录所有者
chmod 700 /usr/local/nginx/html/ -R #设置目录权限
# 在浏览器中打开服务器IP地址，会看到下面的界面
```

## Mac环境搭建

```sh
# 系统默认apache 与php5
httpd -v
php -v

# 停止httpd服务
sudo apachectl stop

# 卸载apache 与PHP56
sudo rm /usr/sbin/apachectl
sudo rm /usr/sbin/httpd
sudo rm -r /etc/apache2/  sudo rm -r /usr/bin/php

# 开启启动
$ cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
$ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php70.plist

# 配置nginx
$ cp /usr/local/Cellar/nginx/1.10.2_1/homebrew.mxcl.nginx.plist ~/Library/LaunchAgents/
$ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist

sudo chown root:wheel /usr/local/Cellar/nginx/1.10.2_1/bin/nginx
sudo chmod u+s /usr/local/Cellar/nginx/1.10.2_1/bin/nginx
sudo nginx -s reload/reopen/stop/quit

/usr/local/etc/nginx/nginx.conf
sudo brew services start nginx
curl -IL http://127.0.0.1:8080
sudo brew services stop nginx

mkdir -p /usr/local/etc/nginx/sites-available && \
mkdir -p /usr/local/etc/nginx/sites-enabled && \
mkdir -p /usr/local/etc/nginx/conf.d && \
mkdir -p /usr/local/etc/nginx/ssl

# mysql
brew install mysql

cd /usr/local/opt/mysql/
sudo vim my.cnf

./bin/mysql_install_db #初始化
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql
/usr/local/bin/mysqladmin -u root password 'new-password' # 设置密码
/usr/local/bin/mysql_secure_installation  # 安全脚本
mysql -u root -p

# PHP配置
brew install php71 --with-imap --with-tidy --with-debug --with-pgsql --with-mysql --with-fpm

/usr/local/etc/php/7.1/php-fpm.conf

;pid = run/php-fpm.log
;error_log = log/php-fpm.log
修改为
pid = /usr/local/var/run/php-fpm.pid
error_log = /usr/local/var/log/php-fpm.log

# php配置
/usr/local/etc/php/7.1/php.ini  # 错误级别定义

/usr/local/etc/php/7.1/php-fpm.d/www.conf

brew services start php70
lsof -Pni4 | grep LISTEN | grep php

alias nginx.start='launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'
alias nginx.stop='launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'
alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php54.plist"
alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php54.plist"
alias php-fpm.restart='php-fpm.stop && php-fpm.start'
alias mysql.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist"
alias mysql.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mariadb.plist"
alias mysql.restart='mysql.stop && mysql.start'

openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/O=Office/CN=localhost" -keyout /usr/local/etc/nginx/ssl/localhost.key -out /usr/local/etc/nginx/ssl/localhost.crt
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=State/L=Town/O=Office/CN=phpmyadmin" -keyout /usr/local/etc/nginx/ssl/phpmyadmin.key -out /usr/local/etc/nginx/ssl/phpmyadmin.crt
```

## 参考

* [Mac OS X LEMP Configuration](https://gist.github.com/petemcw/9265670)
* [lj2007331/oneinstack](https://github.com/lj2007331/oneinstack):OneinStack - A PHP/JAVA Deployment Tool https://oneinstack.com/
* [cytopia/devilbox](https://github.com/cytopia/devilbox):A modern dockerized LAMP and MEAN stack alternative to XAMPP http://devilbox.org
* [lj2007331/lnmp](https://github.com/lj2007331/lnmp):LEMP stack/LAMP stack/LNMP stack installation scripts for CentOS/Redhat Debian and Ubuntu https://blog.linuxeye.cn/31.html
