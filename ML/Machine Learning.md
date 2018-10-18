# Machine learning

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

## 资源

* [tensorflow/tensor2tensor](https://github.com/tensorflow/tensor2tensor)
* [josephmisiti/awesome-machine-learning](https://github.com/josephmisiti/awesome-machine-learning)A curated list of awesome Machine Learning frameworks, libraries and software.
* [scikit-learn/scikit-learn](https://github.com/scikit-learn/scikit-learn)scikit-learn: machine learning in Python <http://scikit-learn.org>
* [ZuzooVn/machine-learning-for-software-engineers](https://github.com/ZuzooVn/machine-learning-for-software-engineers):A complete daily plan for studying to become a machine learning engineer.
* [airbnb/aerosolve](https://github.com/airbnb/aerosolve):A machine learning package built for humans. http://airbnb.github.io/aerosolve/
* [scikit-learn/scikit-learn](https://github.com/scikit-learn/scikit-learn):scikit-learn: machine learning in Python http://scikit-learn.org
* [fchollet/keras](https://github.com/fchollet/keras):Deep Learning library for Python. Runs on TensorFlow, Theano, or CNTK. http://keras.io/

## 教程

* [learnml/machine-learning-specialization](https://github.com/learnml/machine-learning-specialization)
* [ICT-BDA/EasyML](https://github.com/ICT-BDA/EasyML):Easy Machine Learning is a general-purpose dataflow-based system for easing the process of applying machine learning algorithms to real world tasks.
* [kubeflow/kubeflow](https://github.com/kubeflow/kubeflow):Machine Learning Toolkit for Kubernetes
* [Avik-Jain/100-Days-Of-ML-Code](https://github.com/Avik-Jain/100-Days-Of-ML-Code):100 Days of ML Coding
* [llSourcell/Learn_Machine_Learning_in_3_Months](https://github.com/llSourcell/Learn_Machine_Learning_in_3_Months):This is the code for "Learn Machine Learning in 3 Months" by Siraj Raval on Youtube
* [机器学习（Machine Learning）- 吴恩达（Andrew Ng）](https://www.bilibili.com/video/av9912938)
    - [fengdu78/Coursera-ML-AndrewNg-Notes](https://github.com/fengdu78/Coursera-ML-AndrewNg-Notes):吴恩达老师的机器学习课程个人笔记
    - [fengdu78/deeplearning_ai_books](https://github.com/fengdu78/deeplearning_ai_books):deeplearning.ai（吴恩达老师的深度学习课程笔记及资源）
* [李宏毅Machine Learning ](https://www.bilibili.com/video/av15889450)
* [李宏毅机器学习(2017)](https://www.bilibili.com/video/av10590361/)
* [机器学习中的数学基础](https://www.bilibili.com/video/av15673238/)

## 工具

* [guess-js/guess](https://github.com/guess-js/guess):Libraries & tools for enabling Machine Learning driven user-experiences on the web
* [gorgonia/gorgonia](https://github.com/gorgonia/gorgonia):Gorgonia is a library that helps facilitate machine learning in Go.


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
