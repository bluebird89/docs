# Code

* 把大块需求拆解成小块任务
* 把小块的任务实现成代码
* 两件事做得又好又快，就是程序员的基本功

## 资深

* 当你遇到一个棘手的问题，而有一个资深的程序员，快速地帮你解决了问题，说明他/她也走过这个坑。
* 没有书本会教你解决以前没人碰到过的问题。成年人可以直接去学习编码，孩子们则需要发掘他们的好奇心。
* 经验
    - 代码能够工作
    - 使代码清晰、可重用和整洁
    - 艺术家的敏感融入抽象逻辑中，他们相信代码的美感对编程来说，和所有的算法或编码模式一样重要。
    - 在过程中你教教他们如何把事情做好，你让他们知道这世界充满了有趣的事情等待他们去发现，你向他们展示如何充满激情地在他们所做的每件事中寻找那种瞬间的质量感。

## 习惯

* 花10，000小时练习编码。
* 阅读与您所在行业相关的研究论文。
* 不断构建项目（代码，代码，代码）。
* 阅读有关技术和产品的书籍。
* 在压力和截止日期前能够准确交付。
* 透彻阅读其他人的代码。
* 选择新语言（每年一种新语言规则）和技术（一旦发布就拿起新东西）。
* 结对编程，与不同类型的人合作。
* 编写高质量的代码，即具有国际标准的工程级代码。
* 积极参与开源项目。

## 建议

* 开发过程
    - 代码不仅仅是用来运行的。代码也是跨团队交流的一种方式，是向他人描述问题解决方案的一种方式。良好的代码可读性不是那么容易做到的，但它是编写代码最基础的部分之一。良好的代码可读性包括清晰地分解代码，选择恰当的自解释变量名，添加注释来描述所有隐含的内容。
    - 不要渴望你的 pull request 能为你赢得多少名声，而要多关注你的 pull request 能为你的用户和社区做些什么。要不惜一切代价避免“功利性的贡献”。如果你提交的功能对于这个产品想要达到的目的没有明显的帮助，就不要添加任何功能。
    - 品味也适用于代码。品味是一种受约束的满足过程，这种满足是由对简单的渴望所约束的。保持对简单性的偏爱。
    - 要学会说“不”——仅仅因为有人要求做某个特性，并不意味着你就应该这么做。每个特性都有一个超出初始实现的成本：维护成本、文档成本和用户的认知成本。我们要时刻提醒自己：我们真的应该这样做吗? 通常，答案是否定的。
    - 当你准备答应实现一个新的使用场景时，请记住，仅从字面意思理解实现用户的需求通常不是最佳选择。用户关注的仅仅是他们自己的特定使用场景，你必须从整个项目的角度出发，兼顾整体性和原则性。通常，正确的做法是在现有特性的基础上做扩展。
    - 不断进行持续集成，并以完整的单元测试覆盖为目标。确保你处在一个可以自信地编写代码的环境中；如果不是这样，那么你需要从构建正确的基础设施开始。
    - 可以不事先计划好一切。先试一下，看看结果如何。尽早对错误的选择进行回退。当然，前提是确保你的开发环境可以做到这一点。
    - 好的软件使困难的事情变得简单。问题一开始看起来很困难，并不意味着解决方案必须很复杂或者很难操作。在很多情况下，工程师给出的解决方案都是未经思考的，这就可能在有更简单的解决方案（虽然可能不那么明显）的情况下，带来不必要的复杂性（我们可以使用 ML！我们可以尝试构建一个应用程序！我们可以使用区块链！）。在编写任何代码之前，请确保你所选择的解决方案已经简单到不能再简单。做任何事情都要有本源思维。
    - 避免隐式规则。应该明确说明你自己开发的隐式规则，并与他人共享。当你发现自己提出了一个重复的、准算法的工作流时，你应该设法将它标准化到一个文档中，以便其他团队成员能够从此经验中获益。此外，你应该在软件中尝试自动化任何可以自动化的工作流 (例如，正确性检查)。
    - 在设计过程中应该考虑你选择方案的总体影响，而不仅仅是你希望关注的那些方面——比如收入或增长。除了你正在监控的那些指标之外，你的软件对其用户、对整个世界还会带来哪些影响? 是否存在超过价值主张的不良副作用? 在保持软件可用性的同时，你能做些什么来解决这些问题呢?
    - **设计伦理，把你的价值观融入你的作品中**
* API 的设计
    - 你的 API 是有用户的，因此它事关用户体验。在你做的每一个决定中，都要考虑到用户。要站在用户的角度思考问题，无论他们是初学者还是有经验的开发人员。
    - 总是想着让你的用户在使用 API 的过程中尽量减少认知负荷。自动化可以自动化的东西，最小化用户需要做的操作和选择，不显示不重要的选项，设计简单一致的工作流，反映简单一致的思维模型。
    - 简单的事情要简单处理，复杂的事情应该尽量简单化。不要为了少量特殊的使用场景而增加普通使用场景的认知负荷，即使是最低限度的。
    - 如果工作流的认知负荷足够低，那么用户在使用一到两次之后，应该可以凭记忆完成工作了 (无需查找教程或文档)。
    - 寻求与领域专家和实践者的心智模型相匹配的 API。有领域经验但没有 API 经验的人应该能够使用最少的文档直观地理解你的 API，主要是通过查看一些代码示例，看看哪些对象可用，以及它们的特征是什么。
    - 一个参数的含义应该是容易理解的，而不需要任何关于底层实现的上下文。必须由用户指定的参数应该与用户关于问题的心理模型相关，而不是与代码中的实现细节相关。API 只与它所要解决的问题有关，与软件在后台如何工作无关。
    - 最强大的心智模型是模块化和层次化的：在高层次上很简单，但在细节上很精确。同样地，一个好的 API 也应该是模块化和层次化的：易于使用，但具有表现力。在更少的对象上有复杂的特性和具有更简单特性的对象之间有一个平衡。一个好的 API 要有合理数量的对象，并具有相当简单的特性。
    - 你的 API 不可避免地反映了你选择的实现方式，特别是你选择的数据结构。要实现直观的 API，你必须选择自然适合其领域的数据结构——与领域专家的心智模型相匹配。
    - 有意识地设计端到端工作流，而不是一组原子特性。大多数开发人员在设计 API 时都会问：我们应该提供哪些功能? 让我们为这些功能提供配置选项吧。恰恰相反，开发人员应该这样问：这个工具有哪些使用场景? 对于每个使用场景，用户操作的最佳顺序是什么? 支持这个工作流的最简单的 API 是什么? 你的 API 中的原子选项应该能够满足在高级工作流中出现的明显需求——不要“因为有人可能需要它”而添加某个功能。
    - 错误消息，以及在与 API 交互过程中向用户提供的任何反馈，都是 API 的一部分。交互性和反馈是用户体验的一部分。需要谨慎的设计 API 的错误消息。
    - 因为代码是一种交流方式，所以命名很重要——无论是命名项目还是变量。名字反映了你对问题的看法。避免使用过于通用的名称（ x, variable, parameter），避免使用过于冗长和特定的命名模式，避免使用可能造成不必要误解的术语 (主、从)，并确保你的命名选择方式是一致的。命名一致性意味着内部命名一致性 (不要在其他地方将“dim”称为“axis”) 和与问题域的既定约定的一致性。在确定名称之前，请确保查找领域专家 (或其他 API) 使用的现有名称。
    - 文档是影响 API 用户体验的关键。它不是一个附加产品。着力产出高质量的文档，你将看到比开发更多功能带来的更高回报。
    - Show, don 't tell：你的文档不应该讨论软件是如何工作的，它应该展示如何使用这个软件。显示端到端工作流的代码示例；为 API 的每个常见使用场景和关键特性展示代码示例。
    - **生产力可以归结为快速决策和偏好行动**
* 软件职业生涯
    - 事业的进步不在于你管理了多少人，而在于你产生了多大的影响：一个有你的工作的世界和一个没有你的工作的世界之间的差别。
    - 软件开发是团队合作 ; 它不仅关乎技术能力，也关乎人际关系。做一个好队友。当你开始做事情的时候，要和别人保持沟通。
    - 技术从来都不是中立的。如果你的工作可能对世界产生任何影响，那么这种影响是有道德导向的。我们在软件产品中做出的看似无害的技术选择有可能会影响获得技术的条件、使用动机、谁将受益、谁将受害。技术选择也是伦理选择。因此，对于你希望自己的选择支持的价值，一定要慎重和明确。基于道德准则来做设计，把你的价值观融入你的作品中。永远不要想，我只是在开发一种能力，这个能力本身是中性的。并不是因为你的开发方式决定了它将如何被使用。
    - 自我指导——掌控你的工作和环境——是获得生活满足感的关键。确保你给你周围的人足够的自我导向，确保你的职业选择为你自己带来更大的回报。
    - 创造世界所需要的，而不仅仅是你希望拥有的。技术人员往往过着精细化的生活，专注于满足自己特定需求的产品。寻找机会拓宽你的生活经验，这将使你更好地看到世界需要什么。
    - 当做出任何具有长期影响的选择时，将你的价值观置于短期的自我利益和短暂的情绪之上——比如贪婪或恐惧。知道你的价值观是什么，让它们来引导你。
    - 当我们发现自己陷入矛盾中时，应该停下来寻找我们共同的价值观和共同的目标，并提醒自己，我们几乎肯定站在同一条战线上。
    - 生产力可以归结为快速决策和偏好行动。这需要 a) 来自经验的良好直觉，以便在给出部分信息的情况下做出普遍正确的决定 ; b) 对何时要小心地前进或等待更多信息要有敏锐的意识，因为一个错误的决定的代价将大于等待的代价。 在不同的环境中，最佳速度 / 质量决策权衡可能会有很大的差异。
    - 快速做决定意味着在你的职业生涯中你能做出更多的决定，这会让你对哪一个备选项才是正确的选择产生更强的直觉。经验是生产力的关键，更高的生产力将为你提供更多的经验：这是一个良性循环。
    - 在你意识到自己缺乏直觉的情况下，坚持抽象原则。在你的职业生涯中建立一个可靠的原则清单。原则是形式化的直觉，比原始模式识别适用于更广泛的情况 (这需要对类似情况有直接且广泛的经验)。


* 本质上做技术的都是手艺人，但代码不会传承，代码只会更新—程序员都是不吃老本的手艺人。
* 工作越久越发现，靠谱和情商慢慢比技术能力还要重要一些。
* 程序员的收入相对可观，但把「月薪」变成「时薪」，你会发现所谓赚得多其实是个笑话。这行吃的是青春饭，30岁后的一段日子里，从业者就能感受到了前所未有的压力。
* 于是开始强迫自己研究投资理财—我发现我们在理财方面是有优势的！比如流水不低，花钱又不多，结余率很高，每个月都有比较可观的钱可以拿去理财；
* 我们对新事物的接受程度高，更容易抓住新物种的早期红利；我们「执行力」比普通人强，而执行力在投资中太重要了；
* 最好的理财方式，是构建一个「赚钱系统」。搭建好框架后，我们只需花少量的时间做后期维护。这个系统会源源不断地赚取「睡后收入」。

## GOOD

* The only “best practice” you should be using all the time is “Use Your Brain”.
* Programmers who don’t code in their spare time for fun will never become as good as those that do.
* Most comments in code are in fact a pernicious form of code duplication.
* XML is highly overrated
* Not all programmers are created equal
* ”Googling it” is okay!
* If you only know one language, no matter how well you know it, you’re not a great programmer.
* Your job is to put yourself out of work.
* Design patterns are hurting good design more than they’re helping it.
* Unit Testing won’t help you write good code
* 过早的优化是万恶之源。Premature optimization is the root of all evil! – Donald Knuth
* 在水里行走和以一个需求规格进行软件开发，有一点是相同的，那就是如果水或需求都被冻住不了，那么行走和软件开发都会变得容易。Walking on water and developing software from a specification are easy if both are frozen – Edward V Berard
* Hofstadter 定理：“一件事情总是会花费比你预期更多的时间，就算是你已经考虑过本条Hofstadter 定理”。It always takes longer than you expect, even when you take into account Hofstadter’s Law. – Hofstadter’s Law
* 有些遇到问题的人总是会说“我知道，我会使用正则表达式”，那么，你现在有两个问题了。（意思是：你本想用正则表达式来解决你已有问题，但实际上你又引入了“正则表达式”的一个新问题）Some people, when confronted with a problem, think “I know, I’ll use regular expressions.” Now they have two problems – Jamie Zawinski
* 调试程序的难度是写代码的两倍。因此，只要你的代码写的尽可能的清楚，那么你在调试代码时就不需要那么地有技巧。Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it. – Brian Kernighan
* 用代码行来衡量开发进度，无异于用重量来衡量制造飞机的进度。Measuring programming progress by lines of code is like measuring aircraft building progress by weight.  – Bill Gates
* PHP被一些不合格的业余人员造就成了一个小恶魔；而Perl则是被一些熟练的但不正当的专业人员造就成了一个超级大恶魔。PHP is a minor evil perpetrated and created by incompetent amateurs, whereas Perl is a great and insidious evil, perpetrated by skilled but perverted professionals.  – Jon Ribbens
* 在两个场合我被问到：“请你告诉我，如果你给机器输入了错误的数字，那么，是否还能得到正确的答案？”我并不能正确领会这类想法。（注意，本引言的作者姓Babbage，这个名字和神父同名，意思是，作者在反问提问的人，你是问我还是向神父祈祷？）On two occasions I have been asked, ‘Pray, Mr. Babbage, if you put into the machine wrong figures, will the right answers come out?’ I am not able rightly to apprehend the kind of confusion of ideas that could provoke such a question.”  – Charles Babbage
* 在编程的时候，我们一定要想像一下，以后维护我们自己的代码的那个人会成为一个有暴力倾向的疯子，并且，他还知道我们住在哪里？Always code as if the guy who ends up maintaining your code will be a violent psychopath who knows where you live. – Rick Osborne
* 现代的编程是“程序员努力建一个更大更傻的程序”和“世界正在尝试创造更多更傻的人”之间的一种竞赛，目前为止，后者是赢家。Programming today is a race between software engineers striving to build bigger and better idiot-proof programs, and the Universe trying to produce bigger and better idiots. So far, the Universe is winning. – Rich Cook
* 我才不关于我的代码是否能在你的机器上工作！我们不会给你提供机器。I don’t care if it works on your machine! We are not shipping your machine! – Ovidiu Platon
* 我总是希望我的电脑能够像电话一样容易使用；我的这个希望正在变成现实，因为我现在已经不知道怎么去使用我的电话了。I have always wished for my computer to be as easy to use as my telephone; my wish has come true because I can no longer figure out how to use my telephone. – Bjarne Stroustrup
* 计算机是一种在人类历史上所有发明中，可以让你比以前更快地犯更多的错误的发明，同样，其也包括了“手枪”和“龙舌兰酒”这两种发明的缺陷。A computer lets you make more mistakes faster than any other invention in human history, with the possible exceptions of handguns and tequila. – Mitch Ratcliffe
* 如果调试程序是一种标准的可以铲除BUG的流程，那么，编程就是把他们放进来的流程。If debugging is the process of removing software bugs, then programming must be the process of putting them in. – E. W. Dijkstra
* 教一群被BASIC先入为主的学生，什么是好的编程风格简直是一件不可能的事。对于一些有潜力的程序员，他们所受到的智力上的伤害远远超过了重建他们的信心。It is practically impossible to teach good programming style to students that have had prior exposure to BASIC. As potential programmers, they are mentally mutilated beyond hope of regeneration. – E. W. Dijkstra
* 理论上来说，理论和实际是一样的。但实际上来说，他们则不是。In theory, theory and practice are the same. In practice, they’re not. – Unknown
* 只有两个事情是无穷尽的：宇宙和人类的愚蠢。当然，我现在还不能确定宇宙是无穷尽的。Two things are infinite: the universe and human stupidity; and I’m not sure about the universe. – Albert Einstein
* Perl这种语言就好像是被RSA加密算法加密过的一样。Perl – The only language that looks the same before and after RSA encryption. – Keith Bostic
* 我爱“最终期限”，我喜欢“嗖嗖嗖”的声音就像他们在飞一样。I love deadlines. I like the whooshing sound they make as they fly by. – Douglas Adams
* 说Java好的是因为它跨平台就像好像说肛交好是因为其可以适用于一切性别。Saying that Java is good because it works on all platforms is like saying anal sex is good because it works on all genders – Unknown
* XML就像是一种强暴——如果它不能解决你的问题，那只能说明你没有用好它。XML is like violence – if it doesn’t solve your problems, you are not using enough of it. – Unknown
* 爱因期坦说，自然界中的一切一定会有一个简单的解释，因为上帝并不是反复无常和独裁的。当然，不会有什么信仰能程序员像爱因期坦那样感到舒服。Einstein argued that there must be simplified explanations of nature, because God is not capricious or arbitrary. No such faith comforts the software engineer. – Fred Brooks
* 函数不要超过50行。
* 不要一次性写太多来不及测的代码，而是要写一段调试一段
* UT和编码要同步做
* 多写注释方便的往往是自己
* 碰到一堆问题时，一次只尝试解决一个问题
* 没把握一眼看出问题症结的时候，老老实实单步调试
* 设计模式是个好东西，但不要强行使用
* 没造成可观的损失前不要尝试做性能优化
* 没事别重复造轮子
* 大多数情况下Boss不关心技术含量，而且往往简单的解决方案更快更有效果
* 不要害怕接触新知识，因为害怕也没用，不管你愿意不愿意，你现在会的东西5年后就会过时
* 重构是程序员的主力技能
* 工作日志能提升脑容量
* 先用profiler调查，才有脸谈优化
* 漫山遍野的注释实际背景噪音
* 普通程序员+google=超级程序员
* 写单元测试总是合算的
* 不要先写框架再写实现。最好反过来，从原型中提炼框架
* 代码结构清晰，其它问题都不算事儿
* 管理行不行，就看工作流
* 编码不要畏惧变化，要拥抱变化
* 常充电。程序员只有一种死法：土死的。

## BAD

* 情绪化的思维
* 怀疑别人
* 过多关注实现，陷入问题细节
* 使用并不熟悉的代码
* 拼命工作而不是聪明的工作
* 总是在等待、找借口以及抱怨
* 滋生办公室政治
* 说得多做得少
* 顽固
* 写“聪明”的代码

## LISCENSE

* 开源许可证是一种法律许可。通过它，版权拥有人明确允许，用户可以免费地使用、修改、共享版权软件。
* 版权法默认禁止共享，也就是说，没有许可证的软件，就等同于保留版权，虽然开源了，用户只能看看源码，不能用，一用就会侵犯版权。所以软件开源的话，必须明确地授予用户开源许可证。
* 宽松式（permissive）许可证
    - 没有使用限制 用户可以使用代码，做任何想做的事情。
    - 没有担保 不保证代码质量，用户自担风险。
    - 披露要求（notice requirement） 用户必须披露原始作者。
    - 常见:允许用户任意使用代码，区别在于要求用户遵守的条件不同。
        + BSD（ Berkeley Software Distribution 二条款版） 分发软件时，必须保留原始的许可证声明。
        + BSD（3-clause license） 分发软件时，必须保留原始的许可证声明。不得使用原始作者的名字为软件促销。
            * 如果再发布的产品中包含源代码，则在源代码中必须带有原来代码中的BSD协议。
            * 如果再发布的只是二进制类库/软件，则需要在类库/软件的文档和版权声明中包含原来代码中的BSD协议。
            * 不可以用开源代码的作者/机构名字和原来产品的名字做市场推广。
            * BSD 代码鼓励代码共享，但需要尊重代码作者的著作权。BSD由于允许使用者修改和重新发
        + MIT 分发软件时，必须保留原始的许可证声明，与 BSD（二条款版）基本一致。
            * 作者只想保留版权,而无任何其他了限制。MIT与BSD类似，但是比BSD协议更加宽松，是目前最少限制的协议
            * 这个协议唯一的条件就是在修改后的代码或者发行包包含原作者的许可信息。适用商业软件。使用MIT的软件项目有：jquery、Node.js。
        + Apache 2 分发软件时，必须保留原始的许可证声明。那些涉及专利内容的开发者而言，该协议最适合 凡是修改过的文件，必须向用户说明该文件修改过；没有修改过的文件，必须保持许可证不变。
            * 永久权利: 一旦被授权，永久拥有。
            * 全球范围的权利: 在一个国家获得授权，适用于所有国家。
            * 授权免费，且无版税: 前期，后期均无任何费用。
            * 授权无排他性: 任何人都可以获得授权
            * 授权不可撤消: 一旦获得授权，没有任何人可以取消。比如，你基于该产品代码开发了衍生产品
        + EPL (Eclipse Public License 1.0)
            * EPL允许Recipients任意使用、复制、分发、传播、展示、修改以及改后闭源的二次商业发布。
            * 使用EPL协议，需要遵守以下规则：
            * 当一个Contributors将源码的整体或部分再次开源发布的时候,必须继续遵循EPL开源协议来发布,而不能改用其他协议发布.除非你得到了原"源码"Owner 的授权；
            * EPL协议下,你可以将源码不做任何修改来商业发布.但如果你要发布修改后的源码,或者当你再发布的是Object Code的时候,你必须声明它的Source Code是可以获取的,而且要告知获取方法；
            * 当你需要将EPL下的源码作为一部分跟其他私有的源码混和着成为一个Project发布的时候,你可以将整个Project/Product以私人的协议发布,但要声明哪一部分代码是EPL下的,而且声明那部分代码继续遵循EPL；
            * 独立的模块(Separate Module),不需要开源。
* Copyleft 许可证:
    - 如果分发二进制格式，必须提供源码
    - 修改后的源码，必须与修改前保持许可证一致
    - 不得在原始许可证以外，附加其他限制
    - 常见
        + Affero GPL (AGPL) 如果云服务（即 SAAS）用到的代码是该许可证，那么云服务的代码也必须开源。
        + GPL（GNU General Public License） 如果项目包含了 GPL 许可证的代码，那么整个项目都必须使用 GPL 许可证。Linux 采用了 GPL
            * 出发点是代码的开源/免费使用和引用/修改/衍生代码的开源/免费使用，但不允许修改后和衍生的代码做为闭源的商业软件发布和销售。
        + LGPL 如果项目采用动态链接调用该许可证的库，项目可以不用开源。
        + Mozilla（MPL） 只要该许可证的代码在单独的文件中，新增的其他文件可以不用开源。
            * MPL协议允许免费重发布、免费修改，但要求修改后的代码版权归软件的发起者 。这种授权维护了商业软件的利益，它要求基于这种软件的修改无偿贡献版权给该软件。这样，围绕该软件的所有代码的版权都集中在发起开发人的手中。但MPL是允许修改，无偿使用得。MPL软件对链接没有要求。

## 语言

* [skiplang/skip](https://github.com/skiplang/skip):A programming language to skip the things you have already computed http://www.skiplang.com

## 项目

* [gothinkster/realworld](https://github.com/gothinkster/realworld):"The mother of all demo apps" — Exemplary fullstack Medium.com clone powered by React, Angular, Node, Django, and many more 🏅 https://realworld.io/

## 参考

* [Java World](http://www.javaworld.com/)
* [Java SE 技术文档](http://docs.oracle.com/javase/)
* [DZone](http://www.dzone.com)
* [Stackoverflow](http://stackoverflow.com/)
* [30-seconds/30-seconds-of-code](https://github.com/30-seconds/30-seconds-of-code)：Curated collection of useful Javascript snippets that you can understand in 30 seconds or less. https://30secondsofcode.org/
* [教程](http://www.phperz.com/special.html)
* [aosabook/500lines](https://github.com/aosabook/500lines):500 Lines or Less
* [斯坦福大学公开课：编程方法学28集全](https://www.bilibili.com/video/av8048664)
* [hellerve/programming-talks](https://github.com/hellerve/programming-talks):Awesome & interesting talks about programming

## 工具

* [dawnlabs/carbon](https://github.com/dawnlabs/carbon):🎨 Create and share beautiful images of your source code https://dawnlabs.io/carbon
* [adambard/learnxinyminutes-docs](https://github.com/adambard/learnxinyminutes-docs):Code documentation written as code! How novel and totally my idea! http://learnxinyminutes.com/
* [justjavac/Programming-Alpha-To-Omega](https://github.com/justjavac/Programming-Alpha-To-Omega):从零开始学编程 系列汇总（从 α 到 Ω）
* [unbug/codelf](https://github.com/unbug/codelf):Best GitHub stars, repositories tagger and organizer. Search over projects from Github, Bitbucket, Google Code, Codeplex, Sourceforge, Fedora Project, GitLab to find real-world usage variable names https://unbug.github.io/codelf/
* [prettier/prettier](https://github.com/prettier/prettier):Prettier is an opinionated code formatter. https://prettier.io
* [ggreer/the_silver_searcher](https://github.com/ggreer/the_silver_searcher):A code-searching tool similar to ack, but faster. http://geoff.greer.fm/ag/
* [hackmdio/codimd](https://github.com/hackmdio/codimd):CodiMD - Realtime collaborative markdown notes on all platforms.
