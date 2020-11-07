# [Arch Linux](https://www.archlinux.org/)

## 安装

* 提供了一个最小的环境，所有的安装操作都需要在命令行中完成
* 引导方式
    - EFI引导+GPT分区表（较新）
    - BIOS(LEGACY)引导+MBR分区表

```sh
# 验证启动模式来判断主板是以何种方式引导系统
ls /sys/firmware/efi/efivars # 目录不存在，系统就可能以BIOS模式启动

# 软件包都需要联网下载安装 测试网络状态
dhcpcd # 有线网 获取IP地址
wifi-menu # 无线
ping -c 4 www.baidu.com
systemctl enable dhcpcd.service # 开启 dhcp服务

# 测试系统时间
timedatectl status
timedatectl set-ntp true # 开启ntp服务，它会每隔11分钟进行一次网络对时

# 查看存储设备状态
lsblk
# 分区

## 一个根分区（挂载在根目录）  /
## 如果 UEFI 模式被启用，你还需要一个 EFI 系统分区（512M） EFI分区需要FAT32文件格式
## Swap 可以在一个独立的分区上设置，也可以直接建立 交换文件

# BIOS/MBR方式引导，跳过下面创建一个引导分区的步骤
# EFI/GPT方式引导，并且同时安装了其他系统，那么应该可以在分区列表中发现一个较小的并且类型为EFI的分区, 请记下它的路径（/dev/sdxY)备用，跳过下面创建一个引导分区的步骤。
# EFI/GPT方式引导，但是没有这个较小的并且类型为EFI的引导分区（这种情况一般只会出现在新的硬盘），那么需要先创建一个引导分区。
cfdisk # new->type->write 改成bootable（也就是把那个星号打上）
mkfs.fat -F32 /dev/sda1 # 已安装有Windows的情况下安装Linux成双系统，且以EFI引导系统，则EFI分区不需要再次格式化
mkfs.ext4 /dev/sda2
mkswap /dev/sda3 -L Swap
swapon /dev/sda3

mount /dev/sda2 /mnt
mkdir -p /mnt/boot/EFI
mount /dev/sda1 /mnt/boot/EFI

# 修改镜像 /etc/pacman.d/mirrorlist
echo '## China\nServer = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > mrlist
grep -A 1 'China' mirrorlist|grep -v '\-\-' >mrlist # 找到所有中国的镜像源
cat mirrorlist>>mrlist
mv  mrlist mirrorlist
# 源镜像
# Server = http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.zju.edu.cn/archlinux/$repo/os/$arch
Server = http://mirrors.163.com/archlinux/$repo/os/$arch
Server = http://mirrors.cqu.edu.cn/archlinux/$repo/os/$arch

pacstrap -i /mnt base base-devel vim linux linux-firmware dhcpcd

# 生成fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 进入新系统
arch-chroot /mnt /bin/bash

# 配置区域 /etc/locale.gen  将en_US.UTF-8，zh_CN.UTF-8和zh_TW.UTF-8这三行前面的#号删除
locale-gen
locale -a
echo LANG=zh_CN.UTF-8 >> /etc/locale.conf

# 配置时区 /usr/share/zoneinfo/
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --utc # 设置时间标准为UTC，并调整时间漂移

pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager

# 设置主机名 并添加到/etc/hosts
echo archlinux >/etc/hostname
127.0.0.1   localhost.localdomain   localhost archlinux
::1     localhost.localdomain   localhost archlinux

# 重设root密码

# 创建用户
useradd -m -G wheel -s /bin/bash free
passwd free

#  修改权限 /etc/sudoers
visudo # 删除wheel组前面的注释（#）

# 安装引导工具grub 使用的UEFI方式引导系统，则还需要安装efibootmgr，如果是双系统的话，还需要安装os-prober
pacman -S os-prober ntfs-3g # 可以配合Grub检测已经存在的系统，自动设置启动选项

# BIOS/MBR引导
pacman -S grub
## 部署grub
grub-install --target=i386-pc /dev/sdx （将sdx换成你安装的硬盘）

# EFI/GPT引导方式
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

grub-mkconfig -o /boot/grub/grub.cfg # 默认的配置文件

cd /boot
ls # 是否有initramfs-linux-fallback.img initramfs-linux.img intel-ucode.img vmlinuz-linux这几个文件，如果都没有，说明linux内核没有被正确部署，很有可能是/boot目录没有被正确挂载导致的，确认/boot目录无误后，可以重新部署linux内核
pacman -S linux

umount -R /mnt
reboot

# 安装桌面环境
pacman -S xorg
pacman -S xterm
pacman -S xorg-xinit

# 安装显示管理器sddm
pacman -S sddm
systemctl enable sddm.service

# 安装xfce4桌面
pacman -S xfce4
pacman -S xfce4-goodies
pacman -S wqy-zenhei wqy-microhei # 中文区域的情况下，务必安装一两种中文字体，否则所有程序都会显示成方块

# 安装plasma桌面
pacman -S plasma
pacman -S kde-applications # 要使用完整的kde应用程序的话，还需要安装kde-applications包
# 安装中文语言文件包
pacman -S  kde-l10n-zh_cn
# 配置显示管理器sddm
sddm --example-config >/etc/sddm.conf

# 自动登录
[Autologin]
User=john
Session=plasma.desktop

# 使用tty7开启图形会话 /etc/sddm.conf
[XDisplay]
MinimumVT=7
# 开机时自动打开数字锁定键
[General]
Numlock=on

## 用户库AUR即Arch User Repository，为我们提供了官方包之外的各种软件包
## yay实际上也是一个软件包，我们可以把它看成是对pacman的包装，它兼容pacman的所有操作，最大的不同是我们可以用它方便地安装与管理AUR中的包，下面的许多软件包都是在AUR库中的，也都是使用AUR来安装的。
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## 参考

* [wiki](https://wiki.archlinux.org/)
* [安装教程](https://www.viseator.com/categories/Linux/)
* [installation_guide](https://wiki.archlinux.org/index.php/installation_guide)
