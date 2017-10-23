# PVN

## 工具

- [Lantern](https://github.com/getlantern/lantern)
- firefly-proxy
- [XX-net/XX-Net](https://github.com/XX-net/XX-Net)a web proxy tool
- [googlehosts/hosts](https://github.com/googlehosts/hosts)


## 搭建服务

### 服务

* [StreisandEffect/streisand](https://github.com/StreisandEffect/streisand):Streisand sets up a new server running L2TP/IPsec, OpenConnect, OpenSSH, OpenVPN, Shadowsocks, sslh, Stunnel, a Tor bridge, and WireGuard. It also generates custom instructions for all of these services. At the end of the run you are given an HTML file with instructions that can be shared with friends, family members, and fellow activists.
* [Nyr/openvpn-install](https://github.com/Nyr/openvpn-install):OpenVPN road warrior installer for Debian, Ubuntu and CentOS


## shadowsocks

[wiki](https://github.com/shadowsocks/shadowsocks/wiki)

```shell
apt-get install python-pip
wget https://bootstrap.pypa.io/ez_setup.py -O - | python

ssserver -p 443 -k password -m rc4-md5
sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start // 后台运行
sudo ssserver -d stop // 停止
sudo less /var/log/shadowsocks.log // 日志

ssserver -c /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start
ssserver -c /etc/shadowsocks.json -d stop
```


```json
{
    "server":"my_server_ip",  //服务器ip the address your server listens
    "server_port":8388,  // 对外服务端口 server port
    "local_address": "127.0.0.1",  // 本地ip the address your local listens
    "local_port":1080,   // local port
    "password":"mypassword",
    "timeout":300,
    "method":"aes-256-cfb",
    "fast_open": false
}
```
