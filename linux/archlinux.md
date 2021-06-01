# [Arch Linux](https://www.archlinux.org/)

* 紧随上游的特点和AUR的支持

## [安装](https://www.arcolinuxd.com/installation/)(https://wiki.archlinux.org/title/Installation_guide)

* 提供了一个最小的环境，所有安装操作都在命令行中完成
* Application
* Desktop Environment:Gnome|sfce|Mate
* Graphical User Interface:Xorg| WIndow manager|****Openbox**
* Base System
	* Kernel
	* Filesystem
* [引导方式](https://www.arcolinuxd.com/4-downloading-the-ISO-and-setting-up-virtual-box/)
  - [EFI引导+GPT分区表](https://www.arcolinuxd.com/5-the-actual-installation-of-arch-linux-phase-1-uefi/)
	  - Tell virtualbox to use **EFI or UEFI** with the tick “**Enable EFI (special OSes only)**“.
  - BIOS(LEGACY)引导+MBR分区表:不需要引导分区

```sh
# 验证启动模式：判断主板是以何种方式引导系统，目录不存在，系统以BIOS模式启动
ls /sys/firmware/efi/efivars # 

# 测试网络状态
ifconfig
iwctl # 无线
dhcpcd # 有线网 获取IP地址
ping -c 4 www.baidu.com
systemctl enable dhcpcd.service # 开启 dhcp服务

# UPDATE THE SYSTEM CLOCK
timedatectl status
timedatectl set-ntp true # 开启ntp服务，它会每隔11分钟进行一次网络对时

# PARTITION THE DISKS
lsblk|fdisk -l

# BIOS/MBR
## Root partition **/dev/sda1** with 20GB, EXT4 format, primary, boot
## Swap partition **/dev/sda2** with 2XRAM recommended size, primary, swap on **Rule of thumb is twice your RAM for the size of your swap**
## create user home partition
# UEFI 模式：需要一个 EFI 系统分区（512M）FAT32文件格式

## EFI/GPT方式引导，但是没有这个较小的并且类型为EFI的引导分区（这种情况一般只会出现在新的硬盘），那么需要先创建一个引导分区
## EFI/GPT方式引导，并且同时安装了其他系统，应该在分区列表中发现一个较小的并且类型为EFI的分区, 请记下路径（/dev/sdxY)备用，跳过下面创建一个引导分区的步骤

cfdisk
# choosen to install **BIOS,** so select **DOS**
## Delete all the partitions
wipefs -a /dev/sda ||| sgdisk -Z /dev/sda
## root:New->**primary**->**type is set to **Linux**->**Bootable**（星号打上）
## swap:new->**Primary**->**Type**->**Linux swap**.
## Write->quit

mkfs.fat -F32 /dev/sda1 # 已安装有Windows的情况下安装Linux成双系统，且以EFI引导系统，则EFI分区不需要再次格式化
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt

mkswap /dev/sda3
swapon /dev/sda3

mount /dev/sda4 /mnt/home

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

pacstrap /mnt base base-devel linux linux-firmware nano

# 生成fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 进入新系统
arch-chroot /mnt

# 语言 
nano /etc/locale.gen  # 将en_US.UTF-8，zh_CN.UTF-8和zh_TW.UTF-8这三行前面的#号删除
locale-gen
locale -a
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo KEYMAP=be-latin1 >> /etc/vconsole.conf

# 时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --utc # 设置时间标准为UTC，并调整时间漂移

pacman -S vim dialog wpa_supplicant ntfs-3g networkmanager

# hostname
echo Archlinux >/etc/hostname
nano /etc/hosts
127.0.0.1   Archlinux.localdomain archlinux
127.0.0.1   localhost 
::1         localhost

# network
pacman -S networkmanager
systemctl enable NetworkManager

# 重设root密码
passwd

## bootloader
pacman -S grub

## 部署grub
grub-install --target=i386-pc /dev/sda

# 使用UEFI方式引导系统，需要安装efibootmgr
# 双系统需要安装os-prober
pacman -S os-prober ntfs-3g # 可以配合Grub检测已经存在的系统，自动设置启动选项
# EFI/GPT引导方式
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
# 默认的配置文件
grub-mkconfig -o /boot/grub/grub.cfg

cd /boot
ls # 是否有initramfs-linux-fallback.img initramfs-linux.img intel-ucode.img vmlinuz-linux这几个文件，如果都没有，说明linux内核没有被正确部署，很有可能是/boot目录没有被正确挂载导致的，确认/boot目录无误后，可以重新部署linux内核
pacman -S linux

exit
umount -R /mnt
reboot

## MULTILIB REPOSITORY
vi /etc/pacman.conf
[multilib]
include = /etc/pacman.d/mirrorlist
pacman -Syu
pacman -S bash-completion

# 创建用户
useradd -m -g users -G audio,video,network,wheel,storage,rfkill -s /bin/bash henry
passwd henry
EDITOR=nano visudo
%wheel ALL=(ALL) ALL
# login in with new user
sudo pacman -Syu

# 桌面环境
## xorg
sudo pacman -S xorg-server xorg-apps xorg-xinit xterm

# xfce4桌面
pacman -S xfce4
pacman -S xfce4-goodies
pacman -S wqy-zenhei wqy-microhei # 中文区域的情况下，务必安装一两种中文字体，否则所有程序都会显示成方块

# 安装plasma桌面
pacman -S plasma
pacman -S kde-applications # 要使用完整的kde应用程序的话，还需要安装kde-applications包

## GRAPHICS DRIVER
sudo pacman _ss |grep ATI|AMD|intel
sudo pacman -S xf86
lspci | grep -e VGA -e 3D

# DISPLAY MANAGER
## sddm
pacman -S sddm
systemctl enable sddm.service

## LIGHTDM
sudo pacman -S lightdm
sudo pacman -S lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm.service

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

# 增强包
pacman -S virtualbox-guest-utils
```

```sh
vagrant init archlinux/archlinux
vagrant up

docker run -it archlinux
```

## Repositories

* basic repositories
	* The **core** repository contains all the packages that are needed to setup the base system like booting Arch Linux and building packages.
	* The **extra** repository contains extra packages that do not fit in the core involving desktop environment.
	* The **community** repository has packages that are adopted by trusted Linux community users, and most of them will transfer to the core or extra repository.
	* The **Multilib** repository contains 32-bit software and libraries for 32-bit application installation on 64-bit system.
	* The **testing** repository contains packages that are destined for core or extra repositories.
	* The **community-testing** repository is for the Linux community.
	* The **multilib testing** repository is similar to the testing repository, but for multilib candidates.
	* The **gnome-unstable** repository has the latest GNOME desktop environment.
	*  The **kde-unstable** repository contains the latest KDE software before they are been released.
* pacman

```sh
pacman -Syy
```

## 参考

* [wiki](https://wiki.archlinux.org/)
* [](https://arcolinuxb.com/)