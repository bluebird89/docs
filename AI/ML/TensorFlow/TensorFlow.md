# [tensorflow/tensorflow](https://github.com/tensorflow/tensorflow)

An Open Source Machine Learning Framework for Everyone https://tensorflow.org

* TensorFlow 是采用数据流图(data flow graphs)、用于数值计算的开源软件库。这个软件库提供包括图像识别、语音识别等神经网络学习的数据基础架构，是专门为系统开发人员准备的深度学习开源工具。
只要开发者能够将计算表示为一个数据流图，就可以使用 Tensorflow。
* 相比竞争对手，TensorFlow 更注重拓展技术覆盖面，以更大的普适性抢占优势地位。TensorFlow 所使用的底层技术更加注重对不同技术的优化结合，目前在专业领域的深度学习项目都可以使用 TensorFlow 平台，规模在同类中可以达到最大。而且其灵活性也比其他的平台更好，即使是新的研发项目也可以轻易接入到 TensorFlow。
TensorFlow 还支持异构设备分布式计算，这意味着它能够在各个平台上运行模型，从电话、单个 CPU / GPU 到成百上千 GPU 卡组成的分布式系统，适用性和实用性非常强。

！[](../_static/TensorFlow.gif)

## 安装

```python
# 对于CPU
pip install tensorflow

# 对于启用CUDA的GPU卡
pip install tensorflow-gpu

docker run -it b.gcr.io/tensorflow/tensorflow

# OSX El Capitan: sudo pip install OSError: [Errno: 1] Operation not permitted:El Capitan引入了SIP机制(System Integrity Protection)，默认下系统启用SIP系统完整性保护机制，无论是对于硬盘还是运行时的进程限制对系统目录的写操作
# Go to home directory
virtualenv my-venv
source my-venv/bin/activate
pip install IPython
```

## 组件

* Tensorboard：帮助使用数据流图进行有效的数据可视化
* TensorFlow：用于快速部署新算法/试验

## 应用

* 基于文本的应用：语言检测、文本摘要
* 图像识别：图像字幕、人脸识别、目标检测
* 声音识别
* 时间序列分析
* 视频分析

## 问题
> ERROR: Cannot uninstall 'wrapt'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.

## 项目

* [guillaume-chevalier/LSTM-Human-Activity-Recognition](https://github.com/guillaume-chevalier/LSTM-Human-Activity-Recognition):Human Activity Recognition example using TensorFlow on smartphone sensors dataset and an LSTM RNN (Deep Learning algo). Classifying the type of movement amongst six activity categories - Guillaume Chevalier http://www.neuraxio.com/en/

## 课程

* [深度学习框架Tensorflow学习与应用](https://www.bilibili.com/video/av20542427)
* [sjchoi86/Tensorflow-101](https://github.com/sjchoi86/Tensorflow-101):TensorFlow Tutorials
* [Kyubyong/transformer](https://github.com/Kyubyong/transformer):A TensorFlow Implementation of the Transformer: Attention Is All You Need
* [aymericdamien/TensorFlow-Examples](https://github.com/aymericdamien/TensorFlow-Examples):TensorFlow Tutorial and Examples for Beginners with Latest APIs https://tensorflow.org
* [osforscience/TensorFlow-Course](https://github.com/osforscience/TensorFlow-Course):Simple and ready-to-use tutorials for TensorFlow
* [open-source-for-science/TensorFlow-Course](https://github.com/open-source-for-science/TensorFlow-Course):Simple and ready-to-use tutorials for TensorFlow
* [machinelearningmindset/TensorFlow-Course](https://github.com/machinelearningmindset/TensorFlow-Course):Simple and ready-to-use tutorials for TensorFlow
* [Hvass-Labs/TensorFlow-Tutorials](https://github.com/Hvass-Labs/TensorFlow-Tutorials):TensorFlow Tutorials with YouTube Videos

## 参考

* [TensorFlow 官方文档中文版](http://wiki.jikexueyuan.com/project/tensorflow-zh/)
* [vahidk/EffectiveTensorflow](https://github.com/vahidk/EffectiveTensorflow):TensorFlow tutorials and best practices. https://twitter.com/VahidK
* [xitu/tensorflow-docs](https://github.com/xitu/tensorflow-docs):TensorFlow 最新官方文档中文版 V1.10 https://tensorflow.juejin.im
* [apachecn/learning-tf-zh](https://github.com/apachecn/learning-tf-zh):📖 [译] TensorFlow 学习指南 https://legacy.gitbook.com/book/wizardforcel/learning-tf/details
* [tensorflow/tensor2tensor](https://github.com/tensorflow/tensor2tensor)：Library of deep learning models and datasets designed to make deep learning more accessible and accelerate ML research.
* [TensorFlow R1.2 中文文档](http://cwiki.apachecn.org/pages/viewpage.action?pageId=10030122)
* [MrGemy95/Tensorflow-Project-Template](https://github.com/MrGemy95/Tensorflow-Project-Template)：A best practice for tensorflow project template architecture.
* [fendouai/Awesome-TensorFlow-Chinese](https://github.com/fendouai/Awesome-TensorFlow-Chinese):Awesome-TensorFlow-Chinese，TensorFlow 中文资源精选，官方网站，安装教程，入门教程，视频教程，实战项目，学习路径。QQ群：167122861，微信群二维码：http://www.tensorflownews.com/ http://www.tensorflownews.com/
* [tensorflow/nmt](https://github.com/tensorflow/nmt):TensorFlow Neural Machine Translation Tutorial
* [nfmcclure/tensorflow_cookbook](https://github.com/nfmcclure/tensorflow_cookbook):Code for Tensorflow Machine Learning Cookbook
* [tutorials](https://tensorflow.google.cn/tutorials/): <https://github.com/czy36mengfei/tensorflow2_tutorials_chinese>
* [初始教程](https://www.datacamp.com/community/tutorials/tensorflow-tutorial)
* [tensorflow/models](https://github.com/tensorflow/models):Models and examples built with TensorFlow
* [TensorFlow 官方 YouTube 频道](https://www.youtube.com/channel/UC0rqucBdTuFTjJiefW5t-IQ)
* [博客](https://medium.com/tensorflow)
* [TensorFlow教程](https://www.tensorflow.org/tutorials)

## 工具

* [tensorflow/tfjs-models](https://github.com/tensorflow/tfjs-models):Pretrained models for TensorFlow.js https://js.tensorflow.org
* [TensorFlow Lite](link)
* [TensorFlow Hub](link)
* [](https://js.tensorflow.org/)
* [deepmind/graph_nets](https://github.com/deepmind/graph_nets):Build Graph Nets in Tensorflow https://arxiv.org/abs/1806.01261
