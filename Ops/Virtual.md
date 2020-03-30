# Virtual

VM 的 Hypervisor 需要实现对硬件的虚拟化，并且还要搭载自己的操作系统

## 网络

* 文件共享
    - 设备-》安装[增强功能](http://download.virtualbox.org/virtualbox/5.0.0/)
    - 虚拟机-》设置-〉共享文件夹-》指定目录（需要挂载）
* 网络连接
    - NAT（Network Address Translation）：Vhost访问网络的所有数据都是由主机提供的，vhost并不真实存在于网络中，主机与网络中的任何机器都不能查看和访问到Vhost的存在。VirtualBox虚拟出一个路由器，为虚拟机中的网卡分配参数
        + 宿主机相当于虚拟机的路由器
        + 虚拟机可以通过网络访问到主机，主机无法通过网络访问到虚拟机
        + 虚拟机与虚拟机各自完全独立，相互间无法通过网络访问彼此
        + 可以从虚拟机内部访问外部，但是不能从外部访问虚拟机
        + 一台虚拟机的多个网卡可以被设定使用 NAT， 第一个网卡连接了到专用网 10.0.2.0，第二个网卡连接到专用网络 10.0.3.0，等等。默认得到的客户端ip（IP Address）是10.0.2.15，网关（Gateway）是10.0.2.2，域名服务器（DNS）是10.0.2.3
        + 笔记本已插网线时： 虚拟机可以访问主机，虚拟机可以访问互联网，在做了端口映射后（最后有说明），主机可以访问虚拟机上的服务（如数据库）
        + 笔记本没插网线时： 主机的“本地连接”有红叉的，虚拟机可以访问主机，虚拟机不可以访问互联网，在做了端口映射后，主机可以访问虚拟机上的服务（如数据库）
    - Bridged Adapter 桥接：通过主机网卡，架设了一条桥，直接连入到网络中了。因此，它使得虚拟机能被分配到一个网络中独立的IP，所有网络功能完全和在网络中的真实机器一样
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
    - Host-only Adapter 较复杂的模式，通过虚拟机及网卡的设置都可以被实现.Vbox在主机中模拟出一张专供虚拟机使用的网卡，所有虚拟机都是连接到该网卡上的，可以通过设置这张网卡来实现上网及其他很多功能，比如（网卡共享、网卡桥接等）
        + 相当于虚拟机和宿主机通过交叉线相连
        + 虚拟机与主机关系 默认不能相互访问，双方不属于同一IP段，host-only网卡默认IP段为192.168.56.X 子网掩码为255.255.255.0，后面的虚拟机被分配到的也都是这个网段。通过网卡共享、网卡桥接等，可以实现虚拟机于主机相互访问。
        + 虚拟机与网络主机关系默认不能相互访问
        + 虚拟机与虚拟机关系默认可以相互访问，都是同处于一个网段
        + 虚拟机访问主机 用的是主机的VirtualBox Host-Only Network网卡的IP：192.168.56.1 ，不管主机“本地连接”有无红叉，永远通。
        + 主机访问虚拟机，用是的虚拟机的网卡3的IP： 192.168.56.101 ，不管主机“本地连接”有无红叉，永远通
        + 虚拟机访问互联网，用的是自己的网卡2， 这时主机要能通过“本地连接”有线上网，（无线网卡不行）

 连接 宿主机和虚拟机 虚拟机对外网访问    外网对虚拟机访问
Host-only    可以互访   不能直接访问  不能直接访问
NAT 虚拟机可访问宿主机   可以(通过宿主机)   不能直接访问
桥接  可以互访    直接访问    直接访问

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

## 工具

* Mac
    - Parallels Desktop
    - Vmvare Fusion
