# [FFmpeg](https://github.com/FFmpeg/FFmpeg)

A complete, cross-platform solution to record, convert and stream audio and video. <https://ffmpeg.org>

* 一个为流媒体提供解决方案的跨平台的C++开源项目
* 实现了对标准流媒体传输协议如RTP/RTCP、RTSP、SIP等的支持
* 实现了对多种音视频编码格式的数据流化、接收和处理等支持，包括MPEG、H.263+、DV、JPEG视频和多种音频编码

## 安装

* ffmpeg 用于转码的应用程序
* `ffplay test.avi` 多媒体播放器
* ffprobe 查看文件格式的应用程序

```sh
sudo apt|yum -y install ffmpeg

ffmpeg -h [full]
ffmpeg -formats # 显示可用的格式，编解码的，协议的
```

## 原理

* 音视频文件本身是一个容器（container），里面包括了视频和音频，也可能有字幕等其他内容
  - 以 MP4 为例，就可以存放一路视频流，多路音频流，多路字幕流
  - 音视频需要经过编码保存成文件
  - 因为压缩算法不一样，音频和视频的压缩与解码分开进行
  - 为了传输过程方便，将压缩过的音频和视频捆绑在一起进行传输
* channel 声道
* 封装格式 把视频数据和音频数据打包成一个文件的规范
  - MP4
  - MKV
  - WebM
  - AVI
  - TS
  - RMVB
* 编码格式｜编码标准 CODEC `ffmpeg -codecs`
  - 视频
    + H.262(有版权)
    + H.264(有版权)
    + H.265(有版权)
    + VP8(无版权)
    + VP9(无版权)
    + AV1(无版权)
  - 音频
    + MP3
    + AAC
* 编码器 encoders 实现某种编码格式的库文件。只有安装了某种格式的编码器，才能实现该格式视频/音频的编码和解码 `ffmpeg -encoders`
  - 视频
    + libx264 最流行的开源 H.264 编码器
    + NVENC 基于 NVIDIA GPU 的 H.264 编码器
    + libx265 开源的 HEVC 编码器
    + libvpx 谷歌的 VP8 和 VP9 编码器
    + libaom AV1 编码器
  - 音频
    + libfdk-aac
    + aac
* 解码 Decode
  - 解复用(Demux):绑在一起的音频和视频流分开来 Video Streams and Audio Streams
* 封装技术
* 流程
  - 解协议：将流媒体协议的数据，解析为标准的相应的封装格式数据。
    + 视音频在网络上传播的时候，常常采用各种流媒体协议，例如HTTP，RTMP，或是MMS等等。这些协议在传输视音频数据的同时，也会传输一些信令数据。这些信令数据包括对播放的控制（播放，暂停，停止），或者对网络状态的描述等。
    + 解协议的过程中会去除掉信令数据而只保留视音频数据。例如，采用RTMP协议传输的数据，经过解协议操作后，输出FLV格式的数据。
  - 解封装：将输入的封装格式的数据，分离成为音频流压缩编码数据和视频流压缩编码数据。
    + 封装格式种类很多，例如MP4，MKV，RMVB，TS，FLV，AVI等等，它的作用就是将已经压缩编码的视频数据和音频数据按照一定的格式放到一起。例如，FLV格式的数据，经过解封装操作后，输出H.264编码的视频码流和AAC编码的音频码流。
  - 解码：将视频/音频压缩编码数据，解码成为非压缩的视频/音频原始数据。音频的压缩编码标准包含AAC，MP3，AC-3等等，视频的压缩编码标准则包含H.264，MPEG2，VC-1等等。解码是整个系统中最重要也是最复杂的一个环节。通过解码，压缩编码的视频数据输出成为非压缩的颜色数据，例如YUV420P，RGB等等；压缩编码的音频数据输出成为非压缩的音频抽样数据，例如PCM数据。
  - 视音频同步的作用，就是根据解封装模块处理过程中获取到的参数信息，同步解码出来的视频和音频数据，并将视频音频数据送至系统的显卡和声卡播放出来。
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

```sh
ffmpeg -i input.mp4 -hide_banner # 查看视频文件的元信息，比如编码格式和比特率
ffprobe -show_format test.mp4

ffmpeg -i test.flv 2>&1 | grep 'Duration' | cut -d ' ' -f 4 | sed s/,// # duration
ffmpeg -i test.flv 2>&1 | grep 'creationdate' | cut -d ' ' -f  5- # createtime
ffmpeg -i test.flv 2>&1 | grep 'Video' | cut -d ' ' -f 10 | sed s/,// # 获得视频尺寸大小
```

## 类库

* libavcodec
* libavformat 封装格式的处理
* libavdevice（读设备）
  - 读取电脑的多媒体设备的数据，或者输出数据到指定的多媒体设备上
* libavfilter（加特效）
  - 给视音频添加各种滤镜效果
* libavutil
* libpostproc
* libswresample
* libswscale（图像拉伸，像素格式转换）
  - 转换像素数据的格式，同时可以拉伸图像的大小

## 基础使用

* `ffmpeg {1} {2} -i {3} {4} {5}`
  - 1 全局参数
  - 2 输入文件参数
  - 3 输入文件
  - 4 输出文件参数
  - 5 输出文件
* 参数
  - -hide_banner don't show ffmpeg compilation information
  - -i 输入文件
    + -ar 44100 设置音频采样频率
    + -ac 设置音频通道数
      * 1 表示单声道
      * 2 就是立体声
    + -ab 设定声音比特率
    + -vol <百分比> 设定音量
  - 码率 bitrate = file size / duration, example: 20.8M bit/60s = 20.8*1024*1024*8 bit/60s= 2831Kbps
    + -b:a 64k 表示音频码率为64kb/s，即8kB/s
    + -b:v 64k video bitrate of the output file to 64 kbit/s
  - 编码器
    + -c 指定编码器
      - copy 直接复制，不经过重新编码（比较快）
    + -c:v|-vcodec 指定视频编码器
      * mp3
    + -c:a|-acodec 指定音频编码器,未设定时则使用与输入流相同的编解码器
    + -an 去除音频流
    + -vn 去除视频流
  - -ss seek for that second to start its processing, so it will extract frames from that moment.
  - 输出
    + -vframes the number of frames to extract. FFMPEG will extract only one image and use thumb.jpg as output file
      * using a pattern like "%04d"
      * extracting only one frame.
    + -vf
      + "fps=1" so ffmpeg will filter the video and extract one image (1 frame per second) for the output;
      + fps=1/5 extract one image every 5 seconds
      + -vsync vfr: This is a parameter that tells the filter to use a variable bitrate video synchronization. If we do not use this parameter ffmpeg will fail to find only the keyframes and shoud extract other frames that can be not processed correctly.
      * -r 24 frame rate of the output file to 24 fps
      * -s 480x300 frame size of image to output (image resized to fit dimensions)
      * -f 设定输出格式 forces format
        - image2
    + -af
      * volume=-3dB 改变音量大小
    + -preset 指定输出视频质量，会影响文件生成速度
      * ultrafast
      * superfast
      * veryfast
      * faster
      * fast
      * medium
      * slow
      * slower
      * veryslow
    + -y 输出时不经过确认直接覆盖同名文件
  - -title string 设置标题
  - -author string 设置作者
  - -copyright string 设置版权
  - -comment string 设置评论

```sh
ffmpeg.exe [global options] [input file options] -i input_file [output file options] output_files

ffmpeg \
-y \  # 全局参数
-c:a libfdk_aac -c:v libx264 \  # 输入文件参数
-i input.mp4 \  # 输入文件
-c:v libvpx-vp9 -c:a libvorbis \  # 输出文件参数
output.webm # 输出文件

ffmpeg -i test.mp4 -r 1 -f image2 image-%5d.jpeg
ffmpeg -ss 0.5 -i inputfile.mp4 -t 1 -s 480x300 -f image2 imagefile.jpg

# 改变分辨率（transsizing） 从 1080p 转为 480p
ffmpeg -i input.mp4 -vf scale=480:-1 output.mp4
```

## 转换格式（transmuxing）将文件从一种容器转到另一种容器

```sh
# 只是转一下容器，内部的编码格式不变，所以使用-c copy指定直接拷贝
ffmpeg -i input.mp4 -c copy output.webm
```

## 转码 transcoding process:libavformat

```sh
# 编码转成另一种编码
ffmpeg -i [input.file] -c:v libx264|libx265 output.mp4
```

## 调整码率（transrating）

* 改变编码的比特率，一般用来将视频文件的体积变小

```sh
# 码率最小964K，最大3856K，缓冲区大小为 2000K
ffmpeg -i input.mp4 -minrate 964K -maxrate 3856K -bufsize 2000K output.mp4
```

## 音频压缩编码技术

* 调整音频速率
  - 调整音频采样率，但是会改变音色
  - 对原音进行冲采样，差值等方法
  - 倍率调整范围为[0.5, 2.0]
* 选项
  - -ab bitrate 设置音频码率
  - -ar freq 设置音频采样率
  - -ac channels 设置通道 缺省为1
  - -an 不使能音频纪录
  - -acodec codec 使用codec编解码
  - -vd device 设置视频捕获设备。比如/dev/video0
  - -vc channel 设置视频捕获通道 DV1394专用
  - -tvstd standard 设置电视标准 NTSC PAL(SECAM)
  - -dv1394 设置DV1394捕获
  - -av device 设置音频设备 比如/dev/dsp
  - -map file:stream 设置输入流映射
  - -debug 打印特定调试信息
  - -benchmark 为基准测试加入时间
  - -hex 倾倒每一个输入包
  - -bitexact 仅使用位精确算法 用于编解码测试
  - -ps size 设置包大小，以bits为单位
  - -re 以本地帧频读数据，主要用于模拟捕获设备
  - -loop 循环输入流（只工作于图像流，用于ffserver测试）

```sh
# 拼接
file '1.mp3'
file '2.mp3'
file '3.mp3'
file '4.mp3'

ffmpeg -f concat -i list.txt -c copy all.mp3

ffmpeg -y -i "concat:1.mp3|2.mp3" -acodec copy output.mp3

# 音频前插入一段静音
ffmpeg -i science.wav -i input.wav -filter_complex '[0:0] [1:0] concat=n=2:v=0:a=1 [a]' -map [a] output.wav -y

# 从5秒开始淡入3秒，淡入开始前都是最低音量
ffmpeg -i 12.mp3 -filter afade=t=in:ss=5:d=3 tttt111t.wav
# 5.3秒开始淡出5秒，淡出后面变成静音，无论是否已经完成
ffmpeg -i 12.mp3 -filter afade=t=out:st=5.3:d=5 danchu.mp3

# 混音
ffmpeg -i INPUT1 -i INPUT2 -i INPUT3 -filter_complex amix=inputs=3:duration=first:dropout_transition=3 OUT

ffmpeg -i input.mkv -filter:a "atempo=2.0" -vn output.mkv
# 调整4倍
ffmpeg -i input.mkv -filter:a "atempo=2.0,atempo=2.0" -vn output.mkv

# 延迟 1000 ms
ffmpeg -i futurebass300.wav  -filter_complex adelay="1000|1000"  futurebass-300-d1.wav

# 静音音频
ffmpeg -f lavfi -t 11 -i anullsrc test.aac -y

# 为音频添加封面
ffmpeg -loop 1 -i cover.jpg -i input.mp3 -c:v libx264 -c:a aac -b:a 192k -shortest output.mp4
```

## 视频压缩编码技术

* 音轨
  - 提取 demuxing
  - 添加 muxing
* 帧
  - 抽取截图
    + -vframes 1 指定只截取一帧
    + -q:v 2 表示输出的图片质量，一般是1到5之间（1 为质量最高）
  - 合成视频
* 裁剪（cutting）截取原始视频里面的一个片段，输出为一个新视频
  - 可以指定开始时间（start）和持续时间（duration），也可以指定结束时间（end）
  - -ss 开始切割时间
  - -t [duration] 持续时间
  - -to [end] 指定结束时间
* 参数
  - -b bitrate 设置比特率，缺省200kb/s
  - -r fps 设置帧频 缺省25
  - -s size 设置帧大小 格式为WXH 缺省160X128.下面的简写也可以直接使用：
  - Sqcif 128X96 qcif 176X144 cif 252X288 4cif 704X576
  - -aspect aspect 设置横纵比 4:3 16:9 或 1.3333 1.7777
  - -croptop size 设置顶部切除带大小 像素单位
  - -cropbottom size –cropleft size –cropright size
  - -padtop size 设置顶部补齐的大小 像素单位
  - -padbottom size –padleft size –padright size –padcolor color 设置补齐条颜色(hex,6个16进制的数，红:绿:兰排列，比如 000000代表黑色)
  - -vn 不做视频记录
  - -bt tolerance 设置视频码率容忍度kbit/s
  - -maxrate bitrate设置最大视频码率容忍度
  - -minrate bitreate 设置最小视频码率容忍度
  - -bufsize size 设置码率控制缓冲区大小
  - -vcodec codec 强制使用codec编解码方式。如果用copy表示原始编解码数据必须被拷贝。
  - -sameq 使用同样视频质量作为源（VBR）
  - -pass n 选择处理遍数（1或者2）。两遍编码非常有用。第一遍生成统计信息，第二遍生成精确的请求的码率
  - -passlogfile file 选择两遍的纪录文件名为file
  - -g gop_size 设置图像组大小
  - -intra 仅适用帧内编码
  - -qscale q 使用固定的视频量化标度(VBR)
  - -qmin q 最小视频量化标度(VBR)
  - -qmax q 最大视频量化标度(VBR)
  - -qdiff q 量化标度间最大偏差 (VBR)
  - -qblur blur 视频量化标度柔化(VBR)
  - -qcomp compression 视频量化标度压缩(VBR)
  - -rc_init_cplx complexity 一遍编码的初始复杂度
  - -b_qfactor factor 在p和b帧间的qp因子
  - -i_qfactor factor 在p和i帧间的qp因子
  - -b_qoffset offset 在p和b帧间的qp偏差
  - -i_qoffset offset 在p和i帧间的qp偏差
  - -rc_eq equation 设置码率控制方程 默认tex^qComp
  - -rc_override override 特定间隔下的速率控制重载
  - -me method 设置运动估计的方法 可用方法有 zero phods log x1 epzs(缺省) full
  - -dct_algo algo 设置dct的算法 可用的有 0 FF_DCT_AUTO 缺省的DCT 1 FF_DCT_FASTINT 2 FF_DCT_INT 3 FF_DCT_MMX 4 FF_DCT_MLIB 5 FF_DCT_ALTIVEC
  - -idct_algo algo 设置idct算法。可用的有 0 FF_IDCT_AUTO 缺省的IDCT 1 FF_IDCT_INT 2 FF_IDCT_SIMPLE 3 FF_IDCT_SIMPLEMMX 4 FF_IDCT_LIBMPEG2MMX 5 FF_IDCT_PS2 6 FF_IDCT_MLIB 7 FF_IDCT_ARM 8 FF_IDCT_ALTIVEC 9 FF_IDCT_SH4 10 FF_IDCT_SIMPLEARM
  - -er n 设置错误残留为n 1 FF_ER_CAREFULL 缺省 2 FF_ER_COMPLIANT 3 FF_ER_AGGRESSIVE 4 FF_ER_VERY_AGGRESSIVE
  - -ec bit_mask 设置错误掩蔽为bit_mask,该值为如下值的位掩码 1 FF_EC_GUESS_MVS (default=enabled) 2 FF_EC_DEBLOCK (default=enabled)
  - -bf frames 使用frames B 帧，支持mpeg1,mpeg2,mpeg4
  - -mbd mode 宏块决策 0 FF_MB_DECISION_SIMPLE 使用mb_cmp 1 FF_MB_DECISION_BITS 2 FF_MB_DECISION_RD
  - -4mv 使用4个运动矢量 仅用于mpeg4
  - -part 使用数据划分 仅用于mpeg4
  - -bug param 绕过没有被自动监测到编码器的问题
  - -strict strictness 跟标准的严格性
  - -aic 使能高级帧内编码 h263+
  - -umv 使能无限运动矢量 h263+
  - -deinterlace 不采用交织方法
  - -interlace 强迫交织法编码仅对mpeg2和mpeg4有效。当你的输入是交织的并且你想要保持交织以最小图像损失的时候采用该选项。可选的方法是不交织，但是损失更大
  - -psnr 计算压缩帧的psnr
  - -vstats 输出视频编码统计到vstats_hhmmss.log
  - -vhook module 插入视频处理模块 module 包括了模块名和参数，用空格分开

```sh
# 提取音频
ffmpeg -i test.mp4 -acodec aac -vn output.aac
# 添加音轨
ffmpeg -i input.aac -i input.mp4 output.mp4
# 替换视频音轨
ffmpeg -i input.mp4 -i input.wav -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0  output.mp4 -y

# 提取视频
ffmpeg -i input.mp4 -vcodec copy -an output.mp4

# 抽帧
ffmpeg -i video.webm thumb%04d.jpg -hide_banner
ffmpeg -i input.mp4 -q:v 2 -f image2 output/%d.jpeg -y

## 从指定时间开始，连续对1秒钟的视频进行截图
ffmpeg -y -i input.mp4 -ss 00:01:24 -t 00:00:01 output_%3d.jpg

## 截取指定一帧
ffmpeg -ss 01:23:45 -i input -vframes 1 -q:v 2 output.jpg
ffmpeg -ss 00:00:07.000 -i video.webm -vframes 1 thumb.jpg # Extract only one frame
ffmpeg -ss 00:00:07.000 -i video.webm -vframes 3 thumb%04d.jpg -hide_banner

ffmpeg -i video.webm -vf fps=1 thumb%04d.jpg -hide_banner # Extract frames in a regular time basis
ffmpeg -i video.webm -vf fps=1/5 thumb%04d.jpg -hide_banner # extract one image every 5 seconds

ffmpeg -i video.webm -vf "select=eq(pict_type\,I)" -vsync vfr thumb%04d.jpg -hide_banner # make the filter to select all images that are keyframes. ("pict_type\,I" refers to Index picture type, "eq" refers to equal, so we can read it as "select all equal to index images")

ffmpeg -r 1 -i input.m2v -r 24 output.avi

ffmpeg -ss 00:00:15 -t 00:00:05 -i input.mp4 -vcodec copy -acodec copy output.mp4 # 从15秒开始，切5秒钟出来

# 裁剪
ffmpeg -ss 00:01:50 -i [input] -t 10.5 -c copy [output]
ffmpeg -ss 2.5 -i [input] -to 10 -c copy [output]
ffmpeg -ss 71 -t 52 -accurate_seek -i input.mp4 -codec copy -avoid_negative_ts 1 output.mp4  -y

# 帧合成视频
ffmpeg -f image2 -i output/%d.jpeg -i 1.wav -acodec copy output.mp4 -y

# 拼接
ffmpeg -i input1.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 1.ts
ffmpeg -i input2.mp4 -vcodec copy -acodec copy -vbsf h264_mp4toannexb 2.ts
ffmpeg -i "concat:1.ts|2.ts" -acodec copy -vcodec copy -absf aac_adtstoasc outp
```

## Convert to an animated GIF

```sh
### Convert a whole video to GIF
ffmpeg -i $INPUT_FILENAME \
-vf "fps=$OUTPUT_FPS,scale=$OUTPUT_WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
-loop $NUMBER_OF_LOOPS $OUTPUT_FILENAME

# Change these placeholders:
# * $INPUT_FILENAME - path to the input video.
# * $OUTPUT_FPS - ouput frames per second. Start with `10`.
# * $OUTPUT_WIDTH - output width in pixels. Aspect ratio is maintained.
# * $NUMBER_OF_LOOPS - use `0` to loop forever, or a specific number of loops.
# * $OUTPUT_FILENAME - the name of the output animated GIF.

ffmpeg -i "sample_recording.mp4" \
-vf "fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
-loop 0 sample_recording.gif

### Convert part of a video to GIF
ffmpeg -ss $INPUT_START_TIME -t $LENGTH -i $INPUT_FILENAME \
-vf "fps=$OUTPUT_FPS,scale=$OUTPUT_WIDTH:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
-loop $NUMBER_OF_LOOPS $OUTPUT_FILENAME

# Change these placeholders:
# * $INPUT_START_TIME - number of seconds in the input video to start from.
# * $LENGTH - number of seconds to convert from the input video.
# * $INPUT_FILENAME - path to the input video.
# * $OUTPUT_FPS - ouput frames per second. Start with `10`.
# * $OUTPUT_WIDTH - output width in pixels. Aspect ratio is maintained.
# * $NUMBER_OF_LOOPS - use `0` to loop forever, or a specific number of loops.
# * $OUTPUT_FILENAME - the name of the output animated GIF.

ffmpeg -ss 32.5 -t 7 -i "sample_recording.mp4" \
-vf "fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
-loop 0 sample_recording.gif

### Convert a whole video to animated WebP
ffmpeg -i $INPUT_FILENAME \
-vf "fps=$OUTPUT_FPS,scale=$OUTPUT_WIDTH:-1:flags=lanczos" \
-vcodec libwebp -lossless 0 -compression_level 6 \
-q:v $OUTPUT_QUALITY -loop $NUMER_OF_LOOPS \
-preset picture -an -vsync 0 $OUTPUT_FILENAME

# Change these placeholders:
# * $INPUT_FILENAME - path to the input video.
# * $OUTPUT_FPS - ouput frames per second. Start with `10`.
# * $OUTPUT_WIDTH - output width in pixels. Aspect ratio is maintained.
# * $OUTPUT_QUALITY - quality of the WebP output. Start with `50`.
# * $NUMBER_OF_LOOPS - use `0` to loop forever, or a specific number of loops.
# * $OUTPUT_FILENAME - the name of the output animated WebP.

ffmpeg -i "sample_recording.mp4" \
-vf "fps=10,scale=720:-1:flags=lanczos" \
-vcodec libwebp -lossless 0 -compression_level 6 \
-q:v 50 -loop 0 \
-preset picture -an -vsync 0 sample_recording.webp

#### Convert part of a video to animated WebP
ffmpeg -ss $INPUT_START_TIME -t $LENGTH -i $INPUT_FILENAME \
-vf "fps=$OUTPUT_FPS,scale=$OUTPUT_WIDTH:-1:flags=lanczos" \
-vcodec libwebp -lossless 0 -compression_level 6 \
-q:v $OUTPUT_QUALITY -loop $NUMER_OF_LOOPS \
-preset picture -an -vsync 0 $OUTPUT_FILENAME

# Change these placeholders:
# * $INPUT_START_TIME - number of seconds in the input video to start from.
# * $LENGTH - number of seconds to convert from the input video.
# * $INPUT_FILENAME - path to the input video.
# * $OUTPUT_FPS - ouput frames per second. Start with `10`.
# * $OUTPUT_WIDTH - output width in pixels. Aspect ratio is maintained.
# * $OUTPUT_QUALITY - quality of the WebP output. Start with `50`.
# * $NUMBER_OF_LOOPS - use `0` to loop forever, or a specific number of loops.
# * $OUTPUT_FILENAME - the name of the output animated WebP.

ffmpeg -ss 32.5 -t 7 -i "sample_recording.mp4" \
-vf "fps=10,scale=720:-1:flags=lanczos" \
-vcodec libwebp -lossless 0 -compression_level 6 \
-q:v 50 -loop 0 \
-preset picture -an -vsync 0 sample_recording.webp
```

## video player

## Directshow Filter

## Multimedia

* filters:libavfilter

## 流媒体协议技术

* 把采集阶段封包好的内容传输到服务器的过程。其实就是将现场的视频信号传到网络的过程.把本地音视频数据通过网络上传到云端/后台服务器，所谓“采集阶段封包好”
* 协议
  - RTMP （Real Time Messaging Protocol 实时消息传输协议）
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

# 发送H.264裸流至组播地址
# # -re一定要加，代表按照帧率发送，否则ffmpeg会一股脑地按最高的效率发送数据
# -vcodec copy要加，否则ffmpeg会重新编码输入的H.264裸流
ffmpeg -re -i chunwan.h264 -vcodec copy -f h264 udp://233.233.233.223:6666
# 播放承载H.264裸流的UDP
ffplay -f h264 udp://233.233.233.223:6666

# 发送MPEG2裸流至组播地址
ffmpeg -re -i chunwan.h264 -vcodec mpeg2video -f mpeg2video udp://233.233.233.223:6666
# 播放MPEG2裸流
ffplay -vcodec mpeg2video udp://233.233.233.223:6666

# “>test.sdp”用于将ffmpeg的输出信息存储下来形成一个sdp文件。该文件用于RTP的接收。当不加“>test.sdp”的时候，ffmpeg会直接把sdp信息输出到控制台。将该信息复制出来保存成一个后缀是.sdp文本文件，也是可以用来接收该RTP流的。加上“>test.sdp”后，可以直接把这些sdp信息保存成文本。
ffmpeg -re -i chunwan.h264 -vcodec copy -f rtp rtp://233.233.233.223:6666>test.sdp
ffplay test.sdp

ffmpeg -re -i chunwan.h264 -vcodec copy -f flv rtmp://localhost/oflaDemo/livestream
ffplay “rtmp://localhost/oflaDemo/livestream live=1”
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
