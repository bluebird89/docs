# Docker

Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从Apache2.0协议开源。Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

云计算时代的到来，极大程度上整合了硬件网络资源，开发于云端，如成功模版AWS，然而其相应大规模，分布式软件配置及管理则带来相当的复杂度，Docer则借鉴传统的虚拟及镜像机制，提供artifact集装箱能力，从而助力云计算，尤其是类似于提供了Web, Hadoop集群，消息队列等。

镜像装箱机制：类似一个只读模版的文件结构，可以自定义及扩展，用来创建Docker容器。

高效虚拟化：Docker借助LXC并进行革新提供了高效运行环境，而非类似VM的虚拟OS，GuestOS的弊端在于看起来够虚拟，隔离，然而使用起来又浪费资源，又难于管理。Docker则基于LXC的核心Linux Namespace,对cgroups/namespace机制及网络过封装，把隔离性，灵活性（资源分配），便携，安全性，最重要是其性能做到了极致。

Docker的总体架构图:
![](../_static/architect_docker.jpg)
Docker与VM对比:Docker是在操作系统层面进行虚拟化，而传统VM则直接在硬件层面虚拟化。
![](../_static/VMvsDocker.jpg)
Docker复用Host主机的OS, 抽象出Docker Engine层面实现调度与隔离，大大降低其负重级别.底层实现则借助了LXC, 管理利用了namespace做全县控制和隔离，cgroup来进行资源配置，aufs（类似git的思想，把文件系统的修改当作一次代码commit进行叠加从而节省存储）提高文件系统资源利用率。

## 原理

### 对比

- Hypervisor抽象虚拟化硬件平台
- VMWare, XEN抽象虚拟化操作系统
- LXC进程级别虚拟化

### 优点

- 启动速度快，通常小于1秒
- 资源利用率高，一个PC可以跑上千个容器
- 性能开销小
- 面向软件开发者而非硬件运维
- 轻便，移植性高

Docker基于LXC的改进

- 提供了简洁易用的命令行和API
- 使用Go语言开发，吸引开源社区关注
- 基于联合文件系统的镜像分层技术，加上在线Docker Hub服务，容器迁移方便快捷
- 一个容器只包含一个进程的微服务架构

## 概念

- 镜像（Image）：Docker的镜像即一个只读的模版，用来创建真正Docker容器。有点类似Java的类定义。镜像是一种文件结构，Dockerfile中的命令都会在文件系统中创建一个新的层次结构，镜像则构建与这些文件系统之上。
- 容器(Container)：容器则是镜像创建的实例，同样用Java类比的话类似Java的运行时对象Object。它可以被启动，开始，停止，删除等操作。容器之间是相互隔离的，保证安全的平台，如上文分析的进程间隔离的，甚至可以把每个容器当作一个精简版的Linux。
- 仓库（Registry）：镜像的仓库，用来保存images，当我们创建了自己的image后可以用push把它上传到公有或者私有仓库，类似我们git或者svn代码仓库，这样其他开发人员或者Ops可以pull用来开发或者部署。同样，类似代码仓库，每个镜像支持tag标签。
- 客户端(Client)：通过命令行或者其他工具使用 Docker API (https://docs.docker.com/reference/api/docker_remote_api) 与 Docker 的守护进程通信。
- 主机(Host)：一个物理或者虚拟的机器用于执行 Docker 守护进程和容器。
- Docker daemon 作为服务端接受来自客户的请求，并处理这些请求（创建、运行、分发容器）。 客户端和服务端既可以运行在一个机器上，也可通过 socket 或者RESTful API 来进行通信。Docker daemon 一般在宿主主机后台运行，等待接收来自客户端的消息。 Docker 客户端则为用户提供一系列可执行命令，用户用这些命令实现跟 Docker daemon 交互。

### 核心技术

- 隔离性
  + pid namespace：不同用户的进程就是通过pid隔离开的，且不同的namespace中可以有相同pid。所有LXC进程在Docker中的父进程为Docker进程，同时允许嵌套，实现Docker in Docker。
  + net namespace:网络的隔离则通过net namespace实现，每个net namspace有独立的network device， IP, IP routing table， /proc/net目录等。
  + ipc namespace:Container中进程交互采用linux的进程间交互方法， Interprocess Communicaiton - IPC， 包括信号量，消息队列，共享内存等。
  + mnt namespace: mnt namespace允许不同namespace的进程看到的文件结构不同，即隔离文件系统。
  + uts namesapce:UTS - Unix Time-Sharing System namespace允许每个Container拥有独立的hostname和domain name，使其在网络上可以独立的节点。
  + user namespace：每个Container拥有不同user和group id，即隔离用户。
- 可配额/可度量:Linux的cgroups实现了对资源配额和度量。cgroups类似文件的接口，在/cgroups目录下新建一个group，在此文件夹新建task，并将pid写入即可实现对改进程的资源控制。groups可以限制blkio，cpu，devices，memory，net_cls, ns等9大子系统。
- 便携性
  + AUFX（Another UnionFS），做到了支持将不同目录挂在到同一个虚拟文件系统下，AUFX支持为每一个成员目录设定权限readonly，readwrite等，同时引入分层概念，对于readonly的权限branch可以逻辑进行增量修改。Docker的初始化是将rootfs以readonly加载，之后利用union mount将一个readwrite文件系统挂载在readonly的rootfs之上，并向上叠加，这一系列的结构构成了container运行时。
  ![](../_static/docker_init.jpg)
- 安全性
  + 借助linux的kernel namspace和cgroups实现
  + deamon的安全接口
  + linux本身提供的安全方案，apparmor，selinux

## 仓库

- [Docker Hub](https://hub.docker.com)
- [The Docker Store](https://store.docker.com/)

## Install

- Mac : [docker-ce-desktop-mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)

  ```
  brew install docker
  brew install boot2docker
  ```

- Install packages to allow apt to use a repository over HTTPS

  ```
  sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
  ```

- Add Docker's official GPG key

  ```
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  ```

- set up the stable repository

  ```
  sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
  ```

- Update the apt package index and install

  ```
  sudo apt-get install docker-ce
  ```

## Usage:

### 应用场景

- Automating the packaging and deployment of applications
- Creation of lightweight, private PAAS environment
- Automated testing and continuous integration/deployment
- Deploying and scaling web apps, databases and backend services

```
docker version
docker search tutorial
docker images
docker pull learn/tutorial
docker run learn/tutorial echo "hello word"   // 两个参数，一个是指定镜像名（从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像），一个是要在镜像中运行的命令
docker run -i -t ubuntu:15.10 /bin/bash
docker run learn/tutorial apt-get install -y ping   // learn/tutorial镜像里面安装ping程序
docker ps -l(获取容器id)  
docker commit 698 learn/ping：版本号 alias 提交，获取新的版本号
docker run lean/ping ping www.google.com
docker logs -f $CONTAINER_ID  | docker attach $CONTAINER_ID
docker top determined_swanson
docker stop $CONTAINER_ID
docker inspect name  ||  docker ps -l(ast)/-a(ll)
docker start name
docker rm name
docker push learn/ping
```

## 运行方式

- 短暂方式：就是刚刚的那个"hello world"，命令执行完后，container就终止了，不过并没有消失，可以用 sudo docker ps -a 看一下所有的container，第一个就是刚刚执行过的container，可以再次执行一遍： linjiqin@ubuntu:~$ sudo docker start container_id：不过这次看不到"hello world"了，只能看到ID，用logs命令才能看得到：linjiqin@ubuntu:~$ sudo docker logs container_id可以看到两个"hello world"，因为这个container运行了两次。
- 交互方式：linjiqin@ubuntu:~$ sudo docker run -i -t image_name /bin/bash #image_name为docker镜像名称 -t:在新容器内指定一个伪终端或终端。 -i:允许你对容器内的标准输入 (STDIN) 进行交互
- daemon方式：即让软件作为长时间服务运行，这就是SAAS啊！例如，一个无限循环打印的脚本(替换为memcached、apache等，操作方法仍然不变！)：linjiqin@ubuntu:~$ CONTAINER_ID=$(sudo docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done") --name标识来命名容器 -P:是容器内部端口随机映射到主机的高端口 -p : 是容器内部端口绑定到指定的主机端口。 docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py 查看端口： docker port adoring_stonebraker 5002

## 构建容器

可以采用dockerfile来定义生成容器以及使用Fig来定义整个容器的运行框架, 构建Dockerfile：
```
FROM centos:6.7 MAINTAINER Fisher "fisher@sudops.com"
RUN /bin/echo 'root:123456' |chpasswd 
RUN useradd runoob 
RUN /bin/echo 'runoob:123456' |chpasswd 
RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local 
EXPOSE 22 
EXPOSE 80 
CMD /usr/sbin/sshd -D

docker build -t runoob/centos:6.7 . 
```

-t ：指定要创建的目标镜像名 . ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径 `docker tag 860c279d2fec runoob/centos:dev`

## boot2docker

## 分布式发布部署
- Google的Kubernetes
- Apache的Mesos

### 引用

- [Docker]http://blog.csdn.net/erixhao/article/details/72762851)
- [Docker 教程](http://www.runoob.com/docker/docker-tutorial.html)
