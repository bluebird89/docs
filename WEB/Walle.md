# [walle](https://github.com/meolu/walle-web)

A Web Deployment Tool 一个web部署系统工具，配置简单、功能完善、界面流畅、开箱即用！支持git、svn版本管理，支持各种web代码发布，PHP，Python，JAVA等代码的发布、回滚，可以通过web来一键完成。

* 宿主机（walle所在的机器），是一个中间机器，是代码托管与远程目标机群的纽带。所以宿主机需要与代码托管(github/gitlab)和远程目标机群都建立ssh-key信任。
* 宿主机安装 ansible
* 项目配置 中 开启Ansible
* (可选) config/params.php 配置 ansible_hosts 文件存放路径
* 按正常流程发布、上线代码，传输文件、远程执行命令均会通过ansible并发执行

```sh
su - www                 # 宿主机中www为你的php进程用户
ssh-keygen -t rsa        # 如果你都没有生成过rsa_key的话
cat ~/.ssh/id_rsa.pub    # 复制  打开github/gitlab添加到你的ssh-keys或者deploy-keys里
ssh-copy-id -i ~/.ssh/id_rsa.pub www_remote@remote_host  # 加入目标机群信任，需要输入www_remote密码
chown {user} -R {path} # php进程用户{user}有代码存储仓库{path}读写权限
chmod 755 -R {path}
su {local_user} && ssh-copy-id -i ~/.ssh/id_rsa.pub remote_user@remote_server # 确认宿主机php进程{local_user}用户ssh-key加入目标机器的{remote_user}用户ssh-key信任列表，且{remote_user}有目标机器发布版本库{path}写入权限。

# 目标机 部署代码的用户，对webroot父目录有读写权限，建立软连接。不一定非为php进程用户
su remote_user
chown {remote_user} -R {path}
chmod 755 -R {path}

# 修改/etc/sudoers
www    ALL=(ALL)       ALL
www ALL = (ALL) NOPASSWD: /usr/local/nginx/bin/nginx
```

### 宿主机

* LAMP环境搭建
* composer安装

```sh
mkdir -p /data/www/walle-web && cd /data/www/walle-web  # 新建目录
git clone git@github.com:meolu/walle-web.git .          # 代码检出

# vi config/local.php
'db' => [
    'dsn'       => 'mysql:host=127.0.0.1;dbname=walle', # 新建数据库walle
    'username'  => 'root',                              # 连接的用户名
    'password'  => '',                      # 连接的密码
],

composer install --prefer-dist --no-dev --optimize-autoloader -vvvv
./yii walle/setup # 需要你的yes
# 配置nginx
server {
    listen       80;
    server_name  120.76.97.128; # 改你的host
    root /data/www/walle-web/web; # 根目录为web
    index index.php;

    # 建议放内网
    # allow 192.168.0.0/24;
    # deny all;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }

    location ~ \.php$ {
        try_files $uri = 404;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }
}
```

## 过程

部署是在一台宿主机拉取代码，做编译、配置后，向目标机群分发，执行相关目标机群任务。部署流程拆分为以下6个环节，其中1-5为在宿主机进行，6在目标机群执行。

* 权限、目录检查，开辟一个上线的独立空间以并行发布，防止同时部署出现代码污染
* pre-deploy任务，代码检出前的一些操作任务，如环境检查
* 代码从git/svn版本库中检出
* post-deploy任务，代码检出之后操作任务，如java的mvn编译，php的composer插件安装
* 保留在独立空间的代码均会被同步至目标机群的一个版本库中
* 全量更新：当所有机器都分发完毕，开始做pre-release任务（java暂停服务）、切换版本软链、post-release任务（ java启动服务）
* 先同步代码，后切换服务。部署发布每次都会有版本记录保留，版本上线事故一旦发生，回滚可瞬间完成。可配置线上版本最大保留数，过期的版本被会删除，同时也就不能回滚被删除的版本。对于需要编译、自定义多任务辅助，可配置前置、后置操作自定义任务；同时提供一些预置变量（{WORKSPACE}宿主机的当前独立空间、目标机webroot，{VERSION}版本库目录）方便用户操作自定义任务。

## 参考

* [meolu/walle-web](https://github.com/meolu/walle-web):A Web Deployment Tool (web代码部署工具) https://walle-web.io，通过yii框架搭建的GUI框架
* [文档](https://www.walle-web.io/docs/installation.html)
