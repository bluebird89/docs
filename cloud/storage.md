# 存储 Store

## Saas

* [腾讯微云](https://www.weiyun.com/)
* [Google Drive](https://drive.google.com/drive/)
  - [harababurel/gcsf](https://github.com/harababurel/gcsf):a FUSE file system based on Google Drive
* 华为云 OBS
* [icloud](https://www.icloud.com/)
* [juicefs](https://juicefs.io/):为云端设计的 POSIX 共享文件系统
* dropbox
* [pCloud](https://www.pcloud.com/zh/)
* 百度云
  - [Pan](https://pandownload.com)
  - [BaiduExporter](https://github.com/acgotaku/BaiduExporter):Assistant for Baidu to export download links to aria2/aria2-rpc
  - [baidu-netdisk-downloaderx](https://github.com/b3log/baidu-netdisk-downloaderx):⚡️ 百度网盘不限速下载器 BND，支持 Windows、Mac 和 Linux。 <https://hacpai.com/tag/bnd>
  - [BaiduNetdiskPlugin-macOS](https://github.com/CodeTips/BaiduNetdiskPlugin-macOS):For macOS.百度网盘 破解SVIP、下载速度限制~
  - [baidupcs-web](https://github.com/liuzhuoling2011/baidupcs-web):
* [坚果云](https://www.jianguoyun.com/)
* [数蚁](https://teamyi.com)
* [server](https://github.com/nextcloud/server):☁️ Nextcloud server, a safe home for all your data <https://nextcloud.com>
  - `sudo -u www-data php occ maintenance:install --database "mysql" --database-name "henry" --database-user "nextcloud" --database-port:"33060" --database-pass "henry" --admin-user "admin" --admin-pass "admin"`
* 建议
  - 40GB 空间以下选阿里云的 OSS
  - 40GB 以上可以对比下腾讯云的 COS
  - 国外服务商，请优先选择 BackBlaze，性价比完爆 AWS、MS、Google

###  [Resilio](https://www.resilio.com/)

* 在几台不同的设备之间同步文件,是一种分布式网盘 `config.getsync.com/sync.conf`
* [linux install](https://help.resilio.com/hc/en-us/articles/206178924)

```sh
./rslsync --webui.listen 0.0.0.0:8888
```

## 服务

* [syncthing](https://github.com/syncthing/syncthing):Open Source Continuous File Synchronization <https://forum.syncthing.net/>
* [seaweedfs](https://github.com/chrislusf/seaweedfs):SeaweedFS is a simple and highly scalable distributed file system. There are two objectives: to store billions of files! to serve the files fast! SeaweedFS implements an object store with O(1) disk seek, and an optional Filer with POSIX interface.
* [rclone](https://github.com/ncw/rclone):"rsync for cloud storage" - Google Drive, Amazon Drive, S3, Dropbox, Backblaze B2, One Drive, Swift, Hubic, Cloudfiles, Google Cloud Storage, Yandex Files <https://rclone.org>
* [linux-timemachine](https://github.com/cytopia/linux-timemachine):Rsync-based OSX-like time machine for Linux and BSD (and even OSX)
* [iterm2-zmodem](https://github.com/mmastrac/iterm2-zmodem):Automatic ZModem support for iTerm 2
* [node-fs](https://github.com/bailicangdu/node-fs):基于node搭建的文件/图片管理系统
  - [UZER.ME](https://uzer.me/)

## 下载

* [proxyee-down](https://github.com/proxyee-down-org/proxyee-down):http下载工具，基于http代理，支持多连接分块下载
* [webtorrent-desktop](https://github.com/webtorrent/webtorrent-desktop):❤️ Streaming torrent app for Mac, Windows, and Linux <https://webtorrent.io/desktop>
* [Motrix](https://github.com/agalwood/Motrix):A full-featured download manger. <https://motrix.app/>
* [Downie](https://software.charliemonroe.net/downie/):YouTube Video Downloader for macOS - Charlie
* [bundlehunt](https://bundlehunt.com/)
* [盘下载器](https://www.baiduwp.com/)
* [EagleGet](http://www.eagleget.com/cn/)
* [ytdl-webserver](https://github.com/Algram/ytdl-webserver):📻 Webserver for downloading youtube videos. Ready for docker.
* [Free Download Manager](https://www.freedownloadmanager.org/)
* qBittorrent
  + `sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable`
  + `sudo apt-get update && sudo apt-get install qbittorrent`
  + 开启 UPnP / NAT-PMP 功能
  + 添加 eMule 服务器
  + 添加 trackers 优化下载速度
    - [trackerslist](https://github.com/ngosang/trackerslist):Updated list of public BitTorrent trackers
    - <https://torrents.io/tracker-list/>
    - <https://newtrackon.com/list>
  * 连接 DHT 节点
* C-torrent:最简单的命令行torrent下载工具
* [utorrent](https://www.utorrent.com/intl/zh_cn/)
* [Transmission](https://transmissionbt.com/):  a cross-platform BitTorrent client
* IDM
* axel:多线程下载工具，可下载独立文件片段，因而文件下载起来更快速 `sudo apt install axel`
* [aria2](https://github.com/aria2/aria2):aria2 is a lightweight multi-protocol & multi-source, cross platform download utility operated in command-line. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink. <https://aria2.github.io/> aria2 can be manipulated via built-in JSON-RPC and XML-RPC interfaces.
  - `sudo apt install aria2`
  - `~/.aria2/aria2.conf`
  - `aria2c 'magnet:xxxxxxx'`
  - [aria2gui](https://github.com/yangshun1029/aria2gui):Aria2GUI for macOS
  - [webui-aria2](https://github.com/ziahamza/webui-aria2):The aim for this project is to create the worlds best and hottest interface to interact with aria2. Very simple to use, just download and open index.html in any web browser.
* [annie](https://github.com/iawia002/annie):👾 Fast, simple and clean video downloader
* [you-get](https://github.com/soimort/you-get):⏬ Dumb downloader that scrapes the web <https://you-get.org/>
* [youtube-dl](https://github.com/rg3/youtube-dl):Command-line program to download videos from YouTube.com and other video sites <http://rg3.github.io/youtube-dl/> `curl https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl`
* [popcorn-desktop](https://github.com/popcorn-official/popcorn-desktop):Popcorn Time is a multi-platform, free software BitTorrent client that includes an integrated media player. Desktop ( Windows / Mac / Linux ) a Butter-Project Fork <https://popcorntime.app>
* [magnetW](https://github.com/xiandanin/magnetW):磁力链接聚合搜索

## 传输

* [](https://github.com/schollz/croc):Easily and securely send things from one computer to another 🐊 📦 <https://schollz.com/software/croc6>

## md5 

* verdify

```sh
md5sum /path/filename
sha256sum /path/filename
```

## [minio](https://github.com/minio/minio)

MinIO is a high performance object storage server compatible with Amazon S3 APIs <https://min.io/download>  <https://docs.min.io/cn/>

* 最适合存储非结构化数据，如照片，视频，日志文件，备份和容器/ VM 映像
* 采用了纠删码技术，即便您丢失一半数量（N/2）的硬盘，您仍然可以恢复数据
* 在分布式和单机模式下，所有读写操作都严格遵守read-after-write一致性模型
* 使用s3cmd来操作Minio

```sh
code
```

## Tool

* [rook](https://github.com/rook/rook):Storage Orchestration for Kubernetes <https://rook.io>
* [Unison](https://www.cis.upenn.edu/~bcpierce/unison/):File Synchronizer
* [openmediavault](https://www.openmediavault.org/): the next generation network attached storage (NAS) solution based on Debian Linux. It contains services like SSH, (S)FTP, SMB/CIFS, DAAP media server, RSync, BitTorrent client and many more.
* [transfer.sh](https://github.com/dutchcoders/transfer.sh) Easy and fast file sharing from the command-line.
* [send](https://github.com/timvisee/send) https://send.vis.ee/