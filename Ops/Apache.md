# Apache

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

## mac

系统本身带有apache2

* 程序位置：/private/etc/apache2 或者 /etc/apache2
* 配置文件：httpd.conf
* 开启 `LoadModule php7_module libexec/apache2/libphp7.so`
* 站点默认目录：`DocumentRoot "/Library/WebServer/Documents"`
* `DirectoryIndex index.php index.html`
* 进程管理,用httpd或者aapachectl
    - `apachectl -v`
    - `httpd -t`
    - `sudo httpd -k start`
    - `sudo httpd -k stop`
    - `sudo apachectl -k restart`

### 添加phpmyadmin

- httpd添加
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
```
- 访问 `http://localhost/phpmyadmin`
```
填入用户名密码却提示  [2002] No such file or directory 
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
