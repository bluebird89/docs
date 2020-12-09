# [FFmpeg](https://github.com/FFmpeg/FFmpeg)

Mirror of git://source.ffmpeg.org/ffmpeg.git  Fast Forward Moving Pictures Experts Group <https://ffmpeg.org>

* 实现了对标准流媒体传输是一个为流媒体提供解决方案的跨平台的C++开源项目，实现了对标准流媒体传输协议如RTP/RTCP、RTSP、SIP等的支持
* Live555实现了对多种音视频编码格式的音视频数据的流化、接收和处理等支持，包括MPEG、H.263+、DV、JPEG视频和多种音频编码

## 概念

* 视频文件本身是一个容器（container），里面包括了视频和音频，也可能有字幕等其他内容
* 格式：`ffmpeg -formats`
  - MP4
  - MKV
  - WebM
  - AVI
* 编码 `ffmpeg -codecs` 视频和音频都需要经过编码，才能保存成文件
  - 视频
    + H.262(有版权)
    + H.264(有版权)
    + H.265(有版权)
    + VP8(无版权)
    + VP9(无版权)(无版权)
    + AV1(无版权)
  - 音频
    + MP3
    + AAC
* 编码器
  - 视频
    + libx264：最流行的开源 H.264 编码器
    + NVENC：基于 NVIDIA GPU 的 H.264 编码器
    + libx265：开源的 HEVC 编码器
    + libvpx：谷歌的 VP8 和 VP9 编码器
    + libaom：AV1 编码器
  - 音频
    + libfdk-aac
    + aac
* 解码(Decode)
  - 音频和视频都是分开进行压缩的，因为音频和视频的压缩算法不一样，解码也不一样，所以需要对音频和视频分别进行解码
  - 为了传输过程的方便，将压缩过的音频和视频捆绑在一起进行传输
  - 解复用(Demux):绑在一起的音频和视频流分开来 Video Streams and Audio Streams

## use

* video player
* Directshow Filter
* 转码

## Multimedia

* transcoding process:libavformat
* filters:libavfilter
* bitrate = file size / duration, example: 20.8M bit/60s = 20.8*1024*1024*8 bit/60s= 2831Kbps
* framerate

```
 _______              ______________
|       |            |              |
| input |  demuxer   | encoded data |   decoder
| file  | ---------> | packets      | -----+
|_______|            |______________|      |
                                           v
                                       _________
                                      |         |
                                      | decoded |
                                      | frames  |
                                      |_________|
 ________             ______________       |
|        |           |              |      |
| output | <-------- | encoded data | <----+
| file   |   muxer   | packets      |   encoder
|________|           |______________|
```

## tool

* ffmpeg 快速的音频、视频编码器/解码器
* ffplay 多媒体播放器
* ffprobe 多媒体文件特征解析
* FFmpeg编译之后包含libavcodec、libavformat、libavdevice、libavfilter、libavutil、libpostproc、libswresample、libswscale

## use

* `ffmpeg {1} {2} -i {3} {4} {5}`
  - 全局参数
  - 输入文件参数
  - 输入文件
  - 输出文件参数
  - 输出文件
* 参数
  - -hide_banner:show ffmpeg compilation information
  - -ss  seek for that second to start its processing, so it will extract frames from that moment. (00:00:07.000 is the second 7 from the video in this case)
  - -vframes the number of frames to extract (1 in this case). FFMPEG will extract only one image and it will use thumb.jpg as output file. You might notice that in this case we are not using a pattern like "%04d" as we are extracting only one frame.
  - -vf
    - "fps=1" so ffmpeg will filter the video and extract one image (1 frame per second) for the output;
    - fps=1/5 extract one image every 5 seconds
    - -vsync vfr: This is a parameter that tells the filter to use a variable bitrate video synchronization. If we do not use this parameter ffmpeg will fail to find only the keyframes and shoud extract other frames that can be not processed correctly.
  - -s 480x300: frame size of image to output (image resized to fit dimensions)
  - -f image2: forces format
  - -b:v 64k  video bitrate of the output file to 64 kbit/s
  - -r 24 frame rate of the output file to 24 fps
  - -c：指定编码器
  - -c copy：直接复制，不经过重新编码（比较快）
  - -c:v：指定视频编码器
  - -c:a：指定音频编码器
  - -an：去除音频流
  - -vn：去除视频流
  - -preset：指定输出的视频质量，会影响文件的生成速度，有以下几个可用的值 ultrafast, superfast, veryfast, faster, fast, medium, slow, slower, veryslow。
  - -y：不经过确认，输出时直接覆盖同名文件
* 转换容器格式（transmuxing）指的是，将视频文件从一种容器转到另一种容器 `ffmpeg -i input.mp4 -c copy output.webm`
* 调整码率（transrating）指的是，改变编码的比特率，一般用来将视频文件的体积变小
* 裁剪（cutting）指的是，截取原始视频里面的一个片段，输出为一个新视频。可以指定开始时间（start）和持续时间（duration），也可以指定结束时间（end）。

```sh
sudo apt|yum -y install ffmpeg

ffmpeg -h full

ffmpeg.exe [global options] [input file options] -i input_file [output file options] output_files
ffmpeg -i input.mp4 # 查看视频文件的元信息，比如编码格式和比特率
ffmpeg -i test.mp4 -r 1 -f image2 image-%5d.jpeg
ffmpeg -ss 0.5 -i inputfile.mp4 -t 1 -s 480x300 -f image2 imagefile.jpg

ffmpeg \
-y \ # 全局参数
-c:a libfdk_aac -c:v libx264 \ # 输入文件参数
-i input.mp4 \ # 输入文件
-c:v libvpx-vp9 -c:a libvorbis \ # 输出文件参数
output.webm # 输出文件

ffprobe -show_format test.mp4

ffmpeg -i test.flv 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,// # duration
ffmpeg -i test.flv 2>&1 | grep 'creationdate' | cut -d ' ' -f  5- # createtime
ffmpeg -i test.flv 2>&1 | grep 'Video' | cut -d ' ' -f 10 | sed s/,// # 获得视频尺寸大小
ffmpeg -i video.webm thumb%04d.jpg -hide_banner

ffmpeg -i video.webm -ss 00:00:07.000 -vframes 1 thumb.jpg # Extract only one frame
ffmpeg -i video.webm -ss 00:00:07.000 -vframes 3 thumb%04d.jpg -hide_banner

ffmpeg -i video.webm -vf fps=1 thumb%04d.jpg -hide_banner # Extract frames in a regular time basis
ffmpeg -i video.webm -vf fps=1/5 thumb%04d.jpg -hide_banner # extract one image every 5 seconds

ffmpeg -i video.webm -vf "select=eq(pict_type\,I)" -vsync vfr thumb%04d.jpg -hide_banner # make the filter to select all images that are keyframes. ("pict_type\,I" refers to Index picture type, "eq" refers to equal, so we can read it as "select all equal to index images")

ffmpeg -r 1 -i input.m2v -r 24 output.avi

ffmpeg -i test.mp4 -acodec aac -vn output.aac # 提取音频
ffmpeg -i input.mp4 -vcodec copy -an output.mp4 # 提取视频
ffmpeg -ss 00:00:15 -t 00:00:05 -i input.mp4 -vcodec copy -acodec copy output.mp4 # -ss表示开始切割的时间，-t表示要切多少。上面就是从15秒开始，切5秒钟出来
ffmpeg -ss 2.5 -i [input] -to 10 -c copy [output]
# 从指定时间开始，连续对1秒钟的视频进行截图
ffmpeg \
-y \
-i input.mp4 \
-ss 00:01:24 -t 00:00:01 \
output_%3d.jpg

# 指定只截取一帧
ffmpeg \
-ss 01:23:45 \
-i input \
-vframes 1 -q:v 2 \
output.jpg

# 指定码率最小为964K，最大为3856K，缓冲区大小为 2000K
ffmpeg \
-i input.mp4 \
-minrate 964K -maxrate 3856K -bufsize 2000K \
output.mp4

# 从 1080p 转为 480p
ffmpeg \
-i input.mp4 \
-vf scale=480:-1 \
output.mp4

# 从视频里面提取音频（demuxing）
ffmpeg \
-i input.mp4 \
-vn -c:a copy \
output.aac

# 添加音轨（muxing）
ffmpeg \
-i input.aac -i input.mp4 \
output.mp4

# 将音频文件，转为带封面的视频文件
ffmpeg \
-loop 1 \
-i cover.jpg -i input.mp3 \
-c:v libx264 -c:a aac -b:a 192k -shortest \
output.mp4
```

## 推流

* 把采集阶段封包好的内容传输到服务器的过程。其实就是将现场的视频信号传到网络的过程.把本地音视频数据通过网络上传到云端/后台服务器，所谓“采集阶段封包好”
* 协议
  - RTMP （Real Time Messaging Protocol实时消息传输协议）
    + Adobe公司开发的一个基于TCP的应用层协议
    + 在TCP通道上一般传输的是flv 格式流。请注意，RTMP是网络传输协议，而flv则是视频的封装格式
    + 默认使用端口1935
    + RTMPE在RTMP的基础上增加了加密功能
    + RTMPT封装在HTTP请求之上，可穿透防火墙
    + RTMPS类似RTMPT，增加了TLS/SSL的安全功能
    + RTMFP使用UDP进行传输的RTMP
  - HLS
  - webRTC
  - HTTP-FLV

```sh
# 查看电脑设备
ffmpeg -list_devices true -f dshow -i dummy

# 测试摄像头是否可用
ffplay -f dshow -i video="USB2.0 PC CAMERA"
ffplay -f vfwcap -i 0

# 查看摄像头和麦克风信息
ffmpeg -list_options true -f dshow -i video="USB2.0 PC CAMERA"
# 查询麦克风信息
ffmpeg -list_options true -f dshow -i audio="麦克风 (2- USB2.0 MIC)"

# 本地视频推流
ffmpeg -i ${input_video} -f flv rtmp://${server}/live/${streamName}
ffmpeg.exe -re -i demo.wmv -f flv rtmp://127.0.0.1:1935/live/123
# 摄像头推流
ffmpeg -f dshow -i video="USB2.0 PC CAMERA" -vcodec libx264 -preset:v ultrafast -tune:v zerolatency -f flv rtmp://127.0.0.1:1935/live/123
# 麦克风推流
ffmpeg -f dshow -i audio="麦克风 (2- USB2.0 MIC)" -vcodec libx264 -preset:v ultrafast -tune:v zerolatency -f flv rtmp://127.0.0.1:1935/live/123

# 只有音频
ffmpeg -i ${input_video} -vcodec copy -an -f flv rtmp://${server}/live/${streamName} #  -vcodec：指定视频解码器 -acodec：指定音频解码器 copy表示不作解码  an 代表acodec none 去掉音频

# 摄像头&麦克风推流
ffmpeg -f dshow -i video="USB2.0 PC CAMERA" -f dshow -i audio="麦克风 (2- USB2.0 MIC)" -vcodec libx264 -preset:v ultrafast -tune:v zerolatency -f flv rtmp://127.0.0.1:1935/live/123
ffmpeg -f dshow -i video="USB2.0 PC CAMERA":audio="麦克风 (2- USB2.0 MIC)" -vcodec libx264 -r 25 -preset:v ultrafast -tune:v zerolatency -f flv rtmp://127.0.0.1:1935/live/123
```

## 服务

* 安装nginx-rtmp模块
* 配置
* VLC 播放 `rtmp://192.168.166.172:1935/rtmplive/`

```
rtmp {
  server {
    listen 1935;
    application rtmplive {
      live on;
      record off;
    }

}
```

## Tool

* [PHP-FFMpeg](https://github.com/PHP-FFmpeg/PHP-FFmpeg/): An object oriented PHP driver for FFMpeg binary

## reference

* [Documentation](https://ffmpeg.org/documentation.html)
* [FFMPEG视音频编解码零基础学习方法](https://blog.csdn.net/leixiaohua1020/article/details/15811977)
