# [deepin](https://www.deepin.org/)

```
# error: /boot/vmlinuz-4.18.12-041812-generic has invalid signature
# error: you need to load the kernel first
disable Secure Boot in the BIOS/UEFI

AMD-Vi: Unable to write to IOMMU perf counter.

# grub模式:暂时设置
ls # 显示所有的分区,找到原来系统分区 （hd0,gpt3）
set root=(hd0,gpt3)
set prefix=(hd0,gpt3)/boot/grub
insmod normal
normal #进入 recovery

ls /dev/sd
## 第二种
linux (hd0,gpt3)/boot/vmlinuz（tab补全） root=/dev/sda0 foo bar # 加载系统内核
initrd (hd0,gpt1)/boot/init（tab补全） # 引导进入系统
boot
sudo update-grub
sudo install-grub /dev/sda # efi挂载点

fdisk -l # 查看 type 为 EFI system
sudo grub-install /dev/nvmeOn1p1 # 重新安装efi挂载点

# grub-install: warning: this GPT partition label contains no BIOS Boot Partition; embedding won’t be possible
parted /dev/nvmeOn1 set 1 bios_grub on
parted /dev/nvmeOn1 print

sudo grub-install /dev/nvmeOn1


# 禁用第三方显卡驱动
nano /etc/modprobe.d/blacklist-nouveau.conf

blacklist nouveau
options nouveau modeset=0

sudo update-initramfs -u
reboot
```

## 参考

* [deepinwiki/wiki](https://github.com/deepinwiki/wiki)
