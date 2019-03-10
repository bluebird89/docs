# Image

每一个像素都会代表着一个单独的色块
百万像素（MP）代指单位面积内的像素数量在以百万为单位时的表达
使用规格超出自身实际需求的照片并不能提升输出图像的呈现质量。
图像的压缩处理是一种减小文件尺寸（这种尺寸指的是譬如“MB”这样的储存规格，而非图片的分辨率），同时提供与原图像尽量相似的输出图片的处理手段。
JPEG 是当下最流行的图像压缩格式。它使用从 0 到 100 之间取值的参数来代表自身的压缩质量层级——100 代表最低规格的图片压缩处理，0 则意味着最高的压缩处理规格。
如果图片的用途是网站或者其它的面向公众展示的地方，你应该对图片进行一定的压缩处理（通常为原图的 70 到 90 之间就能达到很好的平衡）
无论你是出于何种目的，图片的 DPI（Dots Per Inch，图像每英寸的像素点数）都不是值得你去关注的问题
DPI 是一种将图像的面积和理论打印尺寸进行关联的文件属性。除非你打算把这些图片打印出来，否则 DPI 就没有那么重要。
如果你的图片宽度为 3000 像素，而你打算把它打印在一张 10 英寸宽的画布上，这张图片的最大可印刷 dpi 就是 300dpi。如果这张图片要被打印在一张 100 英寸宽的画布，它的最大可印刷 dpi 则为 30dpi。
把一张 3MP 的图片缩放到 8MP 的规格并不能提升它的图像质量。同理，把一张压缩到 80 压缩规格的照片重新压缩到 100 的规格也无法让这张图片再度溯回。

## 格式

* WebP：出于减少数据量、加速网络传输的目的而开发的。这是Google旧款VP8编码(已在2010五月开源)的衍生分支，在质量等同于JPEG的情况下压缩文件尺寸。Edge、Firefox。Google声称从PNG格式转换至WebP格式后文件尺寸能够减少28%至45%，其中压缩比例具体取决于原始PNG格

## 工具

* [IMageMagick](https://imagemagick.cn/)
    - convert:转换图像格式，调整图像大小、模糊、裁剪、去斑、抖动、绘图、翻转、加入、重新采样等等
    - mogrify：批量缩放大小
* [nagadomi/waifu2x](https://github.com/nagadomi/waifu2x):Image Super-Resolution for Anime-Style Art
* [photoprism/photoprism](https://github.com/photoprism/photoprism):Personal photo management powered by Go and Google TensorFlow https://photoprism.org/
* [google/filament](https://github.com/google/filament):Filament is a real-time physically based rendering engine for Android, Windows, Linux, macOS and WASM/WebGL
* [Gimp](https://www.gimp.org)
* [muukii/Pixel](https://github.com/muukii/Pixel):🎨🖼 An image editor and engine using CoreImage
* [GoogleChromeLabs/squoosh](https://github.com/GoogleChromeLabs/squoosh):Make images smaller using best-in-class codecs, right in the browser. https://squoosh.app
* [fengyuanchen/compressorjs](https://github.com/fengyuanchen/compressorjs):JavaScript image compressor.
* 看图
    - FastStone Image Viewer
* 截图
    - Snipaste
* [libvips/libvips](https://github.com/libvips/libvips):A fast image processing library with low memory needs. https://libvips.github.io/libvips/
* [AlloyImage](https://github.com/AlloyTeam/AlloyImage)基于HTML5技术的专业图像处理库
* [DmitryUlyanov/deep-image-prior](https://github.com/DmitryUlyanov/deep-image-prior):Image restoration with neural networks but without learning. https://dmitryulyanov.github.io/deep_image_prior
* [esimov/caire](https://github.com/esimov/caire):Content aware image resize library
* [jantic/DeOldify](https://github.com/jantic/DeOldify):A Deep Learning based project for colorizing and restoring old images
* [hackerb9/lsix](https://github.com/hackerb9/lsix):Like "ls", but for images. Shows thumbnails in terminal using sixel graphics. 
* [nagadomi/waifu2x](https://github.com/nagadomi/waifu2x):Image Super-Resolution for Anime-Style Art

## 资源

* [unsplash](https://unsplash.com/):Photos for everyone
*   [天空之城](https://www.skypixel.com/):一个专注于航拍影像的网站
*   [1x](https://1x.com/):摄影网站，作品质量极高。
*   [LFI](http://lfi-online.de/ceemes/en/gallery/):徕卡旗下的作品廊
*   [500px](https://500px.com/popular)
*   [Pixelmator](http://www.pixelmator.com):图像处理软件
*   [GIPHY](https://giphy.com/):寻找动图好去处。
