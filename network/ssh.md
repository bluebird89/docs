## [SSH](https://www.ssh.com/ssh/command/)

* 1995年，芬兰赫尔辛基工业大学的研究员 Tatu Ylönen 设计了 SSH 协议的第一个版本（现称为 SSH 1），同时写出了第一个实现（称为 SSH1）
* SSH 1 协议存在一些安全漏洞，所以1996年又提出了 SSH 2 协议（或者称为 SSH 2.0）。这个协议与1.0版不兼容，在1997年进行了标准化，1998年推出了软件实现 SSH2
* 1999年，OpenBSD 的开发人员决定写一个 SSH 2 协议的开源实现，这就是 OpenSSH 项目
  - 最初是基于 SSH 1.2.12 版本，那是当时 SSH1 最后一个开源版本
  - OpenSSH 很快就完全摆脱了原始的官方代码，在许多开发者的参与下，按照自己的路线发展。
  - OpenSSH 随 OpenBSD 2.6 版本一起提供，以后又移植到其他操作系统，成为最流行的 SSH 实现
* 基于密钥验证是最安全的几个身份验证模式 使用OpenSSH,如普通密码和Kerberos票据。基于密钥的验证密码身份验证有几个优点,例如键值更难以蛮力,比普通密码或者猜测,提供充足的密钥长度。其他身份验证方法仅在非常特殊的情况下使用。
* 安全
  - 如果有人中途拦截了登录请求，将自己伪造的公钥发送给客户端，客户端其实并不能识别这个公钥的可靠性，获取远程主机的登录密码
* 基于非对称加密：通过服务端公钥加密客户端信息-》服务端私钥解密
  - 客户端通过 SSH user@remote-host 发起登录远程主机的请求
  - 远程主机收到请求之后，将自己的公钥发给客户端
  - 客户端使用这个公钥加密登录密码之后发给远程主机
  - 远程主机使用自己的私钥解密登陆请求，获得登录密码，如果正确，则建立 SSH 通道，之后所有客户端和远程主机的数据传输都要使用加密进行

## 安装

```sh
sudo aptitude install openssh-server
sudo yum install openssh-server

sudo systemctl enable|start｜stop|restart sshd.service
service sshd restart

sudo apt install openssh-client
sudo dnf install openssh-clients
ssh -V

ssh username@hostname command
ssh -l username host -p 8821


sudo apt-get install openssh-server
sudo /etc/init.d/ssh start
# /etc/ssh/sshd_config
```

## 架构

* 服务器（server）接收客户端发出的请求的部分，OpenSSH 实现为 sshd
  - `/usr/local/bin/ssh`
* 客户端（client）向服务器发出请求的部分, OpenSSH 实现为 ssh

## 配置

* 配置文件每一行，就是一个配置命令。配置命令与对应值之间，可以使用空格，也可以使用等号
* 服务器
  - 有一对或多对密钥。使用密钥向客户端证明自己身份。所有密钥都是公钥和私钥成对出现，公钥的文件名一般是私钥文件名加上后缀.pub
  - 密钥不是默认文件，可以通过配置文件sshd_config的HostKey配置项指定
  - 选项
    + 配置项与值之间有一个等号，等号前后的空格可选
    + 注释只能放在一行的开头，不能放在一行的结尾
    + 修改PermitRootLogin的值来禁用 root 登陆
  - /etc/ssh/sshd_config：配置文件
  - /etc/ssh/ssh_host_ecdsa_key：ECDSA 私钥。
  - /etc/ssh/ssh_host_ecdsa_key.pub：ECDSA 公钥。
  - /etc/ssh/ssh_host_key：用于 SSH 1 协议版本的 RSA 私钥。
  - /etc/ssh/ssh_host_key.pub：用于 SSH 1 协议版本的 RSA 公钥。
  - /etc/ssh/ssh_host_rsa_key：用于 SSH 2 协议版本的 RSA 私钥。
  - /etc/ssh/ssh_host_rsa_key.pub：用于 SSH 2 协议版本的 RSA 公钥。
  - /etc/pam.d/sshd：PAM 配置文件。
  - `~/.ssh/authorized_keys` 存放远程免密登录的公钥,主要通过这个文件记录多台机器的公钥
  - 参数
    + -d 用于显示 debug 信息
    + -D 指定 sshd 不作为后台守护进程运行
    + -e 将 sshd 写入系统日志 syslog 的内容导向标准错
    + -f 自动读取默认的配置文件。指定希望使用其他的配置文件
    + -h 用于指定密钥
    + -o 指定配置文件的一个配置项和对应的值 `sshd -o "Port 2034"`
    + -p 指定 sshd 的服务端口
      * -p 可以指定多个端口
    + -t（test）检查有没有语法错误
  - 配置项
    + AcceptEnv 指定允许接受客户端通过SendEnv命令发来的哪些环境变量，即允许客户端设置服务器的环境变量清单，变量名之间使用空格分隔
    + AllowGroups 指定允许登录的用户组（AllowGroups groupName，多个组之间用空格分隔。如果不使用该项，则允许所有用户组登录
    + AllowUsers 指定允许登录的用户，用户名之间使用空格分隔（AllowUsers user1 user2），也可以使用多行AllowUsers命令指定，用户名支持使用通配符。如果不使用该项，则允许所有用户登录。该项也可以使用用户名@域名的格式
    + AllowTcpForwarding 指定是否允许端口转发，默认值为yes（AllowTcpForwarding yes），local表示只允许本地端口转发，remote表示只允许远程端口转发
    + AuthorizedKeysFile 指定储存用户公钥的目录，默认是用户主目录的ssh/authorized_keys目录
    + Banner 指定用户登录后，sshd 向其展示的信息文件（Banner /usr/local/etc/warning.txt），默认不展示任何内容
    + ChallengeResponseAuthentication 指定是否使用“键盘交互”身份验证方案，默认值为yes，从理论上讲，“键盘交互”身份验证方案可以向用户询问多重问题，但是实践中，通常仅询问用户密码。如果要完全禁用基于密码的身份验证，请将PasswordAuthentication和ChallengeResponseAuthentication都设置为no
    + Ciphers 指定 sshd 可以接受的加密算法（Ciphers 3des-cbc），多个算法之间使用逗号分隔
    + ClientAliveCountMax 指定建立连接后，客户端失去响应时，服务器尝试连接的次数（ClientAliveCountMax 8）
    + ClientAliveInterval指定允许客户端发呆的时间，单位为秒（ClientAliveInterval 180）。如果这段时间里面，客户端没有发送任何信号，SSH 连接将关闭。
    + Compression指定客户端与服务器之间的数据传输是否压缩。默认值为yes
    + DenyGroups指定不允许登录的用户组
    + DenyUsers指定不允许登录的用户（DenyUsers user1），用户名之间使用空格分隔，也可以使用多行DenyUsers命令指定
    + HostKey指定 sshd 服务器的密钥
    + ListenAddress指定 sshd 监听的本机 IP 地址，即 sshd 启用的 IP 地址，默认是 0.0.0.0（ListenAddress 0.0.0.0）表示在本机所有网络接口启用。可以改成只在某个网络接口启用（比如ListenAddress 192.168.10.23），也可以指定某个域名启用（比如ListenAddress server.example.com），要监听多个指定的 IP 地址，可以使用多行ListenAddress命令
    + LoginGraceTime指定允许客户端登录时发呆的最长时间，比如用户迟迟不输入密码，连接就会自动断开，单位为秒（LoginGraceTime 60）。如果设为0，就表示没有限制。
    + LogLevel指定日志的详细程度，可能的值依次为QUIET、FATAL、ERROR、INFO、VERBOSE、DEBUG、DEBUG1、DEBUG2、DEBUG3，默认为INFO（LogLevel INFO）
    + MACs指定sshd 可以接受的数据校验算法（MACs hmac-sha1），多个算法之间使用逗号分隔
    + MaxAuthTries指定允许 SSH 登录的最大尝试次数（MaxAuthTries 3），如果密码输入错误达到指定次数，SSH 连接将关闭
    + MaxStartups指定允许同时并发的 SSH 连接数量（MaxStartups）。如果设为0，就表示没有限制,这个属性也可以设为A:B:C的形式，比如MaxStartups 10:50:20，表示如果达到10个并发连接，后面的连接将有50%的概率被拒绝；如果达到20个并发连接，则后面的连接将100%被拒绝。
    + PasswordAuthentication指定是否允许密码登录，默认值为yes（PasswordAuthentication yes），建议改成no（禁止密码登录，只允许密钥登录）。
    + PermitEmptyPasswords指定是否允许空密码登录，即用户的密码是否可以为空，默认为yes（PermitEmptyPasswords yes），建议改成no（禁止无密码登录）
    + PermitRootLogin指定是否允许根用户登录，默认为yes（PermitRootLogin yes），建议改成no（禁止根用户登录)
    + PermitUserEnvironment指定是否允许 sshd 加载客户端的~/.ssh/environment文件和~/.ssh/authorized_keys文件里面的environment= options环境变量设置。默认值为no（PermitUserEnvironment no）
    + Port指定 sshd 监听的端口，即客户端连接的端口，默认是22（Port 22）。出于安全考虑，可以改掉这个端口（比如Port 8822）,可以使用多个Port命令，同时监听多个端口
    + PrintMotd指定用户登录后，是否向其展示系统的 motd（Message of the the day）的信息文件/etc/motd。该文件用于通知所有用户一些重要事项，比如系统维护时间、安全问题等等。默认值为yes（PrintMotd yes），由于 Shell 一般会展示这个信息文件，所以这里可以改为no
    + PrintLastLog指定是否打印上一次用户登录时间，默认值为yes
    + Protocol指定 sshd 使用的协议。Protocol 1表示使用 SSH 1 协议，建议改成Protocol 2（使用 SSH 2 协议）。Protocol 2,1表示同时支持两个版本的协议
    + PubKeyAuthentication指定是否允许公钥登录，默认值为yes
    + RSAAuthentication指定允许 RSA 认证，默认值为yes（RSAAuthentication yes）
    + StrictModes指定 sshd 是否检查用户的一些重要文件和目录的权限。默认为yes（StrictModes yes），即对于用户的 SSH 配置文件、密钥文件和所在目录，SSH 要求拥有者必须是根用户或用户本人，用户组和其他人的写权限必须关闭
    + SyslogFacility指定 Syslog 如何处理 sshd 的日志，默认是 Auth（SyslogFacility AUTH）
    + TCPKeepAlive指定打开 sshd 跟客户端 TCP 连接的 keepalive 参数（TCPKeepAlive yes）
    + UseDNS指定用户 SSH 登录一个域名时，服务器是否使用 DNS，确认该域名对应的 IP 地址包含本机（UseDNS yes）。打开该选项意义不大，而且如果 DNS 更新不及时，还有可能误判，建议关闭
    + UseLogin指定用户认证内部是否使用/usr/bin/login替代 SSH 工具，默认为no
    + UserPrivilegeSeparation指定用户认证通过以后，使用另一个子线程处理用户权限相关的操作，这样有利于提高安全性。默认值为yes
    + X11Forwarding指定是否打开 X window 的转发，默认值为 no
* 客户端
  - 全局配置 `/etc/ssh/ssh_config`
  - 个人配置 `~/.ssh/config`
    + 可以按照不同服务器，列出各自连接参数，从而不必每一次登录都输入重复参数
    + Host 值可以使用通配符
  - 配置项
    + AddressFamily inet：表示只使用 IPv4 协议。如果设为inet6，表示只使用 IPv6 协议。
    + BindAddress 192.168.10.235：指定本机的 IP 地址（如果本机有多个 IP 地址）。
    + CheckHostIP yes：检查 SSH 服务器的 IP 地址是否跟公钥数据库吻合。
    + Ciphers blowfish,3des：指定加密算法。
    + Compression yes：是否压缩传输信号。
    + ConnectionAttempts 10：客户端进行连接时，最大尝试次数。
    + ConnectTimeout 60：客户端进行连接时，服务器在指定秒数内没有回复，则中断连接尝试。
    + DynamicForward 1080：指定动态转发端口。
    + GlobalKnownHostsFile /users/smith/.ssh/my_global_hosts_file：指定全局的公钥数据库文件的位置。
    + Host server.example.com：指定连接域名或 IP 地址，也可以是别名，支持通配符。Host命令后面的所有配置，都是针对该主机的，直到下一个Host命令为止。
    + HostKeyAlgorithms ssh-dss,ssh-rsa：指定密钥算法，优先级从高到低排列。
    + HostName myserver.example.com：在Host命令使用别名的情况下，HostName指定域名或 IP 地址。
    + IdentityFile keyfile：指定私钥文件。
    + LocalForward 2001 localhost:143：指定本地端口转发。
    + LogLevel QUIET：指定日志详细程度。如果设为QUIET，将不输出大部分的警告和提示。
    + MACs hmac-sha1,hmac-md5：指定数据校验算法。
    + NumberOfPasswordPrompts 2：密码登录时，用户输错密码的最大尝试次数。
    + PasswordAuthentication no：指定是否支持密码登录。不过，这里只是客户端禁止，真正的禁止需要在 SSH 服务器设置。
    + Port 2035：指定客户端连接的 SSH 服务器端口。
    + PreferredAuthentications publickey,hostbased,password：指定各种登录方法的优先级。
    + Protocol 2：支持的 SSH 协议版本，多个版本之间使用逗号分隔。
    + PubKeyAuthentication yes：是否支持密钥登录。这里只是客户端设置，还需要在 SSH 服务器进行相应设置。
    + RemoteForward 2001 server:143：指定远程端口转发。
    + SendEnv COLOR：SSH 客户端向服务器发送的环境变量名，多个环境变量之间使用空格分隔。环境变量的值从客户端当前环境中拷贝。
    + ServerAliveCountMax 3：如果没有收到服务器的回应，客户端连续发送多少次keepalive信号，才断开连接。该项默认值为3。
    + ServerAliveInterval 300：客户端建立连接后，如果在给定秒数内，没有收到服务器发来的消息，客户端向服务器发送keepalive消息。如果不希望客户端发送，这一项设为0。
    + StrictHostKeyChecking yes：yes表示严格检查，服务器公钥为未知或发生变化，则拒绝连接。no表示如果服务器公钥未知，则加入客户端公钥数据库，如果公钥发生变化，不改变客户端公钥数据库，输出一条警告，依然允许连接继续进行。ask（默认值）表示询问用户是否继续进行。
    + TCPKeepAlive yes：客户端是否定期向服务器发送keepalive信息。
    + User userName：指定远程登录的账户名。
    + UserKnownHostsFile /users/smith/.ssh/my_local_hosts_file：指定当前用户的known_hosts文件（服务器公钥指纹列表）的位置。
    + VerifyHostKeyDNS yes：是否通过检查 SSH 服务器的 DNS 记录，确认公钥指纹是否与known_hosts文件保存的一致
  - ~/.ssh 目录有一些用户个人的密钥文件和其他文件
    + ~/.ssh/id_ecdsa：用户的 ECDSA 私钥。
    + ~/.ssh/id_ecdsa.pub：用户的 ECDSA 公钥。
    + ~/.ssh/id_rsa：用于 SSH 协议版本2 的 RSA 私钥。
    + ~/.ssh/id_rsa.pub：用于SSH 协议版本2 的 RSA 公钥。
    + ~/.ssh/identity：用于 SSH 协议版本1 的 RSA 私钥。
    + ~/.ssh/identity.pub：用于 SSH 协议版本1 的 RSA 公钥。
    + ~/.ssh/known_hosts：包含 SSH 服务器的公钥指纹

```sh
service sshd restart
sudo systemctl reload sshd.service

GatewayPorts
```

## 连接

* 验证:验证远程服务器是否为陌生地址
  - 服务器指纹是否陌生的，让用户选择是否要继续连接
    + 服务器指纹 指的是 SSH 服务器公钥的哈希值。每台 SSH 服务器都有唯一一对密钥，用于跟客户端通信，其中公钥的哈希值就可以用来识别服务器
    + 为了保证非对称加密私钥的安全性，一般非对称加密公钥设置基本都不小于1024位，很难直接让终端用户去确认完整的非对称加密公钥，于是通过 MD5 哈希函数将之转化为128位的指纹，就很容易识别了
    + 服务器指纹可以防止有人恶意冒充远程主机。如果服务器的密钥发生变更（比如重装了 SSH 服务器），客户端再次连接时，就会发生公钥指纹不吻合的情况。这时，客户端就会中断连接，并显示一段警告信息
    + 新的公钥确认可以信任，需要继续执行连接，你可以执行下面的命令，将原来的公钥指纹从~/.ssh/known_hosts文件删除
  - ssh 会将本机连接过的所有服务器公钥的指纹，都储存在本机的~/.ssh/known_hosts文件中。每次连接服务器时，通过该文件判断是否为陌生主机（陌生公钥）
  - 输入yes，就可以将当前服务器的指纹也储存在本机~/.ssh/known_hosts文件中
* 握手
  - 客户端必须跟服务端约定加密参数集（cipher suite）发送握手信息（ClientHello),加密参数集包含了若干不同的加密参数，它们之间使用下划线连接在一起 `TLS_RSA_WITH_AES_128_CBC_SHA`
    + TLS：协议
    + RSA：密钥交换算法
    + AES：加密算法
    + 128：加密强度
    + CBC：加密模式
    + SHA：数字签名的 Hash 函数
  - 服务器在其中选择一个自己支持的参数集,向客户端发出回应

```sh
# 查看公钥指纹
ssh-keygen -l -f /etc/ssh/ssh_host_ecdsa_key.pub
```

## 参数

* -c 指定加密算法
* -C 表示压缩数据传输
* -d 设置打印的 debug 信息级别，数值越高，输出的内容越详细
* -D 指定本机的 Socks 监听端口，该端口收到的请求，都将转发到远程的 SSH 主机，又称动态端口转发
* -f 后台运行
* -F 指定配置文件
* g：Allows remote hosts to connect to local forwarded ports.
* -i 用于指定私钥，意为“identity_file”，默认值为`~/.ssh/id_dsa`
* -l 指定远程登录的账户名
* -L 设置本地端口转发
* -m 指定校验数据完整性的算法（message authentication code，简称 MAC）
* n：Redirects stdin from /dev/null
* N：Do not execute a remote command. 表示只连接远程主机，不打开远程 Shell
* -o 用来指定一个配置命令
  - 使用等号时，配置命令可以不用写在引号里面，但是等号前后不能有空格
* -p 指定 SSH 客户端连接的服务器端口
* -q 表示安静模式（quiet），不向用户输出任何警告信息
* -R 反向代理:指定远程端口转发
* T：Disable pseudo-terminal allocation. 表示不为这个连接分配 TTY
* -t 在 ssh 直接运行远端命令时，提供一个互动式 Shell
* -v 可以重复多次，表示信息的详细程度
* -V 输出 ssh 客户端的版本
* -X 表示打开 X 窗口转发
* -1 指定使用 SSH 1 协议。
* -2 指定使用 SSH 2 协议
* -4 指定使用 IPv4 协议，这是默认值
* -6 指定使用 IPv6 协议

```sh
ssh –d 1 foo.com
ssh -D 1080 server
ssh -m hmac-sha1,hmac-md5 server.example.com
ssh -o User=sally -o Port=220 server.example.com
```

## 算法

* 密钥（key）是一个非常大的数字，通过加密算法得到
* SSH 密钥登录采用的是非对称加密，每个用户通过自己的密钥登录。其中，私钥（private key）必须私密保存，不能泄漏；公钥（public key）则是公开的，可以对外发送。关系是，公钥和私钥是一一对应的，每一个私钥都有且仅有一个对应的公钥
* 使用RSA(Rivest-Shamir-Adleman)或“DSA(数字签名算法)的钥匙。这两个被认为是最先进的算法,当SSH发明,但DSA已经被视为近年来更不安全。RSA是唯一推荐选择新钥匙
* 基于密钥验证使用两个密钥,一个“公共”键,任何人都可以看到,和另一个“私人”键,只有老板是允许的。安全通信使用的基于密钥的认证,需要创建一个密钥对,安全地存储私钥在电脑人想从登录,并存储公钥在电脑上一个想登录。
* 使用基于密钥登录使用ssh通常被认为是比使用普通安全密码登录。导的这个部分将解释的过程中生成的一组公共/私有RSA密钥,并将它们用于登录到你的Ubuntu电脑通过OpenSSH(s)。如果只有服务器也是不能实现一个完整的桌面环境的，当然还需要一个客户端
* 系统会试图通过DNS反查相对应的域名，如果DNS中没有这个IP的域名解析，则会等到DNS查询超时才会进行下一步
* SKM(SSH Key Manager):一个在命令行下帮助管理和切换多个SSH key的工具
* `ls -l /etc/init.d/sshd`
* ssh-keygen
  - -b 指定密钥位数
  - -t指定密钥类型：rsa/dsa/ecdsa
* 询问一系列问题
  - 询问密钥保存的文件名
  - 是否要为私钥文件设定密码保护（passphrase）可以直接按回车键，密码就会为空
  - 生成私钥和公钥,屏幕上会给出公钥的指纹，以及当前的用户名和主机名作为注释，用来识别密钥的来源
* 密钥生成:放在主目录 `.ssh`里面,默认 `~/.ssh/id_dsa` 文件，这个是私钥文件名，对应公钥文件 `~/.ssh/id_dsa.pub` 是自动生成的

```sh
openssl aes-256-cbc -salt -in {源文件名} -out {加密文件名}
openssl aes-256-cbc -d -in {加密文件名} -out {解密文件名}

### 密钥生成
ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"
ssh-keygen -o -a 100 -t ed25519

ls -l ~/.ssh/id_*.pub

# 移除旧域名公钥
ssh-keygen -R hostname

# 修改权限，防止其他人读取
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub

# 公钥文件可以不指定路径和.pub后缀名，ssh-copy-id会自动在~/.ssh目录里面寻找
ssh-copy-id -i id_ed25519 user@host

chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys

scp ~/.ssh/id_rsa.pub hadoop@192.168.1.134:~/
scp ~/.ssh/id_rsa.pub deploy@your_server_ip_address:

cat ~/.ssh/id_rsa.pub | ssh user@host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
cat .ssh/id_ed25519.pub | ssh foobar@remote 'cat >> ~/.ssh/authorized_keys'
```

## 功能

* 服务器登陆
* 执行命令
* 传输文件
* 加密
* 签名:使用私钥加密

```sh
# 传输文件
scp id_rsa.pub git@172.26.186.117:/home/git/
scp -P 1101 username@servername:/remote_path/filename  ~/local_destination   # 源文件  目标文件

## 服务器登陆
ssh -p 2222 user@host   # 登陆服务器
ssh username@remote_host ls /var/www
ssh –d 1 foo.com

# 查看连接过程
ssh -v root@192.168.75.136
```

## 密钥登录 Passwordless Authentication Using SSH

* 密码登录:需要输入服务器密码，非常麻烦，也不安全，存在被暴力破解的风险
* 客户端通过私钥加密-》服务端通过保存用户公钥解密
* 需要服务器保存用户公钥，也需要用户保存服务器公钥指纹。对于多用户、多服务器的大型机构很不方便，如果有员工离职，需要将他的公钥从每台服务器删除
    + 手动将客户端的公钥放入远程服务器的指定位置
    + 客户端向服务器发起 SSH 登录的请求
    + 服务器收到用户 SSH 登录的请求，发送一些随机数据给用户，要求用户证明自己的身份
    + 客户端收到服务器发来的数据，使用私钥对数据进行签名，然后再发还给服务器。
    + 服务器收到客户端发来的加密签名后，使用对应的公钥解密，然后跟原始数据比较。如果一致，就允许用户登录
* 需满足至少下面两个条件
  - `.ssh`目录的权限必须是700
  - `.ssh/authorized_keys`文件权限必须是600
* 启用密钥登录之后，最好关闭服务器的密码登录 `/etc/ssh/sshd_config` 中 `PasswordAuthentication no`

```sh
ssh-keygen -t rsa # 生成.ssh文件目录

ssh-copy-id test_host@40.343.45.77
ssh-copy-id -i ~/.ssh/id_rsa.pub <romte_ip>
scp -p ~/.ssh/id_rsa.pub root@<remote_ip>:/root/.ssh/authorized_keys
# 将文件拷贝至远程服务器
scp ~/.ssh/id_rsa.pub root@<remote_ip>:pub_key

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 将内容追加到authorized_keys文件中， 不过要登录远程服务器来执行这条命令
cat ~/pub_key >>~/.ssh/authorized_keys

# 通过ansible,将需要做免密操作的机器hosts添加到/etc/ansible/hosts下：
[Avoid close]
192.168.91.132
192.168.91.133
192.168.91.134

ansible <groupname> -m authorized_key -a "user=root key='{{ lookup('file','/root/.ssh/id_rsa.pub') }}'" -k

# have SSH host keys for those IPs in your ~/.ssh/known_hosts
ssh-keygen -R <IP_ADDRESS>

ssh \<user>@\<hostname/hostip> \<command>
```

## 证书登录

* 引入了一个证书颁发机构（Certificate1 authority，简称 CA），对信任的服务器颁发服务器证书，对信任的用户颁发用户证书.登录时，用户和服务器不需要提前知道彼此的公钥，只需要交换各自的证书，验证是否可信即可。
* 优点
  - 用户和服务器不用交换公钥，更容易管理，也具有更好的可扩展性
  - 证书可以设置到期时间，而公钥没有到期时间
* 流程
  - 没有证书，需要生成证书
    + 用户和服务器都将自己的公钥，发给 CA
    + CA 使用服务器公钥，生成服务器证书，发给服务器
    + CA 使用用户的公钥，生成用户证书，发给用户
  - 用户登录服务器时，SSH 自动将用户证书发给服务器。
  - 服务器检查用户证书是否有效，以及是否由可信的 CA 颁发。
  - SSH 自动将服务器证书发给用户。
  - 用户检查服务器证书是否有效，以及是否由信任的 CA 颁发。
  - 双方建立连接，服务器允许用户登录。
* CA 至少需要两对密钥
  - 一对是签发用户证书的密钥，假设叫做user_ca
  - 另一对是签发服务器证书的密钥，假设叫做host_ca

```sh
# 生成 CA 签发用户证书的密钥
ssh-keygen -t rsa -b 4096 -f ~/.ssh/user_ca -C user_ca
sudo ssh-keygen -f /etc/ssh/ssh_host_rsa_key -b 4096 -t rsa
# 使用密钥host_ca为服务器的公钥ssh_host_rsa_key.pub签发服务器证书 会生成服务器证书ssh_host_rsa_key-cert.pub
ssh-keygen -s host_ca -I host.example.com -h -n host.example.com -V +52w ssh_host_rsa_key.pub
# 查看证书的细节
ssh-keygen -L -f ssh_host_rsa_key-cert.pub
chmod 600 ssh_host_rsa_key-cert.pub

# CA 签发用户证书
ssh-keygen -f ~/.ssh/user_key -b 4096 -t rsa
# 将用户公钥user_key.pub，上传或复制到 CA 服务器。使用 CA 的密钥user_ca为用户公钥user_key.pub签发用户证书
ssh-keygen -s user_ca -I user@example.com -n user -V +1d user_key.pub
# 查看证书的细节。
ssh-keygen -L -f user_key-cert.pub
chmod 600 user_key-cert.pub

# 服务器安装证书
scp ~/.ssh/ssh_host_rsa_key-cert.pub root@host.example.com:/etc/ssh/
# 添加到服务器配置文件/etc/ssh/sshd_config。
HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub
sudo systemctl restart sshd
sudo service sshd restart

# 将 CA 签发用户证书的公钥user_ca.pub，拷贝到服务器
scp ~/.ssh/user_ca.pub root@host.example.com:/etc/ssh/
# 添加到服务器配置文件/etc/ssh/sshd_config。
TrustedUserCAKeys /etc/ssh/user_ca.pub

# 客户端安装 CA 公钥
# ssh_known_hosts或known_hosts
@cert-authority *.example.com ssh-rsa AAAAB3Nz...XNRM1EX2gQ==

ssh -i ~/.ssh/user_key user@host.example.com

# 用户证书的废除，需要在服务器新建一个/etc/ssh/revoked_keys文件，然后在配置文件sshd_config添加
RevokedKeys /etc/ssh/revoked_keys
ssh-keygen -kf /etc/ssh/revoked_keys -z 1 ~/.ssh/user1_key.pub # -z参数用来指定用户公钥保存在revoked_keys文件的哪一行
```

## [ssh-agent](https://www.ssh.com/ssh/agent)

* 解决私钥设置密码后，每次使用都必须输入密码
* 让用户在整个 Bash 对话（session）之中，只在第一次使用 SSH 命令时输入密码，然后将私钥保存在内存中，后面都不需要再输入私钥的密码了
* 步骤
  - 命令行启用 ssh-agent
  - 使用 ssh-add（将私钥加入ssh-agent） 添加默认私钥
    + -l 列出所有已经添加的私钥
    + -d 从内存中删除指定的私钥
    + -D 从内存中删除所有已经添加的私钥
* 参数
  - -b 4096：指定密钥位数是4096位。安全性要求不高的场合，这个值可以小一点，但是不应小于1024。
  - -f ~/.ssh/user_ca：指定生成密钥的位置和文件名
  - -F 检查某个主机名是否在known_hosts文件里面
  - -C user_ca：为密钥文件指定新的注释,格式为username@host
  - -I：身份字符串，可以随便设置，相当于注释，方便区分证书，将来可以使用这个字符串撤销证书。
  - -h：指定该证书是服务器证书，而不是用户证书。
  - -n host.example.com：指定服务器域名，表示证书仅对该域名有效。如果有多个域名，则使用逗号分隔。用户登录该域名服务器时，SSH 通过证书的这个值，分辨应该使用哪张证书发给用户，用来证明服务器的可信性。
    + user：指定用户名，表示证书仅对该用户名有效。如果有多个用户名，使用逗号分隔。用户以该用户名登录服务器时，SSH 通过这个值，分辨应该使用哪张证书，证明自己的身份，发给服务器
  - -N 用于指定私钥的密码（passphrase）
  - -R 将指定的主机公钥指纹移出known_hosts文件
  - -p 用于重新指定私钥的密码（passphrase）。与-N的不同之处在于，新密码不在命令中指定，而是执行后再输入。ssh 先要求输入旧密码，然后要求输入两遍新密码
  - -s：指定 CA 签发证书的密钥
  - -t rsa：指定密钥算法 一般会选择dsa算法或rsa算法
  - -V +52w：指定证书的有效期，这里为52周（一年）。默认情况下，证书是永远有效的。建议使用该参数指定有效期，并且有效期最好短一点，最长不超过52周。

```sh
# 新建命令
ssh-agent bash

# 当前对话启用
eval `ssh-agent`

ssh-add
ssh-add my-other-key-file

ssh-add -d name-of-key-file
```

## 命令行代理

```sh
sudo apt install proxychains

#/etc/proxychains.conf add
socks5 127.0.0.1 7891

proxychains curl google.com
```

## 端口转发 port forwarding|SSH 隧道 tunnel

* 作为加密通信中介，充当两台服务器之间的通信加密跳板，使得原本不加密的通信变成加密通信
  - 将不加密数据放在 SSH 安全连接里面传输，使得原本不安全的网络服务增加了安全性，比如通过端口转发访问 Telnet、FTP 等明文服务，数据传输就都会加密
  - 作为数据通信的加密跳板，绕过网络防火墙
* 本地转发 local forwarding -L Specifies that the given port on the local (client) host is to be forwarded to the given host and port on the remote side `ssh -L sourcePort:forwardToHost:onPort connectToHost`
  - SSH 服务器作为中介跳板机，建立本地计算机与特定目标网站之间的加密连接，在本地计算机的 SSH 客户端建立的转发规则 本地-》本地ssh->ssh server-〉des
  - 选择端口号时要注意非管理员帐号是无权绑定1-1023端口的，所以最好选择一个1024-65535之间的未占用的端口
  - `ssh -L local-port:target-host:target-port tunnel-host`
    + connect with ssh to connectToHost
    + forward all connection attempts to the local sourcePort to port onPort on the machine called forwardToHost, which can be reached from the connectToHost machine.
  - ssh -L 7001:localhost:389 <ldap-server-host>
    + 在 LDAP 客户端主机上的应用将数据发送到本机的7001端口
    + 本机的 SSH 客户端将7001端口收到的数据加密并转发到 LDAP 服务器端的 SSH 服务器端口
    + SSH 服务器会解密收到的数据并将之转发到监听的 LDAP 服务389端口
    + 最后再将从 LDAP 返回的数据原路返回以完成整个流程
  - 用户个人配置文件（~/.ssh/config） `Host test.example.com LocalForward client-IP:client-port server-IP:server-port`
* 远程转发 -R Specifies that the given port on the remote (server) host is to be forwarded to the given host and port on the local side `ssh -R sourcePort:forwardToHost:onPort connectToHost`
  - 假设由于网络或防火墙的原因不能用 SSH 直接从 LDAP 客户端主机连接到 LDAP 服务器，但是反向连接却是被允许的，可以通过远程端口转发来实现对 LADP 服务器的访问。只需要在在 LDAP 服务器主机上执行如下命令 `ssh -R 7001:localhost:389 <ldap-client-host>`
    + 和本地端口转发相比，这次只是 SSH 服务器端和 SSH 客户端的位置对调了一下，但是数据流传输路径还是一模一样：LDAP 客户端主机上的应用将数据发送到本机的7001端口上，而本机的 SSH 服务器端会将7001端口收到的数据加密并通过 SSH 隧道转发到 LDAP 服务器端的 SSH 客户端，SSH 客户端会解密收到的数据并将之转发到监听的 LDAP 服务的389端口，最后再将从 LDAP 应答消息原路返回以完成整个流程
  - 在远程 SSH 服务器建立的转发规则
  - 主要针对内网情况:本地计算机在外网，SSH 跳板机和目标服务器都在内网，而且本地计算机无法访问内网之中的 SSH 跳板机，但是 SSH 跳板机可以访问本机计算机,从 SSH 跳板机发起隧道，建立端口转发
  - `ssh -R local-port:target-host:target-port -N local` 在 SSH 跳板机执行的，从跳板机去连接本地计算机
  - 要求本地计算机也安装了 SSH 服务器，这样才能接受 SSH 跳板机的远程登录
  - connect with ssh to connectToHost, and forward all connection attempts to the remote sourcePort to port onPort on the machine called forwardToHost, which can be reached from your local machine.
* 机器 (HostA, HostB, HostC, HostD) ，其中 HostA 想访问 HostD 上面的 LDAP 服务，但是由于网络限制，HostA 不能直接访问 HostD ，但是 HostA 可以访问 HostB ，HostB 也能 SSH 到 HostC ，HostC 能直连 HostD ，如何通过 SSH 端口转发来让 HostA 访问 HostD 的 LDAP 服务呢？只需要在 HostB 上执行本地端口转发 `ssh -g -L 7001:<hostD>:389 <HostC>`
* 动态转发:无需指定被访问目标主机的端口。这个端口号需要在本地通过协议指定，该协议就是简单、安全且实用的 SOCKS 协议 ssh -D <local-port> <ssh-server>
  - 创建一个 SOCKS 代理服务器，所有发送到本机8888端口的数据都会转发到远程主机。接下来，我们可以直接在浏览器中设置 SOCKS 代理：localhost:8888 ，这样，在本机上无法端无法访问的网站现在也就可以通过远程主机代理来正常访问
  - 本机与 SSH 服务器之间创建一个加密连接，然后针对本机内部某个端口的通信，都通过这个加密连接转发
  - 需要把本地端口绑定到 SSH 服务器。至于 SSH 服务器要去访问哪一个网站，完全是动态的，取决于原始通信
  - 采用了 SOCKS5 协议。访问外部网站时，需要把 HTTP 请求转成 SOCKS5 协议，才能把本地端口的请求转发出去
  - 使用场景:访问所有外部网站，都通过 SSH 转发
  - 设置写入 SSH 客户端的用户个人配置文件（~/.ssh/config）`DynamicForward tunnel-host:local-port`
* VPN
  - 用来在外网与内网之间建立一条加密通道。内网的服务器不能从外网直接访问，必须通过一个跳板机，如果本机可以访问跳板机，就可以使用 SSH 本地转发，简单实现一个 VPN
* 实验
  - 使用 ssh-copy-id vm 将您的 ssh 密钥拷贝到服务器。
  - 使用python -m http.server 8888 在您的虚拟机中启动一个 Web 服务器并通过本机的http://localhost:9999 访问虚拟机上的 Web 服务器
  - 使用sudo vim /etc/ssh/sshd_config 编辑 SSH 服务器配置，通过修改PasswordAuthentication的值来禁用密码验证。通过修改PermitRootLogin的值来禁用 root 登陆。然后使用sudo service sshd restart重启 ssh 服务器，然后重新尝试。

```sh
# -D表示动态转发，local-port是本地端口，tunnel-host是 SSH 服务器，
# -N表示这个 SSH 连接只进行端口转发，不登录远程 Shell，不能执行远程命令，只能充当隧道
ssh -D 2121 tunnel-host -N
curl -x socks5://localhost:2121 http://www.example.com

ssh -L 123:localhost:456 remotehost
ssh -L 123:farawayhost:456 remotehost
# connects to your computer with a webbrowser, he gets the response of the webserver running on SUPERSERVER. You, on your local machine, have no webserver running.
ssh -L 80:localhost:80 SUPERSERVER

ssh -L 2121:www.example.com:80 tunnel-host -N
curl http://localhost:2121
# 只有本机到other.example.com的这一段是加密的，other.example.com到mail.example.com的这一段并不加密。
ssh -L 1100:mail.example.com:110 mail.example.com

# connects to the small and slow server with a webbrowser, he gets the response of the webserver running on your local machine. The tinyserver, which has not enough diskspace for the big website, has no webserver running. But people connecting to tinyserver think so.
ssh -R 80:localhost:80 tinyserver

# 所有发向本地9999端口的请求，都会经过remoteserver发往 targetServer 的 80 端口，这就相当于直接连上了 targetServer 的 80 端口
ssh  -L 9999:targetServer:80 user@remoteserver
# 需在跳板服务器执行，指定本地计算机local监听自己的 9999 端口，所有发向这个端口的请求，都会转向 targetServer 的 902 端口
ssh -R 9999:targetServer:902 local

ssh -R 2121:www.example.com:80 local -N
curl http://localhost:2121

alias my_server="ssh -i ~/.id_ed25519 --port 2222 -L 9999:localhost:8888 foobar@remote_server"

# 通过 SSH 跳板机，将本机的2080端口绑定内网服务器的80端口，本机的2443端口绑定内网服务器的443端口
ssh -L 2080:corp-server:80 -L 2443:corp-server:443 tunnel-host -N

# 两级跳板
ssh -L 7999:localhost:2999 tunnel1-host
ssh -L 2999:target-host:7999 tunnel2-host -N

# ~/.ssh/config
Host vm
    User foobar
    HostName 172.16.174.141
    Port 2222
    IdentityFile ~/.ssh/id_ed25519
    LocalForward 9999 localhost:8888

# 在配置文件中也可以使用通配符
Host *.mit.edu
    User foobaz

# 通过跳板机访问内部机器
ssh 目标机器登录用户@目标机器IP -p 目标机器端口 -o ProxyCommand='ssh -p 跳板机端口 跳板机登录用户@跳板机IP -W %h:%p'

# 在 $HOME/.ssh 目录下建立/修改文件 config
Host tiaoban   #任意名字，随便使用
    HostName 192.168.1.1   #这个是跳板机的IP，支持域名
    Port 22      #跳板机端口
    User username_tiaoban       #跳板机用户

Host nginx      #同样，任意名字，随便起
    HostName 192.168.1.2  #真正登陆的服务器，不支持域名必须IP地址
    Port 22   #服务器的端口
    User username   #服务器的用户
    ProxyCommand ssh username_tiaoban@tiaoban -W %h:%p

Host 10.10.0.*      #可以用*通配符
    Port 22   #服务器的端口
    User username   #服务器的用户
    ProxyCommand ssh username_tiaoban@tiaoban -W %h:%p

# 通过跳板机（隧道）传输文件
ssh -L 1234:<address of R known to G>:22 <user at G>@<address of G>
echo "请打开另外一个终端"
scp -P 1234 <user at R>@127.0.0.1:/path/to/file file-name-to-be-copied

# 代理本地某端口：
ssh -N -f -L 0.0.0.0:8788:localhost:8787 shilei@localhost
```

![Alt text](../_static/ssh_local_port_forwarding.png "Optional title")
![Alt text](../_static/ssh_local_port_forwarding1.png "Optional title")
![Alt text](../_static/ssh_remote_port_forwarding.png "Optional title")
![Alt text](../_static/ssh_remote_port_forwarding1.png "Optional title")

## scp secure copy

* SSH 提供的一个客户端程序，用来在两台主机之间加密传送文件
* 底层是 SSH 协议，默认端口是22，相当于先使用ssh命令登录远程主机，然后再执行拷贝操作
* 操作
  - 本地复制到远程
  - 远程复制到本地
  - 两个远程系统之间的复制
* 支持一次复制多个文件
* 配置项
  - -c 用来指定文件拷贝数据传输的加密算法
  - -C 表示是否在传输时压缩文件
  - -F 用来指定 ssh_config 文件，供 ssh
  - -i 用来指定密钥
  - -l 用来限制传输数据的带宽速率，单位是 Kbit/sec
  - -p 用来保留修改时间（modification time）、访问时间（access time）、文件状态（mode）等原始文件的信息
  - -P 用来指定远程主机的 SSH 端口。如果远程主机使用默认端口22，可以不用指定，否则需要用-P参数在命令中指定
  - -q 用来关闭显示拷贝的进度条

```sh
scp foobar.txt your_username@remotehost.edu:/some/remote/directory
scp foo.txt bar.txt your_username@remotehost.edu:~
scp -r foo your_username@remotehost.edu:/some/remote/directory/bar
scp -P 2264 foobar.txt your_username@remotehost.edu:foobar.txt /some/local/directory
scp your_username@rh1.edu:/some/remote/directory/foobar.txt your_username@rh2.edu:/some/remote/directory/
scp your_username@remotehost.edu:/some/remote/directory/\{a,b,c\} .
scp your_username@remotehost.edu:~/\{foo.txt,bar.txt\} .
scp /home/space/music/1.mp3 root@www.runoob.com:/home/root/others/music
scp /home/space/music/1.mp3 root@www.runoob.com:/home/root/others/music/001.mp3
```

## sftp

* SSH 提供的一个客户端应用程序，主要用来安全地访问 FTP。因为 FTP 是不加密协议，很不安全，sftp就相当于将 FTP 放入了 SSH
* 指令
  - ls [directory]：列出一个远程目录的内容。如果没有指定目标目录，则默认列出当前目录。
  - cd directory：从当前目录改到指定目录。
  - mkdir directory：创建一个远程目录。
  - rmdir path：删除一个远程目录。
  - put localfile [remotefile]：本地文件传输到远程主机。
  - get remotefile [localfile]：远程文件传输到本地。

```sh
ftp username@hostname
```

## 教程

* [SSh 教程](https://wangdoc.com/ssh)
