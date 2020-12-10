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

```sh
# 二叉树的题目都是一套这个框架
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
    + O(logn)
    + O(n)
    + O(nlogn)
    + O(2^n)
    + O(n!)
    + O(n^2)
  - 最好情况时间复杂度:在最理想的情况下，执行这段代码的时间复杂度
  - 最坏情况时间复杂度:在最糟糕的情况下，执行这段代码的时间复杂度
  - 平均情况时间复杂度:结合概率论分析从最好到最坏每种情况平均下来的加权平均时间复杂度
* 空间复杂度的定义是在程序运行过程中的使用空间的峰值

## 递归

* 定义：直接调用自己或通过一系列调用语句间接调用自己的函数
* 本质是能把问题拆分成具有相同解决思路的子问题，直到最后被拆解的子问题再也不能拆分，解决了最小粒度可求解的子问题后，在「归」的过程中自然顺其自然地解决了最开始的问题
* 条件
  - 问题解可以分解为几个子问题的解
  - 问题与分解之后的子问题，除了数据规模不同，求解思路完全一样
  - 存在递归终止条件
* 特点
  - 一个问题可以分解成具有相同解决思路的子问题，子子问题，换句话说这些问题都能调用同一个函数
  - 分为调用和回退阶段，回退顺序是调用顺序逆序
  - 经过层层分解的子问题最后一定是有一个不能再分解的固定值的（即终止条件）,如果没有的话,就无穷无尽地分解子问题了，问题显然是无解的
  - 程序结构更清晰、更简洁、更容易让人理解，从而减少读懂代码的时间
  - 在迫不得已的情况下才使用递归，因为递归本身的效率并不理想，但思想却值得留存在记忆之中
  - 大量的递归调用会建立函数的副本，会消耗大量的时间和内存，而迭代则不需要此种代价
* 分析：采用**自上而下**思维(最终问题往前推)，而解决问题有时候采用自下而上的方式能让算法性能得到极大提升,思路比结论重要
  - 「递」:将问题拆解成子问题来解决，子问题再拆解成子子问题，直到被拆解的子问题无需再拆分成更细的子问题（即可以求解）正向展开
  - 「归」:最小的子问题解决了，那么它上一层子问题也就解决了，上一层的子问题解决了，上上层子问题自然也就解决了,直到最开始的问题解决 逆向合并
* 套路
  - 定义函数：明确函数功能，由于递归特点是问题和子问题都会调用函数自身，所以这个函数功能一旦确定了，之后只要找寻问题与子问题递归关系即可
  - 确定条件
    + 寻找问题与子问题间关系（即递推公式），由于问题与子问题具有相同解决思路，*子问题可以调用步骤 1 定义的函数*，符合递归的条件（函数里调用自身）所谓的关系最好能用一个公式表示出来，比如 f(n) = n * f(n-)这样，如果暂时无法得出明确的公式，也可以用伪代码表示
    + 终止条件:寻找最终不可再分解的子问题的解（临界条件），确保子问题不会无限分解下去
  - 将递推公式用代码表示出来补充到定义的函数中
  - 优化：根据问题与子问题关系，推导出时间复杂度,如果发现递归时间复杂度不可接受，则需转换思路对其进行改造，看下是否有更靠谱的解法
* 注意
  - 警惕堆栈溢出，为此要设定好终止条件和合理的递归层数
  - 防止重复计算，因此要经过认证求证，不能凭感觉
  - 递归代码更简洁,可读性不好
  - 切忌试图通过人脑去分解每个步骤，那样会把自己搞晕的
* 迭代和递归区别：迭代使用的是循环结构，递归使用的是选择结构。

```java
public int factorial(int n) {
    if (n < =1) {
        return 1;
    }

    return n * factorial(n - 1)
}
```

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

### 二分查找（Binary Search）

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

## 数组操作

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
* DFS（深度优先搜索）
  - 遍历使用递归,隐含地使用了系统的栈，不需要自己维护一个数据结构
* BFS（广度优先搜索）
  - 使用队列数据结构
  - 层序遍历
  - 参考
    + [BFS 的使用场景：层序遍历、最短路径问题](https://mp.weixin.qq.com/s?__biz=MzA5ODk3ODA4OQ==&mid=2648167212&idx=1&sn=6af5ffe5b69075b21bb4743ddcee4e7c&chksm=88aa236abfddaa7cae70b42edb299d0a52d9f1cc4fc1fdba1116972fc0ca0275b8bfdf10851b)

## 最短路径算法

* Floyd

## Dijkstra:带权最短路径问题

* [10行实现最短路算法——Dijkstra](https://mp.weixin.qq.com/s/fZwTBch-pkPrQ5W3AQti1A)

* 最小生成树算法：Prim，Kruskal

* 实际常用算法：关键路径、

* 二分图匹配：配对、匈牙利算法

* 拓展：中心性算法、社区发现算法

## [拓扑排序](https://mp.weixin.qq.com/s/MhbBwkMqsfAe3ep8cdMO4w)

## [动态规划](https://mp.weixin.qq.com/s?__biz=MzAxODQxMDM0Mw==&mid=2247484731&idx=1&sn=f1db6dee2c8e70c42240aead9fd224e6)

* 树形DP：01背包问题
* 线性DP：最长公共子序列、最长公共子串
* 区间DP：矩阵最大值（和以及积）
* 数位DP：数字游戏
* 状态压缩DP：旅行商
* 步骤
  - 定义子问题:子问题是和原问题相似，但规模较小的问题
    + 原问题要能由子问题表示
    + 一个子问题的解要能通过其他子问题的解求出
    + 有的题目需要定义二维、三维的子问题
  - **写出子问题的递推关系**
    + 需要分情况讨论，有复杂的 max、min、sum 表达式
  - 确定 DP 数组的计算顺序,有两种计算顺序
    + 自顶向下的、使用备忘录的递归方法
    + 自底向上的、使用 DP 数组的循环方法
  - 空间优化
* reference
  - [动态规划的解题四步骤](https://mp.weixin.qq.com/s/hSAID_hOPGy_DKleq3_DdA)

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

## bitmap

## [HyperLogLog](http://content.research.neustar.biz/blog/hll.html)

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

## 课程

* [MIT](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-spring-2008/)
* [十大算法精讲](https://www.bilibili.com/video/av18109226/)
* [麻省理工学院公开课：算法导论](https://www.bilibili.com/video/av1149902)
* [公开课](http://open.163.com/special/opencourse/algorithms.html)
* [Erickson 算法](http://jeffe.cs.illinois.edu/teaching/algorithms/)
  - [algorithms](https://github.com/jeffgerickson/algorithms):Bug-tracking for Jeff's algorithms book, notes, etc.
  - [作业](http://jeffe.cs.illinois.edu/teaching/algorithms/hwex.html)

## 图书

* 《大话数据结构》
* 《剑指offer》
* 编程珠玑
* 算法导论 Introduction to Algorithms
  - [cplusplus-_Implementation_Of_Introduction_to_Algorithms](huaxz1986/cplusplus-_Implementation_Of_Introduction_to_Algorithms):《算法导论》第三版中算法的C++实现
  - [](https://www.bilibili.com/video/av48922404)
* 数论
* The Algorithm Design Manual
  - Steven Skiena’s lectures
* [Algorithms, 4th Edition](https://algs4.cs.princeton.edu/home/)
* [An Introduction to the Analysis of Algorithms](https://aofa.cs.princeton.edu/home/)
* 《[Python算法教程](https://www.amazon.cn/gp/product/B019NB0VCI)》
* 《[算法设计与分析基础（第3版）](https://www.amazon.cn/gp/product/B00S4HCQUI)》
* 《[数据结构与算法分析 : C++描述（第4版）](https://www.amazon.cn/gp/product/B01LDG2DSG)》
* 《[数据结构与算法分析 : C语言描述（第2版）](https://www.amazon.cn/gp/product/B002WC7NGS)》
* 《[数据结构与算法分析 : Java语言描述（第2版）](https://www.amazon.cn/gp/product/B01CNP0CG6)》
* 《数据结构与算法 JavaScript 描述》
* 《[学习 JavaScript 数据结构与算法](https://www.amazon.cn/gp/product/B016DWSF8M)》
* 算法图解
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

* <https://www.geekxh.com/>
* [动态规划解题技巧](https://mp.weixin.qq.com/s?__biz=MzI1MzYzMTI2Ng==&mid=2247484431&idx=3&sn=35abe41394f24167b78419edbc36fc7c)
* [我接触过的前端数据结构与算法](https://juejin.im/post/5958bac35188250d892f5c91)
* [wangzheng0822/algo](https://github.com/wangzheng0822/algo):数据结构和算法必知必会的50个代码实现
* [美国高薪计算机大公司流行算法面试题，LeetCode算法题成为破解高薪之道？ - ycombinator](https://www.jdon.com/54814)
