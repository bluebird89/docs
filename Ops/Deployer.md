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

## 仓库

- [deployphp/deployer](https://github.com/deployphp/deployer):A deployment tool written in PHP with support for popular frameworks out of the box <https://deployer.org>

### Webhooks

[sovereign/sovereign](https://github.com/sovereign/sovereign)
