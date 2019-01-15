# [FFmpeg/FFmpeg](https://github.com/FFmpeg/FFmpeg)

Mirror of git://source.ffmpeg.org/ffmpeg.git  Fast Forward Moving Pictures Experts Group https://ffmpeg.org

## use

* video player
* Directshow Filter
* 转码工具

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
* 同时FFmpeg编译之后包含libavcodec、libavformat、libavdevice、libavfilter、libavutil、libpostproc、libswresample、libswscale

## use

* -hide_banner hide ffmpeg compilation information
* -ss  seek for that second to start its processing, so it will extract frames from that moment. (00:00:07.000 is the second 7 from the video in this case)
* -vframes the number of frames to extract (1 in this case). FFMPEG will extract only one image and it will use thumb.jpg as output file. You might notice that in this case we are not using a pattern like "%04d" as we are extracting only one frame.
* -vf
    * "fps=1" so ffmpeg will filter the video and extract one image (1 frame per second) for the output;
    * fps=1/5 extract one image every 5 seconds
    * -vsync vfr: This is a parameter that tells the filter to use a variable bitrate video synchronization. If we do not use this parameter ffmpeg will fail to find only the keyframes and shoud extract other frames that can be not processed correctly.
* -s 480x300: frame size of image to output (image resized to fit dimensions)
* -f image2: forces format
* -b:v 64k  video bitrate of the output file to 64 kbit/s
* -r 24 frame rate of the output file to 24 fps

```sh
sudo apt|yum -y install ffmpeg

ffmpeg -h full

ffmpeg.exe [global options] [input file options] -i input_file [output file options] output_files

ffmpeg -i test.mp4 -r 1 -f image2 image-%5d.jpeg
ffmpeg -ss 0.5 -i inputfile.mp4 -t 1 -s 480x300 -f image2 imagefile.jpg
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
ffmpeg -ss 00:00:15 -t 00:00:05 -i input.mp4 -vcodec copy -acodec copy output.mp4 # -ss表示开始切割的时间，-t表示要切多少。上面就是从15秒开始，切5秒钟出来。
```

## Tool

* [PHP-FFMpeg/PHP-FFMpeg](https://github.com/PHP-FFmpeg/PHP-FFmpeg/): An object oriented PHP driver for FFMpeg binary
    - API
    - test

## reference

* [Documentation](https://ffmpeg.org/documentation.html)
* [FFMPEG视音频编解码零基础学习方法](https://blog.csdn.net/leixiaohua1020/article/details/15811977)

