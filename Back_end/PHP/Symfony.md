# [symfony/symfony](https://github.com/symfony/symfony)

The Symfony PHP framework http://symfony.com. Fabien Potencier

## 安装

```sh
composer create-project symfony/skeleton my-project

cd my-project
composer require server --dev

php bin/console server:run
php bin/console server:start 0.0.0.0:8000

## symfony client
curl -sS https://get.symfony.com/cli/installer | bash

## demo
symfony new --demo my_project
composer create-project symfony/symfony-demo my_project

./bin/phpunit

## nginx
server {
    server_name domain.tld www.domain.tld;
    root /var/www/project/public;

    location / {
        # try to serve file directly, fallback to index.php
        try_files $uri /index.php$is_args$args;
    }

    location ~ ^/index\.php(/|$) {
        fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include fastcgi_params;

        # optionally set the value of the environment variables used in the application
        # fastcgi_param APP_ENV prod;
        # fastcgi_param APP_SECRET <app-secret-id>;
        # fastcgi_param DATABASE_URL "mysql://db_user:db_pass@host:3306/db_name";

        # When you are using symlinks to link the document root to the
        # current version of your application, you should pass the real
        # application path instead of the path to the symlink to PHP
        # FPM.
        # Otherwise, PHP's OPcache may not properly detect changes to
        # your PHP files (see https://github.com/zendtech/ZendOptimizerPlus/issues/126
        # for more information).
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        # Prevents URIs that include the front controller. This will 404:
        # http://domain.tld/index.php/some-path
        # Remove the internal directive to allow URIs like this
        internal;
    }

    # return 404 for all other php files not matching the front controller
    # this prevents access to other php files you don't want to be accessible.
    location ~ \.php$ {
        return 404;
    }

    error_log /var/log/nginx/project_error.log;
    access_log /var/log/nginx/project_access.log;
}
```

## 扩展

* [symfony/thanks](https://github.com/symfony/thanks):Give thanks (in the form of a GitHub ★) to your fellow PHP package maintainers (not limited to Symfony components)!
* [symfony/console](https://github.com/symfony/console):The Console component eases the creation of beautiful and testable command line interfaces. https://symfony.com/console
* [symfony/http-foundation](https://github.com/symfony/http-foundation):The HttpFoundation component defines an object-oriented layer for the HTTP specification. https://symfony.com/http-foundation
* [jonaswouters/XhprofBundle](https://github.com/jonaswouters/XhprofBundle):XHProf bundle for Symfony 2

## 工具

* [symfony/dotenv](https://github.com/symfony/dotenv):Symfony Dotenv parses .env files to make environment variables stored in them accessible via getenv(), $_ENV, or $_SERVER. https://symfony.com/dotenv

## 框架

* [Documentation](https://symfony.com/doc/current/index.html)
* [官网](https://symfony.com/)
* [](https://github.com/symfony/symfony-standard)
* [](https://github.com/javiereguiluz/EasyAdminBundle)
* [](http://symfony.com/legacy/doc/jobeet/1_2/zh_CN/01?orm=Propel)
* [](http://www.newlifeclan.com/symfony/)
* [symfony/symfony-docs](https://github.com/symfony/symfony-docs):The Symfony documentation https://symfony.com/doc
* [](https://symfony.com/doc/current/setup.html)
