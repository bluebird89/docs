# NLP Natural Language Processing

研究计算机处理人类语言的一门技术，目的是弥补人类交流（自然语言）和计算机理解（机器语言）之间的差距

包含句法语义分析、信息抽取、文本挖掘、机器翻译、信息检索、问答系统和对话系统等领域

## 图书

* [基于深度学习的自然语言处理]()
* 信息检索导论 Introduction to Information Retrieval
* 统计自然语言处理（第2版）
* Neural Network Methods for Natural Language Processing Yoav Goldberg
* 知识图谱 赵军
+ Python自然语言处理
+ 自然语言处理综论 Daniel Jurafsky和James H. Martin
+ 统计自然语言处理基础 Chris Manning和HinrichSchütze

## 课程

* [斯坦福CS224n深度学习与自然语言处理](http://web.stanford.edu/class/cs224n/)
  + [17版中文字幕](https://www.bilibili.com/video/av41393758/?p=1)
  + [课程笔记](http://www.hankcs.com/?s=CS224n%E7%AC%94%E8%AE%B0)
  + [2019版课程主页](http://web.stanford.edu/class/cs224n/)
  + [项目地址](https://github.com/DSKSD/DeepNLP-models-Pytorch)
  + [cs224n-winter17-notes](https://github.com/stanfordnlp/cs224n-winter17-notes):Course notes for CS224N Winter17
  - [CoreNLP](https://github.com/stanfordnlp/CoreNLP):Stanford CoreNLP: A Java suite of core NLP tools. <http://stanfordnlp.github.io/CoreNLP/>
  + [PPT](http://web.stanford.edu/class/cs224n/syllabus.html)
  + 视频
    * [youtube](https://www.youtube.com/watch?v=OQQ-W_63UgQ&list=PL3FW7Lu3i5Jsnh1rnUwq_TcylNr7EkRe6)
    - [云盘资源](https://blog.csdn.net/NeighborhoodGuo/article/details/46868143)
  - [CS224N 2019](http://web.stanford.edu/class/cs224n/)
    + 目前仅提供 2017 年春季课程：<https://www.youtube.com/playlist?list=PL3FW7Lu3i5Jsnh1rnUwq_TcylNr7EkRe6>
    + <https://www.youtube.com/playlist?list=PLoROMvodv4rOhcuXMZkNm7j3fVwBBY42z>
    + <https://www.bilibili.com/video/av46216519/>
  - [NLU公开课CS224U](http://web.stanford.edu/class/cs224u/)
    + 代码地址：<https://github.com/cgpotts/cs224u/>
    + 视频地址：<https://www.youtube.com/playlist?list=PLoROMvodv4rObpMCir6rNNUlFAn56Js20>
    + B 站视频地址：<https://www.bilibili.com/video/av56067156/>
- 自然语言处理 - Dan Jurafsky 和 Chris Manning
  * [B站英文字幕版](https://www.bilibili.com/video/av35805262/)
  * [学术激流网](http://academictorrents.com/details/d2c8f8f1651740520b7dfab23438d89bc8c0c0ab)
+ [深度学习自然语言处理（Natural Language Processing with Deep Learning）](https://www.youtube.com/playlist?list=PLU40WL8Ol94IJzQtileLTqGZuXtGlLMP_)
* [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/)
* [CS 11-747](http://phontron.com/class/nn4nlp2019/)
  - <https://www.youtube.com/playlist?list=PL8PYTP1V4I8Ajj7sY6sdtmjgkt7eo2VMs>
  - <https://www.bilibili.com/video/av40929856/>
* [StarSpace](https://github.com/facebookresearch/StarSpace):Learning embeddings for classification, retrieval and ranking.
* [gt-nlp-class](https://github.com/jacobeisenstein/gt-nlp-class):Course materials for Georgia Tech CS 4650 and 7650, "Natural Language"
* [nlp_course](https://github.com/yandexdataschool/nlp_course):YSDA course in Natural Language Processing
* [nlp-beginner](https://github.com/FudanNLP/nlp-beginner):复旦NLP实验室NLP上手教程 <https://nndl.github.io/>
* [nlp-tutorial](https://github.com/lyeoni/nlp-tutorial)
* [nlp-tutorial](https://github.com/graykode/nlp-tutorial):Natural Language Processing Tutorial for Deep Learning Researchers <https://www.reddit.com/r/MachineLearning/comments/amfinl/project_nlptutoral_repository_who_is_studying/>

```sh
git clone https://github.com/DSKSD/cs-224n-Pytorch.git

# 准备数据集
cd script
chmod u+x prepare_dataset.sh
./prepare_dataset.sh

# docker env
docker pull dsksd/deepstudy:0.2
pip3 install docker-compose
cd script
docker-compose up -d
```

## 工具

* [pytext](https://github.com/facebookresearch/pytext):A natural language modeling framework based on PyTorch <https://fb.me/pytextdocs>
* [funNLP](https://github.com/fighting41love/funNLP):文本中抽取结构化信息 <https://zhuanlan.zhihu.com/yangyangfuture>
* [snownlp](https://github.com/isnowfy/snownlp):Python library for processing Chinese text
* [textlint](https://github.com/textlint/textlint):The pluggable natural language linter for text and markdown. <https://textlint.github.io/>
* [transformers](https://github.com/huggingface/transformers):🤗 Transformers: State-of-the-art Natural Language Processing for TensorFlow 2.0 and PyTorch. <https://huggingface.co/transformers>
* [HanLP](https://github.com/hankcs/HanLP):中文分词 词性标注 命名实体识别 依存句法分析 语义依存分析 新词发现 关键词短语提取 自动摘要 文本分类聚类 拼音简繁转换 自然语言处理 <https://hanlp.hankcs.com/>
* [中文NLP相关](https://github.com/crownpku/Awesome-Chinese-NLP)
* [NLTK](http://www.nltk.org/)
* [TextBlob](http://textblob.readthedocs.org/en/dev/)
* [Gensim](http://radimrehurek.com/gensim/)
* [Pattern](http://www.clips.ua.ac.be/pattern)
* [Spacy](http://spacy.io)
* [Orange](http://orange.biolab.si/features/)
* [Pineapple](https://github.com/proycon/pynlpl)

## 参考

* [nlp-journey](https://github.com/msgi/nlp-journey):nlp相关的一些论文及代码, 包括LDA主题模型、词向量(Word Embedding)、命名实体识别(NER)、文本分类(Text Classificatin)、文本生成、文本相似性(Text Similarity)计算等，基于keras和tensorflow
* [NLP-progress](https://github.com/sebastianruder/NLP-progress):Repository to track the progress in Natural Language Processing (NLP), including the datasets and the current state-of-the-art for the most common NLP tasks.
* [nlp-architect](https://github.com/NervanaSystems/nlp-architect):NLP Architect by Intel AI Lab: Python library for exploring the state-of-the-art deep learning topologies and techniques for natural language processing and natural language understanding <http://nlp_architect.nervanasys.com/>
* [decaNLP](https://github.com/salesforce/decaNLP):The Natural Language Decathlon: A Multitask Challenge for NLP
* [InferSent](https://github.com/facebookresearch/InferSent):Sentence embeddings (InferSent) and training code for NLI.
* [spaCy](https://github.com/explosion/spaCy):💫 Industrial-strength Natural Language Processing (NLP) with Python and Cython <https://spacy.io>
* [awesome-sentence-embedding](https://github.com/Separius/awesome-sentence-embedding):A curated list of pretrained sentence(and word) embedding models
* [Awesome-Chinese-NLP](https://github.com/crownpku/Awesome-Chinese-NLP):A curated list of resources for Chinese NLP 中文自然语言处理相关资料
* [Understanding LSTM Networks](http://colah.github.io/posts/2015-08-Understanding-LSTMs/)
* [我爱自然语言处理](http://www.52nlp.cn/)
* [](https://github.com/facebookresearch/fastText)
* 博客
  * [我爱自然语言处理](http://www.52nlp.cn/)
  * [语言日志博客（Mark Liberman）](http://languagelog.ldc.upenn.edu/nll/)
  * [natural language processing blog](https://nlpers.blogspot.com/)
+ 项目
  - [基于LSTM的中文问答系统](https://github.com/S-H-Y-GitHub/QA)
  - [基于RNN的文本生成器](https://github.com/karpathy/char-rnn)
  - [基于char-rnn的汪峰歌词生成器](https://github.com/phunterlau/wangfeng-rnn)
  - [用RNN生成手写数字](https://github.com/skaae/lasagne-draw)
* 论文
    + [100 Must-Read NLP Papers](https://github.com/mhagiwara/100-nlp-papers)
