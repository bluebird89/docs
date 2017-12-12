# Apache

最流行的服务器

* 基于文件配置。
* 跨平台的。所有操作系统都能安装。
* 虚拟主机。

## 本地环境

* xampp
* WAMP
* phpstudy

## 文件结构

* Apache2:程序目录
* bin:二进制文件 httpd
* conf:配置文件
    - httpd.conf
* htdocs:默认网站根目录
* log:日志目录
    - 通过Analog或Webalizer等实用程序访问日志文件
* modules:加载的第三方插件
* Apache2 Service Monitor:监控apache2服务

## 使用

### windows

* apache2运行于系统服务中。
* 将bin目录添加到系统变量：Path中添加 apache2/bin(需要重启命令行客户端)

```sh
httpd -t # 检测配置语法

net start apache2 # 服务管理
net stop apache2
```

### mac

系统本身带有apache2

* 程序位置：/private/etc/apache2 或者 /etc/apache2
* 配置文件：httpd.conf
* 开启 `LoadModule php7_module libexec/apache2/libphp7.so`
* 站点默认目录：`DocumentRoot "/Library/WebServer/Documents"`
* `DirectoryIndex index.php index.html`
* 进程管理,用httpd或者aapachectl

```sh
apachectl -v
httpd -t
sudo httpd -k start
sudo httpd -k stop
sudo apachectl -k restart
```

### 配置

httpd.conf文件为服务器的主配置文件

* DocumentRoot：网站的根目录，一般绝对路径  `DocumentRoot："E:\www\local"`
* DirectoryIndex：指定网站的默认首页 `DirectoryIndex index.html index.htm index.php`
* Apache启动后，会监听自己电脑的网卡的IP(或端口)的访问
    - listen 80   监听自己电脑的所有IP的80端口的请求
    - listen 192.168.21.80:80   监听自己电脑的指定IP的指定端口的访问。
* `<Directory></Directory>`:默认为所有目录配置的访问权限
    - Options:指定开放哪些服务器特性
        + All：开放所有权限。
        + None：不开放任何权限，任何人都无权访问。
        + Indexes：如果指定的首页文件名(DirectoryIndex)不存在，则会显示格式化目录列表。
        + FollowSymLinks：表示支持符号链接
    - Order:deny allow同时出现，指定禁止和允许的顺序，后面的重写前面的
        + Order Deny,Allow   先禁止，后允许
        + Order Allow,Deny   先允许，后禁止 
    - Deny:禁止哪些外部IP的访问
        + Deny from All    //禁止所有IP的访问
        + Deny from 192.168.21.89   //禁止192.168.21.89的访问
        + Deny from 192.168.21     //禁止了整个网段
        + Deny from 192.168.21.89  192.168.21.34 //同时禁止这个IP访问
    - allow:允许哪些外部IP的访问
        + Allow from All 
        + Allow from 192.168.21.89
        + Allow from 192.168.21.89  192.168.21.34

```
DocumentRoot："E:\www\local"
<Directory E:\www\local>
    Options All
    Order Deny,allow
    Deny from All
    Allow from All
</Directory>
```

#### 分布式配置文件

* 在.htaccess配置文件中加入的配置信息只会影响.htaccess所在目录以及子目录的运行效果.
* 通过.htaccess不用重启服务器
* 在没有权限修改apache的配置文件或者php的配置文件时可以使用.htaccess来修改Apache原本的配置。
* 修改PHP配置信息

```
php_flag session.auto_start 1 # 指定开关类的配置信息
php_value date.timezone PRC # 指定字符串形式的配置信息
```

#### 虚拟主机

同一个主机上虚拟出来的网站.

* 配置了其他的虚拟主机，默认的主机就会改变为第一个虚拟主机。虚拟主机的优先级最高，比全局配置中的虚拟主机优先级要高。将默认主机作为一个虚拟主机放在第一个虚拟主机的位置即可。第1个虚拟主机的优先最高，localhost或127.0.0.1都会指向它。
* 如果在hosts文件指了域名，但在虚拟主机中并未配置这个域名，此时，将指向第1个虚拟主机。
* 单独再配置一个localhost的虚拟主机，并指向原来的目录。

步骤

* 配置host文件
* 修改httpd.conf文件包含extra\httpd-vhosts.conf
* 添加httpd-vhosts.conf中的配置

```
NameVirtualHost *:80
#配置localhost虚拟主机
<VirtualHost *:80>
    #指定服务器的域名
    ServerName localhost
    #指定网站根目录
    DocumentRoot "e:/www"
    #指定目录权限
    <Directory "e:/www">
        Options Indexes
        Order Deny,Allow
        Deny from All
        Allow from All
    </Directory>
</VirtualHost>
#配置www.2015.com虚拟主机
<VirtualHost *:80>
    #指定服务器的域名
    ServerName www.2015.com
    #指定网站根目录
    DocumentRoot "e:/itcast/20151101/lesson/day1"
    #指定目录权限
    <Directory "e:/itcast/20151101/lesson/day1">
        Options Indexes
        Order Deny,Allow
        Deny from All
        Allow from All
    </Directory>
    # 访问www.2015.com/music
    Alias /music “e:/itcast/20151101/music”
    <Directory "e:/itcast/20151101/lesson/day1">
        Options Indexes
        Order Deny,Allow
        Deny from All
        Allow from All
    </Directory>
</VirtualHost>
```

## WAMP

### apache 配置

在apache配置中添加PHP模块，PHP模块不用单独启动，也不能单独停止，一般情况下，是Apache启动时，PHP5模块也跟着启动了。

```
httpd.exe -M # 查看apache加载了哪些模块
LoadModule  php5_module  "C:\wamp\PHP5\php5apache2_2.dll" # LoadModule   module_name   module_path
AddHandler  application/x-httpd-php  .php # AddHandler handler_name extension1 extension2 如果你预览的文件是.php后缀，去调用PHP处理器
AddType  application/x-httpd-php   .php  .phtml # 添加文件类型和扩展名之间的映射关系
PHPIniDir "c:/wamp/PHP5" # 指定PHP配置路径
```

### php配置

* 添加PHP程序文件路径到环境变量
* 配置文件php.ini，已存在php.ini-development 和 php.ini-production,复制一份

```
extension_dir = "./" # 模块路径,确保找到文件
extension=php_mysql.dll
php -m # 可以找到mysql
```

### 数据库

* 程序路径
* 数据库路径

配置通过MySQL Instance Configuration Wizard

* 详细配置、标准配置
* 开发、服务器、只做数据库
* 做多功能、实物型、非事物型
* 并发数选择：OLAP OLTP 或手动设置
* 开启TCP/IP端口。使用Strict Mode（可以做服务器使用）
* 字符集的选择：utf-8
* 添加MySQL后台服务于环境变量
* 用户与密码设置
* 生成配置文件

#### 命令行服务管理

```
net start mysql
net stop mysql
```

## Docker配置

- `mkdir -p  ~/apache/www ~/apache/logs ~/apache/conf`
- Dockerfile

```
FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
#RUN groupadd -r www-data && useradd -r --create-home -g www-data www-data

ENV HTTPD_PREFIX /usr/local/apache2
ENV PATH $PATH:$HTTPD_PREFIX/bin
RUN mkdir -p "$HTTPD_PREFIX" \
    && chown www-data:www-data "$HTTPD_PREFIX"
WORKDIR $HTTPD_PREFIX

# install httpd runtime dependencies
# https://httpd.apache.org/docs/2.4/install.html#requirements
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libapr1 \
        libaprutil1 \
        libaprutil1-ldap \
        libapr1-dev \
        libaprutil1-dev \
        libpcre++0 \
        libssl1.0.0 \
    && rm -r /var/lib/apt/lists/*

ENV HTTPD_VERSION 2.4.20
ENV HTTPD_BZ2_URL https://www.apache.org/dist/httpd/httpd-$HTTPD_VERSION.tar.bz2

RUN buildDeps=' \
        ca-certificates \
        curl \
        bzip2 \
        gcc \
        libpcre++-dev \
        libssl-dev \
        make \
    ' \
    set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && rm -r /var/lib/apt/lists/* \
    \
    && curl -fSL "$HTTPD_BZ2_URL" -o httpd.tar.bz2 \
    && curl -fSL "$HTTPD_BZ2_URL.asc" -o httpd.tar.bz2.asc \
# see https://httpd.apache.org/download.cgi#verify
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys A93D62ECC3C8EA12DB220EC934EA76E6791485A8 \
    && gpg --batch --verify httpd.tar.bz2.asc httpd.tar.bz2 \
    && rm -r "$GNUPGHOME" httpd.tar.bz2.asc \
    \
    && mkdir -p src \
    && tar -xvf httpd.tar.bz2 -C src --strip-components=1 \
    && rm httpd.tar.bz2 \
    && cd src \
    \
    && ./configure \
        --prefix="$HTTPD_PREFIX" \
        --enable-mods-shared=reallyall \
    && make -j"$(nproc)" \
    && make install \
    \
    && cd .. \
    && rm -r src \
    \
    && sed -ri \
        -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' \
        -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' \
        "$HTTPD_PREFIX/conf/httpd.conf" \
    \
    && apt-get purge -y --auto-remove $buildDeps

COPY httpd-foreground /usr/local/bin/

EXPOSE 80
CMD ["httpd-foreground"]
```
- COPY httpd-foreground /usr/local/bin/ 是将当前目录下的httpd-foreground拷贝到镜像里，作为httpd服务的启动脚本,本地创建一个脚本文件httpd-foreground
```
#!/bin/bash
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid
```
- chmod +x httpd-foreground
- docker build -t httpd .
- docker run -p 80:80 -v $PWD/www/:/usr/local/apache2/htdocs/ -v $PWD/conf/httpd.conf:/usr/local/apache2/conf/httpd.conf -v $PWD/logs/:/usr/local/apache2/logs/ -d httpd

### 添加phpmyadmin

- 添加虚拟主机
- 重启web服务器服务
- 访问 `http://localhost/phpmyadmin`

```
Alias /phpmyadmin /usr/local/share/phpmyadmin
  <Directory /usr/local/share/phpmyadmin/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    <IfModule mod_authz_core.c>
      Require all granted
    </IfModule>
    <IfModule !mod_authz_core.c>
      Order allow,deny
      Allow from all
    </IfModule>
  </Directory>

[2002] No such file or directory  # 登陆 填入用户名密码却提示
sudo mkdir /var/mysql
sudo ln -s /private/tmp/mysql.sock /var/mysql/mysql.sock
```

### apache + mod_fastcgi

```
brew tap homebrew/apache
brew install httpd24
brew install mod_fastcgi --with-brewed-httpd24

// 编辑 /usr/local/etc/apache2/2.4/httpd.conf
LoadModule fastcgi_module /usr/local/opt/mod_fastcgi/libexec/mod_fastcgi.so 

<IfModule fastcgi_module>
    ProxyPassMatch ^/(.*\.php(/.*)?)$ 
    unix:/usr/local/var/run/php-fpm.sock|fcgi://127.0.0.1:9000/usr/local/var/www/htdocs
</IfModule>
```
