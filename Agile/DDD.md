# 领域驱动设计

软件开发中困难的部分是规格说明，设计和测试这些概念上的结构，而不是对概念进行表达和对实现逼真程度进行验证

## 分层

* 架构分为四层：
    - Infrastructure（基础实施层）
    - Domain（领域层）
    - Application（应用层）
    - Interfaces（表示层，也叫用户界面层或是接口层）
    - 微服务结合 DDD
* 实施 DDD 的关键
    - 使用通过的语言建立所有的聚合，实体，值对象。
    - 建模
        + 战略建模：从一种宏观的角度去审核整个项目，划分出“界限上下文”，形成具有上帝视角的“上下文映射图”。
        + 战术建模：在“战略建模”划分出来的“界限上下文”中进行“聚合”，“实体”，“值对象”，并按照模块分组。

## 战略设计

从高层“俯视”软件系统，帮助精准地划分领域以及处理各个领域之间的关系

* 领域/子域（Domain/Subdomain）
    - 建模在哪些子系统里面
    - 各个子系统之间的应该如何集成
    - 两个系统之间的集成涉及到基础设施和不同领域概念在两个系统之间的翻译
* 通用语言
    - 将一个限界上下文中的所有概念，包括名词、动词和形容词全部集中在一起，我们便为该限界上下文创建了一套通用语言
* 限界上下文（Bounded Context）
    - 在一个领域/子域中，创建一个概念上的领域边界，在这个边界中，任何领域对象都只表示特定于该边界内部的确切含义.和领域具有一对一的关系
    - 防腐层:负责与外部服务提供方打交道，还负责将外部概念翻译成自己的核心领域能够理解的概念
    - 限界上下文之间的集成关系也可以理解为是领域概念在不同上下文之间的映射关系，因此，限界上下文之间的集成也称为上下文映射图
* 架构风格
    - 事件驱动架构
    - 六边形架构 也称为端口和适配器（Ports and Adapters）
        + 各个组件的之间的交互完全通过接口完成，而不是具体的实现细节
        + 存在着很多端口和适配器的组合。端口表示的是一个软件系统的输入和输出，而适配器则是对每一个端口的访问方式。
        + 领域模型位于应用程序的核心部分，外界与领域模型的交互都通过应用层完成，应用层是领域模型的直接客户
        + 应用层中不应该包含有业务逻辑，否则就造成了领域逻辑的泄漏，而应该是很薄的一层，主要起到协调的作用，它所做的只是将业务操作代理给领域模型
        + 如果业务操作有事务需求，那么对于事务的管理应该放在应用层上，因为事务也是以业务用例为单位的。

## 战术设计

从技术实现的层面教会如何具体地实施DDD

* 创建行为饱满的领域对象:需要转变一下思维，将领域对象当做是服务的提供方，而不是数据容器，多思考一个领域对象能够提供哪些行为，而不是数据
* 可以通过领域特定语言（DSL）的方式实现领域模型

## 实体vs值对象（Entity vs Value Object）

* 实体表示那些具有生命周期并且会在其生命周期中发生改变的东西
    - 只能通过唯一标识来实现了，因为即便两个实体所拥有的状态是一样的，他们依然是不同的实体，就像两个人的名字都叫张三，但是他们却是两个不同的人的个体。
* 值对象则表示起描述性作用的并且可以相互替换的概念
    - 没有唯一标识.equals()方法（比如在Java语言中）可以用它所包含的描述性属性字段来实现

## 聚合（Aggregate）

* 聚合中所包含的对象之间具有密不可分的联系，是内聚在一起的
* 聚合的颗粒度：有无必要维护集合，可以通过ID的方式引用另外的聚合

```java
public class BlogApplicatioinService {

    @Transactional
    public void createBlog(String blogName, String userId) {
        User user = userRepository.userById(userId);
        Blog blog = user.createBlog(blogName);
        blogRepository.save(blog);
    }
}
```

## 领域服务（Domain Service）

* 领域服务和上文中提到的应用服务是不同的，领域服务是领域模型的一部分，而应用服务不是。
* 应用服务是领域服务的客户，它将领域模型变成对外界可用的软件系统。
* 领域服务不能滥用，因为如果我们将太多的领域逻辑放在领域服务上，实体和值对象上将变成贫血对象。

## 资源库（Repository）

* 用于保存和获取聚合对象，在这一点上，资源库与DAO多少有些相似之处
* 资源库和DAO是存在显著区别的
    - DAO只是对数据库的一层很薄的封装，而资源库则更加具有领域特征。
    - 所有的实体都可以有相应的DAO，但并不是所有的实体都有资源库，只有聚合才有相应的资源库
* 分类
    - 基于集合的，具有编程语言中集合的特征
    - 基于持久化的，不仅用于添加新的聚合，还用于显式地更新既有聚合

```java
public interface CollectionOrientedUserRepository {
    public void add(User user);
    public User userById(String userId);
    public List allUsers();     public void remove(User user); 
}

public interface PersistenceOrientedUserRepository {
    public void save(User user); 
    public User userById(String userId); 
    public List<User> allUsers();    
    public void remove(User user); 
}
```

## 领域事件（Domain Event）

* 最终一致性取代了事务一致性，通过领域事件的方式达到各个组件之间的数据一致性。
* 命名遵循英语中的“名词+动词过去分词”格式，即表示的是先前发生过的一件事情

## 图书

* 《领域特定语言》
* 《测试驱动开发》Kent Beck
* [gdut-yy/Domain-Driven-Design-zh](https://github.com/gdut-yy/Domain-Driven-Design-zh): 《领域驱动设计》
* 《实现领域驱动设计》 Vaughn Vernon

## 参考

* [citerus/dddsample-core](https://github.com/citerus/dddsample-core):This is the new home of the original DDD Sample app (previously hosted at sf.net)..
