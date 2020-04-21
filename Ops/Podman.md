# [containers/libpod](https://github.com/containers/libpod)

libpod is a library used to create container pods. Home of Podman. https://podman.io/

* 可以管理和运行任何符合 OCI（Open Container Initiative）规范的容器和容器镜像
* 原来是 CRI-O 项目的一部分，后来被分离成一个单独的项目叫 libpod

```sh
brew cask install podman

podman run -dt -p 8080:8080/tcp -e HTTPD_VAR_RUN=/var/run/httpd -e HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d \
                  -e HTTPD_MAIN_CONF_PATH=/etc/httpd/conf \
                  -e HTTPD_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/httpd/ \
                  registry.fedoraproject.org/f27/httpd /usr/bin/run-httpd
podman run -dt -p 80:80 --name nginx -v /data:/data -e NGINX_VERSION=1.16 nginx:1.16.0

# Listing running containers
podman ps -a

# Inspecting a running container
podman inspect -l | grep IPAddress\":
            "SecondaryIPAddresses": null,
            "IPAddress": "",

# Viewing the container’s logs    
sudo podman logs --latest
# Viewing the container’s pids
sudo podman top <container_id>
podman  stats <container_id>
# Checkpointing the container
sudo podman container checkpoint <container_id>
# Restoring the container
sudo podman container restore <container_id>
# Migrate the container
sudo podman container checkpoint <container_id> -e /tmp/checkpoint.tar.gz # source system
scp /tmp/checkpoint.tar.gz <destination_system>:/tmp 

sudo podman container restore -i /tmp/checkpoint.tar.gz # destination system

# Stopping the container
sudo podman stop --latest

sudo podman rm --latest

# 实现开机自动重启容器:不再使用守护进程管理服务，所以不能通过守护进程去实现自动重启容器的功能
vim /etc/systemd/system/nginx_podman.service

[Unit]
Description=Podman Nginx Service
After=network.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/podman start -a nginx
ExecStop=/usr/bin/podman stop -t 10 nginx
Restart=always

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable nginx_podman.service
sudo systemctl start nginx_podman.service
```

## Podman vs docker

* docker 需要在我们的系统上运行一个守护进程(docker daemon)，而podman 不需要
* 启动容器的方式不同：
    - docker cli 命令通过API跟 Docker Engine(引擎)交互告诉它我想创建一个container，然后docker Engine才会调用OCI container runtime(runc)来启动一个container。这代表container的process(进程)不会是Docker CLI的child process(子进程)，而是Docker Engine的child process。
    - Podman是直接给OCI containner runtime(runc)进行交互来创建container的，所以container process直接是podman的child process。
    - 比较像Linux 的 fork/exec 模型，而 Docker 采用的是 C/S（客户端/服务器）模型。与 C/S 模型相比，fork/exec 模型有很多优势，比如：
        + 系统管理员可以知道某个容器进程到底是谁启动的。
        + 如果利用 cgroup 对 podman 做一些限制，那么所有创建的容器都会被限制。
        + SD_NOTIFY : 如果将 podman 命令放入 systemd 单元文件中，容器进程可以通过 podman 返回通知，表明服务已准备好接收任务。
        + socket 激活 : 可以将连接的 socket 从 systemd 传递到 podman，并传递到容器进程以便使用它们。
* 因为docke有docker daemon，所以docker启动的容器支持--restart策略，但是podman不支持，如果在k8s中就不存在这个问题，我们可以设置pod的重启策略，在系统中我们可以采用编写systemd服务来完成自启动
* docker需要使用root用户来创建容器，但是podman不需要
