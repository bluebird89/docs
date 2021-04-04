# 统计学

## 概率论

### 概念

* 均值和方差来分别衡量这组数字的平均水平和差异程度
  - 均值：计算一组数据的平均数来衡量这组数据的平均水平
  - 方差：基于均值来衡量整体水平之间的差异
* 所有数据称之为总体。之前定义为整体的那部分数据称为这个总体下的一份样本
* 概率：样本的数据表现并不稳定，但是在多次试验的情况下，事件的某种情况发生的频率趋于稳定，结合极限的概念，我们给总体中事件出现的频率一个定义
* 分布：即事件所有可能的概率分布
* 抽样分布：由于得到样本的过程(抽样)是一个随机过程，那个样本的统计量也是一个变量，区别于总体的参数是一个定量；研究变量要看它的分布
* 0-1分布(伯努利分布)
  - 二项分布
  - 泊松分布
  - 指数分布
  - 正态分布|中心极限定理
* 伯努利提出大数定律：样本够大，频率趋近概率

* 朴素贝叶斯分类:即某一特定特征值独立于任何其它特征值
* 线性回归
  - 简单的线性回归就是获取一组数据点并绘制可用于预测未来的趋势线
  - 最小化模型的残差平方和
* 逻辑回归:将所有输入值映射为 0 和 1 之间的概率结果
* K-Means 聚类:一种无监督机器学习，用于对无标签数据（即没有定义的类别或分组）进行归类。该算法的工作原理是发掘出数据中的聚类簇，其中聚类簇的数量由 k 表示。然后进行迭代，根据特征将每个数据点分配给 k 个簇中的一个。K 均值聚类依赖贯穿于整个算法中的距离概念将数据点「分配」到不同的簇中。距离的概念是指两个给定项之间的空间大小。在数学中，描述集合中任意两个元素之间距离的函数称为距离函数或度量

## 正态分布|高斯分布

* 以天才卡尔·弗里德里希·高斯（Carl Friedrich Gauss）的名字命名的。
* 依赖数据集中参数
  - 平均值——样本中所有点的平均值。
  - 标准差——表示数据集与样本均值的偏离程度。
* 概率密度函数:连续随机变量取某些值的概率
  - 平均值是曲线的中心。这是曲线的最高点，因为大多数点都在平均值附近；
  - 曲线两侧点的数量是相等的。曲线中心的点数量最多；
  - 曲线下的面积是变量能取的所有值的概率和；
  - 因此曲线下面的总面积为 100%。

## 课程

* [Statistics for Applications](https://ocw.mit.edu/courses/mathematics/18-650-statistics-for-applications-fall-2016/index.htm)
* [An Introduction to Statistical Learning](http://faculty.marshall.usc.edu/gareth-james/ISL/)
* [STA 663: Computational Statistics and Statistical Computing](http://people.duke.edu/~ccc14/sta-663-2017/)

## 图书

* 统计学习方法 李航
  - [statistical-learning-method](https://github.com/wzyonggege/statistical-learning-method):《统计学习方法》笔记-基于Python算法实现
  + [代码实现](https://github.com/fengdu78/lihang-code)
  - [lihang_book_algorithm](https://github.com/WenDesi/lihang_book_algorithm):书中所有算法实现一遍
  + [讲课 PPT](https://github.com/fengdu78/lihang-code/tree/master/ppt)
  + [读书笔记](http://www.cnblogs.com/limitlessun/p/8611103.html): <https://github.com/SmirkCao/Lihang>
  + [参考笔记](https://zhuanlan.zhihu.com/p/36378498)
* 《赤裸裸的统计学》
* [The Little Handbook of Statistical Practice](http://www.jerrydallal.com/LHSP/LHSP.htm)
* 《[深入浅出统计学](https://www.amazon.cn/gp/product/B006PHIVNA)》
* 《[统计学习基础(第2版)(英文)](https://www.amazon.cn/gp/product/B00PRH2BXA) 》
* 《[概率论与数理统计](https://www.amazon.cn/gp/product/B00264GG56)》
* [看见统计](https://seeing-theory.brown.edu)

## 工具

* [pomegranate](https://github.com/jmschrei/pomegranate):Fast, flexible and easy to use probabilistic modelling in Python.<https://pomegranate.readthedocs.io/en/latest/>
* [Seeing Theory](https://seeing-theory.brown.edu/): A visual instroduction ot probability and statistics

## 参考

* [capital of statistics](http://cos.name/)：统计之都，国内首个旨在推广与应用统计学知识的社区专业型网站
