# 部署工具

## Deployer

- 安装：

  - 通过 Phar 存档

    ```
    curl -LO https://deployer.org/deployer.phar
    mv deployer.phar /usr/local/bin/dep
    chmod +x /usr/local/bin/dep
    ```

  - 通过 composer

    ```
    composer require deployer/deployer --dev
    php vendor/bin/dep
    ```

  - 通过github

    ```
    git clone https://github.com/deployphp/deployer.git
    php ./build
    ```

- 使用：

  - 在项目目录下运行dep init
  - 配置deployer.php 文件

- 部署自动化：git push后的需要dep deploy才部署

  - 生成 git 用户公钥和部署公钥 -> 设置用户公钥到你帐户相关联的 SSH Keys -> 设置部署公钥到你项目的 Deploy keys -> 准备 hook 文件 -> 在项目上添加一个 Webhook 并设置 hook 的网址


### [walle](https://github.com/meolu/walle-web)A Web Deployment Tool

### 代码托管工具支持webhooks

## Travis CI

用来构建托管在GitHub上的代码，最主要工作是自动运行项目的单元测试并生成报告，同时根据的配置文件，生成一个Linux虚拟机来运行你的命令，通常这些命令用于测试，构建等。默认设置下，每次对项目进行Push时，都会触发Travis CI运行一次测试。同时提供了一个项目状态图标，可以放置在项目主页告知用户当前的测试情况.

- 配置文件.travis.yml

```
language: php
php:
  - 5.3
  - 5.4
before_script:
  - composer install
  - cd tests
script: phpunit -v
```

### Webhooks

[sovereign/sovereign](https://github.com/sovereign/sovereign)
