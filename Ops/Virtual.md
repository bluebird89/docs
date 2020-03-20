# Virtual

## 网络

* 类型
    - NAT：可以从虚拟机内部访问外部，但是不能从外部访问虚拟机

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
