# 容器

## DIP 依赖倒置原则(Dependence Inversion Principle)

* 定义
	- 高层模块不应依赖于低层模块，两者应该依赖于抽象
	- 抽象不应该依赖于实现，实现应该依赖于抽象
* 转换了依赖关系，要求高层模块不应该依赖于底层模块的实现，底层模块要依赖于高层模块定义的接口
* 好处
	- 通过抽象使各个类或模块的实现彼此独立，不互相影响，实现模块间的松耦合（也是本质）
	- 规避一些非技术因素引起的问题（如项目大时，需求变化的概率也越大，通过采用依赖倒置原则设计的接口或抽象类对实现类进行约束，可以减少需求变化引起的工作量剧增情况。同时，发生人员变动，只要文档完善，也可让维护人员轻松地扩展和维护）
	- 促进并行开发（如，两个类之间有依赖关系，只要制定出两者之间的接口（或抽象类）就可以独立开发了，而且项目之间的单元测试也可以独立地运行，而TDD开发模式更是DIP的最高级应用（特别适合项目人员整体水平较低时使用）

## IoC 控制反转（Inversion of Control）

* 面向对象编程中的一种设计原则，用来减低计算机代码之间的耦合度
* 通过控制反转，对象在被创建的时候，由一个 调控系统内所有对象 的外界实体，将其所依赖对象的引用传递
* 为相互依赖的组件提供抽象，将依赖的获取交给第三方来控制，即依赖对象不在被依赖的模块中获取
* 主流实现方式
	- 依赖查找(Dependency Lookup DL)
	- 依赖注入(Dependency Injection DI)

## DI 依赖注入（Dependency Injection）

* 将需要依赖的底层模块对象的引用 传递给被依赖对象（业务模块）去使用
* 构造函数注入
	- 将依赖关系从内部转移到了外部
* 属性注入

## 依赖查找（Dependency Lookup）


## IOC Container IOC容器

* 功能
	- 自动的管理依赖关系，避免手工管理的缺陷
	- 在需要使用依赖的时候自动注入所需依赖
	- 管理对象的生命周期
* 利用反射类来完成容器的自动注入

```php
<?php

/**
 * Class Container
 */
class Container
{
    /**
     * 容器内所管理的所有实例
     * @var array
     */
    protected $instances = [];

    /**
     * @param $class
     * @param null $concrete
     */
    public function set($class, $concrete = null)
    {
        if ($concrete === null) {
            $concrete = $class;
        }
        $this->instances[$class] = $concrete;
    }

    /**
     * 获取目标实例
     *
     * @param $class
     * @param array $param
     *
     * @return mixed|null|object
     * @throws Exception
     */
    public function get($class, ...$param)
    {
        // 如果容器中不存在则注册到容器
        if (!isset($this->instances[$class])) {
            $this->set($class);
        }
        //解决依赖并返回实例
        return $this->resolve($this->instances[$class], $param);
    }

    /**
     * 解决依赖
     *
     * @param $class
     * @param $param
     *
     * @return mixed|object
     * @throws ReflectionException
     * @throws Exception
     */
    public function resolve($class, $param)
    {
        if ($class instanceof Closure) {
            return $class($this, $param);
        }
        $reflector = new ReflectionClass($class);
        // 检查类是否可以实例化
        if (!$reflector->isInstantiable()) {
            throw new Exception("{$class} 不能被实例化");
        }
        // 通过反射获取到目标类的构造函数
        $constructor = $reflector->getConstructor();
        if (is_null($constructor)) {
            // 如果目标没有构造函数则直接返回实例化对象
            return $reflector->newInstance();
        }

        // 获取构造函数参数
        $parameters = $constructor->getParameters();
        //获取到构造函数中的依赖
        $dependencies = $this->getDependencies($parameters);
        // 解决掉所有依赖问题并返回实例
        return $reflector->newInstanceArgs($dependencies);
    }

    /**
     * 解决依赖关系
     *
     * @param $parameters
     *
     * @return array
     * @throws Exception
     */
    public function getDependencies($parameters)
    {
        $dependencies = [];
        foreach ($parameters as $parameter) {
            $dependency = $parameter->getClass();
            if ($dependency === null) {
                // 检查是否有默认值
                if ($parameter->isDefaultValueAvailable()) {
                    // 获取参数默认值
                    $dependencies[] = $parameter->getDefaultValue();
                } else {
                    throw new Exception("无法解析依赖关系 {$parameter->name}");
                }
            } else {
                // 重新调用get() 方法获取需要依赖的类到容器中。
                $dependencies[] = $this->get($dependency->name);
            }
        }

        return $dependencies;
    }
}

class MysqlDb
{
    public function insert()
    {
        echo 'mysql';
    }
}

class Order
{
    private $db;

    public function __construct(MysqlDb $db)
    {
        $this->db = $db;
    }

    public function add()
    {
        $this->db->insert();
    }

}

$container = new Container();//使用容器
$order = $container->get('Order');//通过容器拿到我们的Order类
$order->add();//正常的使用业务
```
