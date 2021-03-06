# 领域驱动设计 Domain-Driven Design DDD

软件开发中困难的部分是规格说明，设计和测试这些概念上的结构，而不是对概念进行表达和对实现逼真程度进行验证

* 2004年著名建模专家Eric Evans发表了他最具影响力的书籍：《Domain-Driven Design –Tackling Complexity in the Heart of Software》，书中提出了“领域驱动设计（简称 DDD）”的概念。
* 领域驱动设计事实上是针对OOAD的一个扩展和延伸，DDD基于面向对象分析与设计技术，对技术架构进行了分层规划，同时对每个类进行了策略和类型的划分。
* 领域模型是领域驱动的核心。采用DDD的设计思想，业务逻辑不再集中在几个大型的类上，而是由大量相对小的领域对象(类)组成，这些类具备自己的状态和行为，每个类是相对完整的独立体，并与现实领域的业务对象映射。
* 核心应用场景就是解决复杂业务的设计问题
* 特点
  - 分层架构与职责划分
    + 很好的遵循了关注点分离的原则，提出了成熟、清晰的分层架构
    + 对领域对象进行了明确的策略和职责划分，让领域对象和现实世界中的业务形成良好的映射关系，为领域专家与开发人员搭建了沟通的桥梁。
  - 复用
    + 在领域驱动设计中，领域对象是核心，每个领域对象都是一个相对完整的内聚的业务对象描述，所以可以形成直接的复用
    + 设计过程是基于领域对象而不是基于数据库的Schema，所以整个设计也是可以复用的。
* 专注于核心领域逻辑,在模型上找到综合的设计
* 不断与领域专家合作，改进应用程序模型并解决与领域相关的问题
* 在打通领域专家和开发人员之间的沟通和交流。DDD的精髓在于通过让开发人员理解领域，进而让开发人员使用编程语言建立一个跟领域专家脑海中一致的领域模型，使得该领域模型成为大家共享知识的途径，这将有效的减少不同利益相关者的沟通及交流，确保所有人都在解决同一个问题。

## 领域模型

* 由这样许多的细粒度的类组成。基于领域驱动的设计，保证了系统的可维护性、扩展性和复用性，在处理复杂业务逻辑方面有着先天的优势
* 开发人员需要有很好的抽象能力，通过恰如其分的编程技术，将领域知识映射到一个代码模型中。

## 为什么需要域驱动设计

* 映射领域
* 降低复杂性
* 可测试性
* 可维护性
* 知识丰富的设计
* 将业务和服务结合在一起
* 上下文集中
* 通用语言

## 领域分析

* 企业业务系统的目的往往跟决策者或者管理的诉求相关
  - 可追溯性（traceability）:指责任的可追溯性（traceability of liability），而通常都是在一些不太好的事情发生之后，才需要对责任进行追溯。所以想一个相对负面的例子更容易帮助找到建模所需要解决的问题。
  - 和执行效率（efficiency）
* 任何的业务事件都会以某种数据的形式留下足迹。对于事件的追溯可以通过对数据的追溯来完成。
* 四色建模法
  - 以满足管理和运营的需要为前提，寻找需要追溯的事件
  - 寻找足迹以及相应的时标性对象：通过时标性对象整理，得到整个领域模型的骨干
  - 添加实体对象，丰富这个模型，使它可以更好的描述业务概念。有三类：人，地点， 物（party/place/thing）
    + 可以进一步抽象这些实体
  - 添加一些需要描述的信息放入描述对象（description）
* 实例：科举系统
  - 学员信息 => Student
    + POST /students
  - 考试券 => Ticket
    + GET /students/1
  - 考试记录 => Exam
    + POST /exams
    + GET /students/1
    + GET /quizes/1
    + POST /commits
  - 证书 => Certification
    + GET /certifications/1
    + POST /certifications
    + GET /students/1
    + GET /exams/1

### 领域特定语言 Domain-Specific Languages

* Domain-Specific Language：A computer programming language of limited expressiveness focused on a particular domain
* 从六七十年代就已经有DSL的概念了（从某种程度上来说，COBOL和FORTRAN也算是DSL，一个面向商业，一个面向科学计算），然后有Regexp，再到现在的RoR，无一不采用了DSL的思想。那为什么Martin花那么长时间去写这本书呢？是因为DSL一直是一种隐性的知识或是技巧，并没有书面上的记载，这大大局限了DSL的使用。就像Design Pattern建立了OO模式的词汇表一样，Martin试图用此书建立一个DSL的词汇表，以促进DSL开发者之间的交流，加速DSL的发展。
* Fred Brook在Mythical man-month提到过：让我看你的流程而不让我看你的数据结构，我仍然一头雾水；让我看你的数据结构，我就不需要再看你的流程了，那将是显而易见的。简单的说，数据结构选对了，代码将会顺理成章；数据结构选错了，代码将会一塌糊涂。

## 通用语言 UL

* 特定域的开发人员和用户使用的通用语言，通过该语言可以轻松解释领域。
* 通用语言必须非常清晰，以便将所有团队成员处于同一水平线上，并以机器可以理解的方式进行翻译

## 有界上下文

* 领域驱动设计的核心模式。
* DDD 战略设计部门的重点是处理大型模型和团队。
* 通过将大型模型划分为不同的有界上下文并明确其相互关系来处理大型模型。

## 分层

* 架构
  - Infrastructure 基础实施层
    + 作为其他层的支撑库存在。它提供了层间的通信,实现对业务对象的持久化,包含对用户界面层的支撑库等作用。
    + 向其他层提供通用的技术能力：业务平台，编程框架，持久化机制，消息机制，第三方库的封装，通用算法，等等
  - Domain 领域层
    + 负责表达业务概念，业务状态信息以及业务规则
    + 保留业务对象状态,对业务对象和状态持久化被委托给了基础设施层，反映业务情况的状态是由本层控制并且使用
    + 领域层是业务软件的核心，领域模型位于这一层
  - Application 应用层
    + 很薄的一层,用来协调应用活动，定义软件要完成的任务，并且指挥表达领域概念的对象来解决问题
    + 要尽量简单，不包含业务逻辑、规则或者知识，而只为下一层中的领域对象协调任务，分配工作，使它们互相协作
    + 没有反映业务情况的状态，但是却可以具有另外一种状态，为用户或程序显示某个任务的进度
    + 不保留业务对象的状态,但保有应用任务的进度状态
  - User Interface 表示层|用户界面层或是接口层
    + 用于处理用户发送Restful请求、解析用户输入信息、校验等，并将信息传递给Application层的接口
    + 负责向用户展现信息以及解释用户命令
* 实施
  - 使用通用语言建立所有的聚合，实体，值对象
  - 建模
    + 战略建模：从一种宏观的角度去审核整个项目，划分出“界限上下文”，形成具有上帝视角的“上下文映射图”
    + 战术建模：在“战略建模”划分出来的“界限上下文”中进行“聚合”，“实体”，“值对象”，并按照模块分组

## 生命周期

在设计和实现一个系统的时候，业务领域专家和开发人员以一套统一语言进行协作，共同完成领域模型的构建，在这个过程中，业务架构和系统架构等问题都得到了解决，之后将领域模型中关于系统架构的主体映射为实现代码，完成系统的实现落地

## 战略设计

从高层“俯视”软件系统，帮助精准地划分领域以及处理各个领域之间的关系

* 领域/子域（Domain/Subdomain）
  - 建模在哪些子系统里面
  - 各个子系统之间的应该如何集成
  - 两个系统之间的集成涉及到基础设施和不同领域概念在两个系统之间的翻译
* 通用语言
  - 将一个限界上下文中的所有概念，包括名词、动词和形容词全部集中在一起，便为该限界上下文创建了一套通用语言
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

* 创建行为饱满的领域对象:需要转变一下思维，将领域对象当做是服务的提供方，而不是数据容器，多思考一个领域对象能够提供哪些行为，而不是数据
* 可以通过领域特定语言（DSL）的方式实现领域模型

## 基于业务分包

* 通过软件所实现的业务功能进行模块化划分
* 业务的载体——聚合根(Aggreate Root, AR)
* 实现
  - 聚合根是主要业务逻辑的承载体，也是“内聚性”原则的典型代表，因此通常的做法便是基于聚合根进行顶层包的划分
  - 在各自的顶层包下再根据代码结构的复杂程度划分子包
* 对内聚性的追求会自然地延伸出聚合根的边界
* 创建聚合根
  - 通常通过设计模式中的工厂(Factory)模式完成
    + 直接在聚合根中实现Factory方法，常用于简单的创建过程
    + 独立的Factory类，用于有一定复杂度的创建过程，或者创建逻辑不适合放在聚合根上
  - 业务逻辑的实现代码应该尽量地放在聚合根或者聚合根的边界之内，必要的妥协——领域服务

```
├── order
│   ├── OrderApplicationService.java
│   ├── OrderController.java
│   ├── OrderPaymentProxy.java
│   ├── OrderPaymentService.java
│   ├── OrderRepository.java
│   ├── command
│   │   ├── ChangeAddressDetailCommand.java
│   │   ├── CreateOrderCommand.java
│   │   ├── OrderItemCommand.java
│   │   ├── PayOrderCommand.java
│   │   └── UpdateProductCountCommand.java
│   ├── exception
│   │   ├── OrderCannotBeModifiedException.java
│   │   ├── OrderNotFoundException.java
│   │   ├── PaidPriceNotSameWithOrderPriceException.java
│   │   └── ProductNotInOrderException.java
│   ├── model
│   │   ├── Order.java
│   │   ├── OrderFactory.java
│   │   ├── OrderId.java
│   │   ├── OrderIdGenerator.java
│   │   ├── OrderItem.java
│   │   └── OrderStatus.java
│   └── representation
│       ├── OrderItemRepresentation.java
│       ├── OrderRepresentation.java
│       └── OrderRepresentationService.java

//
public static Product create(String name, String description, BigDecimal price) {
    return new Product(name, description, price);
}

private Product(String name, String description, BigDecimal price) {
    this.id = ProductId.newProductId();
    this.name = name;
    this.description = description;
    this.price = price;
    this.createdAt = Instant.now();
}

@Component
public class OrderFactory {
    private final OrderIdGenerator idGenerator;

    public OrderFactory(OrderIdGenerator idGenerator) {
        this.idGenerator = idGenerator;
    }

    public Order create(List<OrderItem> items, Address address) {
        OrderId orderId = idGenerator.generate();
        return Order.create(orderId, items, address);
    }
}
```

## 组成

* 实体(Entity)：那些具有生命周期并且会在其生命周期中发生改变的东西
  - 当一个对象由其标识（而不是属性）区分时
  - 只能通过唯一标识来实现了，因为即便两个实体所拥有的状态是一样的，依然是不同的实体，就像两个人的名字都叫张三，但是他们却是两个不同的人的个体
* 值对象(Value Object):起描述性作用的并且可以相互替换的概念,当一个对象用于对事物进行描述而没有唯一标识时
  - 没有唯一标识.equals()方法（比如在Java语言中）可以用它所包含的描述性属性字段来实现
  - 不变的(Immutable)，也就说一个值对象一旦被创建出来了便不能对其进行变更，如果要变更，必须重新创建一个新的值对象整体替换原有的
* 区分实体和值对象一个很重要原则便是根据相等性来判断
  - 实体对象的相等性是通过ID来完成的，对于两个实体，如果他们的所有属性均相同，但是ID不同，那么依然两个不同的实体
  - 对于值对象，相等性的判断是通过属性字段来完成的。
* 聚合（Aggregate）
  - 一组相关对象的集合，作为一个整体被外界访问，聚合根（Aggregate Root）是这个聚合的根节点
  - 聚合中所包含的对象之间具有密不可分的联系，内聚在一起
  - 聚合颗粒度：有无必要维护集合，可以通过ID的方式引用另外的聚合
  - 聚合由根实体，值对象和实体组成
    + 根是唯一允许外部对象保持对它的引用的元素
    + 边界内部的对象之间则可以互相引用
  - 需要将领域中高度内聚的概念放到一起组成一个整体，至于哪些概念才能聚到一起，需要对业务本身有很深刻的认识，这也是为什么DDD强调开发团队需要和领域专家一起工作的原因
  - 对聚合根的设计需要提防上帝对象(God Object)，也即用一个大而全的领域对象来实现所有的业务功能
    + 不同限界上下文使用各自的通用语言(Ubiquitous Language)，通用语言要求一个业务概念不应该有二义性，在这样的原则下，不同的限界上下文可能都有自己的Product类，虽然名字相同，却体现着不同的业务
    + 特征
      * 内聚性和一致性
      * 聚合根的实现应该与框架无关：既然DDD讲求业务复杂度和技术复杂度的分离，那么作为业务主要载体的聚合根应该尽量少地引用技术框架级别的设施，最好是POJO。试想一下，如果你的项目哪天需要从Spring迁移到Play，而你可以自信地给老板说，直接将核心Java代码拷贝过去即可，这将是一种多么美妙的体验。又或者说，很多时候技术框架会有“大步”的升级，这种升级会导致框架中API的变化并且不再支持向后兼容，此时如果我们的领域模与框架无关，那么便可做到在框架升级的过程中幸免于难。
      * 聚合根之间的引用通过ID完成：在聚合根边界设计合理的情况下，一次业务用例只会更新一个聚合根，此时你在该聚合根中去引用另外聚合根的整体有什么好处呢？在本文示例中，一个Order下的OrderItem引用了ProductId，而不是整个Product
      * 聚合根内部的所有变更都必须通过聚合根完成：为了保证聚合根的一致性，同时避免聚合根内部逻辑向外泄露，客户方只能将整个聚合根作为统一调用入口
      * 如果一个事务需要更新多个聚合根，首先思考一下自己的聚合根边界处理是否出了问题，因为在设计合理的情况下通常不会出现一个事务更新多个聚合根的场景。如果这种情况的确是业务所需，那么考虑引入消息机制和事件驱动架构，保证一个事务只更新一个聚合根，然后通过消息机制异步更新其他聚合根
      * 聚合根不应该引用基础设施
      * 外界不应该持有聚合根内部的数据结构
      * 尽量使用小聚合
* 领域服务（Domain Service）
  - 领域服务和上文中提到的应用服务是不同的，领域服务是领域模型的一部分，而应用服务不是。
  - 应用服务是领域服务的客户，它将领域模型变成对外界可用的软件系统。
  - 领域服务不能滥用，因为如果我们将太多的领域逻辑放在领域服务上，实体和值对象上将变成贫血对象。
  - 在分析某一领域时，一直在尝试如何将信息转化为领域模型，但并非所有的点都能用Model来涵盖
  - 对象应当有属性，状态和行为，但有时领域中有一些行为是无法映射到具体的对象中的，也不能强行将其放入在某一个模型对象中，而将其单独作为一个方法又没有地方，此时就需要服务
  - 服务是无状态的，对象是有状态的。所谓状态，就是对象基本属性：高矮胖瘦。
  - 服务本身也是对象，没有属性（只有行为），因此说是无状态的
* 领域事件（Domain Event）:对领域内发生的活动进行的建模
  - 最终一致性取代了事务一致性，通过领域事件的方式达到各个组件之间的数据一致性。
  - 命名遵循英语中的“名词+动词过去分词”格式，即表示的是先前发生过的一件事情
* 限界上下文
  - 一个由显示边界限定的特定职责。领域模型便存在于这个边界之内。在边界内，每一个模型概念，包括它的属性和操作，都具有特殊的含义。
  - 一个给定的业务领域会包含多个限界上下文，想与一个限界上下文沟通，则需要通过显示边界进行通信。系统通过确定的限界上下文来进行解耦，而每一个上下文内部紧密组织，职责明确，具有较高的内聚性。
  - 如何划分限界上下文？
    + 考虑产品所讲的通用语言，从中提取一些术语称之为概念对象，寻找对象之间的联系；或者从需求里提取一些动词，观察动词和对象之间的关系
    + 将紧耦合的各自圈在一起，观察他们内在的联系，从而形成对应的界限上下文
    + 形成之后，可以尝试用语言来描述下界限上下文的职责，看它是否清晰、准确、简洁和完整
    + 限界上下文应该从需求出发，按领域划分。
* 资源库（Repositories）
  - 用于保存和获取聚合对象，Repository和DAO所扮演的角色相似，不过DAO的设计初衷只是对数据库的一层很薄的封装，而Repository是更偏向于领域模型
  - 在所有的领域对象中，只有聚合根才“配得上”拥有Repository，而DAO没有这种约束
  - 所扮演的角色只是向领域模型提供聚合根而已，就像一个聚合根的“容器”一样，这个“容器”本身并不关心客户端对聚合根的操作到底是新增还是更新，给一个聚合根对象，Repository只是负责将其状态从计算机的内存同步到持久化机制中，从这个角度讲，Repository只需要一个类似save()的方法便可完成同步操作
  - 资源库和DAO是存在显著区别的
    + DAO只是对数据库的一层很薄的封装，而资源库则更加具有领域特征。
    + 所有的实体都可以有相应的DAO，但并不是所有的实体都有资源库，只有聚合才有相应的资源库
  - 分类
    + 基于集合的，具有编程语言中集合的特征
    + 基于持久化的，不仅用于添加新的聚合，还用于显式地更新既有聚合
  - 封装所有获取对象引用所需的逻辑。领域对象不需处理基础设施，以得到领域中对其他对象的所需的引用。只需从资源库中获取它们，于是模型重获它应有的清晰和焦点。
  - 资源库会保存对某些对象的引用。当一个对象被创建出来时，它可以被保存到资源库中，然后以后使用时可从资源库中检索到。如果客户程序从资源库中请求一个对象，而资源库中并没有它，就会从存储介质中获取它。换种说法是，资源库作为一个全局的可访问对象的存储点而存在。
  - Repository的接口应当采用领域通用语言。作为客户端，不应当知道数据库实现的细节
  - 和DAO的作用类似，二者主要区别：
    + DAO是比Repository更低的一层，包含了如何从数据库中提取数据的代码
    + Repository以“领域”为中心，所描述的是“领域语言”。Repository把ORM框架与领域模型隔离，对外隐藏封装了数据访问机制

```java
# 聚合
public class BlogApplicatioinService {

    @Transactional
    public void createBlog(String blogName, String userId) {
        User user = userRepository.userById(userId);
        Blog blog = user.createBlog(blogName);
        blogRepository.save(blog);
    }
}

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

## 步骤

* 对齐：业务模型对齐需求
* 发现：对领域实现可视化和协作
* 解耦：将领域分为子域
* 连接：将子域形成为一种松耦合架构
* 战略：专攻业务差异化的核心子域
* 组织：按照有界上下文组织团队
* 定义：定义每个有界上下文的角色和职责
* 编码：使用战术模式实现有界上下文

## 读写

* 写操作：严格地按照“应用服务 -> 聚合根 -> 资源库”
* 读操作的方式：
  - 基于领域模型:将读模型和写模型糅合到一起，先通过资源库获取到领域模型，然后将其转换为Representation对象
  - 基于数据模型:绕开了资源库和聚合，直接从数据库中读取客户端所需要的数据
  - CQRS(Command Query Responsibility Segregation)

```java
public OrderRepresentation toRepresentation(Order order) {
        List<OrderItemRepresentation> itemRepresentations = order.getItems().stream()
                .map(orderItem -> new OrderItemRepresentation(orderItem.getProductId().toString(),
                        orderItem.getCount(),
                        orderItem.getItemPrice()))
                .collect(Collectors.toList());

        return new OrderRepresentation(order.getId().toString(),
                itemRepresentations,
                order.getTotalPrice(),
                order.getStatus(),
                order.getCreatedAt());
    }

 @Transactional(readOnly = true)
    public PagedResource<ProductSummaryRepresentation> listProducts(int pageIndex, int pageSize) {
        MapSqlParameterSource parameters = new MapSqlParameterSource();
        parameters.addValue("limit", pageSize);
        parameters.addValue("offset", (pageIndex - 1) * pageSize);

        List<ProductSummaryRepresentation> products = jdbcTemplate.query(SELECT_SQL, parameters,
                (rs, rowNum) -> new ProductSummaryRepresentation(rs.getString("ID"),
                        rs.getString("NAME"),
                        rs.getBigDecimal("PRICE")));

        int total = jdbcTemplate.queryForObject(COUNT_SQL, newHashMap(), Integer.class);
        return PagedResource.of(total, pageIndex, products);
    }
```

## 贫血领域对象（Anemic Domain Object）

* 指仅用作数据载体，而没有行为和动作的领域对象。大量的业务逻辑写在了Service层中，随着业务逻辑复杂，业务逻辑、状态会散落在Service层中的很多处理类或方法中。将数据和行为割裂，原来的代码意图会越来越模糊，代码的理解和维护成本会越来越高。

## 领域模型的门面——应用服务

* 2种工作流程
  - 自底向上：先设计数据模型，比如关系型数据库的表结构，再实现业务逻辑。我在与不同的程序员结对编程的时候，总会是听到这么一句话：“让我先把数据库表的字段设计出来吧”。这种方式将关注点优先放在了技术性的数据模型上，而不是代表业务的领域模型，是DDD之反。
  - 自顶向下：拿到一个业务需求，先与客户方确定好请求数据格式，再实现Controller和ApplicationService，然后实现领域模型(此时的领域模型通常已经被识别出来)，最后实现持久化。
* 在DDD实践中，自然应该采用自顶向下的实现方式。ApplicationService的实现遵循一个很简单的原则，即一个业务用例对应ApplicationService上的一个业务方法
  - 业务方法与业务用例一一对应
  - 业务方法与事务一一对应：也即每一个业务方法均构成了独立的事务边界，在本例中，OrderApplicationService.changeProductCount()方法标记有Spring的@Transactional注解，表示整个方法被封装到了一个事务中。
  - 本身不应该包含业务逻辑：业务逻辑应该放在领域模型中实现，更准确的说是放在聚合根中实现，在本例中，order.changeProductCount()方法才是真正实现业务逻辑的地方，而ApplicationService只是作为代理调用order.changeProductCount()方法，因此，ApplicationService应该是很薄的一层
  - 与UI或通信协议无关：ApplicationService的定位并不是整个软件系统的门面，而是领域模型的门面，意味着ApplicationService不应该处理诸如UI交互或者通信协议之类的技术细节。在本例中，Controller作为ApplicationService的调用者负责处理通信协议(HTTP)以及与客户端的直接交互。这种处理方式使得ApplicationService具有普适性，也即无论最终的调用方是HTTP的客户端，还是RPC的客户端，甚至一个Main函数，最终都统一通过ApplicationService才能访问到领域模型
  - 接受原始数据类型：ApplicationService作为领域模型的调用方，领域模型的实现细节对其来说应该是个黑盒子，因此ApplicationService不应该引用领域模型中的对象。此外，ApplicationService接受的请求对象中的数据仅仅用于描述本次业务请求本身，在能够满足业务需求的条件下应该尽量的简单。因此，ApplicationService通常处理一些比较原始的数据类型。在本例中，OrderApplicationService所接受的Order ID是Java原始的String类型，在调用领域模型中的Repository时，才被封装为OrderId对象。

## 事件驱动架构 Event Driven Architecture EDA

* 在一个领域中所发生的一次对业务有价值的事情，落到技术层面就是在一个业务实体对象(通常来说是聚合根)的状态发生了变化之后需要发出一个领域事件
* 创建
  - 领域事件本身应该是不变的(Immutable)；
  - 领域事件应该携带与事件发生时相关的上下文数据信息，但是并不是整个聚合根的状态数据，例如，在创建订单时可以携带订单的基本信息，而对于产品(Product)名称更新的ProductNameUpdatedEvent事件，则应该同时包含更新前后的产品名称
* 发布
  - 引入事件表
    + 在更新业务表的同时，将领域事件一并保存到数据库的事件表中，此时业务表和事件表在同一个本地事务中，即保证了原子性，又保证了效率。
    + 在后台开启一个任务，将事件表中的事件发布到消息队列中，发送成功之后删除掉事件
* 消费
  - 消费方的幂等性
  - 消费方有可能进一步产生事件
* 风格
  - 事件通知
  - 事件携带状态转移(Event-Carried State Transfer)

```java
public abstract class DomainEvent {
    private final String _id;
    private final DomainEventType _type;
    private final Instant _createdAt;
}
public abstract class OrderEvent extends DomainEvent {
    private final String orderId;
}

public class OrderCreatedEvent extends OrderEvent {
    private final BigDecimal price;
    private final Address address;
    private final List<OrderItem> items;
    private final Instant createdAt;
}
```

## 动态领域建模 dynamic domain modelling

* 复杂性的挑战，在于其中涉及了两种类型的连接，即能导致结构复杂性的稳定连接，和能导致动态复杂性的任意连接。
* 结构复杂性常见于嵌套结构常见于嵌套结构,对象变得复杂的因素，包括其内部状态模型、规则及对象之间的连通性和可变性的深度
* 动态复杂性，源于自治组件或自治对象之间的交互。这就是在动态系统中所见到的复杂性。对象内部可能具有高度的复杂性，而对象之间不断变化的交互作用和任意连接性，造就了动态复杂性
* 领域的动态复杂性源于异步、并发、竞争和协作的过程
* 智能代理是一种能通过观察环境解决问题，并针对该环境执行操作的程序。在这期间，代理可以扮演角色，与其他代理（包括人类）协作并互动。
* 智能代理是人工智能的基石。其种类繁多，小到机器人，大到宇宙飞船。智能代理是理解其自主性（与代理的学习能力密切相关）的关键。智能代理的难题，是代理推理方法（或称作代理功能）的实现，即将给定的感知或目标与可能的最佳动作进行映射.使用能力栈来说明这些功能：
  - 使用诸如智能代理软件模型BDI和认知架构Soar之类的工具，实现基于推理的行为
  - 使用数字滤波器、数学控制系统，模糊逻辑和神经网络，用以发现连续的行为
  - 使用有限状态机，构建状态驱动的行为
  - 使用无记忆能力的函数（例如读取测量值），表示的简单行为
* Soar和BDI这两种领域模型，都是对人类大脑如何推理并将感知转化为行动所进行的建模。这两种架构都获得开源和商业实现的支持
* 行为建模面向那些做有趣事情的对象。这种建模从任务环境开始，并引出更详细的事件和任务模型。任务环境定义了上下文，并且定义了有哪些代理（如服务员），代理的绩效指标（如良好的用餐体验），代理的操作环境（如餐厅）以及代理的执行器（如言语、手和脚）和传感器（如眼睛和耳朵）。
* 事件和任务模型会使用一系列问题，以此将高层次的目标分解为更详细的任务：要执行的任务是什么？什么事件触发了某项任务？任务的预期成效是什么？发送了什么消息？以及谁是接收者？谁执行了这项任务？在执行任务时会创建哪些事件？
* 在开发事件和任务模型时，需要考虑两个重要因素：首先，哪些任务将同时执行？并且它们是否会争用相同的资源？如果是，那么就会面临竞态条件和可能的死锁，所以需要并发编程技能。其次，如果任务的执行时间有限，即必须在给定的时间范围内完成任务，那么需要有实时系统的技能。为了支持动态系统的建模，我们需要在领域驱动设计工具箱中添加4个概念：
  - 任务，即代理要执行的工作。
  - 代理，即感知其环境并执行任务的对象。
  - 代理功能，即代理如何将其感知映射到其所要执行的任务的能力。
  - 事件，即发生了的事情，且因此触发了要执行的任务。
* 领域对象的极致就是代理”？
  - 物联网以及软件定义世界的趋势，改变了商业软件的规则。后台进程必须能够响应边缘事件，还必须能够向边缘进程和设备实时发送新指令。自动化工作始于捕获任务。
  - 希望你现在可以理解这一点——代理是许多领域的一等公民，是领域对象发展的极致。

## 命令查询的责任分离 Command Query Responsibility Segregation CQRS

## 和微服务什么关系

* DDD中的限界上下文则完美匹配微服务要求，可以将该限界上下文理解为一个微服务进程。DDD在面向高度复杂的软件系统，如何去建模，它的核心点是根据系统的复杂度建立合适的模型
* DDD的本质是一种软件设计方法，而微服务是具体的落地实现

## 防腐层

## 注意

* 微服务中应该首先建立UL（Ubiquitous Language，通用语言），然后再讨论领域模型。
* 一个微服务最大不要超过一个BC（Bounded Context，限界上下文），否则微服务内会存在有歧义的领域概念。
* 一个微服务最小不要小于一个聚合，否则会引入分布式事务的复杂度。
* 微服务的划分过程类似于BC的划分过程，每个微服务都有一个领域模型。
* 微服务间的集成可以通过Context Map来完成，比如ACL（Anticorruption Layer，防腐层）。
* 微服务间最好采用Domain Event（领域事件）来进行交互，使得微服务可以保持松耦合。

## 项目

* [jivejdon](https://github.com/banq/jivejdon):Jivejdon is a Domain Driven Design appication with CQRS/ES/Clean/Hexagonal architecture
* [freedom](https://github.com/8treenet/freedom):Freedom是一个基于六边形架构的框架，可以支撑充血的领域模型范式
* [php-ddd-example](https://github.com/CodelyTV/php-ddd-example):🐘🎯 Hexagonal Architecture + DDD + CQRS in PHP using Symfony 5 <https://pro.codely.tv/library/ddd-en-php>
* [ddd-starter-modelling-process](https://github.com/ddd-crew/ddd-starter-modelling-process):If you're new to DDD and not sure where to start, this process will guide you step-by-step

## 图书


* 《领域驱动设计：软件核心复杂性应对之道》（Eric Evans 著）
* 《领域驱动设计 Domain-driven Design》 Vaughn Vernon
  - [gdut-yy/Domain-Driven-Design-zh](https://github.com/gdut-yy/Domain-Driven-Design-zh):中文翻译 <http://gdut_yy.gitee.io/doc-ddd/>
* Patterns, Principles and Practices of Domain-Driven Design
* 领域驱动设计精粹
* 复杂软件设计之道：领域驱动设计全面解析与实战
* 《领域驱动设计模式、原理与实践》
* 实现领域驱动设计 implementing domain-driven design
* 解构领域驱动设计
  - GitChat 课程《领域驱动设计实践》

## 领域驱动设计峰会2020

* 于静：遗留系统改造
  - 基础
    + 团队转型
* 杨云：DDD 落地三步法
  - 函数式编程
  - 模型概念对齐
  - 事件风暴：战略建模、子域划分、微服务划分
  - 名动词：在子域内建模
  - 类型流：微观行为设计
    + 纯函数
    + 副作用函数
* 事件驱动领域驱动
  - 领域模型不断演进
  - 事件-》command
  - context
  - 微服务自治

## 工具

* [mural](https://www.mural.co)

## 参考

* [dddsample-core](https://github.com/citerus/dddsample-core):This is the new home of the original DDD Sample app (previously hosted at sf.net)
* [awesome-ddd](https://github.com/heynickc/awesome-ddd):A curated list of Domain-Driven Design (DDD), Command Query Responsibility Segregation (CQRS), Event Sourcing, and Event Storming resources
* [free-ddd-learning-resources](https://github.com/ddd-crew/free-ddd-learning-resources):A collection of resources for learning DDD. All are free to access.
* [](https://github.com/valignatev/ddd-dynamic):Domain Driven Design in Python, Ruby and other dynamic languages resources

* [使用什么样的开发流程才能更好实现DDD？不是敏捷！](https://www.jdon.com/54721)
* [领域驱动设计(DDD)实现之路](https://www.jianshu.com/p/cdbefdd55b99)
* [领域驱动设计(DDD)编码实践](https://www.jianshu.com/p/84f1d922a6d4)
* [事件驱动架构(EDA)编码实践](https://www.jianshu.com/p/fbd3951259eb)
* [简单可用的CQRS编码实践](https://www.jianshu.com/p/d5e344ccf62a)
* [后端开发实践系列——领域驱动设计(DDD)编码实践](https://insights.thoughtworks.cn/backend-development-ddd)
* [后端开发实践](https://insights.thoughtworks.cn/tag/backend-development/)
