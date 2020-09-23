# [rabbitmq/rabbitmq-server](https://github.com/rabbitmq/rabbitmq-server)

Open source multi-protocol messaging broker https://www.rabbitmq.com/

基于 AMQP 实现的一个开源消息组件，主要用于在分布式系统中存储转发消息，由因高性能、高可用以及高扩展而出名的 Erlang 语言写成。

* AMQP（Advanced Message Queuing Protocol，即高级消息队列协议），是一个异步消息传递所使用的应用层协议规范，为面向消息的中间件设计。消息中间件主要用于组件之间的解耦，消息的发送者无需知道消息使用者的存在，AMQP的主要特征是面向消息、队列、路由（包括点对点和发布/订阅）、可靠性、安全。
* 高可靠：RabbitMQ 提供了多种多样的特性让你在可靠性和性能之间做出权衡，包括持久化、发送应答、发布确认以及高可用性。
* 高可用队列：支持跨机器集群，支持队列安全镜像备份，消息的生产者与消费者不论哪一方出现问题，均不会影响消息的正常发出与接收
* 灵活的路由：所有的消息都会通过路由器转发到各个消息队列中，RabbitMQ 内建了几个常用的路由器，并且可以通过路由器的组合以及自定义路由器插件来完成复杂的路由功能
* 支持多客户端：对主流开发语言（如：Python、Ruby、.NET、Java、C、PHP、ActionScript 等）都有客户端实现。
* 集群：本地网络内的多个 Server 可以聚合在一起，共同组成一个逻辑上的 broker
* 扩展性：支持负载均衡，动态增减服务器简单方便
* 权限管理：灵活的用户角色权限管理，Virtual Host 是权限控制的最小粒度
* 插件系统：支持各种丰富的插件扩展，同时也支持自定义插件，其中最常用的插件是 Web 管理工具 RabbitMQ_Management

![](../_static/rabbitmq.png)

## 安装

```sh
brew install rabbitmq
brew services start rabbitmq # /usr/local/Cellar/rabbitmq/3.6.6/sbin/rabbitmq-server
# 访问 http://localhost:15672/  默认账号密码为guest

# 普通方式启动
./rabbitmq-server
# 守护线程方式启动
./rabbitmq-server –detached

rabbitmqctl status|stop
./rabbitmqctl start_app|stop_app # 起停节点

# 查看队列状态
sudo rabbitmqctl list_queues

## Centos7
# 安装 Erlang
# 下载 https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_19.3-1~centos~7_amd64.rpm
yum install epel-release
yum install unixODBC unixODBC-devel wxBase wxGTK SDL wxGTK-gl
rpm -ivh esl-erlang_19.3-1~centos~7_amd64.rpm
# 测试安装是否成功：
erl

# 下载 http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-3.6.9-1.el7.noarch.rpm
yum install rabbitmq-server-3.6.9-1.el7.noarch.rpm
rpm -qa | grep erlang
# 卸载
rpm -e esl-erlang

## rabbitmq/bin
rabbitmq-plugins enable rabbitmq_management
# 启动rabbitmq服务
rabbitmq-server -detached
# 添加用户并设置权限
rabbitmqctl add_user albert albert
rabbitmqctl set_user_tags albert administrator

# ubuntu
wget http://packages.erlang-solutions.com/site/esl/esl-erlang/FLAVOUR_1_general/esl-erlang_20.1-1~ubuntu~xenial_amd64.deb
sudo dpkg -i esl-erlang_20.1-1\~ubuntu\~xenial_amd64.deb

echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list

wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
sudo apt-key adv --keyserver "hkps://keys.openpgp.org" --recv-keys "0x0A9AF2115F4687BD29803A206B73A36E6026DFCA"

## Install RabbitMQ signing key
curl -fsSL https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc | sudo apt-key add -
# /etc/apt/sources.list.d/bintray.rabbitmq.list
deb https://dl.bintray.com/rabbitmq-erlang/debian bionic erlang
deb https://dl.bintray.com/rabbitmq/debian bionic main

sudo apt-get install rabbitmq-server -y --fix-missing

sudo systemctl  status|start|enable rabbitmq-server.service

sudo rabbitmqctl stop|status  # 查看服务状态
sudo rabbitmqctl list_users # 查看当前所有用户
sudo rabbitmqctl list_user_permissions guest # 查看默认guest用户的权限
sudo rabbitmqctl add_user username password # 添加新用户
sudo rabbitmqctl set_user_tags username administrator # 设置用户tag
sudo rabbitmqctl set_permissions -p / username ".*" ".*" ".*" # 赋予用户默认vhost的全部操作权限
sudo rabbitmqctl delete_user guest # 删掉默认用户(由于RabbitMQ默认的账号用户名和密码都是guest。为了安全起见, 可以删掉默认用户）

sudo rabbitmq-plugins disable|enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/
http://[your-vultr-server-IP]:15672/ # 管理地址

git clone git://github.com/alanxz/rabbitmq-c.git
cd rabbitmq-c
mkdir build  && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ..
cmake --build . --target install

wget http://pecl.php.net/get/amqp-1.9.1.tgz
tar zvxf amqp-1.9.1.tgz
cd amqp-1.9.1
phpize
./configure --with-amqp
make && make install

[ 17%] Linking C shared library librabbitmq.dylib
ld: cannot link directly with dylib/framework, your binary is not an allowed client of /usr/lib/libcrypto.dylib for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[2]: *** [librabbitmq/librabbitmq.4.4.0.dylib] Error 1
make[1]: *** [librabbitmq/CMakeFiles/rabbitmq.dir/all] Error 2
make: *** [all] Error 2
```

## 概念

* ConnectionFactory、Connection、Channel都是RabbitMQ对外提供的API中最基本对象
* connection：连接和具体broker网络连接
  - Connection是RabbitMQ的socket链接，封装了socket协议相关部分逻辑
  - ConnectionFactory为Connection的制造工厂
* channel：网络信道，几乎所有操作都在channel中进行，channel是消息读写的通道。客户端可以建立多个channel，每个channel表示一个会话任务。
  - 与RabbitMQ打交道的最重要的一个接口，大部分的业务操作是在Channel这个接口中完成的，包括定义Queue、定义Exchange、绑定Queue与Exchange、发布消息等
* Queue（队列）是RabbitMQ的内部对象，用于存储消息
  - 消息都只能存储在Queue中，生产者生产消息并最终投递到Queue中，消费者可以从Queue中获取消息并消费。
  - 多个消费者可以订阅同一个Queue，这时Queue中的消息会被平均分摊给多个消费者进行处理，而不是每个消费者都收到所有的消息并处理。
* message：消息，服务器和应用程序之间传递的数据，由properties和body组成
  - properties可以对消息进行修饰，比如消息的优先级，延迟等高级特性
  - body是消息实体内容。
* server：又称broker，接受客户端连接，实现AMQP实体服务。
* Virtual host：虚拟主机，用于逻辑隔离，最上层消息的路由。一个Virtual host可以若干个Exchange和Queue，同一个Virtual host不能有同名的Exchange或Queue。
* Exchange：交换机，生产者将消息发送到Exchange接受消息，由Exchange将消息 据路由键转发一个或多个Queue中  auto delete当最后一个绑定Exchange上的队列被删除Exchange也删除。 交换机的类型
  - Direct Exchange,所有发送到Direct Exchange的消息被转发到那些binding key与routing key完全匹配的Queue中
    + Direct Exchange可以使用默认的默认的Exchange （default Exchange），默认的Exchange会绑定所有的队列，所以Direct可以直接使用Queue名（作为routing key ）绑定。或者消费者和生产者的routing key完全匹配。
  - Toptic Exchange,是指发送到Topic Exchange的消息被转发到所有关心的Routing key中指定topic的Queue上。与direct类型的Exchage相似，但这里的匹配规则有些不同，约定：
    * routing key为一个句点号“. ”分隔的字符串（将被句点号“. ”分隔开的每一段独立的字符串称为一个单词），如“stock.usd.nyse”、“nyse.vmw”、“quick.orange.rabbit”
    * binding key与routing key一样也是句点号“. ”分隔的字符串
    * binding key中可以模糊匹配（使用通配符）：“#”可以匹配一个或多个词，“*”只匹配一个词比如“log.#”可以匹配“log.info.test” "log. "就只能匹配log.error
  - Fanout Exchange:不处理路由键，只需简单的将队列绑定到交换机上。发送到改交换机上的消息都会被发送到有与该交换机绑定的队列上。Fanout转发是最快的
  - headers类型的Exchange不依赖于routing key与binding key的匹配规则来路由消息，而是根据发送的消息内容中的headers属性进行匹配。 在绑定Queue与Exchange时指定一组键值对；当消息发送到Exchange时，RabbitMQ会取到该消息的headers（也是一个键值对的形式），对比其中的键值对是否完全匹配Queue与Exchange绑定时指定的键值对；如果完全匹配则消息会路由到该Queue，否则不会路由到该Queue。 该类型的Exchange没有用到过（不过也应该很有用武之地）
* banding：Exchange和Queue之间的虚拟连接，binding中可以包括routing key 通过Binding将Exchange与Queue关联起来，这样RabbitMQ就知道如何正确地将消息路由到指定的Queue了
* Binding key:在绑定（Binding）Exchange与Queue的同时，一般会指定一个binding key；消费者将消息发送给Exchange时，一般会指定一个routing key；*当binding key与routing key相匹配时，消息将会被路由到对应的Queue中*。这个将在Exchange Types章节会列举实际的例子加以说明。 在绑定多个Queue到同一个Exchange的时候，这些Binding允许使用相同的binding key。 binding key 并不是在所有情况下都生效，它依赖于Exchange Type，比如fanout类型的Exchange就会无视binding key，而是将消息路由到所有绑定到该Exchange的Queue。
* routing key：一个路由规则，虚拟机根据他来确定如何路由一条消息。*生产者在将消息发送给Exchange的时候，一般会指定一个routing key*，来指定这个消息的路由规则，而这个routing key需要与Exchange Type及binding key联合使用才能最终生效。 在Exchange Type与binding key固定的情况下（在正常使用时一般这些内容都是固定配置好的），我们的生产者就可以在发送消息给Exchange时，通过指定routing key来决定消息流向哪里。 RabbitMQ为routing key设定的长度限制为255 bytes。
* Queue：消息队列，用来存放消息的队列。

## 原理

* 典型的开箱即用的消息队列。开发者可以定义一个命名队列，然后发布者可以向这个命名队列中发送消息。最后消费者可以通过这个命名队列获取待处理的消息
* 使用消息交换器来实现发布/订阅模式。发布者通过指定一个Exchange和Routinkey,把消息发布到消息交换器上而不用知道这些消息都有哪些订阅者
  - 每一个订阅了交换器的消费者都会创建一个队列
  - 消息交换器会把生产的消息放入队列以供消费者消费
  - 消息交换器也可以基于各种路由规则为一些订阅者过滤消息
* 支持临时和持久两种订阅类型
* 可以创建一种混合方法——订阅者以组队的方式然后在组内以竞争关系作为消费者去处理某个具体队列上的消息，这种由订阅者构成的组称为消费者组。按照这种方式，实现了发布/订阅模式，同时也能够很好的伸缩（scale-up）订阅者去处理收到的消息。

## 生产

* 生产端可靠性投递
  - 保证消息的成功发出
  - 保证MQ节点节点的成功接收
  - 发送端MQ节点（broker）收到消息确认应答
  - 完善消息进行补偿机制
* 保障方案
  - 消息落库，对消息进行打标
  - 消息的延迟投递
  - 消息幂等性
* confirm消息确认机制:消息的确认，指生产者收到投递消息后，如果Broker收到消息就会给的生产者一个应答，生产者接受应答来确认broker是否收到消息.实现方式
  - 在Channel上开启确认模式：channel.confirmSelect()
  - 在channel上添加监听：addConfirmListener，监听成功和失败的结果，具体结果对消息进行重新发送或者记录日志。
* return消息机制：处理一些不可路由的消息，在发送消息的时候当Exchange不存在或者指定的路由key路由找不到，这个时候如果需要监听这种不可到达的消息，就要使用Return Listener
  - Mandatory 设置为true则会监听器会接受到路由不可达的消息，然后处理。如果设置为false，broker将会自动删除该消息

## 消费

* Message acknowledgment:要求消费者在消费完消息后发送一个回执给RabbitMQ，RabbitMQ收到消息回执（Message acknowledgment）后才将该消息从Queue中移除；如果RabbitMQ没有收到回执并检测到消费者的RabbitMQ连接断开，则RabbitMQ会将该消息发送给其他消费者（如果存在多个消费者）进行处理
  - 消费端进行消费的时候，如果由于业务异常可以进行日志记录，然后进行补偿！（也可以加上最大努力次数的尝试）
  - 如果由于服务器宕机等严重问题，就需要手动进行ack保证消费端的消费成功
* 消息重回队列
  - 重回队列就是为了对没有处理成功的消息，把消息重新投递给broker
  - 实际应用中一般都不开启重回队列。
* TTL队列/消息 TTL time to live 生存时间
  - 支持消息的过期时间，在消息发送时可以指定。
  - 支持队列过期时间，在消息入队列开始计算时间，只要超过了队列的超时时间配置，那么消息就会自动的清除。
* 死信队列 DLX，Dead-Letter-Exchange：当消息在一个队列中变成死信（dead message，就是没有任何消费者消费）之后，能被重新publish到另一个Exchange，这个Exchange就是DLX
  - 变为死信的几种情况
    + 消息被拒绝（basic.reject/basic.nack）同时requeue=false（不重回队列）
    + TTL过期
    + 队列达到最大长度
  - 设置：设置Exchange和Queue，然后进行绑定
    + Exchange: dlx.exchange(自定义的名字)
    + queue: dlx.queue（自定义的名字）
    + routingkey: #（#表示任何routingkey出现死信都会被路由过来）
    + 然后正常的声明交换机、队列、绑定，只是我们在队列上加上一个参数：arguments.put("x-dead-letter-exchange","dlx.exchange");
* Message durability:在RabbitMQ服务重启的情况下，也不会丢失消息，可以将Queue与Message都设置为可持久化
* 限流：提供了一种qos（服务质量保证）的功能，即非自动确认消息的前提下，如果有一定数目的消息（通过consumer或者Channel设置qos）未被确认，不进行新的消费
  - prefetchSize:0 单条消息的大小限制。0就是不限制，一般都是不限制。
  - prefetchCount: 设置一个固定的值，告诉rabbitMQ不要同时给一个消费者推送多余N个消息，即一旦有N个消息还没有ack，则consumer将block掉，直到有消息ack
  - global：truefalse 是否将上面的设置用于channel，也是就是说上面设置的限制是用于channel级别的还是consumer的级别的
* MQ本身是基于异步的消息处理，前面的示例中所有的生产者（P）将消息发送到RabbitMQ后不会知道消费者（C）处理成功或者失败（甚至连有没有消费者来处理这条消息都不知道）。 但实际的应用场景中，我们很可能需要一些同步处理，需要同步等待服务端将我的消息处理完成后再进行下一步处理。这相当于RPC（Remote Procedure Call，远程过程调用）。在RabbitMQ中也支持RPC。
  - 客户端发送请求（消息）时，在消息的属性（MessageProperties ，在AMQP 协议中定义了14中properties ，这些属性会随着消息一起发送）中设置两个值replyTo （一个Queue 名称，用于告诉服务器处理完成后将通知我的消息发送到这个Queue 中）和correlationId （此次请求的标识号，服务器处理完成后需要将此属性返还，客户端将根据这个id了解哪条请求被成功执行了或执行失败）
  - 服务器端收到消息并处理
  - 服务器端处理完消息后，将生成一条应答消息到replyTo 指定的Queue ，同时带上correlationId 属性
  - 客户端之前已订阅replyTo 指定的Queue ，从中收到服务器的应答消息后，根据其中的correlationId 属性分析哪条请求被执行了，根据执行结果进行后续业务处理
* 避免消息重复消费
  - 唯一id+加指纹码，利用数据库主键去重。
    + 优点：实现简单
    + 缺点：高并发下有数据写入瓶颈。
  - 利用Redis的原子性
    + 使用Redis进行幂等是需要考虑的问题
    + 是否进行数据库落库，落库后数据和缓存如何做到保证幂等（Redis   和数据库如何同时成功同时失败）？
    + 如果不进行落库，都放在Redis中如何这是Redis和数据库的同步策略？还有放在缓存中就能百分之百的成功吗？

## 模式

简单模式、工作队列模式、发布/订阅模式、路由模式、主题模式 和 RPC 模式

* 单对单
* 单对多
* 发布订阅模式：Exchange Type 为 topic，发送消息时需要指定交换机及 Routing Key，消费者的消息队列绑定到该交换机并匹配到 Routing Key 实现消息的订阅，订阅后则可接收消息。只有消费者将队列绑定到该交换机且指定的 Routing Key 符合匹配规则，才能收到消息。Routing Key 可以设置成通配符，如：*或 #（*表示匹配 Routing Key 中的某个单词，# 表示任意的 Routing Key 的消息都能被收到）。如果 Routing Key 由多个单词组成，则单词之间用. 来分隔。
* 按路由规则发送接收
* 主题
* RPC（即远程存储调用）

## 集群

* 主备模式：实现rabbitMQ高可用集群，一般在并发量和数据不大的情况下，这种模式好用简单。又称warren模式。（区别于主从模式，主从模式主节点提供写操作，从节点提供读操作，主备模式从节点不提供任何读写操作，只做备份）如果主节点宕机备份从节点会自动切换成主节点，提供服务。
* 集群模式：经典方式就是Mirror模式，保证100%数据不丢失，实现起来也是比较简单。
  - 镜像队列，是rabbitMQ数据高可用的解决方案，主要是实现数据同步，一般来说是由2-3节点实现数据同步，（对于100%消息可靠性解决方案一般是3个节点）
  - 多活模式：这种模式也是实现异地数据复制的主流模式，因为shovel模式配置相对复杂，所以一般来说实现异地集群都是使用这种双活，多活的模式，这种模式需要依赖rabbitMQ的federation插件，可以实现持续可靠的AMQP数据。采用双中心模式（多中心）在两套（或多套）数据中心个部署一套rabbitMQ集群，各中心的rabbitMQ服务需要为提供正常的消息业务外，中心之间还需要实现部分队列消息共享
    + federation插件是一个不需要构建Cluster，而在Brokers之间传输消息的高性能插件，federation可以在brokers或者cluster之间传输消息，连接的双方可以使用不同的users或者virtual host双方也可以使用不同版本的erlang或者rabbitMQ版本。federation插件可以使用AMQP协议作为通讯协议，可以接受不连续的传输。
    + Federation Exchanges,可以看成Downstream从Upstream主动拉取消息，但并不是拉取所有消息，必须是在Downstream上已经明确定义Bindings关系的Exchange,也就是有实际的物理Queue来接收消息，才会从Upstream拉取消息 到Downstream。使用AMQP协议实施代理间通信，Downstream 会将绑定关系组合在一起， 绑定/解除绑定命令将发送到Upstream交换机。Federation Exchange只接收具有订阅的消息。

```
# 现有两台机器ip以及hostname分别为
192.168.232.130 计算机名为cecily
192.168.232.129 计算机名为albert

# 在两台机器cecily和albert的/etc/hosts 末尾都加上
192.168.232.130 cecily
192.168.232.129 albert

# 查找.erlang.cookie文件的位置,两台机器的.erlang.cookie要一致，这是erlang通讯所需要用到的
find -name .erlang.cookie
# 将cecily机器添加到albert中，先将两个机器的防火墙关闭
systemctl stop firewalld.service

# 在cecily机器执行，将cecily的rabbitmq添加到了albert的集群中
rabbitmqctl stop_app
rabbitmqctl join_cluster --ram rabbit@albert
rabbitmqctl start_app

# Haproxy负载均衡
# 安装haproxy
yum install haproxy

# 修改haproxy配置 /etc/haproxy/haproxy.cfg 添加如下内容
#把rabbitmq节点的管理界面也放到haproxy
listen rabbitmq_admin
    bind 0.0.0.0:8600
    server albert 192.168.232.129:15672
    server cecily 192.168.232.130:15672
######################

##raiibitmq集群负载均衡配置
listen rabbitmq_cluster
    bind 0.0.0.0:8660
    option tcplog
    mode tcp
    timeout client 3m
    timeout server 3m
    balance roundrobin
    server albert 192.168.232.129:5672 check inter 5s rise 2 fall 3
    server cecily 192.168.232.130:5672 check inter 5s rise 2 fall 3
######

# 重新启动haproxy
systemctl restart haproxy.service

# 问haproxy机器的8600端口进入rabbitmq集群管理界面，8660端口通讯
```

## 图书

* 《深入RabbitMQ》 Gavin M.Roy

## 参考

* [文档](http://www.rabbitmq.com/tutorials/tutorial-one-php.html)
* [rabbitmq/rabbitmq-server](https://github.com/rabbitmq/rabbitmq-server):Open source multi-protocol messaging broker https://www.rabbitmq.com/
* [rabbitmq/rabbitmq-tutorials](https://github.com/rabbitmq/rabbitmq-tutorials):Tutorials for using RabbitMQ in various ways http://www.rabbitmq.com/getstarted.html
* [rabbitmq](http://blog.csdn.net/column/details/rabbitmq.html)
* [sky-big/RabbitMQ](https://github.com/sky-big/RabbitMQ):RabbitMQ系统3.5.3版本中文完全注释(同时实现了RabbitMQ系统和插件源代码编译，根据配置文件创建RabbitMQ集群，创建连接RabbitMQ系统的客户端节点等相关功能，方便源代码的阅读) https
