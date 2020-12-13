# 人工智能 Artificial Intelligence

* 在1956年的达特茅斯会议上被提出来，它研究的是如何制造智能机器或模拟人类的智能行为。大数据与人工智能之间可以说是相辅相成，人工智能的基础是数据，而数据的利用又离不开人工智能
* 领域方向
  - 模式识别
  - 机器学习
  - 机器翻译
  - 专家系统
  - 逻辑推理
  - 语音识别
  - 自然语言处理
  - 智能机器人
  - 计算机视觉与图像
  - 技术平台
  - 自动驾驶/辅助驾驶
  - 计算机/芯片和智能无人机
* 场景
  - 人脸识别
  - 视频及监控分析
  - 图片识别分析
  - 自动驾驶
  - 三维图像视觉
  - 工业视觉检测
  - 医疗影像诊断
  - 文字识别
  - 图像及视频编辑

## 本质

* 特征
* 可能性

## 深度学习

一种特殊的机器学习，它通过学习将世界表示为嵌套的概念层次结构来实现强大的功能和灵活性，每个概念都是根据更简单的概念进行定义的，而更抽象的表示则用不那么抽象的概念计算出来

* 确定那些特征与找出猫和狗最相关
* 以层次结构为基础，找到可以找到的特征的组合。例如，是否存在胡须，或是否存在耳朵等。
* 在对复杂概念进行连续层次识别之后，它决定通过哪个特征负责来找到答案。
* 卷积神经网络（CNN）、循环神经网络（RNN）、长短时记忆网络（LSTM）、Transformer

## 机器学习

据说计算机程序可以从经验E中学习某些类型的任务T和用来测量的P，如果它在T中的任务中的表现（由P测量）会随着经验E的提高而提高

* 减少预测值和实际值之间的差异
* 收集的数据点越多（经验），模型就越好。还可以通过添加更多变量（例如性别）并为它们创建不同的预测线来改进模型
* 应用机器学习的所有领域。这些包括：
  - 计算机视觉：适用于车牌识别和面部识别等应用。
  - 信息检索：适用于搜索引擎，文本搜索和图像搜索等应用程序。
  - 营销：用于自动化的电子邮件营销，目标识别等应用
  - 医疗诊断：用于癌症鉴定，异常检测等应用
  - 自然语言处理：用于情感分析，照片标记等应用
  - 在线广告等
* K-近邻分类算法（KNN）、朴素贝叶斯、决策树、支持向量机（SVM）、K-Means、TF-IDF
* 神经元结构:有多个输入端用于接受其它神经元的信息，经过「激活函数」的「整合」之后，输出给其它神经元
* 神经元的特征提取能力:选择阶跃函数作为激活函数，并加上合适的权值参数（，，），就可以实现上图的二分类
* 前向传播与反向传播
  - 前向传播，即信号由输入层进入模型，再经隐含层逐层传播，最终达到输出层的过程
  - 反向传播，指神经网络的训练过程中，根据实际输出与期望输出间的误差，反向逐层修正网络参数的过程。
* 模型的训练过程，就是确定模型参数的过程。反向传播为参数调整提供了科学的方法。通过计算模型参数如何对预测值产生影响，从而知道如何调整模型参数，来逼近真实值。可以把这个过程类比「带提示的暴力破解」
* 特征与误差关系后,往减少误差的方向调整 ，让模型训练往期望方向进行,涉及到学习速率
* 方法
  - 神经网络是特征提取的神器
  - 通常 CNN 的倒数第二层输出是图像的特征
  - 特征表示为张量，而张量理解为多维数组
  - 使用一些简单的算法（K-NN 或 SVM）可以实现自定义分类

## ML vs DL

* 数据依赖:数据很小时，因为深度学习算法需要大量数据才能完美理解它 表现不佳。另一方面，传统的机器学习算法及其手工制作的规则在这种情况下占据优势
* 硬件依赖:深度学习算法在很大程度上依赖于高端机器,本质上是做大量的矩阵乘法运算，而使用GPU可以有效的优化这些操作，而这就是使用GPU的目的
* 特征工程是将领域知识放入特征提取器的创建过程，用来降低数据的复杂性并使特征对于学习算法更加可见。
  - 机器学习中，大多数应用的特征需要由专家识别，然后根据领域和数据类型进行手动编码.机器学习算法的性能取决于特征识别和特征提取的准确程度。
  - 深度学习算法尝试从数据中学习高级特征。这是深度学习一个非常独特的部分，也是超越传统机器学习的重要部分。因此，深度学习减少了为每个问题开发新的特征提取器的任务。就像，卷积神经网络将尝试先学习底层特征，例如早期图层中的边缘和线条，然后是人脸的部分面部，最后是高级的面部识别。
* 可解释性
  - 用深度学习自动为论文打评分。它在打分方面的表现的非常出色，接近人类的表现。但有一个问题。它没有透露出为什么它给出了这个分数.以通过数学方法找出深层神经网络的哪些节点被激活，但我们不知道这些神经元是怎么建模的，以及这些神经元做了什么。所以我们无法解释结果。
* 趋势
  - 每个想要活下来的公司来说，在他们的业务中使用机器学习将变得越来越重要
  - 深度学习每天都在带来惊喜

## 算法分发

* 算法分发已经是包括搜索引擎、浏览器、资讯客户端甚至音乐软件在内的互联网产品的标配
* 电商销售根据销售数据，调整产品结构、规划购物录像
* 流量优化
  - 网络流量
  - 车流量
  - 地铁流量
* 控制论和人工智两者之间亲如手足。都是在1940年代后期的研讨会上构思出来的。两者的差异点在于，控制论学者倾向于使用微积分和矩阵代数作为工具，来解决适合这些工具的问题，比如由固定的连续变量集所描述的系统。而AI社群则没有这些限制，而是选择了逻辑推断与计算工具。这使他们能够处理语言、视觉和规划等问题。
* 理性行动的思想催生了理性代理（agent，源自拉丁语agere，意为做事），也称智能代理，例如可工作的计算机程序。当然，所有程序都能工作，但代理应该做得更多——包括能自主运行、持续运行、适应环境、做出改变、创造和追求目标。理性代理是能为实现最佳结果而采取行动的代理（此定义出自Russel和Norvig）

## 路径

* 数学
  - [线性代数](https://zhuanlan.zhihu.com/p/36311622)
    + 麻省理工的《线性代数及其应用》
    + [Linear Algebra and Learning from Data](http://math.mit.edu/~gs/learningfromdata/)
    + [MIT《线性代数（Linear Algebra）》](https://ocw.mit.edu/courses/mathematics/18-06-linear-algebra-spring-2010/)
  - [微积分和统计学](https://zhuanlan.zhihu.com/p/36584206)
    + 《普林斯顿微积分读本》
    + 入门教材: 深入浅出统计学
    + 进阶教材：商务与经济统计
    + 视频：[可汗学院统计学](http://open.163.com/special/Khan/khstatistics.html)
  - [概率论与数理统计](https://zhuanlan.zhihu.com/p/36584335)
    + 陈希孺院士的《概率论与数理统计》
    + [斯坦福《概率与统计（Probability and Statistics）》](https://online.stanford.edu/courses/gse-yprobstat-probability-and-statistics)
* python
  - 环境
    * [Anaconda](https://www.anaconda.com/download/)
    * [pycharm](https://www.jetbrains.com/)
    * [Anaconda+Jupyter notebook+Pycharm](https://zhuanlan.zhihu.com/p/59027692)
    * [Ubuntu18.04深度学习环境配置(CUDA9+CUDNN7.4+TensorFlow1.8)](https://zhuanlan.zhihu.com/p/50302396)
  - 入门
    + [廖雪峰python学习笔记](https://blog.csdn.net/datawhale/article/category/7779959)
    + [南京大学python视频教程](https://www.icourse163.org/course/0809NJU004-1001571005)
  - 补充
    + [代码规范](https://zhuanlan.zhihu.com/p/59763076)
    + [numpy练习题](https://zhuanlan.zhihu.com/p/57872490)
    + [pandas练习题](https://zhuanlan.zhihu.com/p/56644669)
* 数据分析/挖掘
  - 《利用python进行数据分析》
  - [特征工程](https://blog.csdn.net/Datawhale/article/details/83033869)
  - [数据挖掘项目](https://blog.csdn.net/datawhale/article/details/80847662)
* 机器学习
* 深度学习
* 强化学习
  - 公开课
    + Reinforcement Learning-David Silver
      * [视频地址](https://www.bilibili.com/video/av45357759?from=search&seid=9547815852611563503) <https://www.youtube.com/watch?v=2pWv7GOvuf0>
      * [课程PPT](http://www0.cs.ucl.ac.uk/staff/d.silver/web/Teaching.html)
      * [课程笔记](https://www.zhihu.com/people/qqiang00/posts)
    + 李宏毅《深度强化学习》
      * [视频地址](https://www.bilibili.com/video/av24724071)： <https://www.youtube.com/watch?v=2pWv7GOvuf0>
      * [课程PPT](http://speech.ee.ntu.edu.tw/~tlkagk/courses_MLDS18.html)
      * [课程笔记](https://blog.csdn.net/cindy_1102/article/details/87905272)
    + [强化学习入门课程（Introduction to Reinforcement Learning）](：https://www.youtube.com/watch?v=2pWv7GOvuf0&list=PLqYmG7hTraZDM-OYHWgPebj2MfCFzFObQ)
* 自然语言处理
* 计算机视觉
* 推荐系统
* 风控模型（评分卡模型）:在银行、互金等公司与借贷相关业务中最常见也是最重要的模型之一。简而言之它的作用就是对客户进行打分，来对客户是否优质进行评判。
  - 评分卡模型主要分为三大类
    + A卡（Application score card）申请评分卡
    + B卡（Behavior score card）行为评分卡
    + C卡（Collection score card）催收评分卡
    + 其中申请评分卡用于贷前，行为评分卡用于贷中，催收评分卡用于贷后，这三种评分卡在我们的信贷业务的整个生命周期都至关重要
  - 书籍
    + 《信用风险评分卡研究——基于SAS的开发与实施》
  - 评分卡模型建模过程
    + 样本选取：确定训练样本、测试样本的观察窗（特征的时间跨度）与表现窗（标签的时间跨度），且样本的标签定义是什么？一般情况下风险评分卡的标签都是考虑客户某一段时间内的延滞情况。
    + 特征准备：原始特征、衍生变量
    + 数据清洗：根据业务需求对缺失值或异常值等进行处理
    + 特征筛选：根据特征的IV值（特征对模型的贡献度）、PSI（特征的稳定性）来进行特征筛选，IV值越大越好（但是一个特征的IV值超过一定阈值可能要考虑是否用到未来数据），PSI越小越好（一般建模时取特征的PSI小于等于0.01）
    + 对特征进行WOE转换：即对特征进行分箱操作，注意在进行WOE转换时要注重特征的可解释性
    + 建立模型：在建立模型过程中可根据模型和变量的统计量判断模型中包含和不包含每个变量时的模型质量来进行变量的二次筛选。
    + 评分指标：评分卡模型一般关注的指标是KS值（衡量的是好坏样本累计分部之间的差值）、模型的PSI(即模型整体的稳定性）、AUC值等。
* 知识图谱：一种结构化数据的处理方法，它涉及知识的提取、表示、存储、检索等一系列技术。从渊源上讲，它是知识表示与推理、数据库、信息检索、自然语言处理等多种技术发展的融合。
  - 资料
    + [为什么需要知识图谱？什么是知识图谱？——KG的前世今生](https://zhuanlan.zhihu.com/p/31726910)
    + [什么是知识图谱？](<https://zhuanlan.zhihu.com/p/34393554>
    + [智能搜索时代：知识图谱有何价值？](https://zhuanlan.zhihu.com/p/35982177?)
    + [百度王海峰：知识图谱是 AI 的基石](http://www.infoq.com/cn/news/2017/11/Knowledge-map-cornerstone-AI#0-tsina-1-5001-397232819ff9a47a7b7e80a40613cfe1)
    + [译文|从知识抽取到RDF知识图谱可视化](http://rdc.hundsun.com/portal/article/907.html)
  - 内容
    + 知识提取：构建kg首先需要解决的是数据，知识提取是要解决结构化数据生成的问题。
      * 利用规则
        - 正则表达式（Regular Expression， regex）是字符串处 理的基本功。数据爬取、数据清洗、实体提取、关系提取，都离不开regex。
          + [pythex 在线测试正则表达式](<http://pythex.org/>）
          + [Python wrapper for Google's RE2 using Cython](https://pypi.python.org/pypi/re2/)
          + [Parsley ：更人性化的正则表达语法](http://parsley.readthedocs.io/en/latest/tutorial.html)
        - 中文分词和词性标注:分词也是后续所有处理的基础，词性（Part of Speech, POS）就是中学大家学过的动词、名词、形容词等等的词的分类。一般的分词工具都会有词性标注的选项
          + [jieba 中文分词包](https://github.com/fxsjy/jieba)
          + [中文词性标记集](https://github.com/memect/kg-beijing/wiki/)
          + [genius 采用 CRF条件随机场算法](https://github.com/duanhongyi/genius)
          + [Stanford CoreNLP分词](ttps://blog.csdn.net/guolindonggld/article/details/72795022)
        - 名实体识别:命名实体识别（NER）是信息提取应用领域的重要基础工具，一般来说，命名实体识别的任务就是识别出待处理文本中三大类（实体类、时间类和数字类）、七小类（人名、机构名、地名、时间、日期、货币和百分比）命名实体
          + [Stanford CoreNLP 进行中文命名实体识别](https://blog.csdn.net/guolindonggld/article/details/72795022)
      * 使用深度学习:使用自然语言处理的方法，一般是给定schema，从非结构化数据中抽取特定领域的三元组（spo）
        - 序列标注:使用序列生出模型，主要是标记出三元组中subject及object的起始位置，从而抽取信息。
          + [序列标注问题](https://www.cnblogs.com/jiangxinyang/p/9368482.html)
        - seq2seq:使用seq2seq端到端的模型，主要借鉴文本摘要的思想，将三元组看成是非结构化文本的摘要，从而进行抽取，其中还涉及Attention机制
          + [seq2seq详解](<https://blog.csdn.net/irving_zhang/article/details/78889364>
          + [详解从Seq2Seq模型到Attention模型](https://caicai.science/2018/10/06/attention%E6%80%BB%E8%A7%88/)
    + 知识表示（Knowledge Representation，KR，也译为知识表现）是研究如何将结构化数据组织，以便于机器处理和人的理解的方法
      * [json库](https://docs.python.org/2/library/json.html)
      * [PyYAML: 是Python里的Yaml处理库](http://pyyaml.org/wiki/PyYAML)
      * [RDF和OWL语义](http://blog.memect.cn/?p=871)
      * [JSON-LD](http://json-ld.org/)
    + 知识存储:需要熟悉常见的图数据库
      * 知识链接的方式：字符串、外键、URI
      * PostgreSQL及其JSON扩展:[Psycopg包操作PostgreSQL](http://initd.org/psycopg/docs/)
      * 图数据库 Neo4j和OrientDB
        - Neo4j的Python接口 <https://neo4j.com/developer/python/>
        - OrientDB：<http://orientdb.com/orientdb/>
        - RDF数据库Stardog [官网](http://stardog.com/)
    + 知识检索
      * [ElasticSearch教程](http://joelabrahamsson.com/elasticsearch-101/)
    + 术语
      * [本体](https://www.zhihu.com/question/19558514)
      * [RDF](https://www.w3.org/RDF/)
      * [Apache Jena](https://jena.apache.org/)
      * [D2RQ](http://d2rq.org/getting-started)
    + 路线
      * Protege构建本体系列
        - [protege](https://protege.stanford.edu/)
        - [protege使用](https://zhuanlan.zhihu.com/p/32389370)
      * 图数据库技术
        - Neo4j：<https://neo4j.com/>
        - AllegroGraph：<https://franz.com/agraph/allegrograph/>
      * 可视化技术
        - d3.js：<https://d3js.org/>
        - Cytoscape.js：<http://js.cytoscape.org/>
      * 分词技术
        - jieba：<https://github.com/fxsjy/jieba>
        - hanlp：<https://github.com/hankcs/HanLP>
    + 项目
      * [基于知识图谱的问答](https://github.com/kangzhun/KnowledgeGraph-QA-Service)
      * [Agriculture_KnowledgeGraph](https://github.com/qq547276542/Agriculture_KnowledgeGraph)
* Paper
  - [Arxiv Stats](https://arxiv.org/list/stat.ML/recent)
  - [Arxiv Sanity Preserver](http://www.arxiv-sanity.com/)
  - [Papers with Code(Browse state-of-the-art)](https://paperswithcode.com/sota):举两个例子
    + [CV](https://paperswithcode.com/area/computer-vision)
    + [NLP](https://paperswithcode.com/area/natural-language-processing)
  - [Papers with Code(Sorted by stars)](https://github.com/zziz/pwc)
  - [Deep Learning Papers 阅读路线](https://github.com/floodsung/Deep-Learning-Papers-Reading-Roadmap)
  - [Deep Learning Object Detection](https://github.com/hoya012/deep_learning_object_detection)
* 会议
  - 会议
    + [NeurIPS](https://nips.cc/)
    + [ICML](https://icml.cc/)
    + [ICLR](https://iclr.cc/)
    + [AAAI](https://aaai.org/Conferences/AAAI-19/)
    + [IJCAI](https://www.ijcai.org/)
    + [UAI](http://www.auai.org/uai2019/index.php)
  - 计算机视觉
    + [CVPR](http://cvpr2019.thecvf.com/)
    + [ECCV](https://eccv2018.org/program/main-conference/)
    + [ICCV](http://iccv2019.thecvf.com/)
  - 自然语言处理
    + [ACL](http://www.aclcargo.com/)
    + [EMNLP](https://www.aclweb.org/portal/content/emnlp-2018)
    + [NAACL](https://naacl2019.org/)
  - 知名期刊
    + [JAIR](https://www.jair.org/index.php/jair)
    + [JMLR](http://www.jmlr.org/)

## 课程

* [麻省理工学院公开课：人工智能](https://www.bilibili.com/video/av17963543)
* [AI For Everyone](https://www.coursera.org/learn/ai-for-everyone/)
* [CS 188 | Introduction to Artificial Intelligence Fall 2018](https://inst.eecs.berkeley.edu/~cs188/fa18/index.html)

## 图书

* 《人工智能极简编程入门（基于Python）》
* [paip-lisp](https://github.com/norvig/paip-lisp):Lisp code for the textbook "Paradigms of Artificial Intelligence Programming"

## 信息

* 5 月 18 日，北大、清华双双宣布了新专业。北大 2019 年正式启动机器人工程专业招生，清华大学成立人工智能学堂班，今年秋季开始招收本科生。
* 全球有 2.24 万 AI 方面的顶尖人才。其中约半数在美国（1 万 295 人），其次是中国（2525 人）占到 1 成。英国（1475 人）、德国（935 人）和加拿大（815 人）次之。AI 人才较多的欧美和中国近年来出台国家政策，培育了覆盖综合科学技术领域的人才。美国自 10 多年前开始，推行理科和数学教育的振兴政策，大幅增加了科技相关教师人数。

## 公司

* 依图
* 旷视科技
* 商汤科技:专注于安防监控、金融、手机、移动互联网和深度学习芯片五大领域;在核心技术上，主攻人脸识别、视频监控识别算法、增强现实、文字识别、自动驾驶识别算法和医疗影像识别算法几项技术。
* 寒武纪
* 阿里巴巴:软银持有28.8%股权，为最大股东；Altaba持股为14.8%，副董事长蔡崇信持股为2.3%。阿里巴巴管理层一共持股为9.5%
* 达观数据
* 竹间智能
  - 将继续在NLP、情感计算及多模态人机交互技术领域持续创新突破；同时，研发升级Bot Factory™平台，推广标准化产品、进行生态落地构建，加速AI解决方案跨行业落地。
* 盛大创新院
* 石头扫地机器人
* [地平线](https://horizon.ai/)
* 海康和大华是两家监控巨头，国内大部分公共领域监控、安检市场基本都是他们的，民用也有一部分，
* 依图、商汤、旷视以及云丛科技被称为视觉AI四小龙，外加一个科大讯飞，四小龙目前唯一赚钱渠道是给公共部门做监控过滤，人脸筛查，民用基本没有，盈利大部分来自战略基金补贴，但是远远撑不起烧钱速度。

## 资源

* [ailab](https://github.com/Microsoft/ailab):Experience, Learn and Code the latest breakthrough innovations with Microsoft AI
* [ai-edu](https://github.com/microsoft/ai-edu):AI education materials for Chinese students, teachers and IT professionals.
* [AiLearning](https://github.com/apachecn/AiLearning):AiLearning: 机器学习 - MachineLearning - ML、深度学习 - DeepLearning - DL、自然语言处理 NLP <http://ailearning.apachecn.org/>
* [awful-ai](https://github.com/daviddao/awful-ai):😈Awful AI is a curated list to track current scary usages of AI - hoping to raise awareness
* [statsmodels_doc_zh](https://github.com/apachecn/statsmodels_doc_zh):Statsmodels: Python中的统计建模与计量统计学类库
* [腾讯AI开发平台](https://ai.qq.com)
* [practicalAI](https://github.com/GokuMohandas/practicalAI):📚A practical approach to learning machine learning.
* [True_Artificial_Intelligence](https://github.com/makelove/True_Artificial_Intelligence):真AI人工智能
* [autodraw](https://www.autodraw.com/)

## 工具

* [Kalman-and-Bayesian-Filters-in-Python](https://github.com/rlabbe/Kalman-and-Bayesian-Filters-in-Python):Kalman Filter book using Jupyter Notebook. Focuses on building intuition and experience, not formal proofs. Includes Kalman filters,extended Kalman filters, unscented Kalman filters, particle filters, and more. All exercises include solutions.
* [fastText](https://github.com/facebookresearch/fastText):Library for fast text representation and classification.
* [byteps](https://github.com/bytedance/byteps):A high performance and general PS framework for distributed training
* [mindspore](https://github.com/mindspore-ai/mindspore):MindSpore is a new open source deep learning training/inference framework that could be used for mobile, edge and cloud scenarios. <https://www.mindspore.cn>

## 参考

* [OpenAI](https://openai.com) Discovering and enacting the path to safe artificial general intelligence.
* [AIDL-Series](https://github.com/wx-chevalier/AIDL-Series):📚 Series of Artificial Intelligence & Deep Learning, including Mathematics Fundamentals, Python Practices, NLP Application, etc. 💫 人工智能与深度学习实战，机器学习篇 | Tensoflow 篇
* [AI算法工程师手册](http://www.huaxiaozhuan.com)

* [](http://scikit-learn.org/stable/tutorial/machine_learning_map/index.html)
* [完备的 AI 学习路线，最详细的资源整理](https://mp.weixin.qq.com/s?__biz=MzIwODI2NDkxNQ==&mid=2247484347&amp;idx=1&amp;sn=a86919fadffed619bfe744dcef514923)
