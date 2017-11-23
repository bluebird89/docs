# Lnmp 环境搭建

## Linux

### Nginx

```sh
wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key

echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/ubuntu/ trusty nginx" >> /etc/apt/sources.list

echo "deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.list  // Nginx1.9以上的版本可以在packages后添加/mainline，这是主线版本
echo "deb-src http://nginx.org/packages/mainline/ubuntu/ trusty nginx" >> /etc/apt/sources.listen 

sudo apt-get update
sudo apt-get install nginx
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
```

### PHP

```sh
sudo apt-get install python-software-properties software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.1-fpm php7.1-mysql php7.1-common php7.1-curl php7.1-cli php7.1-mcrypt php7.1-mbstring php7.1-dom
```

- 修改配置文件sudo vim /etc/php/7.1/fpm/php.ini：`cgi.fix_pathinfo=0`
- sudo phpenmod mcrypt // 启用 mcrypt
- sudo service php7.1-fpm restart
- php -v

- Modules:

  ```sh
  sudo apt-cache search php7.1*
  sudo apt-get install php7.1-mysql php7.1-curl php7.1-json php7.1-cgi php7.1-mbstring php7.1-xml php7.1-mysql php7.1-common php7.1-gd  php7.1-cli php-pear php7.1-intl
  ```

- 默认安装模块

- 手动安装模块

  - curl
  - GD
  - pear
  - mcrypt
  - mbstring:php7.1-mbstring
  - intl
  - dom:php7.1-dom

    `sudo apt-get install -y php-pear php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip`

- Configure Nginx to Use the PHP Processor

  - default

    ```
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

# Mac环境搭建

```sh
// 系统默认apache 与php5
httpd -v
php -v

// 停止httpd服务
sudo apachectl stop

// 卸载apache 与PHP56
sudo rm /usr/sbin/apachectl
sudo rm /usr/sbin/httpd
sudo rm -r /etc/apache2/  sudo rm -r /usr/bin/php

// 开启启动
$ cp /usr/local/opt/php71/homebrew.mxcl.php71.plist ~/Library/LaunchAgents/
$ launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php70.plist

// 配置nginx
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

// mysql
brew install mysql

cd /usr/local/opt/mysql/
sudo vim my.cnf

./bin/mysql_install_db //初始化
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql
/usr/local/bin/mysqladmin -u root password 'new-password' // 设置密码
/usr/local/bin/mysql_secure_installation  // 安全脚本
mysql -u root -p

// PHP配置
brew install php71 --with-imap --with-tidy --with-debug --with-pgsql --with-mysql --with-fpm

/usr/local/etc/php/7.1/php-fpm.conf

;pid = run/php-fpm.log
;error_log = log/php-fpm.log
修改为
pid = /usr/local/var/run/php-fpm.pid
error_log = /usr/local/var/log/php-fpm.log

// php配置
/usr/local/etc/php/7.1/php.ini  // 错误级别定义

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
