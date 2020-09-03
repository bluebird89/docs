# [phalcon/cphalcon](https://github.com/phalcon/cphalcon)

High performance, full-stack PHP framework delivered as a C extension. <https://phalconphp.com>

## install

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

## Phalcon Developer Tools
php_psr

composer global require phalcon/devtools
extension=psr.so

git clone git://github.com/phalcon/phalcon-devtools.git
cd phalcon-devtools/
./phalcon.sh
ln -s ~/phalcon-devtools/phalcon.php /usr/bin/phalcon
chmod ugo+x /usr/bin/phalcon
```

## 参考

* [documentation](https://docs.phalconphp.com)
* [dreamsxin/cphalcon7](https://github.com/dreamsxin/cphalcon7):Phalcon7 - Web framework for PHP7.x 高性能PHP7框架 http://www.myleftstudio.com/
