# 性能

## 调优

调优性需要找到程序中的Hotspot，也就是被调用最多的地方。只要你能优化一点点，你的性能就会有质的提高

* PHP中Getter和Setter的效率：性能要比直接读写成员变量要差一倍以上
* Python程序在函数内执行得更快：本地变量是存在一个数组中（直到），用一个整型常量去访问，而全局变量存在一个dictionary中，查询很慢。
* 为什么排好序的数据在遍历时会更快：

## 工具

* [Speed](https://developers.google.com/speed/):Analyze and optimize your website with PageSpeed tools
