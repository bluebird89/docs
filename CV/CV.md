# Computer Vision

看懂图片里的内容

* 人的大脑皮层， 有差不多 70% 都是在处理视觉信息.人类的视觉原理如下
    - 从原始信号摄入开始（瞳孔摄入像素 Pixels）
    - 做初步处理（大脑皮层某些细胞发现边缘和方向）
    - 抽象（大脑判定，眼前的物体的形状，是圆形的）
    - 进一步抽象（大脑进一步判定该物体是只气球）
* 机器的方法也是类似：构造多层的神经网络，较低层的识别初级的图像特征，若干底层特征组成更上一层特征，最终通过多个层级的组合，最终在顶层做出分类。

## 挑战

* 特征难以提取:同一只猫在不同的角度，不同的光线，不同的动作下。像素差异是非常大的。就算是同一张照片，旋转90度后，其像素差异也非常大！ 所以图片里的内容相似甚至相同，但是在像素层面，其变化会非常大
* 需要计算的数据量巨大: 手机上随便拍一张照片就是1000*2000像素的。每个像素 RGB 3个参数，一共有1000 X 2000 X 3=6,000,000。随便一张照片就要处理 600万 个参数，再算算现在越来越流行的 4K 视频
* CNN 属于深度学习的范畴，它很好的解决了上面所说的2大难点：
    - 可以有效的提取图像里的特征
    - 可以将海量的数据（不影响特征提取的前提下）进行有效的降维，大大减少了对算力的要求

## 任务

* 图像分类:人脸识别、图片鉴黄、相册根据人物自动分类
* 目标检测:给定一张图像或是一个视频帧，让计算机找出其中所有目标的位置，并给出每个目标的具体类别
* 语义分割:将整个图像分成像素组，然后对像素组进行标记和分类。语义分割试图在语义上理解图像中每个像素是什么,还必须确定每个物体的边界
* 实例分割:需要将这些不同的对象进行分类，而且还要确定对象的边界、差异和彼此之间的关系
* 视频分类:理解视频需要获得更多的上下文信息，不仅要理解每帧图像是什么、包含什么，还需要结合不同帧，知道上下文的关联信息
* 人体关键点检测:通过人体关键节点的组合和追踪来识别人的运动和行为，对于描述人体姿态，预测人体行为至关重要
* 场景文字识别:在图像背景复杂、分辨率低下、字体多样、分布随意等情况下，将图像信息转化为文字序列的过程
* 目标跟踪:在特定场景跟踪某一个或多个特定感兴趣对象的过程

## 过滤器

不同的卷积核将突出原始图像的不同特征属性

* Identity
* Laplacian
* Left Sobel
* Upper Sobel
* Blur

## 项目

* [deeppomf/DeepCreamPy](https://github.com/deeppomf/DeepCreamPy):Decensoring Hentai with Deep Neural Networks
* [thunil/TecoGAN](https://github.com/thunil/TecoGAN):This repo will contain source code and materials for the TecoGAN project, i.e. code for a TEmporally COherent GAN
* [vision](https://github.com/pytorch/vision) Datasets, Transforms and Models specific to Computer Vision

## 参考

* [opencv/opencv](https://github.com/opencv/opencv):Open Source Computer Vision Library http://opencv.org
* [jbhuang0604/awesome-computer-vision](https://github.com/jbhuang0604/awesome-computer-vision):A curated list of awesome computer vision resources
* [makelove/OpenCV-Python-Tutorial](https://github.com/makelove/OpenCV-Python-Tutorial)
* [muhsinali/opencv-book](https://github.com/muhsinali/opencv-book):Exercises and solutions from the Practical Python and OpenCV book
* [whydna/Deep-Learning-For-Computer-Vision](https://github.com/whydna/Deep-Learning-For-Computer-Vision):Exercises from https://www.pyimagesearch.com/deep-learning-computer-vision-python-book/
