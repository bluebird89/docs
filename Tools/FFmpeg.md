# [FFmpeg/FFmpeg](https://github.com/FFmpeg/FFmpeg)

Mirror of git://source.ffmpeg.org/ffmpeg.git https://ffmpeg.org


## use

```sh
sudo apt -y install ffmpeg
sudo yum -y install ffmpeg

ffmpeg -h full

ffmpeg -i test.mp4 -r 1 -f image2 image-%5d.jpeg

ffprobe -show_format test.mp4
```


## reference

* [Documentation](https://ffmpeg.org/documentation.html)
