# 算法

逻辑和数学能力，用更少的代码和资源实现更复杂的逻辑；

* Dijkstra算法
* 算法是设计出来服务于这个协议的

## 方法

* 算法设计，算法分析，算法实践
* 教材：算法导论 数论
* 当习题做，自己实现最重要

## 概念

* 时间复杂度
* 空间复杂度

## 应用

用算法来挖掘出数据的价值。没有数据你就没有核心价值。当有了数据作为基础，你要继续需要思考如何让数据变的有价值

* 图像识别领域，深度学习算法异军突起，不仅可以进行准确的人脸识别、指纹识别，还可以进行复杂的图像对比。我深刻记得，2016年参加的光谷人工智能大会上，听西安电子科技大学公茂果教授分享的“深度神经网络稀疏特征学习与空时影像变化检测”主题，利用图像识别技术，对比汶川地震前后的卫星照片和光感照片，准确地找到了受到地震影响最严重的区域，即震前和震后地貌发生变化最大的区域，快速地为救援队定位到最需要帮助的地点，解救伤者，投放救援物资。
* 自动驾驶领域，可以通过识别路面的状况来实现自动驾驶、自动停车。Uber无人驾驶汽车已经在匹兹堡上路测试，自动驾驶汽车配备了各式传感器，包括雷达、激光扫描仪以及高分辨率摄像头，以便绘制周边环境的细节。自动驾驶汽车有望改善人类的生活质量，也可挽救数百万人的性命，为人们提供更多的出行方便。5年前，我在听Andrew Ng的斯坦福大学机器学习公开课的时候，就被当时的自动驾驶视频介绍所震撼，科幻电影中的世界就快变成现实了。
* 用户行为分析，人类有各种各样的行为和需求。衣食住行，吃喝玩乐，都是人的最基本的行为。大多数人的行为是共性的，商家可以收集这些行为数据，通过数据挖掘算法来找到人们行为共性的规律。根据用户的购物行为，商家可以为用户推荐喜欢的商品，这样就有了推荐系统； 根据用户对信息的查询行为，可以发现用户对信息的需求，这样就有了搜索引擎；根据用户位置的变化，可以发现用户的出行需求，这样就有了地图应用；针对用户个性化的行为，可以给用户打上标签，用来标注用户的特征或身份，这样就有了用户画像。用户行为分析，让商家了解用户习惯，同时也让用户了解自己，有巨大的商业价值。
* 金融征信领域，传统信贷业务都是银行核心业务，但由于中国人数众多且小客户居多，银行无法负担为小客户服务的高成本，导致民间信贷的兴起。2014年底互联网金融P2P的开始爆发，贷款需求被满足的同时，却暴露出了违约风险。征信体系缺失，导致很多P2P公司坏账率很高，到2016年底P2P跑路的多达数千家。征信需求，变得非常迫切。比如，某个人想买车但现金不够，这时就需要进行贷款。商家给用户进行贷款时，通过信用风险的评级就能判断出这个用户的还款能力，从而来决定给他贷多少钱，以什么周期还款，减少违约风险。支付宝的芝麻信用分，是目前被市场一致认可的信用评分模型。
* 量化投资领域，我认为这个领域最复杂的，最有挑战性的，同时也是最有意思的。可以通过量化算法模型实现赚钱，是最容易变现的一种方法。在金融投资领域中，有各式各样的数据，反应的各种金融市场的规则，有宏观数据，经济数据，股票数据，债券数据，期货数据，还有新闻数据，情绪数据等等，金融宽客(Quant)通过分析各种各样的数据，判断出国家的经济形势和个股的走势，进行投资组合算法，实现投资的盈利。
    - 用个人账号在中国二级投资交易市场，完成交易过程。这种方式没有很多的中间环节，你获得交易所的数据，自己编写算法模型，然后用自己的钱去交易，完全自己把握。只要算法有稳定的收益率，你就可以赚到钱。
    - 作为IT人，懂编程，懂算法，只要再了解金融市场的规则，就能去金融市场抢钱了。中国的金融二级投资交易市场，是一个不成熟的市场，同时又是情绪化的市场。市场中，每天都存在着大量的交易机会，每天都会有“乌龙指”。量化投资的技术，可以帮助我们发现这些由于信息不对称出现的机会，赚取超额的收益。
    - 一个私募基金，募集了1亿资金准备杀入金融市场。基金经理决定按照投资组合的建模思路，对各类金融资产进行组合配置。下图就反应了各类资产，以均值-方差的标准来创建投资组合，符合资本资产定价模型(CAPM)的原理。关于资本资产定价模型详细介绍，请参考文章[R语言解读资本资产定价模]型CAPM(http://blog.fens.me/finance-capm/)
    - 需要利用算法进行组合优化，从而找到市场上最优的投资组合。算法本身，才是最能体现价值的部分。在金融市场里，每支基金都配置了不同的资产做组合.从市场上几千支的股票和债券中进行选择，并配置不同的权重，之前都是基金经理干的活，那么我们用算法一样也可以干，说不定用算法模型构建的组合业绩会更好。如果我们用算法模型，取代了年薪几百万的基金经理，那么你就能够获得这个收益。最终实现个人价值，从而用算法改变命运。所以，通过金融变现才是最靠谱的。

### 二分查找（Binary Search）

折半查找要求线性表必须采用顺序存储结构，而且表中元素按关键字有序排列。时间复杂度可以表示O(h)=O(log2n)

* 假设表中元素是按升序排列，将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功；
* 否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，
* 则进一步查找前一子表，否则进一步查找后一子表。重复以上过程，直到找到满足条件的记录，使查找成功，或直到子表不存在为止，此时查找不成功。

```
mid-<(max+min)/2
    while(min<=max)
        mid=(min+max)/2
        if mid=des then
            return mid
        elseif mid >des then
            max=mid-1
        else
        min=mid+1
        return max

function binsearch($x,$a){
    $c=count($a);
    $lower=0;
    $high=$c-1;
    while($lower<=$high){
        $middle=intval(($lower+$high)/2);
        if($a[$middle]>$x){
            $high=$middle-1;
        } elseif($a[$middle]<$x){
            $lower=$middle+1;
        } else{
            return $middle;
        }
    }
    return -1;
}
```

给定一个升序排列的自然数数组，数组中包含重复数字，例如：[1,2,2,3,4,4,4,5,6,7,7]。问题：给定任意自然数，对数组进行二分查找，返回数组正确的位置，给出函数实现。注：连续相同的数字，返回第一个匹配位置还是最后一个匹配位置，由函数传入参数决定。

b字段有一个B+树索引
```sql
select * from t1 where b > 4;  # 就需要跳过所有的4，从最后一个4之后开始返回所有记录
select * from t1 where b >= 4; # 就需要定位到第一个4，然后顺序读取所有记录

select * from t1 where b < 2; # 数据库索引同时支持反向扫描,定位到索引中的第一个2
select * from t1 where b <= 2; # 定位到索引的最后一个2，然后开始反向返回满足查询条件的索引记录。
```

* 一般是对一个索引页面进行二分查找。索引页面中有可能根本不存在用户的记录(索引页面中的记录全部被删除，又没有与兄弟页面合并时)，此时，low/high均为0，此时如果根据low/high计算出来的mid进行记录的读取，就存在逻辑错误。
* 中值算法
    - mid = (low + high) / 2 ： 存在着溢出的风险
    - mid = low + (high – low)/2 ：一个索引页面(大小一般是8k或者是16k)，能够存储的索引记录是有限的，因此肯定不会出现(low + high)溢出的风险。这也是为什么InnoDB中的中值，采用的就是算法一的实现。
* 递归降低了效率
* 如何查找第一个/最后一个等值：用flag来纠正每次比较的最终结果。例如：比较相等(相等用0表示，大于为1，小于为-1)，但是flag = 1，则返回纠正后的比较结果为1，需要移动二分查找的high到mid，继续二分(反之，若flag = 0，则返回纠正后的结果为-1，需要移动二分查找的low到mid，继续二分)。如此一来，等值仍旧可以进行二分查找，最终的对比只需要9次，远远小于200次。
    - InnoDB针对不同的SQL语句，总结出四种不同的Search Mode
    - 然后根据这四种不同的Search Mode，在二分查找碰到相同键值时进行调整。例如：若Search Mode为PAGE_CUR_G或者是PAGE_CUR_LE，则移动low至mid，继续进行二分查找；若Search Mode为PAGE_CUR_GE或者是PAGE_CUR_L，则移动high至mid，继续进行二分查找。

```c
#define    PAGE_CUR_G          1        >查询
#define    PAGE_CUR_GE         2        >=，=查询
#define    PAGE_CUR_L          3        <查询
#define    PAGE_CUR_LE         4        <=查询
```

* LRU（Least Recently Used，最近最少使用）

## 排序

* Quicksort 快速排序
* Mergesort 归并排序
* Heapsort 堆排序
* bubble sort 冒泡排序
* Insert Sort 插入排序
* Selection Sort 选择排序
* Shell Sort 希尔排序
* Bucket Sort 桶排序
* Dadix Sort
* 基数排序
* 计数排序

## 图论算法

* 图的表示：邻接矩阵和邻接表
* 遍历算法：深度搜索和广度搜索
* 最短路径算法：Floyd，Dijkstra
* 最小生成树算法：Prim，Kruskal
* 实际常用算法：关键路径、拓扑排序
* 二分图匹配：配对、匈牙利算法
* 拓展：中心性算法、社区发现算法

## 搜索与回溯算法

* 贪心算法
* 启发式搜索算法：A*寻路算法
* 地图着色算法、N 皇后问题、最优加工顺序
* 旅行商问题

## 动态规划

* 树形DP：01背包问题
* 线性DP：最长公共子序列、最长公共子串
* 区间DP：矩阵最大值（和以及积）
* 数位DP：数字游戏
* 状态压缩DP：旅行商

## 流相关算法

* 最大流：最短增广路、Dinic 算法
* 最大流最小割：最大收益问题、方格取数问题
* 最小费用最大流：最小费用路、消遣

## 课程

* [MIT](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-spring-2008/)
* [十大算法精讲](https://www.bilibili.com/video/av18109226/)
* [麻省理工学院公开课：算法导论](https://www.bilibili.com/video/av1149902)
* [公开课](http://open.163.com/special/opencourse/algorithms.html)
* [Erickson 算法](http://jeffe.cs.illinois.edu/teaching/algorithms/)
    - [jeffgerickson/algorithms](https://github.com/jeffgerickson/algorithms):Bug-tracking for Jeff's algorithms book, notes, etc.
    - [作业](http://jeffe.cs.illinois.edu/teaching/algorithms/hwex.html)

## 图书

* 《数据结构与算法分析：C语言描述版》
* 《大话数据结构》
* 《算法》
* 《剑指offer》
* 《LeetCode刷题》

## 工具

* [Cyan4973/xxHash](https://github.com/Cyan4973/xxHash):Extremely fast non-cryptographic hash algorithm http://www.xxhash.com/

## 参考

* [OpenGenus/cosmos](https://github.com/OpenGenus/cosmos):[Show ❤️ love by 🌟] Your personal library of every algorithm and data structure code that you will ever encounter
* [keon/algorithms](https://github.com/keon/algorithms):Minimal examples of data structures and algorithms in Python\
* [donnemartin/interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges):Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.
* [python](https://github.com/ssjssh/algorithm)
* [keon/algorithms](https://github.com/keon/algorithms)Minimal examples of data structures and algorithms in Python
* [LeuisKen/algorithm](https://github.com/LeuisKen/algorithm)
* [Dictionary of Algorithms and Data Structures](https://xlinux.nist.gov/dads/)
* [frowhy/Algorithm](https://github.com/frowhy/Algorithm)
* [TheAlgorithms/Python](https://github.com/TheAlgorithms/Python):All Algorithms implemented in Python
* [TheAlgorithms/Java](https://github.com/TheAlgorithms/Java):All Algorithms implemented in Java
* [apachecn/awesome-algorithm](https://github.com/apachecn/awesome-algorithm):Leetcode 题解 (跟随思路一步一步撸出代码) 及经典算法实现
* [skybebe/Algorithms-Learning-With-Go](https://github.com/skybebe/Algorithms-Learning-With-Go):算法学习 Golang 版，参考 raywenderlich/swift-algorithm-club
* [ChrisKnott/Algojammer](https://github.com/ChrisKnott/Algojammer):An experimental code editor for writing algorithms
* [algorithm-visualizer/algorithm-visualizer](https://github.com/algorithm-visualizer/algorithm-visualizer):🎆Interactive Online Platform that Visualizes Algorithms from Code https://algorithm-visualizer.org/
* [MisterBooo/LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation):Demonstrate all the questions on LeetCode in the form of animation.（用动画的形式呈现解LeetCode题目的思路）
* [trekhleb/javascript-algorithms](https://github.com/trekhleb/javascript-algorithms):📝 Algorithms and data structures implemented in JavaScript with explanations and links to further readings
* [azl397985856/leetcode](https://github.com/azl397985856/leetcode):LeetCode Solutions: A Record of My Problem Solving Journey
* [huaxz1986/cplusplus-_Implementation_Of_Introduction_to_Algorithms](huaxz1986/cplusplus-_Implementation_Of_Introduction_to_Algorithms):《算法导论》第三版中算法的C++实现
* [wangzheng0822/algo](https://github.com/wangzheng0822/algo):数据结构和算法必知必会的50个代码实现
* [](https://visualgo.net/en):可视化
* [algorithm004-01/algorithm004-01](https://github.com/algorithm004-01/algorithm004-01)
* [labuladong / fucking-algorithm](https://github.com/labuladong/fucking-algorithm):手把手撕LeetCode题目，扒各种算法套路的裤子，not only how，but also why. English version supported! https://labuladong.gitbook.io/algo/

* [leetcode-cn](https://leetcode-cn.com/)
* [leetcode](https://leetcode.com/)
* collabedit.com
* coderpad.io

[动态规划解题技巧](https://mp.weixin.qq.com/s?__biz=MzI1MzYzMTI2Ng==&mid=2247484431&idx=3&sn=35abe41394f24167b78419edbc36fc7c)
* [我接触过的前端数据结构与算法](https://juejin.im/post/5958bac35188250d892f5c91)
