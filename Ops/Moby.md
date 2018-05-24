# Docker

Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从Apache2.0协议开源。Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

云计算时代的到来，极大程度上整合了硬件网络资源，开发于云端，如成功模版AWS，然而其相应大规模，分布式软件配置及管理则带来相当的复杂度，Docer则借鉴传统的虚拟及镜像机制，提供artifact集装箱能力，从而助力云计算，尤其是类似于提供了Web, Hadoop集群，消息队列等。

镜像装箱机制：类似一个只读模版的文件结构，可以自定义及扩展，用来创建Docker容器。

高效虚拟化：Docker借助LXC并进行革新提供了高效运行环境，而非类似VM的虚拟OS，GuestOS的弊端在于看起来够虚拟，隔离，然而使用起来又浪费资源，又难于管理。Docker则基于LXC的核心Linux Namespace,对cgroups/namespace机制及网络过封装，把隔离性，灵活性（资源分配），便携，安全性，最重要是其性能做到了极致。

Docker的总体架构图: ![](../_static/architect_docker.jpg) Docker与VM对比:Docker是在操作系统层面进行虚拟化，而传统VM则直接在硬件层面虚拟化。 ![](../_static/VMvsDocker.jpg) Docker复用Host主机的OS, 抽象出Docker Engine层面实现调度与隔离，大大降低其负重级别.底层实现则借助了LXC, 管理利用了namespace做全县控制和隔离，cgroup来进行资源配置，aufs（类似git的思想，把文件系统的修改当作一次代码commit进行叠加从而节省存储）提高文件系统资源利用率。

## 原理

支持 Windows/Linux/Mac/AWS/Azure 多种平台的安装，其中 Windows 需要 Win10+，Mac 需要 EI Captain+。

### 对比

* Hypervisor抽象虚拟化硬件平台
* VMWare, XEN抽象虚拟化操作系统
* LXC进程级别虚拟化

### 优点

* 不需要等待虚拟系统启动所以启动快速资源占用低，启动速度快，通常小于1秒
* 资源利用率高，一个PC可以跑上千个容器。沙箱机制保证不同服务之间环境隔离
* 性能开销小
* 面向软件开发者而非硬件运维
* 轻便，移植性高
* 不需要打包系统进镜像所以体积非常小
* Dockerfile 镜像构建机制让镜像打包部署自动化
* Docker hub 提供镜像平台方便共享镜像

Docker基于LXC的改进

- 提供了简洁易用的命令行和API
- 使用Go语言开发，吸引开源社区关注
- 基于联合文件系统的镜像分层技术，加上在线Docker Hub服务，容器迁移方便快捷
- 一个容器只包含一个进程的微服务架构

## 概念

* Dockerfile：可以生成 Docker Image(镜像)。自己制作的镜像可以上传到 Docker hub 平台，也可以从平台上拉去我们需要的镜像
  - 使用#来注释
  - FROM 指令告诉 Docker 使用哪个镜像作为基础
  - RUN 开头的指令会在创建中运行，比如安装一个软件包
  - COPY 指令将文件复制进镜像中
  - WORKDIR 指定工作目录
  - CMD/ENTRYPOINT 容器启动执行命令
* 镜像（Image）：Docker的镜像即一个只读的模版，用来创建真正Docker容器。有点类似Java的类定义。镜像是一种文件结构，Dockerfile中的命令都会在文件系统中创建一个新的层次结构，镜像则构建与这些文件系统之上。
* 容器(Container)：容器则是镜像创建的实例，同样用Java类比的话类似Java的运行时对象Object。它可以被启动，开始，停止，删除等操作。容器之间是相互隔离的，保证安全的平台，如上文分析的进程间隔离的，甚至可以把每个容器当作一个精简版的Linux。
* 仓库（Repository）：镜像的仓库，用来保存images，当我们创建了自己的image后可以用push把它上传到公有或者私有仓库，类似我们git或者svn代码仓库，这样其他开发人员或者Ops可以pull用来开发或者部署。同样，类似代码仓库，每个镜像支持tag标签。
* 客户端(Client)：通过命令行或者其他工具使用 Docker API (<https://docs.docker.com/reference/api/docker_remote_api>) 与 Docker 的守护进程通信。
* 主机(Host)：一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。
* Docker daemon 作为服务端接受来自客户的请求，并处理这些请求（创建、运行、分发容器）。 客户端和服务端既可以运行在一个机器上，也可通过 socket 或者RESTful API 来进行通信。Docker daemon 一般在宿主主机后台运行，等待接收来自客户端的消息。 Docker 客户端则为用户提供一系列可执行命令，用户用这些命令实现跟 Docker daemon 交互。

### 核心技术

隔离性主要是来自kernel的namespace, 其中pid, net, ipc, mnt, uts 等namespace将container的进程, 网络, 消息, 文件系统和hostname 隔离开。

- 隔离性
  - pid namespace：不同用户的进程就是通过pid隔离开的，且不同的namespace中可以有相同pid。所有LXC进程在Docker中的父进程为Docker进程，同时允许嵌套，实现Docker in Docker。
  - net namespace:网络的隔离则通过net namespace实现，每个net namspace有独立的network device， IP, IP routing table， /proc/net目录等。
  - ipc namespace:Container中进程交互采用linux的进程间交互方法， Interprocess Communicaiton - IPC， 包括信号量，消息队列，共享内存等。
  - mnt namespace: mnt namespace允许不同namespace的进程看到的文件结构不同，即隔离文件系统。
  - uts namesapce:UTS - Unix Time-Sharing System namespace允许每个Container拥有独立的hostname和domain name，使其在网络上可以独立的节点。
  - user namespace：每个Container拥有不同user和group id，即隔离用户。
- 可配额/可度量:Linux的cgroups实现了对资源配额和度量。cgroups类似文件的接口，在/cgroups目录下新建一个group，在此文件夹新建task，并将pid写入即可实现对改进程的资源控制。groups可以限制blkio，cpu，devices，memory，net_cls, ns等9大子系统。
- 便携性
  - AUFX（Another UnionFS），做到了支持将不同目录挂在到同一个虚拟文件系统下，AUFX支持为每一个成员目录设定权限readonly，readwrite等，同时引入分层概念，对于readonly的权限branch可以逻辑进行增量修改。Docker的初始化是将rootfs以readonly加载，之后利用union mount将一个readwrite文件系统挂载在readonly的rootfs之上，并向上叠加，这一系列的结构构成了container运行时。 ![](../_static/docker_init.jpg)
- 安全性
  - 借助linux的kernel namspace和cgroups实现
  - deamon的安全接口
  - linux本身提供的安全方案，apparmor，selinux

## 仓库

- [Docker Hub](https://hub.docker.com)
- [The Docker Store](https://store.docker.com/)
- [docker cloud](https://cloud.docker.com/)

## Install

- Mac : [docker-ce-desktop-mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)

```sh
# MAC
brew install docker
brew install boot2docker
brew cask install docker-toolbox

# Ubuntu
# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# set up the stable repository
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

# Update the apt package index and install
sudo apt-get update
sudo apt-get install docker-ce
sudo apt-get upgrade docker-ce

sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

docker version

yum install docker
```

## Usage:

ensure docker daemon runing
拉取或新建服务，挂载目录与运行.应用一般包括三种文件：

- 应用文件或数据文件（htdocs/data）
- 配置文件（conf）
- 日志文件

### 应用场景

- Automating the packaging and deployment of applications
- Creation of lightweight, private PAAS environment
- Automated testing and continuous integration/deployment
- Deploying and scaling web apps, databases and backend services

### 镜像使用

- REPOSTITORY：表示镜像的仓库源
- TAG：镜像的标签
- IMAGE ID：镜像ID
- CREATED：镜像创建时间
- SIZE：镜像大小

创建镜像

- 从已经创建的容器中更新镜像，并且提交这个镜像
  - 查看新镜像 docker images
  - 使用镜像来创建一个容器 `docker run -t -i ubuntu:15.10 /bin/bash`
  - -p 3306:3306   表示在这个容器中使用3306端口(第二个)映射到本机的端口号也为3306(第一个)
  - 在运行的容器内使用 apt-get update 命令进行更新,exit退出容器
  - 提交容器`docker commit -m="has update" -a="runoob" e218edb10161 runoob/ubuntu:v2`
  - 使用我们的新镜像 runoob/ubuntu 来启动一个容器`docker run -t -i runoob/ubuntu:v2 /bin/bash`
- 使用 Dockerfile 指令来创建一个新的镜像,`cat Dockerfile`
  - 每一个指令都会在镜像上创建一个新的层，每一个指令的前缀都必须是大写的
  - FROM 和 MAINTAINER 通常出现在文件第一行，用于选择基础镜像和说明维护人信息，
  - RUN:在镜像内执行命令
  - ADD: 将本地目录中的文件添加到docker镜像中 `ADD unicorn.rb /app/config/unicorn.rb`
  - ENV: 添加环境变量  `ENV RAILS_ENV staging`
  - `docker build -t runoob/centos:6.7 .`构建一个镜像
  - -t ：指定要创建的目标镜像名
  - . ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径
  - `docker tag 860c279d2fec runoob/centos:dev` 镜像添加一个新的标签

```
FROM centos:6.7 MAINTAINER Fisher "fisher@sudops.com"
RUN /bin/echo 'root:123456' |chpasswd
RUN useradd runoob
RUN /bin/echo 'runoob:123456' |chpasswd
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
EXPOSE 22
EXPOSE 80
CMD /usr/sbin/sshd -D
```

```sh
# 镜像
docker images # 列出本地主机上的镜像
docker pull ubuntu:13.10 # 获取镜像
docker search httpd  # 搜索镜像
docker pull learn/tutorial
docker create ubuntu:14.04 #  create images
docker rmi [IMAGE ID] # Remove one or more images.
docker build [DOCKERFILE PATH] # Build an image from a Dockerfile
docker build -t my-org:my-image -f /tmp/Dockerfile #  Build an image tagged my-org/my-image where the Dockerfile can be found at /tmp/Dockerfile.

# 容器
docker run -i -t ubuntu:15.10 /bin/bash # 在新容器内建立一个伪终端或终端。
docker run -d -P training/webapp python app.py   #  -P :是容器内部端口随机映射到主机的高端口。
docker run -d -p 127.0.0.1:5001:5002  --name runoob training/webapp python app.py   # -p : 是容器内部端口绑定到指定的主机端口。  使用--name标识来命名容器
docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py
docker run learn/tutorial echo "hello word"   # 两个参数，一个是指定镜像名（从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像），一个是要在镜像中运行的命令
docker run learn/tutorial apt-get install -y ping   # learn/tutorial镜像里面安装ping程序
docker run [组织名称]/<镜像名称>:[镜像标签]

docker ps    # 查看运行容器状态
docker-compose ps #查看当前项目容器
docker ps -l   # 查看最后一次创建的容器
docker commit 698 learn/ping：版本号 alias 提交，获取新的版本号
docker run lean/ping ping www.google.com
docker logs -f $CONTAINER_ID  | docker attach $CONTAINER_ID  # -f:动态输出

docker top determined_swanson    # 查看容器内部运行的进程
docker-compose exec {container-name} bash

docker inspect [CONTAINER ID] # Shows all the info of a container.
docker exec [CONTAINER ID] touch /tmp/exec_works # Execute a command inside a running container.

docker inspect name  ||  docker ps -l(ast)/-a(ll)     # 查看Docker的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息
docker start name
docker rm name # 移除容器
docker rm $(docker ps -a -q) # Delete all containers
docker rmi $(docker images | grep '^<none>' | awk '{print $3}') # Delete all untagged containers
docker push learn/ping
docker port 7a38a1ad55c6  docker port determined_swanson：查看指定 （ID或者名字）容器的某个确定端口映射到宿主机的端口号

docker stop $CONTAINER_ID
docker-compose stop # 关闭当前项目容器

docker system df # See all space Docker take up
docker inspect [CONTAINER ID] | grep -wm1 IPAddress | cut -d '"' -f 4 # Get IP address of running container
docker kill $(docker ps -q) #Kill all running containers
docker rmi $(docker images | grep '^<none>' | awk '{print $3}') # Delete all untagged containers

# 如果要为底层主机添加卷（例如对于 DB 持久性数据），则应该在镜像内定义映射卷： RUN
mkdir -p /data VOLUME ["/data"]
sudo docker run -d -v /data:/data bat/spark

sudo docker create -v /dbdata --name dbstore training/postgres /bin/true
sudo docker run -d --volumes-from dbstore --name db1 training/postgres

sudo docker run -d --add-host=SERVER_NAME:127.0.0.1 bat/spark

docker exec -it [id]|[name] /bin/bash  #i是交互式操作，t是一个终端，d指的是在后台运行
```

### avoid sudo

```sh
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart

sudo usermod -aG docker ${USER}
sudo usermod -aG docker $(whoami)

# mac
docker-machine start # Start virtual machine for docker
docker-machine env  # It's helps to get environment variables
eval "$(docker-machine env default)" # Set environment variables
```

### 容器连接

连接系统允许将多个容器连接在一起，共享连接信息。docker连接会创建一个父子关系，其中父容器可以看到子容器的信息。

## 运行方式

* 短暂方式：就是刚刚的那个"hello world"，命令执行完后，container就终止了，不过并没有消失，可以用 sudo docker ps -a 看一下所有的container，第一个就是刚刚执行过的container，可以再次执行一遍：`sudo docker start container_id`：不过这次看不到"hello world"了，只能看到ID，用logs命令才能看得到： `sudo docker logs container_id`可以看到两个"hello world"，因为这个container运行了两次。
* 交互方式：`sudo docker run -i -t image_name /bin/bash` #image_name为docker镜像名称 -t:在新容器内指定一个伪终端或终端。 -i:允许你对容器内的标准输入 (STDIN) 进行交互
* daemon方式：即让软件作为长时间服务运行，这就是SAAS啊！例如，一个无限循环打印的脚本(替换为memcached、apache等，操作方法仍然不变！)：linjiqin@ubuntu:~$ CONTAINER_ID=$(sudo docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done") --name标识来命名容器 -P:是容器内部端口随机映射到主机的高端口 -p : 是容器内部端口绑定到指定的主机端口。 docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py 查看端口： docker port adoring_stonebraker 5002

### 迁移docker

* 分解：通过设计和部署把这些服务拆分成为它们自己的容器。如果一个应用程序能够被拆分成为越多的分布式组件，那么应用程序扩展的选择则越多。但是，分布式组件越多也意味着管理的复杂性越高。
* 选择基础映像：搜索Docker注册库找到一个基本的Docker映像并将其作为应用程序的基础来使用。
* 安全管理：安全性和管理应当是一个高优先级的考虑因素；企业用户不应再把它们当作应用程序迁移至容器的最后一步。反之，企业必须从一开始就做好安全性和管理的规划，把它们的功能纳入应用程序的开发过程中，并在应用程序运行过程中积极主动地关注这些方面。基于容器的应用程序是分布式应用程序。企业应当更新较老的应用程序以支持联合身份管理方法，这将非常有利于确保分布式应用程序的安全性。为了做到这一点，应为每一个应用程序组件和数据提供一个唯一的标识符，这个标识符可允许企业在一个细粒度的级别上进行安全性管理。企业用户还应当增加一个日志记录的方法。
* 配置Dockerfile，添加到Docker Hub

## boot2docker

## 工具

* [docker/machine](https://github.com/docker/machine)Machine management for a container-centric world
* [drone/drone](https://github.com/drone/drone):Drone is a Continuous Delivery platform built on Docker, written in Go https://drone.io
* Shipyard
* Potainer

> [docker/compose](https://github.com/docker/compose):Define and run multi-container applications with Docker https://docs.docker.com/compose/

Docker Compose 是一款容器编排程序，使用 YAML 配置的形式将你需要启动的容器管理起来.

能够帮我们处理容器的依赖关系，在每个容器中会将容器的 IP 和服务的名称使用 hosts 的方式绑定，这样我们就能在容器中直接使用服务名称来接入对应的容器了

```
version: "2"

services:
 // 服务名称
    nginx:
        depends_on:
          - "php"
        // 指定服务的镜像名称或镜像 ID
        image: "nginx:latest"
        volumes:

          - "$PWD/src/docker/conf:/etc/nginx/conf.d"

          - "$PWD:/home/q/system/m_look_360_cn"

        ports:

          - "8082:80"

        container_name: "m.look.360.cn-nginx"

    php:

        image: "lizheming/php-fpm-yaf"

        volumes:

            - "$PWD:/home/q/system/m_look_360_cn"

        container_name: "m.look.360.cn-php"
```
## 参考

* [Docker](http://blog.csdn.net/erixhao/article/details/72762851)
* [Docker 教程](http://www.runoob.com/docker/docker-tutorial.html)
* [Docker for Mac](https://docs.docker.com/docker-for-mac/)
* [Docker mac 入门](https://docs.docker.com/mac/)
* [Product and tool manuals](https://docs.docker.com/manuals/) https://docs.docker.com/engine/installation/
* [moby/moby](https://github.com/moby/moby)Moby Project - a collaborative project for the container ecosystem to assemble container-based systems https://mobyproject.org/
* [Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/)
* [veggiemonk/awesome-docker](https://github.com/veggiemonk/awesome-docker):A curated list of Docker resources and projects
