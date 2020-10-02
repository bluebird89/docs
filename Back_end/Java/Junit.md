# [Junit](https://github.com/junit-team/junit5)

* The next generation of JUnit. https://junit.org
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

* JUnit5=Platform+Jupiter+Vintage

## 断言

* void assertEquals(boolean expected, boolean actual):检查两个变量或者等式是否平衡
* void assertTrue(boolean expected, boolean actual):检查条件为真
* void assertFalse(boolean condition):检查条件为假
* void assertNotNull(Object object):检查对象不为空
* void assertNull(Object object):检查对象为空
* void assertSame(boolean condition):assertSame() 方法检查两个相关对象是否指向同一个对象
* void assertNotSame(boolean condition):assertNotSame() 方法检查两个相关对象是否不指向同一个对象
* void assertArrayEquals(expectedArray, resultArray):assertArrayEquals() 方法检查两个数组是否相等

## 注解

* @Test:这个注释说明依附在 JUnit 的 public void 方法可以作为一个测试案例。
* @Before:有些测试在运行前需要创造几个相似的对象。在 public void 方法加该注释是因为该方法需要在 test 方法前运行。
* @After:如果你将外部资源在 Before 方法中分配，那么你需要在测试运行后释放他们。在 public void 方法加该注释是因为该方法需要在 test 方法后运行。
* @BeforeClass:在 public void 方法加该注释是因为该方法需要在类中所有方法前运行。
* @AfterClass:它将会使方法在所有测试结束后执行。这个可以用来进行清理活动。
* @Ignore:这个注释是用来忽略有关不需要执行的测试的。

## 工具

* [JUnitGenerator V2.0](link)自动生成测试代码，需要安装

## 参考

* [docs](https://junit.org/junit5/docs/current/user-guide/)
* [Writing Tests with JUnit 5 ](https://blog.jetbrains.com/idea/2020/09/writing-tests-with-junit-5/)
* [unit test](https://mkyong.com/unittest/)
