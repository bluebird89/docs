# [tensorflow](https://github.com/tensorflow/tensorflow)

An Open Source Machine Learning Framework for Everyone https://tensorflow.org

* 采用数据流图(data flow graphs)、用于数值计算的开源软件库。这个软件库提供包括图像识别、语音识别等神经网络学习的数据基础架构，是专门为系统开发人员准备的深度学习开源工具
* 相比竞争对手，TensorFlow 更注重拓展技术覆盖面，以更大的普适性抢占优势地位。TensorFlow 所使用的底层技术更加注重对不同技术的优化结合，目前在专业领域的深度学习项目都可以使用 TensorFlow 平台，规模在同类中可以达到最大。而且其灵活性也比其他的平台更好，即使是新的研发项目也可以轻易接入到 TensorFlow。
* 还支持异构设备分布式计算，意味着能够在各个平台上运行模型，从电话、单个 CPU / GPU 到成百上千 GPU 卡组成的分布式系统，适用性和实用性非常强

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

mkdir my_tensorflow
cd my_tensorflow

#  creates a directory named venv, that contains a copy of the Python binary, the Pip package manager, the standard Python library, and other supporting files
# second venv is the name of the virtual environment
python3 -m venv venv
# the virtual environment’s bin directory will be added at the beginning of the system $PATH variable. Also, the shell’s prompt will change, and it will show the name of the virtual environment you’re currently in. In this example, that is (venv)
source venv/bin/activate
pip install --upgrade pip
pip install --upgrade tensorflow

python -c 'import tensorflow as tf; print(tf.__version__)'

deactivate
```

## 组件

* [Tensorboard](https://github.com/tensorflow/tensorboard)：TensorFlow's Visualization Toolkit 帮助使用数据流图进行有效的数据可视化
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

* [LSTM-Human-Activity-Recognition](https://github.com/guillaume-chevalier/LSTM-Human-Activity-Recognition):Human Activity Recognition example using TensorFlow on smartphone sensors dataset and an LSTM RNN (Deep Learning algo). Classifying the type of movement amongst six activity categories - Guillaume Chevalier http://www.neuraxio.com/en/

## 课程

* [深度学习框架Tensorflow学习与应用](https://www.bilibili.com/video/av20542427)
* [Tensorflow-101](https://github.com/sjchoi86/Tensorflow-101):TensorFlow Tutorials
    - [tensorflow-101](https://github.com/DjangoPeng/tensorflow-101):《TensorFlow 快速入门与实战》和《TensorFlow 2 项目进阶实战》课程代码与课件
* [transformer](https://github.com/Kyubyong/transformer):A TensorFlow Implementation of the Transformer: Attention Is All You Need
* [TensorFlow-Examples](https://github.com/aymericdamien/TensorFlow-Examples):TensorFlow Tutorial and Examples for Beginners with Latest APIs https://tensorflow.org
* [TensorFlow-Course](https://github.com/instillai/TensorFlow-Course):Simple and ready-to-use tutorials for TensorFlow
* [TensorFlow-Tutorials](https://github.com/Hvass-Labs/TensorFlow-Tutorials):TensorFlow Tutorials with YouTube Videos
* [nmt](https://github.com/tensorflow/nmt):TensorFlow Neural Machine Translation Tutorial
* [tutorials](https://tensorflow.google.cn/tutorials/): <https://github.com/czy36mengfei/tensorflow2_tutorials_chinese>
* [TensorFlow教程](https://www.tensorflow.org/tutorials)
* [TensorFlow for Deep Learning Research](http://web.stanford.edu/class/cs20si/)
* [初始教程](https://www.datacamp.com/community/tutorials/tensorflow-tutorial)

## 图书

* [tensorflow_cookbook](https://github.com/nfmcclure/tensorflow_cookbook):Code for Tensorflow Machine Learning Cookbook
* 《TensorFlow 技术解析与实战》  李嘉璇
* TensorFlow：实战Google深度学习框架
* 深入理解Tensor Flow：架构

## 工具

* [tfjs-models](https://github.com/tensorflow/tfjs-models):Pretrained models for TensorFlow.js https://js.tensorflow.org
* [TensorFlow Lite](link)
* [TensorFlow Hub](link)
* [](https://js.tensorflow.org/)
* [graph_nets](https://github.com/deepmind/graph_nets):Build Graph Nets in Tensorflow https://arxiv.org/abs/1806.01261

## 参考

* [TensorFlow 官方文档中文版](http://wiki.jikexueyuan.com/project/tensorflow-zh/)
* [EffectiveTensorflow](https://github.com/vahidk/EffectiveTensorflow):TensorFlow tutorials and best practices. https://twitter.com/VahidK
* [tensorflow-docs](https://github.com/xitu/tensorflow-docs):TensorFlow 最新官方文档中文版 V1.10 https://tensorflow.juejin.im
* [learning-tf-zh](https://github.com/apachecn/learning-tf-zh):📖 [译] TensorFlow 学习指南 https://legacy.gitbook.com/book/wizardforcel/learning-tf/details
* [tensor2tensor](https://github.com/tensorflow/tensor2tensor)：Library of deep learning models and datasets designed to make deep learning more accessible and accelerate ML research.
* [Tensorflow-Project-Template](https://github.com/MrGemy95/Tensorflow-Project-Template)：A best practice for tensorflow project template architecture.
* [Awesome-TensorFlow-Chinese](https://github.com/fendouai/Awesome-TensorFlow-Chinese):Awesome-TensorFlow-Chinese，TensorFlow 中文资源精选，官方网站，安装教程，入门教程，视频教程，实战项目，学习路径。QQ群：167122861，微信群二维码：http://www.tensorflownews.com/ http://www.tensorflownews.com/
* [models](https://github.com/tensorflow/models):Models and examples built with TensorFlow
* [TensorFlow 官方 YouTube 频道](https://www.youtube.com/channel/UC0rqucBdTuFTjJiefW5t-IQ)
* [简单粗暴 TensorFlow 2 | A Concise Handbook of TensorFlow 2](https://tf.wiki/index.html)
