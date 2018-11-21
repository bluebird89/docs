# Machine learning

研究计算机怎样模拟或实现人类的学习行为，以获取新的知识或技能，重新组织已有的知识结构使之不断改善自身的性能。它是人工智能的核心，是使计算机具有智能的根本途径，其应用遍及人工智能的各个领域，它主要使用归纳、综合而不是演译。在过去的十年中，机器学习帮助我们自动驾驶汽车，有效的语音识别，有效的网络搜索，并极大地提高了人类基因组的认识。机器学习是当今非常普遍，你可能会使用这一天几十倍而不自知。很多研究者也认为这是最好的人工智能的取得方式。在本课中，您将学习最有效的机器学习技术，并获得实践，让它们为自己的工作。更重要的是，你会不仅得到理论基础的学习，而且获得那些需要快速和强大的应用技术解决问题的实用技术。最后，你会学到一些硅谷利用机器学习和人工智能的最佳实践创新。

* 机器学习意味着：从数据中学习
* 主要关乎算法与数据，尤其是数据;:可以没有复杂的算法，但不能没有好的数据。
* 除非你有许多数据，否则你应该坚持使用简单的模型:基于数据识别模式，构建由参数定义的模型。如果你的参数定义过多，你很容易过度拟合。详细的解释需要更多数学知识，但是机器学习的原则是：尽可能使模型简单。
* 机器学习的性能受到输入数据质量限制:"无用输入，无用输出"巧妙地点明了机器学习的关键，机器学习只能发现输入数据中的模式。对于有监督的机器学习任务，例如分类，输入数据必须标记正确，特征明显。
* 机器学习需要具有代表性的数据:过去的表现不对未来结果作保证。机器学习则只能对与训练数据分布相同的样本外有良好效果。因此，应对训练数据和样本外数据的偏离表示警觉，经常性地重新训练你的模型以免失效。
* 机器学习中大部分的困难工作为数据转换:用于数据清洗和特征工程（将原始特征转化为更有代表性的特征）上。
* 深度学习将一些传统需要特征工程的工作自动化进行，特别是在图像和视频领域。但是深度学习并不是一种新技术，仍然需要在数据清理和转化方面付出巨大的努力。
* 机器学习系统极易受操作者误差影响:机器学习算法不会杀死人，只有人会杀死人。当机器学习算法系统奔溃时，一般很少是由于机器学习算法错误。而是因为大多数时候，你在训练数据中引进了人为误差，或者一些系统误差。所以，永远保持质疑。
* 机器学习可以漫不尽心地创造自我实现的预言:你今天做的决定将影响明天收集的训练数据。一旦机器学习系统中嵌入偏差，它就会生成更多新的数据强化这些偏差，有一些偏差会毁掉人的生活。负责任一点：不要创造可自我实现的预言。
* AI不会拥有自我意识，不用担心崛起并毁灭人类

## 理论

* 学习它们的模型函数、目标函数，从模型函数到目标函数的运算过程，各个函数相应的物理意义，最优化的方法
* 再与特征工程结合

## 问题

* 业务上要解决什么问题
* 该问题涉及到的信息管道有哪些
* 如何采集数据，数据源在哪
* 数据是完整的吗，数据刻度最小是多少
* 数据是定期发布的还是实时获取的
* 确定影响模型的有价值因素
* 工作量

## 数据

* 待收集的数据可能是表格数据、一串实时数据，N维矩阵或其他类型数据，同时也可能是多种存储介质，通过ETL处理将混合的数据源转成我们需要的格式，生成结构化数据类型。
- 对于收集的数据，可能存在缺陷，比如空值、异常值或数据产生器本身引起的偏差。这些缺陷可能导致模型效果不佳，同时为了优化更快收敛，需要做数据标准化处理，所以需要进行数据预处理。
    * 比如缺失值可以简单设为0、列平均值、中值、最高频率值、甚至是稳健算法和knn等等。
    * 比如标准化数据集，使数据集正态分布，平均值为0标准差为1。而且还达到了特征缩放效果。

## 模型定义

机器学习主要就是模型问题，我们通过机器学习来对现实进行抽象建模，以解决现实问题。所以机器学习主要工作就是使用哪种模型来建模，尽管各种大大小小模型一大堆，但大体上也有些套路。

* 回归问题：预测结果
* 分类问题：对数据进行分类
  * 监督学习：需要数据标记
  * 否则是非监督学习，使用聚类技术。
* 数据是否为连续的，是的话考虑序列模型，比如自回归和RNN之类的。
* 尽量使用简单模型，如果能用比如用单变量或多变量的线性回归或逻辑回归。
* 简单模型解决不了的情况，可通过多层神经网络解决，比如复杂的非线性。
* 使用了多少个维度的变量，将作用大的特征提取出来，并把不重要的特征去掉，比如用PCA降维。
* 不是监督也不是非监督？考虑强化学习

## 损失函数

损失函数用于衡量模型质量，它可以度量模型预测值与实际期望之间的差距，选择不合适的函数可能会影响模型的准确性，甚至影响收敛速度。

## 模型训练

* 迭代，表示模型计算和调整的一次过程；
* 批，数据集每次以一批为单位输入到模型中；
* epoch，每当整个数据集被处理完称为一个epoch。

## 数据分割

一般将整个数据集分成三组，比例是7:2:1

* 第一组为训练集，用于调整模型参数；
* 第二种为验证集，用于比较多个模型直接的表现；
* 第三组为测试集，用于测试训练得到的模型准确性。

## 模型效果

模型训练完后要看效果如何，要看看泛化的能力。

* 对于回归问题，可以通过下面几个指标来了解拟合效果。
  - 平均绝对误差
  - 中值绝对误差
  - 均方误差等等
* 对于分类问题，可以通过下面几个指标来了解分类效果。
  - 准确性
  - 精确率
  - 召回率
  - F值
  - 混淆矩阵
* 对于聚类问题，可以通过下面几个指标来了解聚类效果。
  - 轮廓系数
  - 同质性
  - 完整性
  - V度量

## 课程列表

* 机器学习的数学基础
    - 机器学习的数学基础
        + 函数与数据的泛化
        + 推理与归纳 (Deduction and Induction)
    - 线性代数（Linear Algebra）
        + 向量与矩阵 (Vector and Matrix)
        + 特征值与特征向量
        + 向量与高维空间
        + 特征向量（Feature Vector）
    - 概率与统计（Probability and Statistics）
        + 条件概率与经典问题 (Conditional Probability)
        + 边缘概率 (Marginal Probability)
    - 作业/实践： 财宝问题的概率计算程序
* 机器学习的数学基础
   - 统计推理（Statistical Inference）
        + 贝叶斯原理与推理 (Bayesian Theorem)
        + 极大似然估计 (Maximum Likelihood)
        + 主观概率（Subjective Probability）
        + 最大后延概率（MAP)
   - 随机变量（Random Variable）
        + 独立与相关 (Independence)
        + 均值与方差 （Mean and Variance）
        + 协方差 (Co-Variance)
   - 概率分布（Probability Distributions)
   - 中心极限定理（Central Limit Theorem)
   - 作业/实践： 概率分布采样与不同随机变量之间协方差计算
* 机器学习的数学基础
   - 梯度下降（Gradient Descent）
        + 导数与梯度（Derivative and Gradient）
        + 随机梯度下降（SGD）
        + 牛顿方法（Newton's Method)
   - 凸函数（Convex Function）
        + Jensen不等式（Jensen's Inequality）
        + 拉格朗日乘子（Lagrange Multiplier）
   - 作业/实践： 利用牛顿方法求解给定的方程
* 机器学习的哲学（Philosophy of ML）
   - 算法的科学（Science of Algorithms）
        + 输入与输出的神话（Mystery of I/O）
        + 奥卡姆剃刀（Occam’s Razor）
   - 维数的诅咒（Curse of Dimensionality）
        + 高维的几何特性 (Geometric Properity )
        + 高维空间流形（High-dimensional Manifold）
   - 机器学习与人工智能（Machine learning and AI）
   - 机器学习的范式（Paradigms of ML）
* 经典机器学习模型（Classical ML Models）
   - 样本学习（Case-Based Reasoning）
        + K-近邻（K-Nearest Neighbors）
        + K-近邻预测（KNN for Prediction）
        + 距离与测度（Distance and Metric）
   - 朴素贝叶斯（Naïve Bayes Classifier)
        + 条件独立（Conditional Independence）
        + 分类（Naive Bayes for Classification)
   - 作业/实践：垃圾邮件分类的案例
* 经典机器学习模型（Classical ML Models）
   - 决策树（Decision Tree Learning）
         + 信息论与概率
         + 信息熵（Information Entropy）
         + ID3
   - 预测树（CART）
         - Gini指标（Gini Index）
         - 决策树与规则（DT and Rule Learning）
   - 作业/实践：决策树分类实验
* 经典机器学习模型（Classical ML Models）
   - 集成学习（Ensemble learning）
        + Bagging and Boosting
        + AdaBoost
        + 误差分解（Bias-Variance Decomposition）
        + 随机森林（Boosting and Random Forest）
   + 模型评估（Model Evaluation）
        + 交叉验证（Cross-Validation）
        + ROC (Receiver Operating Characteristics)
        + Cost-Sensitive Learning
   - 作业/实践：随机森林与决策树分类实验的比较
* 线性模型（Linear Models）
   - 线性模型（Linear Models）
        + 线性拟合（Linear Regression）
   - 最小二乘法（LMS）
        + 线性分类器（Linear Classifier）
   - 感知器（Perceptron）
   - 对数几率回归（Logistic Regression）
   - 线性模型的概率解释 (Probabilistic Interpretation)
   - 作业/实践：对数几率回归的文本情感分析中应用
* 线性模型（Linear Models）
   - 线性判别分析 (Linear Discrimination Analysis)
   - 约束线性模型 (Linear Model with Regularization)
         + LASSO
         + Ridge Regression
   - 稀疏表示与字典学习
         + Sparse Representation & Coding
         + Dictionary Learning
* 核方法（Kernel Methods）
   - 支持向量机SVM（Support Vector Machines）
        + VC-维（VC-Dimension）
        + 最大间距（Maximum Margin）
        + 支撑向量（Support Vectors）
   - 作业/实践：SVM不同核函数在实际分类中比较
* 核方法（Kernel Methods）
   - 对偶拉格朗日乘子
   - KKT条件（KKT Conditions）
   - Support Vector Regression (SVR)
   - 核方法（Kernel Methods）
* 统计学习（Statistical Learning）
   - 判别模型与生成模型
        + 隐含变量（Latent Variable）
   - 混合模型（Mixture Model）
        + 三枚硬币问题（3-Coin Problem）
        + 高斯混合模型（Gaussian Mixture Model）
   - EM算法（Expectation Maximization）
        + 期望最大（Expectation Maximization）
        + 混合模型的EM算法（EM for Mixture Models）
        + Jensen 不等式 (Jensen's Inequality)
        + EM算法推导与性能 (EM Algorithm)
* 统计学习（Statistical Learning）
   - 隐马可夫模型（Hidden Markov Models）
        + 动态混合模型（Dynamic Mixture Model）
        + 维特比算法（Viterbi Algorithm）
        + 算法推导 (Algorithm)
   - 条件随机场（Conditional Random Field）
* 统计学习（Statistical Learning）
    - 层次图模型（Hierarchical Bayesian Model）
        + 概率图模型 (Graphical Model)
        + 从隐含语义模型到p-LSA (From LSA to P-LSA)
        + Dirichlet 分布与特点（Dirichlet Distribution）
        + 对偶分布（Conjugate Distribution）
* 统计学习（Statistical Learning）
    - 主题模型（Topic Model – LDA）
        + Latent Dirichlet Allocation
        + 文本分类（LDA for Text Classification）
   - 中文主题模型（Topic Modeling for Chinese）
   - 其他主题模型（Other Topic Variables）
* 无监督学习（Unsupervised Learning）
   - K-均值算法（K-Means）
        + 核密度估计（Kernel Density Estimation）
        + 层次聚类（Hierarchical Clustering）
   - 蒙特卡洛(Monte Carlo)
        + 蒙特卡洛树搜索（Monte Carol Tree Search）
        + MCMC（Markov Chain Monte Carlo）
        + Gibbs Sampling
* 流形学习（Manifold Learning）
   - 主成分分析（PCA）
        + PCA and ICA
   - 低维嵌入（Low-Dimensional Embedding）
        + 等度量映射（Isomap）
        + 局部线性嵌入（Locally Linear Embedding）
* 概念学习（Concept Learning）
   - 概念学习（Concept Learning）
        + 经典概念学习
        + One-Short概念学习
   - 高斯过程学习（Gaussian Process for ML）
        + Dirichlet Process
* 强化学习（Reinforcement Learning）
    - 奖赏与惩罚（Reward and Penalty）
        + 状态空间 (State-Space Model)
        + Q-学习算法 (Q-Learning)
   - 路径规划 （Path Planning）
   - 游戏人工智能 （Game AI）
   - 作业/实践：小鸟飞行游戏的自动学习算法
* 神经网络
   - 多层神经网络
        + 非线性映射（Nonlinear Mapping）
        + 反向传播（Back-propagation）
   - 自动编码器（Auto-Encoder）

## 资源

* [josephmisiti/awesome-machine-learning](https://github.com/josephmisiti/awesome-machine-learning)A curated list of awesome Machine Learning frameworks, libraries and software.
* [ZuzooVn/machine-learning-for-software-engineers](https://github.com/ZuzooVn/machine-learning-for-software-engineers):A complete daily plan for studying to become a machine learning engineer.
* [airbnb/aerosolve](https://github.com/airbnb/aerosolve):A machine learning package built for humans. http://airbnb.github.io/aerosolve/
* [ageron/handson-ml](https://github.com/ageron/handson-ml):A series of Jupyter notebooks that walk you through the fundamentals of Machine Learning and Deep Learning in python using Scikit-Learn and TensorFlow.
* [hangtwenty/dive-into-machine-learning](https://github.com/hangtwenty/dive-into-machine-learning):Dive into Machine Learning with Python Jupyter notebook and scikit-learn! http://hangtwenty.github.io/dive-into-machine-learning/
* [wizardforcel/nyu-mlif-notes](https://github.com/wizardforcel/nyu-mlif-notes):📖 NYU 金融机器学习 中文笔记
* [mlflow/mlflow](https://github.com/mlflow/mlflow):Open source platform for the machine learning lifecycle https://mlflow.org

## 教程

* [learnml/machine-learning-specialization](https://github.com/learnml/machine-learning-specialization)
* [ICT-BDA/EasyML](https://github.com/ICT-BDA/EasyML):Easy Machine Learning is a general-purpose dataflow-based system for easing the process of applying machine learning algorithms to real world tasks.
* [kubeflow/kubeflow](https://github.com/kubeflow/kubeflow):Machine Learning Toolkit for Kubernetes
* [Avik-Jain/100-Days-Of-ML-Code](https://github.com/Avik-Jain/100-Days-Of-ML-Code):100 Days of ML Coding
* [llSourcell/Learn_Machine_Learning_in_3_Months](https://github.com/llSourcell/Learn_Machine_Learning_in_3_Months):This is the code for "Learn Machine Learning in 3 Months" by Siraj Raval on Youtube
* [机器学习（Machine Learning）- 吴恩达（Andrew Ng）](https://www.bilibili.com/video/av9912938)
  - [斯坦福大学2014（吴恩达）机器学习教程中文笔记](https://www.coursera.org/course/ml)
  - [fengdu78/Coursera-ML-AndrewNg-Notes](https://github.com/fengdu78/Coursera-ML-AndrewNg-Notes):吴恩达老师的机器学习课程个人笔记
* [李宏毅Machine Learning ](https://www.bilibili.com/video/av15889450)
* [李宏毅机器学习(2017)](https://www.bilibili.com/video/av10590361/)
* [机器学习中的数学基础](https://www.bilibili.com/video/av15673238/)
* [afshinea/stanford-cs-229-machine-learning](https://github.com/afshinea/stanford-cs-229-machine-learning):VIP cheatsheets for Stanford's CS 229 Machine Learning

## 工具

* [guess-js/guess](https://github.com/guess-js/guess):Libraries & tools for enabling Machine Learning driven user-experiences on the web
* [gorgonia/gorgonia](https://github.com/gorgonia/gorgonia):Gorgonia is a library that helps facilitate machine learning in Go.
* [ray-project/ray](https://github.com/ray-project/ray):A system for parallel and distributed Python that unifies the ML ecosystem. https://ray.readthedocs.io/en/latest/
