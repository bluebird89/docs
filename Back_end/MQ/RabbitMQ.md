# [rabbitmq/rabbitmq-server](https://github.com/rabbitmq/rabbitmq-server)

Open source multi-protocol messaging broker https://www.rabbitmq.com/

RabbitMQ 是基于 AMQP 实现的一个开源消息组件，主要用于在分布式系统中存储转发消息，由因高性能、高可用以及高扩展而出名的 Erlang 语言写成。AMQP（Advanced Message Queuing Protocol，即高级消息队列协议），是一个异步消息传递所使用的应用层协议规范，为面向消息的中间件设计。消息中间件主要用于组件之间的解耦，消息的发送者无需知道消息使用者的存在，AMQP的主要特征是面向消息、队列、路由（包括点对点和发布/订阅）、可靠性、安全。

* 高可靠：RabbitMQ 提供了多种多样的特性让你在可靠性和性能之间做出权衡，包括持久化、发送应答、发布确认以及高可用性。
* 高可用队列：支持跨机器集群，支持队列安全镜像备份，消息的生产者与消费者不论哪一方出现问题，均不会影响消息的正常发出与接收。
* 灵活的路由：所有的消息都会通过路由器转发到各个消息队列中，RabbitMQ 内建了几个常用的路由器，并且可以通过路由器的组合以及自定义路由器插件来完成复杂的路由功能。
* 支持多客户端：对主流开发语言（如：Python、Ruby、.NET、Java、C、PHP、ActionScript 等）都有客户端实现。
* 集群：本地网络内的多个 Server 可以聚合在一起，共同组成一个逻辑上的 broker。
* 扩展性：支持负载均衡，动态增减服务器简单方便。
* 权限管理：灵活的用户角色权限管理，Virtual Host 是权限控制的最小粒度。
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

## 原理

* ConnectionFactory、Connection、Channel都是RabbitMQ对外提供的API中最基本的对象。
* Connection是RabbitMQ的socket链接，它封装了socket协议相关部分逻辑。
* ConnectionFactory为Connection的制造工厂。
* Channel是我们与RabbitMQ打交道的最重要的一个接口，我们大部分的业务操作是在Channel这个接口中完成的，包括定义Queue、定义Exchange、绑定Queue与Exchange、发布消息等。
* Queue（队列）是RabbitMQ的内部对象，用于存储消息。消息都只能存储在Queue中，生产者生产消息并最终投递到Queue中，消费者可以从Queue中获取消息并消费。多个消费者可以订阅同一个Queue，这时Queue中的消息会被平均分摊给多个消费者进行处理，而不是每个消费者都收到所有的消息并处理。
* Message acknowledgment:要求消费者在消费完消息后发送一个回执给RabbitMQ，RabbitMQ收到消息回执（Message acknowledgment）后才将该消息从Queue中移除；如果RabbitMQ没有收到回执并检测到消费者的RabbitMQ连接断开，则RabbitMQ会将该消息发送给其他消费者（如果存在多个消费者）进行处理
* Message durability:在RabbitMQ服务重启的情况下，也不会丢失消息，我们可以将Queue与Message都设置为可持久化的
* Prefetch count:通过设置prefetchCount来限制Queue每次发送给每个消费者的消息数，比如我们设置prefetchCount=1，则Queue每次给每个消费者发送一条消息；消费者处理完这条消息后Queue会再给该消费者发送一条消息。
* Exchange:生产者将消息发送到Exchange，由Exchange将消息路由到一个或多个Queue中
* routing key:*生产者在将消息发送给Exchange的时候，一般会指定一个routing key*，来指定这个消息的路由规则，而这个routing key需要与Exchange Type及binding key联合使用才能最终生效。 在Exchange Type与binding key固定的情况下（在正常使用时一般这些内容都是固定配置好的），我们的生产者就可以在发送消息给Exchange时，通过指定routing key来决定消息流向哪里。 RabbitMQ为routing key设定的长度限制为255 bytes。
* Binding:RabbitMQ中通过Binding将Exchange与Queue关联起来，这样RabbitMQ就知道如何正确地将消息路由到指定的Queue了
* Binding key:在绑定（Binding）Exchange与Queue的同时，一般会指定一个binding key；消费者将消息发送给Exchange时，一般会指定一个routing key；*当binding key与routing key相匹配时，消息将会被路由到对应的Queue中*。这个将在Exchange Types章节会列举实际的例子加以说明。 在绑定多个Queue到同一个Exchange的时候，这些Binding允许使用相同的binding key。 binding key 并不是在所有情况下都生效，它依赖于Exchange Type，比如fanout类型的Exchange就会无视binding key，而是将消息路由到所有绑定到该Exchange的Queue。
* Exchange Types:RabbitMQ常用的Exchange Type有fanout、direct、topic、headers这四种
    - fanout类型的Exchange路由规则非常简单，它会把所有发送到该Exchange的消息路由到所有与它绑定的Queue中。
    - direct类型的Exchange路由规则也很简单，它会把消息路由到那些binding key与routing key完全匹配的Queue中。
    - topic类型的Exchange在匹配规则上进行了扩展，它与direct类型的Exchage相似，也是将消息路由到binding key与routing key相匹配的Queue中，但这里的匹配规则有些不同，它约定：
        * routing key为一个句点号“. ”分隔的字符串（我们将被句点号“. ”分隔开的每一段独立的字符串称为一个单词），如“stock.usd.nyse”、“nyse.vmw”、“quick.orange.rabbit”
        * binding key与routing key一样也是句点号“. ”分隔的字符串，binding key中可以存在两种特殊字符“*”与“#”，用于做模糊匹配，其中“*”用于匹配一个单词，“#”用于匹配多个单词（可以是零个）
    - headers类型的Exchange不依赖于routing key与binding key的匹配规则来路由消息，而是根据发送的消息内容中的headers属性进行匹配。 在绑定Queue与Exchange时指定一组键值对；当消息发送到Exchange时，RabbitMQ会取到该消息的headers（也是一个键值对的形式），对比其中的键值对是否完全匹配Queue与Exchange绑定时指定的键值对；如果完全匹配则消息会路由到该Queue，否则不会路由到该Queue。 该类型的Exchange没有用到过（不过也应该很有用武之地）
    - MQ本身是基于异步的消息处理，前面的示例中所有的生产者（P）将消息发送到RabbitMQ后不会知道消费者（C）处理成功或者失败（甚至连有没有消费者来处理这条消息都不知道）。 但实际的应用场景中，我们很可能需要一些同步处理，需要同步等待服务端将我的消息处理完成后再进行下一步处理。这相当于RPC（Remote Procedure Call，远程过程调用）。在RabbitMQ中也支持RPC。
        + 客户端发送请求（消息）时，在消息的属性（MessageProperties ，在AMQP 协议中定义了14中properties ，这些属性会随着消息一起发送）中设置两个值replyTo （一个Queue 名称，用于告诉服务器处理完成后将通知我的消息发送到这个Queue 中）和correlationId （此次请求的标识号，服务器处理完成后需要将此属性返还，客户端将根据这个id了解哪条请求被成功执行了或执行失败）
        + 服务器端收到消息并处理
        + 服务器端处理完消息后，将生成一条应答消息到replyTo 指定的Queue ，同时带上correlationId 属性
        + 客户端之前已订阅replyTo 指定的Queue ，从中收到服务器的应答消息后，根据其中的correlationId 属性分析哪条请求被执行了，根据执行结果进行后续业务处理

## 模式

简单模式、工作队列模式、发布/订阅模式、路由模式、主题模式 和 RPC 模式

* 单对单
* 单对多
* 发布订阅模式：Exchange Type 为 topic，发送消息时需要指定交换机及 Routing Key，消费者的消息队列绑定到该交换机并匹配到 Routing Key 实现消息的订阅，订阅后则可接收消息。只有消费者将队列绑定到该交换机且指定的 Routing Key 符合匹配规则，才能收到消息。Routing Key 可以设置成通配符，如：*或 #（*表示匹配 Routing Key 中的某个单词，# 表示任意的 Routing Key 的消息都能被收到）。如果 Routing Key 由多个单词组成，则单词之间用. 来分隔。
* 按路由规则发送接收
* 主题
* RPC（即远程存储调用）

## 集群

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
