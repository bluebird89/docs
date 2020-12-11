# 深度学习

只会机器学习肯定不行  肯定要会深度学习

## 分类

* 计算机视觉(Computer Vision)
  - [magenta](link):探索机器学习在艺术、音乐创作中的作用的研究项目
  - [Mask-RCNN](link)
* 自然语言处理(Natural Language Processing)
  - [WaveNet](link)
  - [Sentence Classification with CNN](link): Convolutional Neural Networks for Sentence Classification
* 生成模型(Generative Models)
  - [DCGAN-tensorflow](link):Deep Convolutional Generative Adversarial Networks
  - [Image-to-Image Translation with Conditional Adversarial Networks](link)
* 强化学习（Reinforcement Learing）
  * [Deep Reinforcement Learning for Keras](link)
  * [DQN-tensorflow](link)
* 无监督学习(Unsupervised Learning)
  - [MUSE: Multilingual Unsupervised and Supervised Embeddings](link)
  - [Domain Transfer Network (DTN)](link)

## 环境配置

* 硬件配置： 超微塔式服务器
  - 显卡 NVIDIA TITAN Xp *4
  - 内存 128G
  - CPU 2620V4* 2
  - 电源 1600w *2
  - 硬盘 256G*2+2T*2
* 使用U盘进行Ubuntu操作系统的安装
  - 一开始安装选择"Install Ubuntu"回车后过一会儿屏幕如果显示“输入不支持”，这和Ubuntu对显卡的支持有关，在安装主界面的F6，选择nomodeset，就可以进入下一步安装了
* 安装ssh `sudo apt-get install openssh-server`

```sh
# 安装NVIDIA TITAN Xp显卡驱动 默认安装的显卡驱动不是英伟达的驱动，所以先把旧得驱动删除掉
sudo apt-get purge nvidia*

# 添加Graphic Drivers PPA
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update

# 查看合适的驱动版本：
ubuntu-drivers devices
sudo apt-get install nvidia-driver-430
sudo reboot
nvidia-smi # 看看生效的显卡驱动

# 安装依赖库
sudo apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev libxi-devli

# GCC降低版本:CUDA9.0要求GCC版本是5.x或者6.x，其他版本不可以
sudo apt-get install gcc-5
sudo apt-get install g++-5

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 50
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 50

# 安装Anaconda和tensorflow、keras和pytorch: 让conda自动安装cuda和cudnn
bash Anaconda3-2019.03-Linux-x86_64.sh
# 更改pip和conda为国内的源
mkdir ~/.pip

cat > ~/.pip/pip.conf << EOF
[global]
trusted-host=mirrors.aliyun.com
index-url=https://mirrors.aliyun.com/pypi/simple/
EOF

# 在Anaconda中安装Python3.7的虚拟环境 创建一个Python的虚拟环境
conda create --name tf python=3.7 #创建tf环境
source activate tf #激活tf环境
source deactivate tf #退出tf环境
conda remove --name tf --all #删除tf环境（全部删除）

# 在Anaconda中安装TensorFlow GPU 1.9
conda install tensorflow-gpu==1.9

# 测试安装正确性
source activate tf
python

import tensorflowas tf
hello= tf.constant('Hello, TensorFlow!')
sess= tf.Session()
print(sess.run(hello))

# 安装Keras
conda install pytorch torchvision -c pytorch
import torch
print(torch.cuda.is_available())
```

## 课程


- 吴恩达《Deep Learning》
  + [网易云课堂](https://mooc.study.163.com/university/deeplearning_ai#/c)
  + [Coursera](https://www.coursera.org/specializations/deep-learning)
  + [课程笔记](https://github.com/fengdu78/deeplearning_ai_books/tree/master/%E5%8F%82%E8%80%83%E8%AE%BA%E6%96%87)
  + [课程PPT及课后作业](https://github.com/stormstone/deeplearning.ai)
- Fast.ai《程序员深度学习实战》
  + (视频地址B站地址(英文字幕))[https://www.bilibili.com/video/av18904696]
  + [CSDN地址(2017版中文字幕)](https://edu.csdn.net/course/detail/5192)
  + [课程笔记](https://medium.com/@hiromi_suenaga/deep-learning-2-part-1-lesson-1-602f73869197): <https://github.com/apachecn/fastai-ml-dl-notes-zh>
- CS230 Deep Learning
  + [秋季CS230视频列表](https://www.bilibili.com/video/av47055599)
  + [春季CS230课程大纲](http://cs230.stanford.edu/syllabus/)
  + [Cheetsheet](https://stanford.edu/~shervine/teaching/cs-230.html)
- [全栈深度学习训练营（Full Stack Deep Learning Bootcamp）](https://fullstackdeeplearning.com/march2019)
- [用于视觉识别的卷积神经网络（Convolutional Neural Networks for Visual Recognition）](https://www.youtube.com/playlist?list=PLzUTmXVwsnXod6WNdg57Yc3zFx_f-RYsq)
- [程序员深度学习实战（Practical Deep Learning for Coders）](https://course.fast.ai/)

* [深度学习](https://mooc.study.163.com/university/deeplearning_ai#/c)
  - [deeplearning_ai_books](https://github.com/fengdu78/deeplearning_ai_books):deeplearning.ai（吴恩达老师的深度学习课程笔记及资源）
  - [Deep Learning Specialization](http://www.deeplearning.ai)
  - [coursera](https://www.coursera.org/specializations/deep-learning)
          * [Deep-Learning-Coursera](https://github.com/enggen/Deep-Learning-Coursera):Deep Learning Specialization by Andrew Ng, deeplearning.ai.
  - [神经网络和深度学习](https://mooc.study.163.com/)
* [深度学习（小象学院）](https://www.bilibili.com/video/av10324235)
* [李宏毅深度学习(2017)](https://www.bilibili.com/video/av9770302/)
* [斯坦福2017季CS224n深度学习自然语言处理课程](https://www.bilibili.com/video/av13383754)
* [斯坦福深度学习课程CS231N](https://www.bilibili.com/video/av17204303)
* [深度学习与计算机视觉](https://www.bilibili.com/video/av17741845)
* [Andrew Ng (吴恩达) 深度学习专项课程](http://coursegraph.com/coursera-specializations-deep-learning)
* [fastai-ml-dl-notes-zh](https://github.com/apachecn/fastai-ml-dl-notes-zh):📖 [译] fast.ai 机器学习和深度学习中文笔记
* [PaddlePaddle/book](https://github.com/PaddlePaddle/book):Deep Learning 101 with PaddlePaddle （深度学习框架入门教程）
* [d2l-zh](https://github.com/d2l-ai/d2l-zh):《动手学深度学习》，英文版即伯克利深度学习（STAT 157，2019春）教材。面向中文读者、能运行、可讨论。 <https://zh.d2l.ai>
* [introtodeeplearning_labs](https://github.com/aamini/introtodeeplearning_labs/):Lab Materials for MIT 6.S191: Introduction to Deep Learning  <https://youtu.be/5v1JnYv_yWs?list=PLtBw6njQRU-rwp5__7C0oIVt26ZgjG9NI>
* [神经网络与深度学习](https://nndl.github.io/):复旦邱锡鹏 《神经网络与深度学习》
  - 图书：<https://nndl.github.io/nndl-book.pdf>
  - 示例代码：<https://github.com/nndl/nndl-codes>
  - 课程练习：<https://github.com/nndl/exercise>
* [Deep Learning from the Foundations](https://www.fast.ai/2019/06/28/course-p2v3/)
* [rainbow-is-all-you-need](https://github.com/Curt-Park/rainbow-is-all-you-need):Rainbow is all you need! Step-by-step tutorials from DQN to Rainbow
* [](https://www.cs.toronto.edu/~hinton/)
* [TensorFlow, Keras and deep learning, without a PhD access_time](https://codelabs.developers.google.com/codelabs/cloud-tensorflow-mnist/#3)
* [Practical Deep Learning for Coders](https://course.fast.ai/)
  - [Deep Learning for Coders with Fastai and PyTorch: AI Applications Without a PhD](link)
  - [fastbook](https://github.com/fastai/fastbook):The fastai book, published as Jupyter Notebooks

## 图书

- 神经网络与深度学习 - 复旦邱锡鹏
  + [GitHub地址](https://nndl.github.io/)
  + [全书 pdf](https://nndl.github.io/nndl-book.pdf)
  + [示例代码](https://github.com/nndl/nndl-codes)
  + [课程练习](https://github.com/nndl/exercise)
- [《深度学习》Deep Learning](https://github.com/exacity/deeplearningbook-chinese):花书
- [《深度学习 500 问》](https://github.com/scutan90/DeepLearning-500-questions)
- 《深度学习实战》 [美] 杜威·奥辛格（DouweOsinga）
* 《机器学习实战》 Peter Harrington
* 《Python深度学习（Keras）》
* 《深度学习入门：基于Python的理论与实现》
* [因果推理](https://www.hsph.harvard.edu/miguel-hernan/causal-inference-book/)
* [Grokking Deep Learning](https://livebook.manning.com/#!/book/grokking-deep-learning/about-this-book/)
* [Deep Learning](http://www.deeplearningbook.org/)
* 《深度学习的数学》
* Deep Learning with Python
  - [deep-learning-with-python-notebooks](https://github.com/fchollet/deep-learning-with-python-notebooks):Jupyter notebooks for the code samples of the book "Deep Learning with Python"
* Dive into Deep Learning
  - [](https://github.com/ShusenTang/Dive-into-DL-PyTorch)

## 实例

* [nsfw_data_scrapper](https://github.com/alexkimxyz/nsfw_data_scrapper):Collection of scripts to aggregate image data for the purposes of training an NSFW Image Classifier

## 工具

* [dl-docker](https://github.com/floydhub/dl-docker):An all-in-one Docker image for deep learning. Contains all the popular DL frameworks (TensorFlow, Theano, Torch, Caffe, etc.) <https://www.floydhub.com>
* [faceswap](https://github.com/deepfakes/faceswap):Non official project based on original /r/Deepfakes thread. Many thanks to him! <https://www.reddit.com/r/deepfakes/>
* [mace](https://github.com/XiaoMi/mace):MACE is a deep learning inference framework optimized for mobile heterogeneous computing platforms
* [autokeras](https://github.com/jhfjhfj1/autokeras):accessible AutoML for deep learning. <http://autokeras.com/>
* [openface](https://github.com/cmusatyalab/openface):Face recognition with deep neural networks. <http://cmusatyalab.github.io/openface/>
* [PaddlePaddle](https://github.com/PaddlePaddle):百度自主研发、集深度学习训练和预测框架、模型库、工具组件、服务平台等为一体的开源深度学习平台 <http://paddlepaddle.org/>
* [deepo](https://github.com/ufoym/deepo):Set up deep learning environment in a single command line. <http://ufoym.com/deepo>
* [TensorFlow 官方文档](https://www.tensorflow.org/api_docs/python/tf): <https://github.com/jikexueyuanwiki/tensorflow-zh>
* [PyTorch官方文档](https://pytorch.org/docs/stable/index.html) <https://github.com/apachecn/pytorch-doc-zh>

## 参考

* [x-deeplearning](https://github.com/alibaba/x-deeplearning):An industrial deep learning framework for high-dimension sparse data
* [Model Zoo](https://modelzoo.co/):Discover open source deep learning code and pretrained models.
* [deep-learning-ai](https://www.nvidia.com/en-us/deep-learning-ai/developer/)
* [char-rnn](https://github.com/karpathy/char-rnn):Multi-layer Recurrent Neural Networks (LSTM, GRU, RNN) for character-level language models in Torch
* [scutan90/DeepLearning-500-questions](https://github.com/scutan90/DeepLearning-500-questions):深度学习500问，以问答形式对常用的概率知识、线性代数、机器学习、深度学习、计算机视觉等热点问题进行阐述
* [DeepLearning.ai-Summary](https://github.com/mbadry1/DeepLearning.ai-Summary):This repository contains my personal notes and summaries on DeepLearning.ai specialization courses. I've enjoyed every little bit of the course hope you enjoy my notes too.
* [Awesome-Deep-Learning-Resources](https://github.com/guillaume-chevalier/Awesome-Deep-Learning-Resources):Rough list of my favorite deep learning resources, useful for revisiting topics or for reference. I have got through all of the content listed there, carefully. - Guillaume Chevalier <http://www.neuraxio.com/en/>
* [MMdnn](https://github.com/Microsoft/MMdnn):MMdnn is a set of tools to help users inter-operate among different deep learning frameworks. E.g. model conversion and visualization. Convert models between Caffe, Keras, MXNet, Tensorflow, CNTK, PyTorch Onnx and CoreML.
* [nndl](https://github.com/nndl/nndl.github.io):《神经网络与深度学习》 Neural Network and Deep Learning <https://nndl.github.io>
* [deep-learning-ocean](https://github.com/osforscience/deep-learning-ocean):📡 All You Need to Know About Deep Learning - A kick-starter
* [The Matrix Calculus You Need For Deep Learning](https://explained.ai/matrix-calculus/index.html)
* [HyperDL-Tutorial](https://github.com/zeusees/HyperDL-Tutorial):深度学习教程整理 | 干货 <http://www.zeusee.com>
