# Laradock

Docker PHP development environment

>  安装

```sh
git clone https://github.com/Laradock/laradock.git
cp env-example .env
docker-compose up -d nginx mysql phpmyadmin redis workspace #
docker-compose up --build # 会构建所有容器：Service 'aws' failed to build: COPY failed: stat /var/lib/docker/tmp/docker-builder279203978/ssh_keys: no such file or directory
```

## 问题

> No such file or directory: u'./docker-compose.dev.yml'

.env->COMPOSE_FILE:COMPOSE_FILE=docker-compose.yml

## 参考

* [laradock/laradock](https://github.com/laradock/laradock):Docker PHP development environment. http://laradock.io
* [文档](http://laradock.io/)
