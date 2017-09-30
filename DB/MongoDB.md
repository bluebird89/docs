# 安装与使用

- 下载安装（或通过包工具）
- 添加系统变量：C:\Program Files\MongoDB\Server\3.4\bin（echo 'export PATH=/usr/local/mongodb/bin:$PATH'>>~/.bash_profile）
- 创建数据库文件路径:C:\data\db(/data/db)
- 通过命令行工具启动服务: mongod（本地访问<http://localhost:27017/）MongoDB系统的主要守护进程，用于处理数据请求，数据访问和执行后台管理操作，必须启动，才能访问MongoDB数据库>

  ```
  --dbpath ：存储MongoDB数据文件的目录` mongod --dbpath=C:datadb`
  --directoryperdb：指定每个数据库单独存储在一个目录中（directory），该目录位于–dbpath指定的目录下，每一个子目录都对应一个数据库名字。
  --logpath ：指定mongod记录日志的文件
  --fork：以后台deamon形式运行服务    mongod -fork
  --journal：开始日志功能，通过保存操作日志来降低单机故障的恢复时间
  --config（或-f）：配置文件，用于指定runtime options
  --bind_ip ：指定对外服务的绑定IP地址
  --port ：对外服务窗口
  --auth：启用验证，验证用户权限控制
  --syncdelay：系统刷新disk的时间，单位是second，默认是60s
  --replSet ：以副本集方式启动mongod，副本集的标识是setname
  mongod的命令参数写入配置文档，以参数-f 启动     `mongod -f C:datadbmongodb_config.config`
  -查看mongod的启动参数： db.serverCmdLineOpts()
  ```

- 命令行工具运行客户端：mongo

  ```
   - --nodb: 阻止mongo在启动时连接到数据库实例；
   - --port ：指定mongo连接到mongod监听的TCP端口，默认的端口值是27017；
   - --host ：指定mongod运行的server，如果没有指定该参数，那么mongo尝试连接运行在本地（localhost）的mongod实例；
   - --db：指定mongo连接的数据库
   - --username/-u 和 –password/-p ：指定访问MongoDB数据库的账户和密码，只有当认证通过后，用户才能访问数据库；
   - --authenticationDatabase ：指定创建User的数据库，在哪个数据库中创建User时，该数据库就是User的Authentication Database；
  ```

- 数据结构：db->collection->table

- 指令

```
db:获取数据库名称db.getName()
show dbs：查询dbs
show collections:查询collection   db。getCollectionNames()
use foo:切换数据库
db.users.insert({"name":"name 1",age:21})
db.users.find()show dbs //显示数据库
use test //使用某个数据库
db.test.insert({‘name’:’byc’}) //插入一条记录
db.test.find() //查找所有记录
db.test.findone() //查找一条记录
db.dropDatabase() //删除数据库
db.test.drop //删除指定集合
show collections //显示所有集合
db.createColletion(‘byc’) //创建集合
db.test.save({}) //插入记录db.test.update({‘_id’,1},{$set:{name:’test’,age:20}})
db.test.remove({}) //删除所有集合
for(var i=1;i<=10;i++){db.test.insert({"name":"king"+i,"age":i})} //循环插入10条记录
db.test.find().pretty() //格式化显示查询结果
db.test.find().count() //查询数据条数
db.test.find({"age":5}) /查找age是5的条目
db.test.find({“age”:{$gt:5}}) //查找age大于5的条目
db.test.find({"age":{$gt:5}}).sort({"age":1}) //查找age大于5的条目且升序排列
db.test.find({"age":{$gt:5}}).sort({"age":1}) //查找age大于5的条目且升序排列
db.test.find({"age":{$gt:5}}).sort({"age”:-1}) //查找age大于5的条目且降序排列
```

- 关闭实例：

  ```
  use admin
  db.shutdownServer()
  ```

- GUI工具：Robomongo MongoBooster

## ubnutu

### install

```
sudo apt-get install libssl-dev pkg-config
pecl install mongodb
```
## docker

- `mkdir -p ~/mongo  ~/mongo/db`  // db目录将映射为mongo容器配置的/data/db目录,作为mongo数据的存储目录
- 创建Dockerfile
```
FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        numactl \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

# gpg: key 7F0CEB10: public key "Richard Kreuter <richard@10gen.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10

ENV MONGO_MAJOR 3.0
ENV MONGO_VERSION 3.0.12

RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        mongodb-org=$MONGO_VERSION \
        mongodb-org-server=$MONGO_VERSION \
        mongodb-org-shell=$MONGO_VERSION \
        mongodb-org-mongos=$MONGO_VERSION \
        mongodb-org-tools=$MONGO_VERSION \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mongodb \
    && mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /data/db /data/configdb \
    && chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db /data/configdb

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
```
- docker build -t mongo:3.2 .
-  docker run -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2
### notice

PHP不同版本的扩展库使用版本不一样 php5 使用内置方法 php7.1 使用composer扩展mongodb/mongodb
