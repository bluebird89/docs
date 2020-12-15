# Linear Algebra

* 线性代数的核心意义在于提供了⼀种看待世界的抽象视角：万事万物都可以被抽象成某些特征的组合，并在由预置规则定义的框架之下以静态和动态的方式加以观察。
* 集合的定义是由某些特定对象汇总而成的集体。集合中的元素通常会具有某些共性，因而可以用这些共性来表示
    - 集合的元素需要进行进一步的抽象——用数字或符号来表示。既可以是单个的数字或符号，也可以是多个数字或符号以某种方式排列形成的组合。
* 向量:如果多个标量 a1​,a2​,⋯,an​ 按一定顺序组成一个序列。n 维线性空间中的静止点；
* 将矩阵中的每个标量元素再替换为向量的话，得到的就是张量
* 用虚拟数字世界表示真实物理世界的工具。

## 范数

* 对单个向量大小的度量，描述的是向量自身的性质，其作用是将向量映射为一个非负的数值,Lp 范数
* L1 范数计算的是向量所有元素绝对值的和，L2 范数计算的是通常意义上的向量长度，L∞ 范数计算的则是向量中最大元素的取值。

## 内积

* 计算的则是两个向量之间的关系
* 能够表示两个向量之间的相对位置，即向量之间的夹角
* 如果有一个集合，它的元素都是具有相同维数的向量（可以是有限个或无限个）， 并且定义了加法和数乘等结构化的运算，这样的集合就被称为线性空间，定义了内积运算的线性空间则被称为内积空间
* 在内积空间中，一组两两正交的向量构成这个空间的正交基，假若正交基中基向量的 L2 范数都是单位长度 1，这组正交基就是标准正交基。正交基的作用就是给内积空间定义出经纬度
    - 描述内积空间的正交基并不唯一
    - 当作为参考系的标准正交基确定后，空间中的点就可以用向量表示
    - 当这个点从一个位置移动到另一个位置时，描述它的向量也会发生改变。点的变化对应着向量的线性变换，而描述对象变化抑或向量变换的数学语言，正是矩阵。

## 线性变换

* 矩阵作用就是对正交基进行变换 `Ax=y`
    - 表达式 Ax 就相当于对向量 x 做了一个环境声明，用于度量它的参考系是 A。如果想用其他的参考系做度量的话，就要重新声明。而对坐标系施加变换的方法，就是让表示原始坐标系的矩阵与表示变换的矩阵相乘。
* 描述矩阵的⼀对重要参数是特征值和特征向量。对于给定的矩阵 A，假设其特征值为λ，特征向量为 x，则它们之间的关系如下 `Ax=λx`
    - 矩阵特征值和特征向量的动态意义在于表示了变化的速度和方向。
    - 可对于有些特殊的向量，矩阵作用只有尺度变化而没有方向变化，也就是只有伸缩的效果而没有旋转的效果。对于给定的矩阵来说，这类特殊的向量就是矩阵的特征向量，特征向量的尺度变化系数就是特征值。
* 特征值分解: 求解给定矩阵的特征值和特征向量的过程
    - 前提：能够进行特征值分解的矩阵必须是 n 维方阵
    - 特征值分解算法推广到所有矩阵之上，就是更加通用的奇异值分解

## 课程

* [李宏毅(国语)线性代数课程](https://www.bilibili.com/video/av31780632/)
* [可汗学院：线性代数](https://www.bilibili.com/video/av9504432): <http://open.163.com/special/Khan/linearalgebra.html>
* [apachecn/math](https://github.com/apachecn/math):MIT-18.06-线性代数-完整笔记
* [fastai-num-linalg-v2-zh](https://github.com/apachecn/fastai-num-linalg-v2-zh):📖 [译] fast.ai 数值线性代数讲义 v2
* [Linear Algebra 麻省理工公开课：线性代数](https://ocw.mit.edu/courses/mathematics/18-06-linear-algebra-spring-2010/):Introduction to Linear Algebra (3rd Ed.) by Gilbert Strang <http://open.163.com/special/opencourse/daishu.html>
* [3Blue1Brown: Essence of linear algebra 线性代数的本质](https://www.bilibili.com/video/av5987715/)  <https://www.bilibili.com/video/av6540378/>
* [Immersive Linear Algebra](http://immersivemath.com/ila/index.html)
* [Matrix Algebra for Engineers](http://coursegraph.com/coursera-matrix-algebra-engineers)
* [Mathematics for Machine Learning: Linear Algebra](http://coursegraph.com/coursera-linear-algebra-machine-learning)
* [Gilbert Strang 教授 MIT公开课：数据分析、信号处理和机器学习中的矩阵方法 Matrix Methods in Data Analysis, Signal Processing, and Machine Learning](https://ocw.mit.edu/courses/mathematics/18-065-matrix-methods-in-data-analysis-signal-processing-and-machine-learning-spring-2018/)
  - [A 2020 Vision of Linear Algebra](https://ocw.mit.edu/resources/res-18-010-a-2020-vision-of-linear-algebra-spring-2020/index.htm)
  - [课程官方视频](https://www.youtube.com/playlist?list=PLUl4u3cNGP63oMNUHXqIUcrkS2PivhN3k)
  - [爱可可老师B站搬运链接](https://www.bilibili.com/video/av53055190/)

## 图书

* 《Schaum's Outlines: Linear Algebra》
* 《No Bullshit Guide to Linear Algebra》
  - 把线性代数内容分成三个部分，计算线性代数、几何线性代数和理论线性代数。作者在开篇就写道，线性代数这门学科，用一句话就可以说完，那就是：Linear  functions transform linear combinations of their inputs into the same  linear combination of their outputs. That’s it, that’s all!
* 《Linear Algebra Problem Book》

## 参考

* [Introduction to Linear Algebra for Applied Machine Learning with Python](https://pabloinsente.github.io/intro-linear-algebra)
