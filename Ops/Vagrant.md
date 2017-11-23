# Vagrant

方便开发环境迅速搭建与打包，windows下避免虚拟机安装的麻烦

## 安装

mac

```
brew cask install virtualbox
brew cask install vagrant
```

windows&&linux

- 下载安装virtualbox与vagrant

## box下载

环境有默认的box名称，添加box时不带url或uri会默认从官网下载（速度不敢保证），国外服务器通过wget下载，scp root@192.168.10.10:virtualbox.box virtualbox.box

* [官网](https://app.vagrantup.com/boxes/search?provider=virtualbox) 比如：https://atlas.hashicorp.com/laravel/boxes/homestead/versions/0.4.4/providers/virtualbox.boxes 
* [资源](http://www.vagrantbox.es/)

解决版本号的问题
新建
```json
{
    "name": "laravel/homestead",            //盒子名称
    "versions": 
    [
        {
            "version": "0.4.4",             //版本号
            "providers": [
                {
                  "name": "virtualbox",
                  "url": "virtualbox.box"   //盒子所在路径
                }
            ]
        }
    ]
}
```
`vagrant box add metadata.json`

## 端口检测:

在windows命令行窗口下执行：

```
C:\>netstat -aon|findstr "80"
TCP  127.0.0.1:80   0.0.0.0:0   LISTENING      2448
```

看到了吗，端口被进程号为2448的进程占用，继续执行下面命令：

```
C:\>tasklist|findstr "2448"
thread.exe  2016 Console    0    16,064 K
```

## 配置文件:ruby

```
`Vagrant.configure("2") do |config|
        config.vm.box = "ubuntu/trusty64"
        config.vm.network "forwarded_port", guest: 80, host: 5000
        config.vm.synced_folder "../", "/vagrant"
end`
```

## 命令

### box管理

```
vagrant box list 
vagrant box add ubuntu/trusty64 通过包名先去本地是否存在，没有去仓库下载，下载的版本在上述命令行下加入 --box-version=版本号
vagrant box add hahaha ~/box/package.box 加载本地文件(package包)
vagrant box add {title} {url} :title ubuntu/trusty64 [laravel/homestead](https://vagrantcloud.com/laravel/boxes/homestead/versions/3.0.0/providers/virtualbox.box)外网不稳定，可以试着换时间下载

vagrant box add name url      # 添加镜像
vagrant box list              # 列表
vagrant box remove name       # 移除镜像
vagrant box repackage         # 重新打包
```

### 服务管理

```
vagrant init {title}  hashicorp/precise64  #用 hashicorp/precise64 进行 box 初始化实例，自动帮你生成vagrantfile

vagrant up      # 启动配置虚拟机
vagrant halt      # 关闭虚拟机
vagrant suspend
vagrant resume
vagrant status  # 查看虚拟机运行状态

vagrant ssh      # SSH 至虚拟机
vagrant ssh web/dbmaster

vagrant reload  # 重新加载vagarntfile文件
vagrant reload --provision #系统更新配置文件的命令

vagrant destroy // 销毁虚拟机

vagrant package ：`vagrant package web --output web.box --vagrantfile Vagrantfile`(一块打到包里) 打包环境，包名、包文件

vagrant plugin install vagrant-vbguest
```

### 配置选项

```
config.vm.synced_folder “path/on/host”, “/absolute/path/on/vm”
config.vm.provision :shell, :inline => “ifconfig”  # inline script
config.vm.provision :shell, :path => “initialize.sh”  # external script
config.vm.network :forwarded_port, guest: 10022, host: 2255
# config.ssh.port = 2255            # port of host  # commented in step1
# config.ssh.guest_port = 10022     # port of VM    # commented in step1

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "gentoo"
    config.vm.box_check_update = false
    config.vm.network "forwarded_port", guest: 80, host: 8080   # 端口转发
    config.vm.network "private_network", ip: "192.168.33.10"    # 或 config.vm.network "public_network"，顾名思义
    config.ssh.forward_agent = true
    config.vm.synced_folder "./", "/vagrant"
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ......
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.name = "gentoo"
        vb.memory = 1024
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    end
    ......
end
```

## 搭建集群:ip中的0与1默认被占用，hostname不能含特殊符号

```
Vagrant.configure("2") do |config|
config.vm.define :web do |web|     #定义服务器名称，各种配置
    web.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "web", "--memory", "512"]
    end
    web.vm.box = "ubuntu/trusty64" 
    web.vm.hostname = "web"
    web.vm.synced_folder "../", "/vagrant"
    web.vm.network :private_network, ip: "192.168.33.4"
  end
config.vm.define :dbmaster do |dbmaster|
    dbmaster.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "dbmaster", "--memory", "512"]
    end
    dbmaster.vm.box = "ubuntu/trusty64"
    dbmaster.vm.hostname = "dbmaster"
    dbmaster.vm.network :private_network, ip: "192.168.33.1"
end
config.vm.define :dbslave do |dbslave|
    dbslave.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "dbslave", "--memory", "512"]
    end
    dbslave.vm.box = "ubuntu/trusty64"
    dbslave.vm.hostname = "dbslave"
    dbslave.vm.network :private_network, ip: "192.168.33.2"
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

app_servers = {
    :http => '192.168.58.20',
    :php => '192.168.58.21'
}

Vagrant.configure("2") do |config|
    config.vm.box = "centos6.3"

    config.vm.define :haproxy do |haproxy_config|
        haproxy_config.vm.network :private_network, ip: "192.168.58.10"
        haproxy_config.vm.network :forwarded_port, guest: 80, host: 8080
        config.vm.provider :virtualbox do |vb|
            vb.name = "haproxy"
            vb.customize ["modifyvm", :id, "--memory", "256"]
        end
    end

    app_servers.each do |app_server_name, app_server_ip|
        config.vm.define app_server_name do |app_config|
            app_config.vm.hostname = "#{app_server_name.to_s}.vagrant.internal"
            app_config.vm.network :private_network, ip: app_server_ip
           # app_config.vm.synced_folder "../app", "/opt/app"
            app_config.vm.provider "virtualbox" do |vb|
                vb.name = app_server_name.to_s
                vb.customize ["modifyvm", :id, "--memory", "256"]
            end
        end
    end

    config.vm.define :redis do |redis_config|
        redis_config.vm.hostname = "redis.vagrant.internal"
        redis_config.vm.network :private_network, ip: "192.168.58.30"
        redis_config.vm.provider "virtualbox" do |vb|
            vb.name = "redis"
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
            vb.customize ["modifyvm", :id, "--memory", "256"]
        end
    end
end

config.vm.define :app1 do |app1|
    app1.vm.box = "app1"
    app1.vm.network "private_network", ip: "192.168.33.10"
    app1.memory = 512
    app1.cpus = 2
    app1.vm.customize [ "modifyvm", :id, "--name", "app1", "--cpuexecutioncap", "50" ]
end
config.vm.define :app2 do |app2|
    app2.vm.box = "app2"
    app2.vm.network "private_network", ip: "192.168.33.11"
    app2.memory = 512
    app2.cpus = 1
    app1.vm.customize [ "modifyvm", :id, "--name", "app2", "--cpuexecutioncap", "40" ]
end

vagrant up app1
vagrant up app2
```

## 记录

- v1.9.4 bugs :SSH cann't connect

## 预安装

```
config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  ...

  config.vm.provision "shell", path: "bootstrap.sh"  # 添加这行
end
```

## 网络说明

- 端口映射(Forwarded port) ，顾名思义是指把宿主计算机的端口映射到虚拟机的某一个端口上，访问宿主计算机端口时，请求实际是被转发到虚拟机上指定端口的。Vagrantfile中设定语法为： `config.vm.forwarded_port 80, 8080` 以上将访问宿主计算机8080端口的请求都转发到虚拟机的80端口上进行处理。 默认只转发TCP包，UDP需要额外添加以下语句： `config.vm.forwarded_port 80, 8080, protocol: "udp"`

  - 优点：

    - 简单易理解
    - 容易实现外网访问虚拟机

  - 缺点：

    - 如果一两个端口需要映射很容易，但是如果有有很多端口，比如MySQL，MongoDB，tomcat等服务，端口比较多时，就比较麻烦。
    - 不支持在宿主机器上使用小于1024的端口来转发。比如：不能使用SSL的443端口来进行https连接。

- 私有网络（Private network） ，只有主机可以访问虚拟机，如果多个虚拟机设定在同一个网段也可以互相访问，当然虚拟机是可以访问外部网络的。设定语法为： `config.vm.network "private_network", ip: "192.168.50.4"`

  - 优点：

    - 安全，只有自己能访问

  - 缺点：

    - 因为私有的原因，所以团队成员其他人不能和你写作

- 公有网络（Public network） ，虚拟机享受实体机器一样的待遇，一样的网络配置，vagrant1.3版本之后也可以设定静态IP。设定语法如下： `config.vm.network "public_network", ip: "192.168.1.120"` 公有网络中还可以设置桥接的网卡，语法如下 `config.vm.network "public_network", :bridge => 'en1: Wi-Fi (AirPort)'`

  - 优点：

    - 方便团队协作，别人可以访问你的虚拟机

  - 缺点：

    - 需要有网络，有路由器分配IP

### 记录

- `It appears your machine doesn't support NFS, or there is not an adapter to enable NFS on this machine for Vagrant`:`sudo apt-get install nfs-kernel-server`
- `default: Warning: Authentication failure. Retrying...`;homestead.rb 中加入如下配置`config.ssh.username = 'vagrant'``config.ssh.password = 'vagrant'`

## 工具

- [Parallels/vagrant-parallels](https://github.com/Parallels/vagrant-parallels)Vagrant Parallels Provider
- [Vagrant Documentation](https://www.vagrantup.com/docs/)
