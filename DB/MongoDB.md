# Mongodb

mongodb由C＋＋写就，其名字来自humongous这个单词的中间部分，从名字可见其野心所在就是海量数据的处理。关于它的一个最简洁描述为：scalable, high-performance, open source, schema-free, document-oriented database。MongoDB的主要目标是在键/值存储方式（提供了高性能和高度伸缩性）以及传统的RDBMS系统（丰富的功能）架起一座桥梁，集两者的优势于一身。

数据结构：db->collection->document（BSON（binary json）存放于硬盘）

跟一般的key-value数据库不一样的是，它的value中存储了结构信息

以单文档为单位存储的，你可以任意给一个或一批文档新增或删除字段，而不会对其它文档造成影响，这就是所谓的schema-free，这也是文档型数据库最主要的优点。

Mongo最大的特点是他支持的查询语言非常强大，其语法有点类似于面向对象的查询语言，几乎可以实现类似关系数据库单表查询的绝大部分功能，而且还支持对数据建立索引。Mongo还可以解决海量数据的查询效率，根据官方文档，当数据量达到50GB以上数据时，Mongo数据库访问速度是MySQL10 倍以上。

BSON是Binary JSON 的简称，是一个JSON文档对象的二进制编码格式。BSON同JSON一样支持往其它文档对象和数组中再插入文档对象和数组，同时扩展了JSON的数据类型。如：BSON有Date类型和BinDate类型。
BSON被比作二进制的交换格式，如同Protocol Buffers，但BSON比它更“schema-less”，非常好的灵活性但空间占用稍微大一点。

## 安装与使用

### ubnutu

```
sudo apt-get install libssl-dev pkg-config
pecl install mongodb
```

### Windows

- 下载安装（或通过包工具）
- 添加系统变量：C:\Program Files\MongoDB\Server\3.4\bin（echo 'export PATH=/usr/local/mongodb/bin:$PATH'>>~/.bash_profile）
- 创建数据库文件路径:C:\data\db(/data/db)
- 通过命令行工具启动服务: mongod（本地访问<http://localhost:27017/）MongoDB系统的主要守护进程，用于处理数据请求，数据访问和执行后台管理操作，必须启动，才能访问MongoDB数据库>

## Mac

```shell
brew services mongodb // mac启动服务
```

### 使用

开启服务端

```
mongod

--dbpath ：存储MongoDB数据文件的目录` mongod --dbpath=C:datadb`
--directoryperdb：指定每个数据库单独存储在一个目录中（directory），该目录位于–dbpath指定的目录下，每一个子目录都对应一个数据库名字。
--logpath ：指定mongod记录日志的文件
--fork：以后台deamon形式运行服务mongod -fork
--journal：开始日志功能，通过保存操作日志来降低单机故障的恢复时间
--config（或-f）：配置文件，用于指定runtime options
--bind_ip ：指定对外服务的绑定IP地址
--port ：指定mongo连接到mongod监听的TCP端口，默认的端口值是27017；
--auth：启用验证，验证用户权限控制
--syncdelay：系统刷新disk的时间，单位是second，默认是60s
--replSet ：以副本集方式启动mongod，副本集的标识是setname

mongod的命令参数写入配置文档，以参数-f 启动 `mongod -f C:datadbmongodb_config.config`
db.serverCmdLineOpts() // 查看mongod的启动参数
--nodb: 阻止mongo在启动时连接到数据库实例；
--host ：指定mongod运行的server，如果没有指定该参数，那么mongo尝试连接运行在本地（localhost）的mongod实例；
--db：指定mongo连接的数据库
--username/-u 和 –password/-p ：指定访问MongoDB数据库的账户和密码，只有当认证通过后，用户才能访问数据库；
--authenticationDatabase ：指定创建User的数据库，在哪个数据库中创建User时，该数据库就是User的Authentication Database；
```

客户端

```
mongo --help

mongoimport --db test --collection restaurants --drop --file ~/Downloads/primer-dataset.json
mongo
help

db.collection.save // 查看该方法

show dbs // 查询dbs
use foo //使用foo数据库或者切换数据库
db.getName() // db:获取数据库名称
db.dropDatabase() //删除数据库

show collections // 查询collection
db.collection.help()
db.getCollectionNames()
db.createColletion(‘byc’) //创建集合
db.test.drop //删除指定集合

db.users.insert({"name":"name 1",age:21})
for(var i=1;i<=10;i++){
    db.test.insert({"name":"king"+i,"age":i})
} //循环插入10条记录

db.restaurants.find( { "address.zipcode": "10075" } )
db.restaurants.find( { "grades.score": { $gt: 30 } } )
db.restaurants.find( { "cuisine": "Italian", "address.zipcode": "10075" } ) // and
db.restaurants.find(
   { $or: [ { "cuisine": "Italian" }, { "address.zipcode": "10075" } ] }
) // or
db.restaurants.find().sort( { "borough": 1, "address.zipcode": 1 } ) // sort  1 for ascending and -1 for descending.
db.test.find().pretty() //格式化显示查询结果
db.test.find().count() //查询数据条数

db.restaurants.update(
    { "name" : "Juni" },
    {
      $set: { "cuisine": "American (New)" },
      $currentDate: { "lastModified": true }
    }
)  // update

db.restaurants.update(
  { "address.zipcode": "10016", cuisine: "Other" },
  {
    $set: { cuisine: "Category To Be Determined" },
    $currentDate: { "lastModified": true }
  },
  { multi: true}
) // Update Multiple Documents

db.restaurants.update(
   { "restaurant_id" : "41704620" },
   {
     "name" : "Vella 2",
     "address" : {
              "coord" : [ -73.9557413, 40.7720266 ],
              "building" : "1480",
              "street" : "2 Avenue",
              "zipcode" : "10075"
     }
   }
) // To replace the entire document except for the _id field

db.restaurants.aggregate(
   [
     { $group: { "_id": "$borough", "count": { $sum: 1 } } }
   ]
); // group 格式

db.restaurants.aggregate(
   [
     { $match: { "borough": "Queens", "cuisine": "Brazilian" } },
     { $group: { "_id": "$address.zipcode" , "count": { $sum: 1 } } }
   ]
); // 含有where条件

db.restaurants.remove( { "borough": "Manhattan" } )
db.restaurants.remove( { "borough": "Queens" }, { justOne: true } ) // limit the remove operation to only one of the matching documents
db.restaurants.remove( { } ) // Remove All Documents

db.restaurants.createIndex( { "cuisine": 1 } )
db.restaurants.createIndex( { "cuisine": 1, "address.zipcode": -1 } )

use admin
db.shutdownServer()
```

## GUI工具

* Robomongo MongoBooster

## docker

- `mkdir -p ~/mongo ~/mongo/db` // db目录将映射为mongo容器配置的/data/db目录,作为mongo数据的存储目录
- 创建Dockerfile ``` FROM debian:wheezy

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added

RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \ && apt-get install -y --no-install-recommends \ numactl \ && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root

ENV GOSU_VERSION 1.7 RUN set -x \ && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \ && wget -O /usr/local/bin/gosu "<https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg> --print-architecture)" \ && wget -O /usr/local/bin/gosu.asc "<https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg> --print-architecture).asc" \ && export GNUPGHOME="$(mktemp -d)" \ && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \ && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \ && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \ && chmod +x /usr/local/bin/gosu \ && gosu nobody true \ && apt-get purge -y --auto-remove ca-certificates wget

# gpg: key 7F0CEB10: public key "Richard Kreuter [richard@10gen.com](mailto:richard@10gen.com)" imported

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10

ENV MONGO_MAJOR 3.0 ENV MONGO_VERSION 3.0.12

RUN echo "deb <http://repo.mongodb.org/apt/debian> wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

RUN set -x \ && apt-get update \ && apt-get install -y \ mongodb-org=$MONGO_VERSION \ mongodb-org-server=$MONGO_VERSION \ mongodb-org-shell=$MONGO_VERSION \ mongodb-org-mongos=$MONGO_VERSION \ mongodb-org-tools=$MONGO_VERSION \ && rm -rf /var/lib/apt/lists/* \ && rm -rf /var/lib/mongodb \ && mv /etc/mongod.conf /etc/mongod.conf.orig

RUN mkdir -p /data/db /data/configdb \ && chown -R mongodb:mongodb /data/db /data/configdb VOLUME /data/db /data/configdb

COPY docker-entrypoint.sh /entrypoint.sh ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 27017 CMD ["mongod"] ```

- docker build -t mongo:3.2 .
- docker run -p 27017:27017 -v $PWD/db:/data/db -d mongo:3.2

## 参考

- [MongoDB Docs](https://docs.mongodb.com/)

### notice

PHP不同版本的扩展库使用版本不一样 php5 使用内置方法 php7.1 使用composer扩展mongodb/mongodb
