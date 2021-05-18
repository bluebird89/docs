# Computer Vision CV

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

## OCR Optical Character Recognition 光学字符识别

* 2021年1月， 微信发布了微信8.0， 这次更新支持图片文字提取的功能
* 用于识别图像中的文字，常见的有卡证识别、票据识别和通用识别等
* 优化通用识别算法，达到效果和效率的平衡？通用OCR的识别能力是业务使用的主要能力，我们希望通用OCR识别的效果尽可能好，能涵盖大部分用户的拍摄场景需求，同时落地业务也需要考虑成本。
* 解决方案
  - 快速文字判定模块用于快速判断图像中是否存在文字，如果存在文字，弹出提取文字入口。
    + 图片的种类复杂多类，存在商品、人物、风景、汽车等各种可能性，其中大部分图片可能没有文字，希望只处理有文字的图片，过滤无文字图片。
    + 可以用于移动端部署的快速多语种文本分类检测网络，判断不同区域的文本所属的语种类别，可以计算得到图像中是否存在文字以及文字语种以及所占面积等
    + 采用超轻量级的CNN网络，在移动端平均耗时约80ms，具有较高的检测召回和分类精度，能够快速过滤不必要的图像。
  - 文本图像分类模块用于判断文本图像的类别，是垂类文本场景还是通用文本场景等，根据类别选择不同的识别路线。垂类文本识别包括证件识别、表格识别等，可以调用相关的API进行识别，我们也会根据线上用户数据分析用户需求，不断扩展新的垂类文本识别能力。
    + 存在复杂多样的问题，比如证件类图像、手写体图像、表格图像等等，OCR识别有大量的垂类场景，依靠单一的识别模型识别能力可能不足，准确率不够好。因此我们希望能判断文本图像的类型，根据不同类别选择不同的识别模型。
    + 采用多标签分类来适应复杂图像场景。目前文本图像类别分为证件票据和文档两大类别
  - 通用文本识别
    + 文本检测用于定位文字区域
      * 常用的基于深度学习的文本检测方法一般可以分为基于回归的、基于分割的两大类，当然还有一些将两者进行结合的方法。
      * 基于回归的方法
        - 采用box回归的方法主要有CTPN、Textbox系列和EAST，这类算法对规则形状文本检测效果较好，但无法准确检测不规则形状文本，对过长文本效果也不太好。
        - 像素值回归的方法主要有CRAFT和SA-Text，这类算法能够检测弯曲文本且对小文本效果优秀但是实时性能不够。
      * 基于分割的算法，如PSENet，这类算法不受文本形状的限制，对各种形状的文本都能取得较好的效果，但是后处理通常比较复杂，耗时较多。采用了基于实例分割的DBNet算法，DBNet将二值化进行近似，使其可导，融入训练，从而获取更准确的边界，大大降低了后处理的耗时。此外，DB使用轻量级网络也有很好的表现，且长文本不易切断。
        - 基于速度和性能的平衡的考虑，backbone我们选择了轻量级网络mobilenetv3，并对模型的header做了一些裁剪，使得模型大小减少、预测速度提升，但性能轻微下降。针对小文本、超长图像检测和一些特殊场景图像检测，我们也做了一些相应的优化。
        - 此外为了适应多方向的文本图像，我们在检测模型上加入了方向判定分支，支持判断文本框的文本方向。
        - 在模型训练上，我们采用了模型蒸馏的方法，先训练resnet50模型作为teacher模型，然后加入mobilenetv3模型作为student模型联合训练，最终的性能相对不蒸馏的模型能提升1个点。
        - 在模型部署上，采用TensorRT部署，线上T4机型平均耗时小于30ms。
    + 文本识别用于识别文本行的内容
      * 需要大量的数据进行训练，特别是中文字符数较多，存在生僻字等，训练数据获取困难。使用数据合成工具来合成大量训练数据。
        - TextRender 合成文本行识别数据；利用图像处理的方法来合成数据，对已有语料或字符表字符随机组合，结合模糊、倾斜、透视变换和加背景等方法，生成接近真实场景中的文字图片，生成字符的数量、字体、大小和风格可控，速度快，是我们主要采用的合成方法。
        - StyleText 合成文本行识别数据。采用模型风格迁移的方法，针对实际场景真实数据严重不足，TextRender无法合成文字风格（字体、颜色、间距、背景）的问题的补充，利用少许目标场景图像就可以批量合成大量与目标场景风格相近的文本图像。我们主要利用其补充badcase的数据。
    + 文本识别算法
      * 主流的是基于深度学习的端到端的文字识别，将其转化为序列学习问题，两大主流技术是CRNN OCR 和Attention OCR。
        - CRNN OCR借鉴了语音识别思想，引入LSTM + CTC 的建模方式解决不定长序列对齐问题。
        - Attention OCR借鉴了机器翻译中的Encoder-Decoder模型，并加入了注意力(Attention)机制来帮助特征对齐。
        - 近年来还出现了一些新的方法，如ACE方法，采用统计时间维度上各字符的数量进行监督的方法来进行文本识别，也取得了不错的效果。
        - 在模型设计上，我们采用了结合上面3种方法的多任务文本识别模型。在训练时，以CTC为主，Attention Decoder和ACE辅助训练。在预测时，考虑到速度和性能，只采用CTC进行解码预测。多任务可以提高模型的泛化性，同时如果对预测时间要求不高，多结果也可以提供更多的选择和对比。
      * 在模型训练上，我们采用了多种文本图像增强的方法来提升模型的泛化性和鲁棒性，特别是为了对弯曲扭曲变形文本有更好的识别效果，我们采用了在线文本distort变换，识别准确率提升1-2个点。
      * 针对生僻字和形似字问题，我们对CTC loss进行优化，加入了focal loss 和center loss辅助训练，在形似字测试集上能提升2-3个点。
  - 版面分析模块将识别出来的文本按易于阅读的方式进行排版展示
    + 文本识别出来的结果是孤立的文本行内容，展示给用户一行行的文字，不符合用户的阅读习惯，用户后续对比和使用时也会存在困难。希望能对识别出来的文本行进行合并排版，以用户易于阅读的方式展示。
    + 用于分析哪些文本行属于同一段落，合并文本行，哪些区域是表格等目前有基于深度学习分割的方法和基于规则的方法。
    
## [face_recognition](https://github.com/ageitgey/face_recognition)

The world's simplest facial recognition api for Python and the command line

* [face-api.js](https://github.com/justadudewhohacks/face-api.js):JavaScript API for face detection and face recognition in the browser with tensorflow.js
* [insightface](https://github.com/deepinsight/insightface):Face Recognition Project on MXNet

## 项目

* [DeepCreamPy](https://github.com/deeppomf/DeepCreamPy):Decensoring Hentai with Deep Neural Networks
* [TecoGAN](https://github.com/thunil/TecoGAN):This repo will contain source code and materials for the TecoGAN project, i.e. code for a TEmporally COherent GAN
* [vision](https://github.com/pytorch/vision) Datasets, Transforms and Models specific to Computer Vision

## 课程

+ [李飞飞：CS231n: Convolutional Neural Networks for Visual Recognition](http://cs231n.stanford.edu)
  * [中文](https://study.163.com/course/introduction/1003223001.htm)
  * <https://github.com/mbadry1/CS231n-2017-Summary>
    - [cs231n.github.io](https://github.com/cs231n/cs231n.github.io):Public facing notes page

## 图书

+ 入门学习：《Computer Vision：Models, Learning and Inference》
+ 经典权威的参考资料：《Computer Vision：Algorithms and Applications》
+ 理论实践：《OpenCV3编程入门》

## 参考

* [awesome-computer-vision](https://github.com/jbhuang0604/awesome-computer-vision):A curated list of awesome computer vision resources
* [awesome-deep-vision](https://github.com/kjw0612/awesome-deep-vision)A curated list of deep learning resources for computer vision
* [Deep-Learning-For-Computer-Vision](https://github.com/whydna/Deep-Learning-For-Computer-Vision):Exercises from <https://www.pyimagesearch.com/deep-learning-computer-vision-python-book/>
