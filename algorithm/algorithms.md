# 算法 Algorithms

逻辑和数学能力，用更少的代码和资源实现更复杂的逻辑

* 场景：用算法来挖掘出数据的价值。没有数据就没有核心价值。当有了数据作为基础，要继续需要思考如何让数据变的有价值
  - 图像识别领域，深度学习算法异军突起，不仅可以进行准确的人脸识别、指纹识别，还可以进行复杂的图像对比。2016年参加的光谷人工智能大会上，听西安电子科技大学公茂果教授分享的“深度神经网络稀疏特征学习与空时影像变化检测”主题，利用图像识别技术，对比汶川地震前后的卫星照片和光感照片，准确地找到了受到地震影响最严重的区域，即震前和震后地貌发生变化最大的区域，快速地为救援队定位到最需要帮助的地点，解救伤者，投放救援物资。
  - 自动驾驶领域，可以通过识别路面的状况来实现自动驾驶、自动停车。Uber无人驾驶汽车已经在匹兹堡上路测试，自动驾驶汽车配备了各式传感器，包括雷达、激光扫描仪以及高分辨率摄像头，以便绘制周边环境的细节。自动驾驶汽车有望改善人类的生活质量，也可挽救数百万人的性命，为人们提供更多的出行方便。5年前，我在听Andrew Ng的斯坦福大学机器学习公开课的时候，就被当时的自动驾驶视频介绍所震撼，科幻电影中的世界就快变成现实了。
  - 用户行为分析，人类有各种各样的行为和需求。衣食住行，吃喝玩乐，都是人的最基本的行为。大多数人的行为是共性的，商家可以收集这些行为数据，通过数据挖掘算法来找到人们行为共性的规律。根据用户的购物行为，商家可以为用户推荐喜欢的商品，这样就有了推荐系统； 根据用户对信息的查询行为，可以发现用户对信息的需求，这样就有了搜索引擎；根据用户位置的变化，可以发现用户的出行需求，这样就有了地图应用；针对用户个性化的行为，可以给用户打上标签，用来标注用户的特征或身份，这样就有了用户画像。用户行为分析，让商家了解用户习惯，同时也让用户了解自己，有巨大的商业价值。
  - 金融征信领域，传统信贷业务都是银行核心业务，但由于中国人数众多且小客户居多，银行无法负担为小客户服务的高成本，导致民间信贷的兴起。2014年底互联网金融P2P的开始爆发，贷款需求被满足的同时，却暴露出了违约风险。征信体系缺失，导致很多P2P公司坏账率很高，到2016年底P2P跑路的多达数千家。征信需求，变得非常迫切。比如，某个人想买车但现金不够，这时就需要进行贷款。商家给用户进行贷款时，通过信用风险的评级就能判断出这个用户的还款能力，从而来决定给他贷多少钱，以什么周期还款，减少违约风险。支付宝的芝麻信用分，是目前被市场一致认可的信用评分模型。
  - 量化投资领域，我认为这个领域最复杂的，最有挑战性的，同时也是最有意思的。可以通过量化算法模型实现赚钱，是最容易变现的一种方法。在金融投资领域中，有各式各样的数据，反应的各种金融市场的规则，有宏观数据，经济数据，股票数据，债券数据，期货数据，还有新闻数据，情绪数据等等，金融宽客(Quant)通过分析各种各样的数据，判断出国家的经济形势和个股的走势，进行投资组合算法，实现投资的盈利。
    + 用个人账号在中国二级投资交易市场，完成交易过程。这种方式没有很多的中间环节，你获得交易所的数据，自己编写算法模型，然后用自己的钱去交易，完全自己把握。只要算法有稳定的收益率，你就可以赚到钱。
    + 作为IT人，懂编程，懂算法，只要再了解金融市场的规则，就能去金融市场抢钱了。中国的金融二级投资交易市场，是一个不成熟的市场，同时又是情绪化的市场。市场中，每天都存在着大量的交易机会，每天都会有“乌龙指”。量化投资的技术，可以帮助我们发现这些由于信息不对称出现的机会，赚取超额的收益。
    + 一个私募基金，募集了1亿资金准备杀入金融市场。基金经理决定按照投资组合的建模思路，对各类金融资产进行组合配置。下图就反应了各类资产，以均值-方差的标准来创建投资组合，符合资本资产定价模型(CAPM)的原理。关于资本资产定价模型详细介绍，请参考文章[R语言解读资本资产定价模]型CAPM(<http://blog.fens.me/finance-capm/>)
    + 需要利用算法进行组合优化，从而找到市场上最优的投资组合。算法本身，才是最能体现价值的部分。在金融市场里，每支基金都配置了不同的资产做组合.从市场上几千支的股票和债券中进行选择，并配置不同的权重，之前都是基金经理干的活，那么我们用算法一样也可以干，说不定用算法模型构建的组合业绩会更好。如果我们用算法模型，取代了年薪几百万的基金经理，那么你就能够获得这个收益。最终实现个人价值，从而用算法改变命运。所以，通过金融变现才是最靠谱的。
* 数据结构是工具，算法是通过合适的工具解决特定问题的方法
* 人理解迭代，神理解递归
* 特征
  - 有穷性：算法必须能在执行有限个步骤之后终止
  - 确切性：每一步骤必须有确切的定义（容错性得好，考虑兼容性）
  - 输入项：有0个或多个输入（有限），用来规定初始情况，所谓0个输入是指算法本身定义了初始条件
  - 输出项：有一个或多个输出，是对输入数据处理后的结果。没有输出的算法毫无意义
  - 可行性：算法中执行的任何计算步骤都是可以被分解为基本的可执行的操作步，每个计算步骤都可以在有限时间内完成

## 方法

* 算法衡量
  - 时间复杂度
  - 空间复杂度
* 算法分析
  - 设计数据结构
* 算法实践
* 思路
  - 养成算法思维是一个长期过程，要时刻问自己几个问题：
    + 结果是什么？
    + 步骤是什么？
    + 判断结果的标准是什么？
  - 化繁为简
    + 很难在第一时间内得到正确思路，这时候可以尝试一种由简至繁的思路。首先把问题规模缩小到非常容易解答的地步。用来解决动态规划问题
  - 分而治之：把问题分为两半，变成两个与原来问题同构的问题
  - 化虚为实
* 刷题指南
  - 先刷二叉树.试着从框架上看问题，而不要纠结于细节问题。
  - 二叉树是最容易培养框架思维的，而且大部分算法技巧，本质上都是树的遍历问题
  - 刚开始刷二叉树的题目，前 10 道也许有点难受；结合框架再做 20 道，也许你就有点自己的理解了；刷完整个专题，再去做什么回溯动规分治专题，就会发现只要涉及递归的问题，都是树的问题
  - 很多动态规划问题就是在遍历一棵树，如果对树的遍历操作烂熟于心，起码知道怎么把思路转化成代码，也知道如何提取别人解法的核心思路
* 看书的同时结合刷在线编程算法题的方式
  - 边看数据结构或算法导论，同时在牛客或者leetcode上刷题，因为看书太枯燥很容易失去耐心，在线刷题的好处是你可以每天定目标，享受每个题目通过的快感，有正向反馈更容易坚持下来

```c
// 二叉树题目框架
void traverse(TreeNode root) {
    // 前序遍历
    traverse(root.left)
    // 中序遍历
    traverse(root.right)
    // 后序遍历
}
```

## 复杂度

* 时间复杂度: 代码执行时间随数据规模增长的变化趋势 T(n) = O(f(n))
  - 只关注循环执行次数最多的一段代码；
  - 加法法则：总复杂度等于量级最大的那段代码的复杂度；
  - 乘法法则：嵌套代码的复杂度等于嵌套内外代码复杂度的乘积
  - 量级
    + O(1)
    + O(logn) O(log2 N) 的简写
    + O(n)
    + O(nlogn)
    + O(2^n)
    + O(n!)
    + O(n^2)
  - 最好情况时间复杂度:在最理想的情况下，执行这段代码的时间复杂度
  - 最坏情况时间复杂度:在最糟糕的情况下，执行这段代码的时间复杂度
  - 平均情况时间复杂度:结合概率论分析从最好到最坏每种情况平均下来的加权平均时间复杂度
* 空间复杂度:在程序运行过程中的使用空间的峰值

## 分治

* 把一个大问题分解成相似的小问题，通过解决这些小问题，再用小问题的解构造大问题的解
  - 各个小模块通常具有与大问题相同的结构
  - 把大的问题分解成小问题的过程就叫“分”
  - 解决小问题的过程就叫“治”
  - 合：用小问题的解构造大问题的解
* 分治法基本都是可以用递归来实现
  - 递归是一种编程技巧，一个函数自己调用自己就是递归
  - 分治法是一种解决问题的思想
* 时间复杂度: O(nlogn)
* 空间复杂度

### 二分查找 Binary Search

折半查找要求线性表必须采用顺序存储结构，而且表中元素按关键字有序排列。时间复杂度可以表示O(h)=O(log2n)

* 时间复杂度是 O(logn)
* 针对的是一个有序的数据集合,每次都通过跟区间的中间元素对比，将待查找的区间缩小为之前的一半，直到找到要查找的元素，或者区间被缩小为 0
* 适用于变动不是很频繁的静态序列集，如果序列集变动很频繁，经常进行插入删除操作，那么就要不断维护这个序列集的排序，这个成本也很高
* 变形版本
  - 从给定序列中查找第一个或最后一个匹配元素
* 假设表中元素是按升序排列，将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功
* 否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，
* 则进一步查找前一子表，否则进一步查找后一子表。重复以上过程，直到找到满足条件的记录，使查找成功，或直到子表不存在为止，此时查找不成功
* 给定一个升序排列的自然数数组，数组中包含重复数字，例如：[1,2,2,3,4,4,4,5,6,7,7]。问题：给定任意自然数，对数组进行二分查找，返回数组正确的位置，给出函数实现。注：连续相同的数字，返回第一个匹配位置还是最后一个匹配位置，由函数传入参数决定。
* 一般是对一个索引页面进行二分查找。索引页面中有可能根本不存在用户的记录(索引页面中的记录全部被删除，又没有与兄弟页面合并时)，此时，low/high均为0，此时如果根据low/high计算出来的mid进行记录的读取，就存在逻辑错误。
* 中值算法
  - mid = (low + high) / 2 ： 存在着溢出的风险
  - mid = low + (high – low)/2 ：一个索引页面(大小一般是8k或者是16k)，能够存储的索引记录是有限的，因此肯定不会出现(low + high)溢出的风险。这也是为什么InnoDB中的中值，采用的就是算法一的实现。
* 递归降低了效率
* 如何查找第一个/最后一个等值：用flag来纠正每次比较的最终结果。例如：比较相等(相等用0表示，大于为1，小于为-1)，但是flag = 1，则返回纠正后的比较结果为1，需要移动二分查找的high到mid，继续二分(反之，若flag = 0，则返回纠正后的结果为-1，需要移动二分查找的low到mid，继续二分)。如此一来，等值仍旧可以进行二分查找，最终的对比只需要9次，远远小于200次。
  - InnoDB针对不同的SQL语句，总结出四种不同的Search Mode
  - 然后根据这四种不同的Search Mode，在二分查找碰到相同键值时进行调整。例如：若Search Mode为PAGE_CUR_G或者是PAGE_CUR_LE，则移动low至mid，继续进行二分查找；若Search Mode为PAGE_CUR_GE或者是PAGE_CUR_L，则移动high至mid，继续进行二分查找。
* 参考
  - [套框架刷通二叉树](https://mp.weixin.qq.com/s/izZ5uiWzTagagJec6Y7RvQ)
  - [线段树](https://mp.weixin.qq.com/s/rjXqcYDaeA8_Ppj48Dg-Nw)

```sql
# b字段有一个B+树索引
select * from t1 where b > 4;  # 就需要跳过所有的4，从最后一个4之后开始返回所有记录
select * from t1 where b >= 4; # 就需要定位到第一个4，然后顺序读取所有记录

select * from t1 where b < 2; # 数据库索引同时支持反向扫描,定位到索引中的第一个2
select * from t1 where b <= 2; # 定位到索引的最后一个2，然后开始反向返回满足查询条件的索引记录。
```

```c
#define    PAGE_CUR_G          1        >查询
#define    PAGE_CUR_GE         2        >=，=查询
#define    PAGE_CUR_L          3        <查询
#define    PAGE_CUR_LE         4        <=查询
```

## LRU Least Recently Used

## 字符串操作

* 字符串匹配
  - 主串和模式串。简单来说，要在字符串 A 中查找子串 B，那么 A 就是主串，B 就是模式串
* BF(Brute Force) 算法
* KMP 算法
  - 后缀子串：以某个字符串最后一个字符为尾字符的子串（不包含字符串自身），比如上面的 ababa，后缀子串为 baba、aba、ba、a；
  - 前缀子串：以某个字符串第一个字符为首字符的子串（不包含字符串自身），还是以 ababa 为例，前缀子串为 a、aba、abab；
  - 最长可匹配后缀子串：后缀子串与前缀子串最长可匹配子串，也可叫做共有子串，以 ababa 为例，自然是 aba 了，长度为 3；
  - 最长可匹配前缀子串：与上面定义相对，即前缀子串与后缀子串最长可匹配子串。最长可匹配前缀子串和最长可匹配后缀子串肯定是一样的。
  - 假设坏字符所在位置是 j，最长可匹配后缀子串长度为 k，则模式串需要后移的位数为 j-k。每当我们遇到坏字符，就将模式串后移 j-k 位，直到模式串与对应主串字符完全匹配；如果移到最后还是不匹配，则返回 -1
  - 直接把模式串移到下一个可能和 A 匹配的主串位置
* Trie 树
  - 也叫「前缀树」或「字典树」，顾名思义，它是一个树形结构，专门用于处理字符串匹配，用来解决在一组字符串集合中快速查找某个字符串的问题
  - 本质，就是利用字符串之间的公共前缀，将重复的前缀合并在一起
  - 每个节点表示一个字符串中的字符，从根节点到红色节点的一条路径表示一个字符串,（红色节点表示是某个单词的结束字符，但不一定都是叶子节点）
  - 应用
    + 敏感词过滤系统
    + 搜索框联想功能

## 回溯

* 在一棵决策树上做遍历的过程
- 决策树形状主要取决于每个结点处可能的分支，就是在每次做决策时，“可以选什么”、 “有什么可选的”
* 核心就是 for 循环里面的递归，在递归调用**之前做选择**，在递归调用**之后撤销选择**
* backtrack函数其实就像一个指针，在这棵树上游走，同时要正确维护每个节点的属性，每当走到树的底层，其「路径」就是一个全排列
* 路径：已经做出的选择
* 选择列表：当前可以做的选择
  - 分析问题的候选集合
  - 候选集合的变化规律
  - 已选集合与候选集合关系
  - 一般情况下，候选集合使用数组表示即可。 候选集合上需要做的操作并不是很多，使用数组简单又高效
* 结束条件：到达决策树底层，无法再做选择的条件
* 参考
  - [回溯算法](https://mp.weixin.qq.com/s?__biz=MzAxODQxMDM0Mw==&mid=2247484709&idx=1&sn=1c24a5c41a5a255000532e83f38f2ce4)
  - [回溯法的候选集合](https://mp.weixin.qq.com/s?__biz=MzA5ODk3ODA4OQ==&mid=2648167091&idx=1&sn=82ed3bfa68f92b2826247a0bba40d8ff&chksm=88aa22f5bfddabe322bf5dafeef4f7cd56897d2d7e5b91d55e2baa2b21056694cae7da10c2b5&token=1295540189)
* 贪心算法
* 启发式搜索算法：A*寻路算法
* 题目
  - 地图着色算法
  - N 皇后问题
  - 最优加工顺序
  - 旅行商问题

```
void traverse(TreeNode root) {
    for (TreeNode child : root.childern)
        // 前序遍历需要的操作
        traverse(child);
        // 后序遍历需要的操作
}

result = []
def backtrack(路径, 选择列表):
    if 满足结束条件:
        result.add(路径)
        return
    for 选择 in 选择列表:
        # 做选择
        将该选择从选择列表移除
        路径.add(选择)
        backtrack(路径, 选择列表)
        # 撤销选择
        路径.remove(选择)
        将该选择再加入选择列表

    void backtrack(int[] nums, int i, int rest) {
        if (i == nums.length) {
            return;
        }
        backtrack(nums, i + 1, rest - nums[i]);
        backtrack(nums, i + 1, rest + nums[i]);
    }
```

## 图论

* 图的表示：邻接矩阵和邻接表

### 遍历

* 层序遍历
  - 要求的输入结果和 BFS 是不同的
    + 层序遍历要求区分每一层，也就是返回一个二维数组
    + BFS 的遍历结果是一个一维数组，无法区分每一层

## Depth First Search DFS 深度优先搜索

- 遍历使用递归,隐含地使用了系统的栈，不需要自己维护一个数据结构
* 从图中一个未访问的顶点 V 开始，沿着一条路一直走到底，然后从这条路尽头的节点回退到上一个节点，再从另一条路开始走到底...，不断递归重复此过程，直到所有的顶点都遍历完成，它的特点是不撞南墙不回头，先走完一条路，再换一条路继续走
* 递归实现,如果层级过深，很容易导致栈溢出
* 非递归实现
  - 对于每个节点来说，先遍历当前节点，然后把右节点压栈，再压左节点
  - 弹栈，拿到栈顶的节点，如果节点不为空，重复步骤 1， 如果为空，结束遍历
* leetcode 104，111: 给定一个二叉树，找出其最大/最小深度

## Breath First Search BFS 广度优先搜索

* 最短路径问题 shorterst-path problem:是否有从A到B的路径,如果有，广度优先搜索将找出最短路径
* 方法
  - 用图来建立模型，再使用广度优先搜索来解决问题
  - 从图的一个未遍历的节点出发，先遍历这个节点的相邻节点，再依次遍历每个相邻节点的相邻节点
  - 使用队列弹出当前元素检查
  - 压入当前元素的子元素
  - 按加入顺序检查搜索列表中的人，否则找到的就不是最短路径，因此搜索列表必须是队列
  - 对于检查过的人，务必不要再去检查，否则可能导致无限循环
* 层序遍历
* 参考
  - [使用场景：层序遍历、最短路径问题](https://mp.weixin.qq.com/s?__biz=MzA5ODk3ODA4OQ==&mid=2648167212&idx=1&sn=6af5ffe5b69075b21bb4743ddcee4e7c&chksm=88aa236abfddaa7cae70b42edb299d0a52d9f1cc4fc1fdba1116972fc0ca0275b8bfdf10851b)
* LeetCode 102.Binary Tree Level Order Traversal:给你一个二叉树，请你返回其按层序遍历得到的节点值。（即逐层地，从左到右访问所有节点）
* LeetCode 1162. As Far from Land as Possible 离开陆地的最远距离（Medium）最短路径：结点之间最近路径
* Floyd

## Dijkstra 狄克斯特拉算法

* 带权最短路径问题:每条边都有关联数字的图
* 狄克斯特拉算法找出总权重最小路径，只适用于有向无环图(directed acyclic graph，DAG).
* 如果有负权边，就不能使用狄克斯特拉算法
  - 对于处理过的节点，没有前往该节点的更短路径。 这种假设仅在没有负权边时才成立
* [10行实现最短路算法——Dijkstra](https://mp.weixin.qq.com/s/fZwTBch-pkPrQ5W3AQti1A)
* 最小生成树算法：Prim，Kruskal
* 实际常用算法：关键路径
* 二分图匹配：配对、匈牙利算法
* 拓展：中心性算法、社区发现算法

## 贝尔曼.福德算法 Bellman-Ford algorithm

* 处理包含负权边的图

## [拓扑排序](https://mp.weixin.qq.com/s/MhbBwkMqsfAe3ep8cdMO4w)

* 列表是有序的。如果任务A依赖于任务B，在列表中任务A就必须在任务B后面

## [动态规划](https://mp.weixin.qq.com/s?__biz=MzAxODQxMDM0Mw==&mid=2247484731&idx=1&sn=f1db6dee2c8e70c42240aead9fd224e6)

* 先解决子问题，再逐步解决大问题
* 树形DP：背包问题
* 线性DP：最长公共子序列、最长公共子串
* 区间DP：矩阵最大值（和以及积）
* 数位DP：数字游戏
* 状态压缩DP：旅行商
* 方法
  - 在给定约束条件下找到最优解，每种动态规划解决方案都涉及网格
  - 单元格中的值通常就是要优化的值
  - 在问题可分解为彼此独立且离散的子问题时，就可使用动态规划来解决
  - 每个单元格都是一个子问题，因此应考虑如何将问题分成子问题，这有助于找出网格的坐标轴
* 步骤
  - 定义子问题:子问题是和原问题相似，但规模较小问题
    + 原问题要能由子问题表示
    + 一个子问题的解要能通过其他子问题的解求出
    + 有的题目需要定义二维、三维的子问题
  - **写出子问题的递推关系**
    + 需要分情况讨论，有复杂的 max、min、sum 表达式
  - 确定 DP 数组计算顺序
    + 自顶向下：备忘录递归方法
    + 自底向上： DP 数组循环方法
  - 空间优化
* reference
  - [动态规划的解题四步骤](https://mp.weixin.qq.com/s/hSAID_hOPGy_DKleq3_DdA)

## NP完全问题

* 需要计算所有的解，并从中选出最小/最短 的那个
* 识别
  - 元素较少时算法的运行速度非常快，但随着元素数量的增加，速度会变得非常慢。
  - 涉及“所有组合”的问题通常是NP完全问题。
  - 不能将问题分成小问题，必须考虑各种可能的情况。这可能是NP完全问题。
  - 如果问题涉及序列(如旅行商问题中的城市序列)且难以解决，它可能就是NP完全问题。
  - 如果问题涉及集合(如广播台集合)且难以解决，它可能就是NP完全问题。
  - 如果问题可转换为集合覆盖问题或旅行商问题，那它肯定是NP完全问题。
* 最佳做法是使用近似算法
  - 贪婪算法易于实现、运行速度快，是不错的近似算法

## 贪婪

* 寻找局部最优解，企图以这种方式获得全局最优解

## 流算法

* 最大流：最短增广路、Dinic 算法
* 最大流最小割：最大收益问题、方格取数问题
* 最小费用最大流：最小费用路、消遣
* 在一个像素矩阵中有一条封闭曲线，给出一个点的坐标，怎么判断该点在曲线内
* 在一棵二叉树中找三个数的最小公共祖先，尽量只用一次遍历实现。

## KMP 算法

* 匹配表: ABCABD 000120
  - 前缀:除了最后个字符以外所有的顺序组合方式 A、AB、ABC、ABCA、ABCAB
  - 后缀:除了第一个字符外，其他所有的组合方式 BCABD、CABD、ABD、ABD、BD、D
  - 匹配值：对子串的每个字符组合寻找出前缀和后缀，然后进行比较是否有相同的，相同的字符组合有几位
* 下一次要移动的次数 = 成功匹配的位数 - 匹配值
* 在同一字符串中出现两种相同的字符，比如上面中的 AB，由两个字符组成的，所以匹配值为 2，同时在匹配的过程中，如果 D 前边的字符能够匹配，则子串往后移动 3 位，则再次匹配 AB

## K 最近邻算法 k-nearest neighbours，KNN

* 特征抽取：将物品转换为一系列可比较的数字，能否挑选合适的特征事关KNN算法的成败
* 训练(training)
* 朴素贝叶斯分类器(Naive Bayes classifier)
* 分类：进行编组
* 回归 regression：预测结果

## bitmap

## 布隆过滤器 Bloom Filter

* 1970年由布隆提出的。实际上是一个很长的二进制向量和一系列随机映射函数，可以用于检索一个元素是否在一个集合中
* 优点是空间效率和查询时间都远远超过一般的算法
* 缺点是有一定的误识别率和删除困难
* 某个值存在时，这个值 可能不存在；当它说不存在时，那么 一定不存在
* 使用 contains 方法判断某个对象是否存在时，它可能会误判。但是布隆过滤器也不是特别不精确，只要参数设置的合理，它的精确度可以控制的相对足够精确，只会有小小的误判概率。
* 场景
  - 大数据判断是否存在：这就可以实现出上述的去重功能，如果你的服务器内存足够大的话，那么使用 HashMap 可能是一个不错的解决方案，理论上时间复杂度可以达到 O(1 的级别，但是当数据量起来之后，还是只能考虑布隆过滤器。
  - 解决缓存穿透：经常会把一些热点数据放在 Redis 中当作缓存，例如产品详情。通常一个请求过来之后我们会先查询缓存，而不用直接读取数据库，这是提升性能最简单也是最普遍的做法，但是如果一直请求一个不存在的缓存，那么此时一定不存在缓存，那就会有大量请求直接打到数据库上，造成缓存穿透，布隆过滤器也可以用来解决此类问题。
  - 爬虫/邮箱等系统过滤：有一些正常的邮件也会被放进垃圾邮件目录中，这就是使用布隆过滤器误判导致的
* 原理
  - 长度为 m 的位向量或位列表（仅包含 0 或 1 位值的列表）组成，最初所有的值均设置为 0
  - 向布隆过滤器中添加数据时，会使用多个 hash 函数对 key 进行运算，算得一个证书索引值，然后对位数组长度进行取模运算得到一个位置，每个 hash 函数都会算得一个不同的位置。再把位数组的这几个位置都置为 1 就完成了 add 操作
  - 向布隆过滤器查查询 key 是否存在时，跟 add 操作一样，会把这个 key 通过相同的多个 hash 函数进行运算，查看 对应的位置 是否 都 为 1，只要有一个位为 0，那么说明布隆过滤器中这个 key 不存在。如果这几个位置都是 1，并不能说明这个 key 一定存在，只能说极有可能存在，因为这些位置的 1 可能是因为其他的 key 存在导致的。
  - 记住
    + 使用时不要让实际元素数量远大于初始化数量
    + 当实际元素数量超过初始化数量时，应该对布隆过滤器进行 重建，重新分配一个 size 更大的过滤器，再将所有的历史元素批量 add 进行

* 答案却是很可能是正确
  - 已搜集:实际上并没有搜集
  - 未搜集:肯定未搜集
* 优点在于占用的存储空间很少
* 适用于不要求答案绝对准确的情况

## [HyperLogLog](http://content.research.neustar.biz/blog/hll.html)

* 类似于布隆过滤器的算法
* 近似地计算集合中不同的元素数，不能给出准确的答案， 但也八九不离十，而占用的内存空间却少得多
* [神奇的HyperLoglog解决统计问题](https://mp.weixin.qq.com/s?__biz=MzU4Mjk0MjkxNA==&mid=2247484713&idx=1&sn=adb21a258683aff10098ca13007b03d7)

## 回文数

* 指正序（从左向右）和倒序（从右向左）读都是一样的整数
* 方法
  - 反转后是否相等
  - 将整数转为字符串 ，然后将字符串分割为数组，只需要循环数组的一半长度进行判断对应元素是否相等即可
  - 取整和取余操作获取整数中对应的数字进行比较
  - 取出后半段数字进行翻转
    + 长度是奇数时，那么它对折过来后，有一个的长度需要去掉一位数（除以 10 并取整）
* 参考
  - [让字符串成为回文串的最少插入次数](https://mp.weixin.qq.com/s/C14WNUpPeBMVSMqh28JdfA)

## [leetcode](https://leetcode.com/) [leetcode-cn](https://leetcode-cn.com/)

* method
  - 输出为「二值」的题目:直接输出结果测试，再慢慢提高
  - 建议使用 Java 作为笔试的编程语言。因为 JetBrain 家的 IntelliJ 实在是太香了，相比其他语言的编辑器，不仅有 psvm 和 sout 这样的命令缩写
    + C++ 代码对时间的限制苛刻
  - main 函数负责接收数据，加一个 solution 函数负责统一处理数据和输出答案，然后再用诸如 backtrack 这样一个函数处理具体的算法逻辑
* reference
  - [leetcode](https://github.com/azl397985856/leetcode):LeetCode Solutions: A Record of My Problem Solving Journey <https://leetcode-solution.cn/>
  - [LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation):Demonstrate all the questions on LeetCode in the form of animation.（用动画的形式呈现解LeetCode题目的思路）
  - [fucking-algorithm](https://github.com/labuladong/fucking-algorithm):手把手撕LeetCode题目，扒各种算法套路的裤子，not only how，but also why. English version supported! <https://labuladong.gitbook.io/algo/>
  - [little-algorithm](https://github.com/nettee/little-algorithm):LeetCode 题目参考代码与详细讲解，公众号《面向大象编程》文章整理
  - 《LeetCode刷题》

## 技巧

* n&(n-1)：消除数字 n 的二进制表示中的最后一个 1
  - 循环计算 1 的个数
  - 判断一个数是不是 2 的指数：二进制表示一定只含有一个 1

## 面试

* 基础：
  - 数据结构
    + 数组、链表、栈、队列、散列表、二叉树、堆、图的定义等
    + 跳表、并查集、线段树、树状数组
  - 算法
    + 排序、二分查找、二叉树上的操作（遍历、查找、插入、删除等）、图的深度广度优先搜索、字符串朴素匹配算法，以及递归、分治、贪心、回溯、动态规划等基础算法思想。
    + BM算法、KMP算法、AC自动机、红黑树、B+树、图的一些高级算法（比如最大流、二分匹配、Dijkstra、Floyd算法）等。
  - 对于基础的数据结构和算法，需要掌握原理、熟练代码实现、复杂度分析等，毕竟它们是很多算法问题解决的基础，需要掌握牢固
  - 对于高级的数据结构和算法，只需要理解算法原理、掌握应用场景，对于代码实现，基本上不做要求，更不需要像对待基础数据结构和算法那样，要牢记原理和实现
* 用比较长的一段时间（比如半年）来刷题强化训练。目前，最著名的刷题网站非LeetCode莫属，可以针对每种类型，选择一些题目刻意训练
  - 面试前一定要在纸上多练习一下，做到脑袋里想好算法之后，能一气呵成地写出代码
* 解题技巧
  - 跟面试官沟通确认问题，包括数据规模、输入输出要求，以及其他一些不清楚的地方，一定要确认没有理解误差之后，再进行答题。
  - 答题的过程，先思考最简单的解决方案，说给面试官听，然后再行优化，思考更加好的解决方案。这样做的目的是，一方面能缓和自己紧张的心情，不至于大脑放空、卡壳，另一方面，一开始就思考最优解法，可能要闷头想很久，面试官很难知道你的思考进度，也无法基于你现有的思考进度做提示。
  - 不管题目的难易，建议每个题目的思考时间都不要超过10分钟。10分钟还想不出解法，更多的时间可能也无济于事了，而且10分钟是面试官可以忍受的沉默时间的极限。所以，如果10分钟还没有思路，建议跟面试官沟通，以求给与提示。
  - 在想到最优解决思路之后，也不要着急写代码，先要跟面试官沟通，看是否满足面试官的要求。在得到面试官的肯定之后，再进行编码实现，以免进入思维误区，想出来的解决办法有漏洞，并非正确或最优解，急匆匆地写代码，写完才发现有问题，最后也没有时间去改正或优化了。
  - 编码也是一个非常重要的环节。很多算法问题，即便有了解决思路，编码实现也并不简单。比如在O(1)空间复杂度内判断存储在链表中的字符串是否是回文串这样一个题目，实际上，它就是反转链表和链表求中间结点这两个问题的组合，算法并不难，但要正确、快速地用代码实现，并不简单，需要处理很多细节，稍有不慎就会引入bug，非常考验候选人的编码能力。
  - 除此之外，在编写代码的过程中，一定要注意编码规范，保证代码整洁、可读，切记使用i、j、k这样的字母来命名重要的变量。一目了然的命名，清晰的代码结构，会反映出候选人良好的编程习惯，从而赢得面试官的好感。
  - 在写完代码之后，一定要进行单元测试。列举完备的测试用例，特别是一些极端测试用例，比如输入为0、null等，看程序是否运行正确。一方面能验证自己写的代码的正确性，另一方面还能发现一些边界条件处理不到位的情况，再者还能让面试官觉得你思考问题比较全面、细心。
  - 一般情况下，面试官会自己阅读你的代码来判断是否编写正确，但也有些面试官会要求候选人逐行解释代码。为了方面解释，特别是针对链表或树相关的一些复杂问题，我们可以通过具体的例子或者画图来辅助讲解。
  - 算法面试并非笔试，并不只看最终答案，考察的重点是候选人在面试的过程中体现出来的沟通能力、逻辑思维能力、分析问题能力、优秀的编码开发能力等等。所以，有的时候即便你没有给出最优解决思路，也有可能会被录用，而有的时候，你觉得回答的很不错，给出了最优解，也未必会被录用。

## 课程

* [算法导论 Introduction to Algorithms](https://www.bilibili.com/video/av48922404)
  - [MIT](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-spring-2008/)
  - [麻省理工学院公开课：算法导论](https://www.bilibili.com/video/av1149902)
  - [cplusplus-_Implementation_Of_Introduction_to_Algorithms](huaxz1986/cplusplus-_Implementation_Of_Introduction_to_Algorithms):《算法导论》第三版中算法的C++实现
* [十大算法精讲](https://www.bilibili.com/video/av18109226/)
* [公开课](http://open.163.com/special/opencourse/algorithms.html)
* [Erickson 算法](http://jeffe.cs.illinois.edu/teaching/algorithms/)
  - [algorithms](https://github.com/jeffgerickson/algorithms):Bug-tracking for Jeff's algorithms book, notes, etc.
  - [作业](http://jeffe.cs.illinois.edu/teaching/algorithms/hwex.html)
* [屈婉玲教授的算法设计分析](https://www.bilibili.com/video/av83623454?p=1)

## 图书

* 算法图解
* [Algorithms, 4th Edition](https://algs4.cs.princeton.edu/home/)
  - [ppt](https://www.cs.princeton.edu/~wayne/kleinberg-tardos/)
* 《大话数据结构》
* 《剑指offer》
* 编程珠玑
* 数论
* The Algorithm Design Manual
  - Steven Skiena’s lectures
* [An Introduction to the Analysis of Algorithms](https://aofa.cs.princeton.edu/home/)
* 《[Python算法教程](https://www.amazon.cn/gp/product/B019NB0VCI)》
* 《[算法设计与分析基础（第3版）](https://www.amazon.cn/gp/product/B00S4HCQUI)》
* 《[数据结构与算法分析 : C++描述（第4版）](https://www.amazon.cn/gp/product/B01LDG2DSG)》
* 《[数据结构与算法分析 : C语言描述（第2版）](https://www.amazon.cn/gp/product/B002WC7NGS)》
* 《[数据结构与算法分析 : Java语言描述（第2版）](https://www.amazon.cn/gp/product/B01CNP0CG6)》
* 《数据结构与算法 JavaScript 描述》
* 《[学习 JavaScript 数据结构与算法](https://www.amazon.cn/gp/product/B016DWSF8M)》
* 算法设计
* Algorithms to Live
* [Analytic Combinatorics](https://ac.cs.princeton.edu/home/)
* [Problem Solving with Algorithms and DataStructures](https://www.cs.auckland.ac.nz/compsci105s1c/resources/ProblemSolvingwithAlgorithmsandDataStructures.pdf)

## 工具

* [xxHash](https://github.com/Cyan4973/xxHash):Extremely fast non-cryptographic hash algorithm <http://www.xxhash.com/>
* [cheatsheet](https://www.bigocheatsheet.com/)
* collabedit.com
* coderpad.io

## 参考

* [cosmos](https://github.com/OpenGenus/cosmos):[Show ❤️ love by 🌟] Your personal library of every algorithm and data structure code that you will ever encounter
* [interactive-coding-challenges](https://github.com/donnemartin/interactive-coding-challenges):Huge update! Interactive Python coding interview challenges (algorithms and data structures). Includes Anki flashcards.
* [algorithms](https://github.com/keon/algorithms)Minimal examples of data structures and algorithms in Python
* [algorithm](https://github.com/LeuisKen/algorithm)
* [Dictionary of Algorithms and Data Structures](https://xlinux.nist.gov/dads/)
* [Algorithm](https://github.com/frowhy/Algorithm)
* [python](https://github.com/ssjssh/algorithm)
* [Python](https://github.com/TheAlgorithms/Python):All Algorithms implemented in Python
* [Java](https://github.com/TheAlgorithms/Java):All Algorithms implemented in Java
* [Go](https://github.com/TheAlgorithms/Go):Algorithms Implemented in GoLang
* [Algorithms-Learning-With-Go](https://github.com/skybebe/Algorithms-Learning-With-Go):算法学习 Golang 版，参考 raywenderlich/swift-algorithm-club
* [Javascript](https://github.com/TheAlgorithms/Javascript):A repository for All algorithms implemented in Javascript (for educational purposes only)
* [javascript-algorithms](https://github.com/trekhleb/javascript-algorithms):📝 Algorithms and data structures implemented in JavaScript with explanations and links to further readings
* [awesome-algorithm](https://github.com/apachecn/awesome-algorithm):Leetcode 题解 (跟随思路一步一步撸出代码) 及经典算法实现
* [Algojammer](https://github.com/ChrisKnott/Algojammer):An experimental code editor for writing algorithms
* [algorithm-visualizer](https://github.com/algorithm-visualizer/algorithm-visualizer):🎆Interactive Online Platform that Visualizes Algorithms from Code <https://algorithm-visualizer.org/>
* [VisuAlgo](https://visualgo.net/en):visualising data structures and algorithms through animation
* [algorithm004-01](https://github.com/algorithm004-01/algorithm004-01)
* [](https://github.com/overnote/over-algorithm)
* [](https://www.techiedelight.com/)

* <https://www.geekxh.com/>
* [动态规划解题技巧](https://mp.weixin.qq.com/s?__biz=MzI1MzYzMTI2Ng==&mid=2247484431&idx=3&sn=35abe41394f24167b78419edbc36fc7c)
* [我接触过的前端数据结构与算法](https://juejin.im/post/5958bac35188250d892f5c91)
* [wangzheng0822/algo](https://github.com/wangzheng0822/algo):数据结构和算法必知必会的50个代码实现
* [美国高薪计算机大公司流行算法面试题，LeetCode算法题成为破解高薪之道？ - ycombinator](https://www.jdon.com/54814)
