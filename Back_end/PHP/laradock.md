# [laradock](https://laradock.io/)

```sh
git clone https://github.com/Laradock/laradock.git
git submodule add https://github.com/Laradock/laradock.git # exist project

cp env-example .env
docker-compose up -d nginx mysql phpmyadmin redis workspace
```

```
// . env
DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd
APP_CODE_PATH_HOST=../project-z/ #  exist project
```

```sh
docker-compose exec workspace bash
docker-compose exec --user=laradock workspace bash

docker-compose ps|stop|down

docker-compose logs -f {container-name}
```
