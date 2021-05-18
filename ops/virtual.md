# Virtual

VM 的 Hypervisor 需要实现对硬件的虚拟化，并且还要搭载自己的操作系统

* VMM (Virtual Machine Monitor)：也被称为 hypervisor，在同一个物理机器上创建出来多态虚拟机器的假象。
* 虚拟化技术(virtualization)：是一种资源管理技术，将计算机的各种实体资源（CPU、内存、磁盘空间、网络适配器等），进行抽象、转换后呈现出来并可供分割、组合为一个或多个电脑配置环境。
* 云(cloud)：云是目前虚拟机最重要、最时髦的玩法。
* 解释器(interpreter)：解释器是一种程序，能够把编程语言一行一行解释运行。每次运行程序时都要先转成另一种语言再运行，因此解释器的程序运行速度比较缓慢。它不会一次把整个程序翻译出来，而是每翻译一行程序叙述就立刻运行，然后再翻译下一行，再运行，如此不停地进行下去。
* 半虚拟化(paravirtualization)：半虚拟化的目的不是呈现出一个和底层硬件一摸一样的虚拟机，而是提供一个软件接口，软件接口与硬件接口相似但又不完全一样。
* 全虚拟化(full virtualization)：全虚拟化是硬件虚拟化的一种，允许未经修改的操作系统隔离运行。对于全虚拟化，硬件特征会被映射到虚拟机上，这些特征包括完整的指令集、I/O操作、中断和内存管理等。
* 客户操作系统(guest operating system) : 客户操作系统是安装在计算机上操作系统之后的操作系统，客户操作系统既可以是分区系统的一部分，也可以是虚拟机设置的一部分。客户操作系统为设备提供了备用操作系统。
* 主机操作系统(host operating system)：主机操作系统是计算机系统的硬盘驱动器上安装的主要操作系统。在大多数情况下，只有一个主机操作系统。

## 虚拟化进程

* 单应用单物理机
* 应用虚拟化
  - Virual Host:web 服务器和数据库这样的基础层应用，开始提供逻辑隔离功能，即允许在一个基础层上同时支撑多个用户应用
  - 增加了程序架构和部署的复杂度
* 虚拟机
  - 一台物理机上的每个应用程序都可以拥有自己的操作系统和运行环境
  - 通过逻辑上的隔离显著地简化了应用程序架构
  - 虚拟机时代最具革命性的结果，是以 AWS 为主导的云计算业务
* 容器:把进程“装箱”到了一个操作系统不同的资源子集当中
  - 随着大量新功能的引入，也带来了服务部署和管理复杂度的挑战
  - 服务扩容仍然需要依赖云计算厂商提供的特定方法来扩容底层的虚拟机。何时创建容器，将容器部署在何处也是非常复杂的问题
* Kubernetes:基于容器的服务，提供了一种标准的、环境无关的方式来描述、管理和运行一个完整的可扩展的大型系统
* 技术
  - Hypervisor抽象虚拟化硬件平台
  - VMWare, XEN抽象虚拟化操作系统
    + 进程隔离需要系统隔离

## 网络

* 文件共享
  - 设备-》安装[增强功能](http://download.virtualbox.org/virtualbox/5.0.0/)
  - 虚拟机-》设置-〉共享文件夹-》指定目录（需要挂载）
* 网络连接
  - NAT（Network Address Translation）
    + Vhost访问网络的所有数据都是由主机提供的，vhost并不真实存在于网络中，主机与网络中的任何机器都不能查看和访问到Vhost的存在。VirtualBox虚拟出一个路由器，为虚拟机中的网卡分配参数
    + 宿主机相当于虚拟机的路由器
    + 虚拟机可以通过网络访问到主机，主机无法通过网络访问到虚拟机
    + 虚拟机与虚拟机各自完全独立，相互间无法通过网络访问彼此
    + 可以从虚拟机内部访问外部，但是不能从外部访问虚拟机
    + 一台虚拟机的多个网卡可以被设定使用 NAT， 第一个网卡连接了到专用网 10.0.2.0，第二个网卡连接到专用网络 10.0.3.0，等等。默认得到的客户端ip（IP Address）是10.0.2.15，网关（Gateway）是10.0.2.2，域名服务器（DNS）是10.0.2.3
    + 笔记本已插网线时： 虚拟机可以访问主机，虚拟机可以访问互联网，在做了端口映射后（最后有说明），主机可以访问虚拟机上的服务（如数据库）
    + 笔记本没插网线时： 主机的“本地连接”有红叉的，虚拟机可以访问主机，虚拟机不可以访问互联网，在做了端口映射后，主机可以访问虚拟机上的服务（如数据库）
  - Bridged Adapter 桥接：通过主机网卡，架设了一条桥，直接连入到网络中了。虚拟机被分配到一个网络中独立的IP，所有网络功能完全和在网络中的真实机器一样
    + 虚拟机在真实网络段中有独立IP，主机与虚拟机处于同一网络段中，彼此可以通过各自IP相互访问
    + 虚拟机于虚拟机 可以相互访问
    + 桥接，相当于把宿主机和虚拟机同时接到交换机上，然后交换机接到外网
    + IP：一般是DHCP分配的，与主机的“本地连接”的IP 是同一网段的。虚拟机就能与主机互相通信。
    + 笔记本已插网线时：（若网络中有DHCP服务器）主机与虚拟机会通过DHCP分别得到一个IP，这两个IP在同一网段。 主机与虚拟机可以ping通，虚拟机可以上互联网。
    + 笔记本没插网线时：主机与虚拟机不能通信。主机的“本地连接”有红叉，就不能手工指定IP。虚拟机也不能通过DHCP得到IP地址，手工指定IP后，也无法与主机通信，因为主机无IP
    + 这时主机的VirtualBox Host-Only Network 网卡是有ip的，192.168.56.1。虚拟机就算手工指定了IP 192.168.56.*，也ping不能主机。
  - Internal 内部网络:虚拟机与外网完全断开，只实现虚拟机于虚拟机之间的内部网络模式
    + 虚拟机与主机不能相互访问，彼此不属于同一个网络，无法相互访问
    + 虚拟机与虚拟机可以相互访问，前提是在设置网络时，两台虚拟机设置同一网络名称。如上配置图中，名称为intnet。
    + IP: VirtualBox的DHCP服务器会为它分配IP ，一般得到的是192.168.56.101，因为是从101起分的，也可手工指定192.168.56.*。
    + 笔记本已插网线时：虚拟机可以与主机的VirtualBox Host-Only Network 网卡通信
  - Host-only Adapter
    + 较复杂的模式，通过虚拟机及网卡的设置都可以被实现.Vbox在主机中模拟出一张专供虚拟机使用的网卡，所有虚拟机都是连接到该网卡上的，可以通过设置这张网卡来实现上网及其他很多功能，比如（网卡共享、网卡桥接等）
    + 相当于虚拟机和宿主机通过交叉线相连
    + 虚拟机与主机关系 默认不能相互访问，双方不属于同一IP段，host-only网卡默认IP段为192.168.56.X 子网掩码为255.255.255.0，后面的虚拟机被分配到的也都是这个网段。通过网卡共享、网卡桥接等，可以实现虚拟机于主机相互访问。
    + 虚拟机与网络主机关系默认不能相互访问
    + 虚拟机与虚拟机关系默认可以相互访问，都是同处于一个网段
    + 虚拟机访问主机 用的是主机的VirtualBox Host-Only Network网卡的IP：192.168.56.1 ，不管主机“本地连接”有无红叉，永远通。
    + 主机访问虚拟机，用是的虚拟机的网卡3的IP： 192.168.56.101 ，不管主机“本地连接”有无红叉，永远通
    + 虚拟机访问互联网，用的是自己的网卡2， 这时主机要能通过“本地连接”有线上网，（无线网卡不行）

| 连接        | 宿主机和虚拟机   | 虚拟机对外网访问  | 外网对虚拟机访问 |
|:----------|:----------|:----------|:---------|
| Host-only | 可以互访      | 不能直接访问    | 不能直接访问   |
| NAT       | 虚拟机可访问宿主机 | 可以(通过宿主机) | 不能直接访问   |
| 桥接        | 可以互访      | 直接访问      | 直接访问     |

## 初始化

```sh
## 重新设置SSH端口
cp sshd_config sshd_config.origin
# /etc/ssh/sshd_config
Port 22222

systemctl restart sshd
ssh root@虚拟机IP -p 22222

## 创建自己的用户
cp sudoers sudoers.origin # 备份原文件
visudo # 编辑sudoers文件专用命令
#%wheel ALL=(ALL)   ALL
%wheel  ALL=(ALL)   NOPASSWD: ALL

useradd -d /home/myuser -m myuser -g wheel
su myuser
mkdir ~/.ssh && cd ~
chmod 700 .ssh # SSH对权限很敏感，设置不正确可能导致无法登录
cd .ssh
touch authorized_keys
chmod 600 authorized_keys # 用户的公钥文件的内容拷贝到authorized_keys

## 设置SSH免密登录
# /etc/ssh/sshd_config
PubkeyAuthentication yes
systemctl restart sshd
ssh myuser@虚拟机IP

# /etc/ssh/sshd_config
PasswordAuthentication no # 禁用SSH密码登录
PermitRootLogin no # 禁止root用户登录

systemctl restart sshd
```

## Signing VirtualBox Kernel Modules

* install virtualbox
* [Create an RSA key pair to sign kernel modules](./vm/create_rsa_pair.sh)
* Import the MOK ("Machine Owner Key") so it can be trusted by the system `sudo mokutil --import /root/module-signing/MOK.der` will prompt for a password
* Reboot your machine,enter the MOK manager EFI utility
  - Select Enroll MOK
  - Select Continue
  - Select Yes to enroll the keys
  - 输入密码
  - 选择 OK to reboot.
  - Verify `dmesg | grep '[U]EFI.*cert'`
* `sudo modprobe vboxdrv`

```sh
sudo apt-get purge "^virtualbox-.*"
sudo apt-get update
sudo apt-get autoremove | sudo apt-get autoclean | sudo apt-get clean

echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" | sudo tee /etc/apt/sources.list.d/oracle-vbox.list

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install virtualbox-5.1
```

## [VMware Fusion](https://fuckcloudnative.io/posts/vmware-fusion-11-5-now-supports-containers/)

* VMware Workstation 是专为 Linux 和 Windows 系统设计的，为了照顾 Mac 平台的用户，VMware 原班人马又打造的
* 可以直接使用 Docker 镜像启动容器，还可以构建镜像、推送镜像到镜像仓库，不需要安装 Docker Desktop。创建了一个新的 CLI 工具：vctl，它包含在 VMware Fusion 中，安装好了之后就有这个命令了
* 相关的二进制文件/组件捆绑在 Fusion 应用程序中，可在 Applications/VMware Fusion.app/Contents/Library/vkd/ 文件夹中找到
  - bin/containerd： 这是一个在后台运行的容器运行时守护进程。必须先启动 containerd 守护进程，然后才能运行任何与容器相关的操作。要启动该守护进程，请使用 vctl system start 命令，要停止该守护进程，请使用 vctl system stop 命令。
  - bin/containerd-shim-crx-v2 启动新容器时，将启动一个新的 containerd-shim-crx-v2 进程，该进程将充当 CRX 虚拟机中的容器与 containerd 守护进程之间的适配器。
  - bin/vctl 这是一个在前台运行的命令行实用程序，它可以将用户输入转发到 containerd 守护进程，和 containerd 进程进行交互，类似于 crictl 的功能。
* 启动 Containerd：

## QEMU/KVM 虚拟化

* QEMU/KVM 是目前最流行的虚拟化技术，基于 Linux 内核提供的 kvm 模块，结构精简，性能损失小，而且开源免费（对比收费的 vmware），因此成了大部分企业的首选虚拟化方案。
* 目前各大云厂商的虚拟化方案，新的服务器实例基本都是用的 KVM 技术。即使是起步最早，一直重度使用 Xen 的 AWS，从 EC2 C5 开始就改用了基于 KVM 定制的 Nitro 虚拟化技术。
* KVM 作为一个企业级的底层虚拟化技术，却没有对桌面使用做深入的优化，因此如果想把它当成桌面虚拟化软件来使用，替代掉 VirtualBox/VMware，有一定难度。
* 安装环境需要很多组件
  - qemu: 模拟各类输入输出设备（网卡、磁盘、USB端口等）,qemu 底层使用 kvm 模拟 CPU 和 RAM，比软件模拟的方式快很多。
  - libvirt: 提供简单且统一的工具和 API，用于管理虚拟机，屏蔽了底层的复杂结构。（支持 qemu-kvm/virtualbox/vmware）
  - ovmf: 为虚拟机启用 UEFI 支持
  - virt-manager: 用于管理虚拟机的 GUI 界面（可以管理远程 kvm 主机）。
  - virt-viewer: 通过 GUI 界面直接与虚拟机交互（可以管理远程 kvm 主机）。
  - dnsmasq vde2 bridge-utils openbsd-netcat:网络相关组件，提供了以太网虚拟化、网络桥接、NAT网络等虚拟网络功能。
    + dnsmasq 提供了 NAT 虚拟网络的 DHCP 及 DNS 解析功能。
    + vde2: 以太网虚拟化
    + bridge-utils: 顾名思义，提供网络桥接相关的工具。
    + openbsd-netcat: TCP/IP 的瑞士军刀，详见 socat & netcat，这里不清楚是哪个网络组件会用到它。
* libguestfs 是一个虚拟机磁盘映像处理工具，可用于直接修改/查看/虚拟机映像、转换映像格式等。提供的命令列表如下：
  - virt-df centos.img: 查看硬盘使用情况
  - virt-ls centos.img /: 列出目录文件
  - virt-copy-out -d domain /etc/passwd /tmp：在虚拟映像中执行文件复制
  - virt-list-filesystems /file/xx.img：查看文件系统信息
  - virt-list-partitions /file/xx.img：查看分区信息
  - guestmount -a /file/xx.qcow2(raw/qcow2都支持) -m /dev/VolGroup/lv_root --rw /mnt：直接将分区挂载到宿主机
  - guestfish: 交互式 shell，可运行上述所有命令。
  - virt-v2v: 将其他格式的虚拟机(比如 ova) 转换成 kvm 虚拟机。
  - virt-p2v: 将一台物理机转换成虚拟机。
* 让非 root 用户能正常使用 kvm
* 启用嵌套虚拟化: 在虚拟机中运行虚拟机（比如在虚拟机里测试 katacontainers 等安全容器技术），那就需要启用内核模块 kvm_intel 实现嵌套虚拟化
* 在系统中找到 virt-manager 的图标，进去就可以使用了。 virt-manager 的使用方法和 virtualbox/vmware workstation 大同小异
* 虚拟机磁盘映像管理
  - qemu-img: qemu 的磁盘映像管理工具，用于创建磁盘、扩缩容磁盘、生成磁盘快照、查看磁盘信息、转换磁盘格式等等
    + img 镜像文件，就是所谓的 raw 格式镜像，也被称为裸镜像，IO 速度比 qcow2 快，但是体积大，而且不支持快照等高级特性。 如果不追求 IO 性能的话，建议将它转换成 qcow2 再使用

```sh
# archlinux/manjaro
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat

# ubuntu,参考了官方文档，但未测试
sudo apt install qemu-kvm libvirt-daemon-system virt-manager virt-viewer virtinst bridge-utils

# centos,参考了官方文档，但未测试
sudo yum groupinstall "Virtualization Host"
sudo yum install virt-manager virt-viewer virt-install

# opensuse
# see: https://doc.opensuse.org/documentation/leap/virtualization/html/book-virt/cha-vt-installation.html
sudo yast2 virtualization
# enter to terminal ui, select kvm + kvm tools, and then install it.
# opensuse
sudo zypper install libguestfs

# archlinux/manjaro，目前缺少 virt-v2v/virt-p2v 组件
sudo pacman -S libguestfs

# ubuntu
sudo apt install libguestfs-tools

# centos
sudo yum install libguestfs-tools
# 启动 QEMU/KVM
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

# /etc/libvirt/libvirtd.conf
# 取消这一行的注释，使 libvirt 用户组能使用 unix 套接字。
unix_sock_group = "libvirt"
# 取消这一行的注释，使用户能读写 unix 套接字
unix_sock_rw_perms = "0770"

newgrp libvirt
sudo usermod -aG libvirt $USER
sudo systemctl restart libvirtd.service

# 临时启用 kvm_intel 嵌套虚拟化
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1
# 修改配置，永久启用嵌套虚拟化
echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
# 验证嵌套虚拟化已经启用
cat /sys/module/kvm_intel/parameters/nested

# 创建磁盘
qemu-img create -f qcow2 -o cluster_size=128K virt_disk.qcow2 20G

# 扩容磁盘
qemu-img resize ubuntu-server-cloudimg-amd64.img 30G

# 查看磁盘信息
qemu-img info ubuntu-server-cloudimg-amd64.img

# 转换磁盘格式
qemu-img convert -f raw -O qcow2 vm01.img vm01.qcow2  # raw => qcow2
qemu-img convert -f qcow2 -O raw vm01.qcow2 vm01.img  # qcow2 => raw

# 直接从 vmware ova 文件导入 kvm，这种方式转换得到的镜像应该能直接用（网卡需要重新配置）
virt-v2v -i ova centos7-test01.ova -o local -os /vmhost/centos7-01  -of qcow2
# 先从 ova 中解压出 vmdk 磁盘映像，将 vmware 的 vmdk 文件转换成 qcow2 格式，然后再导入 kvm（网卡需要重新配置）。直接转换 vmdk 文件得到的 qcow2 镜像，启会报错，比如「磁盘无法挂载」。 根据 Importing Virtual Machines and disk images - ProxmoxVE Docs 文档所言，需要在网上下载安装 MergeIDE.zip 组件， 另外启动虚拟机前，需要将硬盘类型改为 IDE，才能解决这个问题
# 转换映像格式
qemu-img convert -p -f vmdk -O qcow2 centos7-test01-disk1.vmdk centos7-test01.qcow2
# 查看转换后的映像信息
qemu-img info centos7-test01.qcow2

qemu-img convert -f raw -O qcow2 vm01.img vm01.qcow2

```

### 虚拟机管理 virsh

```sh
# 查看正在运行的虚拟机
virsh list

# 查看所有虚拟机，包括 inactive 的虚拟机
virsh list --all
# 使用虚拟机 ID 连接 以 vnc 协议登入虚拟机终端
virt-viewer 8
# 使用虚拟机名称连接，并且等待虚拟机启动
virt-viewer --wait opensuse15

virsh start opensuse15
virsh suspend opensuse15
virsh resume opensuse15
virsh reboot opensuse15
# 优雅关机
virsh shutdown opensuse15
# 强制关机
virsh destroy opensuse15

# 启用自动开机
virsh autostart opensuse15
# 禁用自动开机
virsh autostart --disable opensuse15

# 列出一个虚拟机的所有快照
virsh snapshot-list --domain opensuse15
# 给某个虚拟机生成一个新快照
virsh snapshot-create <domain>
# 使用快照将虚拟机还原
virsh snapshot-restore <domain> <snapshotname>
# 删除快照
virsh snapshot-delete <domain> <snapshotname>

# 删除虚拟机
virsh undefine opensuse15

# 使用默认参数进行离线迁移，将已关机的服务器迁移到另一个 qemu 实例
virsh migrate 37 qemu+ssh://tux@jupiter.example.com/system

# 改成 4 核
virsh setvcpus opensuse15 4
# 改成 4G
virsh setmem opensuse15 4096
# 添加新设备
virsh attach-device
virsh attach-disk
virsh attach-interface
# 删除设备
virsh detach-disk
virsh detach-device
virsh detach-interface

# 列出所有虚拟机网络
virsh net-list
```

## 快照

## 虚部网络

## 工具

* Mac
  - Parallels Desktop
  - GNOME Boxes
* [macos-virtualbox](https://github.com/myspaghetti/macos-virtualbox):Push-button installer of macOS Catalina, Mojave, and High Sierra guests in Virtualbox for Windows, Linux, and macOS
* [bottlerocket](https://github.com/bottlerocket-os/bottlerocket):An operating system designed for hosting containers
* [Bosh](https://bosh.io)
