# Document

Docker 是一个开源的应用容器引擎，基于 Go 语言 并遵从Apache2.0协议开源。Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

# Install

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

# Usage:

```
docker version
docker search tutorial
docker images
docker pull learn/tutorial
docker run learn/tutorial echo "hello word" 两个参数，一个是镜像名，一个是要在镜像中运行的命令
docker run learn/tutorial apt-get install -y ping:learn/tutorial镜像里面安装ping程序
保存容易修改：docker ps -l(获取容器id)  docker commit 698 learn/ping：版本号 alias 提交，获取新的版本号
运行新镜像：docker run lean/ping ping www.google.com
docker logs -f $CONTAINER_ID  | docker attach $CONTAINER_ID
docker top determined_swanson
docker stop $CONTAINER_ID
docker inspect name  ||  docker ps -l(ast)/-a(ll)
docker start name
docker rm name
发布镜像：docker push learn/ping
```

# 运行方式

- 短暂方式：就是刚刚的那个"hello world"，命令执行完后，container就终止了，不过并没有消失，可以用 sudo docker ps -a 看一下所有的container，第一个就是刚刚执行过的container，可以再次执行一遍： linjiqin@ubuntu:~$ sudo docker start container_id：不过这次看不到"hello world"了，只能看到ID，用logs命令才能看得到：linjiqin@ubuntu:~$ sudo docker logs container_id可以看到两个"hello world"，因为这个container运行了两次。

- 交互方式：linjiqin@ubuntu:~$ sudo docker run -i -t image_name /bin/bash #image_name为docker镜像名称 -t:在新容器内指定一个伪终端或终端。 -i:允许你对容器内的标准输入 (STDIN) 进行交互

- daemon方式：即让软件作为长时间服务运行，这就是SAAS啊！例如，一个无限循环打印的脚本(替换为memcached、apache等，操作方法仍然不变！)：linjiqin@ubuntu:~$ CONTAINER_ID=$(sudo docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done") --name标识来命名容器 -P:是容器内部端口随机映射到主机的高端口 -p : 是容器内部端口绑定到指定的主机端口。 docker run -d -p 127.0.0.1:5000:5000/udp training/webapp python app.py 查看端口： docker port adoring_stonebraker 5002

# 构建镜像

新建文件Dockerfile：

runoob@runoob:~$ cat Dockerfile FROM centos:6.7 MAINTAINER Fisher "fisher@sudops.com"

RUN /bin/echo 'root:123456' |chpasswd RUN useradd runoob RUN /bin/echo 'runoob:123456' |chpasswd RUN /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local EXPOSE 22 EXPOSE 80 CMD /usr/sbin/sshd -D

```
docker build -t runoob/centos:6.7 .
```

-t ：指定要创建的目标镜像名 . ：Dockerfile 文件所在目录，可以指定Dockerfile 的绝对路径 docker tag 860c279d2fec runoob/centos:dev

## boot2docker

-
