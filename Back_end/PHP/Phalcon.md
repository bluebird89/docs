# [phalcon/cphalcon](https://github.com/phalcon/cphalcon)

High performance, full-stack PHP framework delivered as a C extension. <https://phalconphp.com>

## Add extension phalcon

```sh
pecl channel-update pecl.php.net
pecl install phalcon

### Ubuntu
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash

sudo apt-get install php5.6-phalcon
sudo apt-get install php7.2ssssclear-phalcon

sudo service php5.6-fpm start

### Mac
brew install php71-phalcon
```

## Phalcon Developer Tools

```sh
composer global require phalcon/devtools

git clone git://github.com/phalcon/phalcon-devtools.git
cd phalcon-devtools/
./phalcon.sh
ln -s ~/phalcon-devtools/phalcon.php /usr/bin/phalcon
chmod ugo+x /usr/bin/phalcon
```

## 仓库

- [Phalcon中文文档](http://docs.iphalcon.cn/)
- [documentation](https://docs.phalconphp.com/en/3.2)
- [dreamsxin/cphalcon7](https://github.com/dreamsxin/cphalcon7):Phalcon7 - Web framework for PHP7.x 高性能PHP7框架 http://www.myleftstudio.com/
