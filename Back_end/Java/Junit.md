# [Junit](https://junit.org)

* 测试方法使用@Test修饰
* 使用public void修饰，不带任何参数
* 新建源代码目录存放测试代码
* 测试类包与被测试类保持一致
* 测试单元中每个方法可以独立测试，方法间不能有任何依赖
* 测试类使用Test作为类名后缀
* 测试方法使用test作为方法名前缀

Failture:由断言方法引起，输出与预期不一样
Error:代码异常引起
测试用例不是用来证明你是对的，而是用来证明你没有错

## 版本

JUnit5=Platform+Jupiter+Vintage

## 工具

* [JUnitGenerator V2.0](link)自动生成测试代码，需要安装


gradle

构建打包命令 gradle clean build
编译时跳过测试，使用-x,-x参数用来排除不需要执行的任务

gradle clean build -x test

没有失败的测试就不能写代码
只写让测试代码恰好通过的代码

IDE 快捷键
代码生成
    testP  模版
    import包配置

    guava
