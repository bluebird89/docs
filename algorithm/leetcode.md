# [Leetcode](https://leetcode.com/) 

* [leetcode-cn](https://leetcode-cn.com/)

## method

- 先刷二叉树:二叉树是最容易培养框架思维的，而且大部分算法技巧，本质上都是树的遍历问题
  - 输出为「二值」的题目:直接输出结果测试，再慢慢提高
  - 建议使用 Java 作为笔试的编程语言。因为 JetBrain 家的 IntelliJ 实在是太香了，相比其他语言的编辑器，不仅有 psvm 和 sout 这样的命令缩写
    + C++ 代码对时间的限制苛刻
  - main 函数负责接收数据，加一个 solution 函数负责统一处理数据和输出答案，然后再用诸如 backtrack 这样一个函数处理具体的算法逻辑
-  对 1e9+7 取模
	-  满足\[0,1e9+7)内所有数，两个数相加不爆int，两个数相乘不爆long long
	-     是质数，所以在\[1,1e9+7)内所有数都存在关于1e9+7的逆元（这样就可以做除法）

## reference

- [awesome-algorithm](https://github.com/apachecn/awesome-algorithm):Leetcode 题解 (跟随思路一步一步撸出代码) 及经典算法实现
- [leetcode](https://github.com/azl397985856/leetcode):LeetCode Solutions: A Record of My Problem Solving Journey <https://leetcode-solution.cn/>
- [LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation):Demonstrate all the questions on LeetCode in the form of animation.（用动画的形式呈现解LeetCode题目的思路）
- [fucking-algorithm](https://github.com/labuladong/fucking-algorithm):手把手撕LeetCode题目，扒各种算法套路的裤子，not only how，but also why. English version supported! <https://labuladong.gitbook.io/algo/>
- [little-algorithm](https://github.com/nettee/little-algorithm):LeetCode 题目参考代码与详细讲解，公众号《面向大象编程》文章整理
- 《LeetCode刷题》

* 判断链表是否有回环:两个指针，分别是前指针和后指针，按照节点往下走，当前指针位置大于或者等于后指针的位置时就代表有回环
