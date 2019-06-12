# [hashicorp/vagrant](https://github.com/hashicorp/vagrant)

Vagrant is a tool for building and distributing development environments. https://www.vagrantup.com

* 统一开发环境。一次配置打包，统一分发给团队成员，统一团队开发环境
* 多个相互隔离开发环境。可以在不用box里跑不同的语言，或者编译安装同一语言不同版本，搭建多个相互隔离的开发环境，卸载清除时也很快捷轻松。
* windows下避免虚拟机安装的麻烦

## 安装

### mac

* /usr/local/bin
* /opt/vagrant/bin/vagrant

```sh
brew cask install virtualbox
brew cask install vagrant
brew cask install vagrant-manager
```

### windows

- 下载virtualbox与vagrant
- 安装
- 端口检测

```
# 在windows命令行窗口下执行
C:\>netstat -aon|findstr "80"
TCP  127.0.0.1:80   0.0.0.0:0   LISTENING      2448
# 看到了吗，端口被进程号为2448的进程占用，继续执行下面命令

C:\>tasklist|findstr "2448"
thread.exe  2016 Console    0    16,064 K
```

## 使用

### box管理

```sh
vagrant box list              # 列表

vagrant box add {title} {url}       # 添加镜像 title ubuntu/trusty64 [laravel/homestead](https://vagrantcloud.com/laravel/boxes/homestead/versions/3.0.0/providers/virtualbox.box)外网不稳定，可以试着换时间下载
vagrant box add ubuntu/trusty64 # 通过包名先去本地是否存在，没有去仓库下载，下载的版本在上述命令行下加入 --box-version=版本号
vagrant box add hahaha ~/box/package.box # 加载本地文件(package包)
vagrant box add precise64 http://files.vagrantup.com/precise64.box

vagrant box remove ubuntu/trusty64  --box-version=20170810.0.0  # 移除镜像,指定版本
vagrant box repackage         # 重新打包

vagrant plugin repair|update
vagrant plugin expunge --reinstall
```

box下载

* 环境有默认的box名称，添加box时不带url或uri会默认从官网下载（速度不敢保证）
* 国外服务器通过wget下载，scp root@192.168.10.10:virtualbox.box virtualbox.box
* box版本号的问题

```json
// 新建metadata.json
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
vagrant box add metadata.json
```

### 服务管理

通常情况下Box只做最基本的设置，因此Vagrant通常使用Chef或者Puppet来做进一步的环境搭建.那么Chef或者Puppet称为provisioning，而该命令就是指定开启相应的provisioning。按照Vagrant作者的说法，所谓的provisioning就是"The problem of installing software on a booted system"的意思。

* Chef
* Puppet
* Ansible
* 使用Shell来编写安装脚本

```sh
vagrant -h

vagrant init hashicorp/precise64  # 用 hashicorp/precise64 进行 box 初始化实例，自动帮你生成vagrantfile，默认base

vagrant status  # 查看虚拟机运行状态
vagrant up      # 启动配置虚拟机
vagrant suspend
vagrant resume
vagrant halt      # 关闭虚拟机

vagrant ssh      # SSH 至虚拟机
vagrant ssh web/dbmaster
vagrant ssh-config

vagrant reload  # 重新启动虚拟机，主要用于重新载入配置文件
vagrant reload --provision #系统更新配置文件的命令

vagrant destroy # 销毁虚拟机

vagrant package (--base web --output web.box --vagrantfile Vagrantfile) # 打包环境，包名、包文件

vagrant provision --provision-with chef

vagrant plugin install vagrant-vbguest # 插件安装
```

## 配置

* 文件默认Vagrantfile，基于Ruby配置
    - 虚拟机的配置
    - SSH配置
    - Vagrant配置
* 搭建集群:ip中的0与1默认被占用，hostname不能含特殊符号

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
# VAGRANTFILE_API_VERSION = "2"
# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
Vagrant.configure("2") do |config|
    # The most common configuration options are documented and commented below.
    # For a complete reference, please see the online documentation at
    # https://docs.vagrantup.com.

    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    # box设置：启用那个box作为系统，也就是vagrant init Box名称时所指定的box，如果沒有输入box名称的話，那么默认就是base
    config.vm.box = "ubunut/trusty64"

    # hostname 设置
    config.vm.hostname = "for_work"

    # Disable automatic box update checking. If you disable this, then
    # boxes will only be checked for updates when the user runs
    # `vagrant box outdated`. This is not recommended.
    # config.vm.box_check_update = false

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # NOTE: This will enable public access to the opened port
    # config.vm.network "forwarded_port", guest: 80, host: 8080

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine and only allow access
    # via 127.0.0.1 to disable public access
    # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    #
    # 主机和虚拟机之间的网络互访
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    # config.vm.network "private_network", ip: "192.168.33.10"

    # Create a public network, which generally matched to bridged network.
    # Bridged networks make the machine appear as another physical device on
    # your network.
    # config.vm.network "public_network"

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    config.vm.synced_folder "../data", "/vagrant_data"

    config.ssh.username = 'vagrant'
    config.ssh.password = 'vagrant'
    config.vbguest.auto_update = false
    # Provider-specific configuration so you can fine-tune various
    # backing providers for Vagrant. These expose provider-specific options.
    # Example for VirtualBox:
    # VirtualBox提供了VBoxManage这个命令行工具，modifyvm的命令置VM的名称与内存
    #
    # config.vm.provider "virtualbox" do |vb|
    #   # Display the VirtualBox GUI when booting the machine
    #   vb.gui = true
    #
    #   # Customize the amount of memory on the VM:
    #   vb.memory = "1024"
    #   vb.cpus = 2
    #   vb.name = "my_vm"
    #   hosts 解析慢
    #   vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    #   vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #   vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    # end
    #
    # View the documentation for the provider you are using for more
    # information on available options.

    # config.ssh.port = 2255            # port of host  # commented in step1
    # config.ssh.guest_port = 10022     # port of VM    # commented in step1
    # config.ssh.forward_agent = true

    # Enable provisioning with a shell script. Additional provisioners such as
    # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
    # documentation for more information about their specific syntax and use.
    # config.vm.provision "shell", inline: <<-SHELL
    #   apt-get update
    #   apt-get install -y apache2
    # SHELL
    #
    # config.vm.provision :shell, :path => “initialize.sh”
end

Vagrant.configure("2") do |config|
    config.vm.define :web do |web|     #定义服务器名称，各种配置
        web.vm.box = "ubuntu/trusty64"
        web.vm.hostname = "web"
        web.vm.network :private_network, ip: "192.168.33.4"
        web.vm.synced_folder "../", "/vagrant"
        web.memeory = 512
        web.cpus = 2
        web.vm.provider "virtualbox" do |v|
              v.customize ["modifyvm", :id, "--name", "web", , "--cpuexecutioncap", "40" ]
        # web.vm.customize [ "modifyvm", :id, "--name", "web", "--cpuexecutioncap", "50" ]
        end
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
            app_config.vm.synced_folder "../app", "/opt/app"
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
```

## 网络说明

* 端口映射(Forwarded port) ，顾名思义是指把宿主计算机的端口映射到虚拟机的某一个端口上，访问宿主计算机端口时，请求实际是被转发到虚拟机上指定端口的。Vagrantfile中设定语法为： `config.vm.forwarded_port 80, 8080` 以上将访问宿主计算机8080端口的请求都转发到虚拟机的80端口上进行处理。 默认只转发TCP包，UDP需要额外添加以下语句： `config.vm.forwarded_port 80, 8080, protocol: "udp"`
  - 简单易理解:容易实现外网访问虚拟机
  - 如果一两个端口需要映射很容易，但是如果有有很多端口，比如MySQL，MongoDB，tomcat等服务，端口比较多时，就比较麻烦;不支持在宿主机器上使用小于1024的端口来转发。比如：不能使用SSL的443端口来进行https连接。
* 私有网络（Private network） ，只有主机可以访问虚拟机，如果多个虚拟机设定在同一个网段也可以互相访问，当然虚拟机是可以访问外部网络的。设定语法为： `config.vm.network "private_network", ip: "192.168.50.4"`
  - 安全，只有自己能访问
  - 因为私有的原因，所以团队成员其他人不能和你写作
* 公有网络（Public network） ，虚拟机享受实体机器一样的待遇，一样的网络配置，vagrant1.3版本之后也可以设定静态IP。设定语法如下： `config.vm.network "public_network", ip: "192.168.1.120"` 公有网络中还可以设置桥接的网卡，语法如下 `config.vm.network "public_network", :bridge => 'en1: Wi-Fi (AirPort)'`
  - 方便团队协作，别人可以访问你的虚拟机
  - 需要有网络，有路由器分配IP

### 记录

- v1.9.4 bugs :SSH cann't connect
- `It appears your machine doesn't support NFS, or there is not an adapter to enable NFS on this machine for Vagrant`:`sudo apt-get install nfs-kernel-server`
- `default: Warning: Authentication failure. Retrying...`;homestead.rb 中加入如下配置`config.ssh.username = 'vagrant'``config.ssh.password = 'vagrant'`
- Vagrant was unable to mount VirtualBox shared folders. This is usually because the filesystem "vboxsf" is not available

```sh
sudo apt-get install virtualbox-guest-utils # ubuntu

sudo find / -name VBoxGuestAdditions.iso #  centos  文件位于VirtualBox安装文件夹下
mount /dev/cdrom /cdrom #( 该cdrom是我在/目录下创建的文件夹)
cd /cdrom;
sh ./VBoxLinuxAdditions.run
vagrant up
```

## 参考

* [Parallels/vagrant-parallels](https://github.com/Parallels/vagrant-parallels)Vagrant Parallels Provider
* [Vagrant Documentation](https://www.vagrantup.com/docs/)
* [官网](https://app.vagrantup.com/boxes/search?provider=virtualbox) 比如：https://atlas.hashicorp.com/laravel/boxes/homestead/versions/0.4.4/providers/virtualbox.boxes
* [资源](http://www.vagrantbox.es/)

## 工具

* [dotless-de/vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest):A Vagrant plugin to keep your VirtualBox Guest Additions up to date
