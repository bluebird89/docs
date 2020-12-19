# [react](https://github.com/facebook/react)

A declarative, efficient, and flexible JavaScript library for building user interfaces. <https://reactjs.org>

* 与Jquery对比
  - DSL:声明式设计 - HTML这种语义话标签是不是很容易学习？
  - Jquery直接操作Dom, 是野战，正规作战需要战术，就如抽象MVC模型，用router提前声明路由轮转的逻辑，实现的时候就不需要大量的switch case
  - 组件重用 - 无状态
  - Model 与 View的同步机制
* 开创性地采用了 Virtual DOM（虚拟 DOM）避免了 DOM 操作消耗性能的问题，将 UI 拆分成不同的可组合、可复用、可维护的组件，组件和组件之间耦合度极低
* 优势
  - 声明式设计 −React采用声明范式，可以轻松描述应用
  - 高效:React通过虚拟DOM和Diff算法，最大限度地减少与DOM的交互和渲染。——提高运行效率
    + 用JS对象模拟DOM树
    + 比较两棵虚拟DOM树的差异
    + 把差异应用到真正的DOM树上
  - 灵活 −React可以与已知的库或框架很好地配合
  - JSX − JSX 是 JavaScript 语法的扩展
    + React 使用 JSX 来替代常规的 JavaScript
    + JSX 是一个看起来很像 XML 的 JavaScript 语法扩展
    + 优点
      * JSX 执行更快，因为在编译为 JavaScript 代码后进行了优化
      * 类型安全，在编译过程中就能发现错误
      * 使用 JSX 编写模板更加简单快速
  - 组件模块化 − 通过 React 构建组件，使得代码更加容易得到复用，能够很好的应用在大项目的开发中。——提高可维护性和复用性以及开发效率
  - 单向响应数据流 − React 实现了单向响应的数据流，从而减少了重复代码，这也是它为什么比传统数据绑定更简单。提高可维护性

## 哲学

* React 最棒的部分之一是引导思考如何构建一个应用
* 将设计好 UI 划分为组件层级
  - 可以将组件当作一种函数或者是对象来考虑，根据单一功能原则来判定组件的范围
  - UI（或者说组件结构）便会与数据模型一一对应，这是因为 UI 和数据模型都会倾向于遵守相同的信息结构
* 用 React 创建一个静态版本
* 确定 UI state 的最小（且完整）表示
* 确定 state 放置的位置
* 添加反向数据流

## 安装

* 在线体验
  - CodePen
  - CodeSandbox
  - Glitch
  - Stackblitz
* 在网站中添加 React
  - div
  - 添加 Script 标签
  - 创建一个 React 组件
* 工具链
  - 学习 React 或创建一个新单页应用，使用 [create-react-app](https://github.com/facebookincubator/create-react-app) Create React apps with no build configuration. <https://create-react-app.dev/>
  - 用 Node.js 构建服务端渲染的网站: Next.js
  - 面向内容的静态网站:Gatsby
  - 组件库或将 React 集成到现有代码仓库，尝试更灵活的[工具链](https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658)

```sh
npm install --save-dev @babel/core @babel/cli @babel/preset-env @babel/preset-react
npm install --save-dev webpack webpack-cli webpack-dev-server style-loader css-loader babel-loader

npm run --save react react-dom react-hot-loader

npm install -g create-react-app

npx create-react-app my-app
npm init react-app my-app
yarn create react-app my-app

create-react-app my-app
cd my-app

npm|yarn start
npm|yarn test
npm run build | yarn build

npm run eject #  导出配置文件
```

## 生态

* 不使用 HTML，而使用 JSX
* 抛弃了 SQL ，自己发明了一套查询语言 GraphQL

## JSX

* HTML 语言直接写在 JavaScript 语言之中，不加任何引号
* 允许 HTML 与 JavaScript 混写
* 注释 /*...*/
* 规则
  - 遇到 HTML 标签（以 < 开头），就用 HTML 规则解析
  - 遇到代码块（以 { 开头），就用 JavaScript 规则解析
  - 允许直接在模板插入 JavaScript 变量。如果这个变量是一个数组，则会展开这个数组的所有成员
* 嵌套多个 HTML 标签，需要使用一个 div 元素包裹它
* 允许在模板中插入数组，数组会自动展开所有成员
* 要渲染 HTML 标签，只需在 JSX 里使用小写字母的标签名
* 要渲染 React 组件，只需创建一个大写字母开头的本地变量
* 使用 className 和 htmlFor 来做对应的属性
* Babel 会把 JSX 转译成一个名为 React.createElement() 函数调用
* 通过花括号包裹代码，可以在 JSX 中嵌入表达式。这也包括 JavaScript 中的逻辑与 (&&) 运算符。它可以很方便地进行元素的条件渲染

## Components API

* 抛弃使用了createClass这个函数，这个也是为了配合ES6
* UI使用数据结构表示。UI变化就是一种数据结构变成另一种数据结构，是一个纯函数，同样的数据结构，就得到同样的UI
* 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。React.createClass 方法就用于生成一个组件类
* 将组件看成是一个状态机，一开始有一个初始状态，然后用户互动，导致状态变化，从而触发重新渲染 UI
* 语法
  - 所有组件类必须有 render 方法，用于输出组件
  - 组件最外层只能有一个标签。因为，一个组件就相当于调用一个构造函数，如果有多个标签，就变成一个组件对应多个构造函数
  - 原生提供组件，都是HTML语言已经定义的标签,组件首字母小写.用户自定义组件，首字母必须大写
* 属性
  - class 写成 className
  - for 写成 htmlFor ，因为 class 和 for 是 JavaScript 保留字
  - 向原生组件提供自定义属性，要写成data-前缀
* 场景
  - State
  - Lifecycle
* 复合组件
  - 子组件：父组件内部组件
    + Parent可以通过this.props.children属性，读取子组件
    + 同级而且同类型的每个子组件，应该有一个key属性，用来区分
  - 操作子组件
    + 父组件向子组件传入一个新参数
    + 子组件在componentWillReceiveProps方法里面处理新的参数，必要时调用setState方法
    + 子组件在componentWillUpdate方法里面处理新的state，但是一般来说，只使用componentWillReceiveProps方法就足够了
* Container Component
* Presentation Component
* findDOMNode 获取DOM节点
  - 如果组件已经挂载到DOM中，该方法返回对应的本地浏览器 DOM 元素
  - 当render返回null 或 false时，this.findDOMNode()也会返回null
  - 从DOM 中读取值的时候，该方法很有用，如：获取表单字段的值和做一些 DOM 操作
* isMounted 判断组件挂载状态
  - 用于判断组件是否已挂载到DOM中。可以使用该方法保证了setState()和forceUpdate()在异步场景下的调用不会出错
* 阻止组件渲染: 让 render 方法直接返回 null
* Do Not Define Components Within Components

## 生命周期

* 每个状态都提供两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用
* The constructor() method is called before anything else
  - called with the props, as arguments, and you should always start by calling the super(props) before anything else
* Mounting：已插入真实 DOM
  - componentWillMount():渲染前调用,只会执行一次，在浏览器和服务器都会执行。一般用来对props和state进行初始化处理
  - componentDidMount():可以读取组件生成的 DOM。如果要与 DOM 互动，应该就在这个方法里面，而不是在render方法里面
    + 在第一次渲染后调用，只在客户端
    + 之后组件已经生成了对应的DOM结构，可以通过this.getDOMNode()来进行访问
    + 如果想和其他JavaScript框架一起使用，可以在这个方法中调用setTimeout, setInterval或者发送AJAX请求等操作(防止异部操作阻塞UI)
    + run statements that requires that the component is already placed in the DOM.
  - getDefaultProps
  - getInitialState
  - render 将模板转为 HTML 语言，并插入指定的 DOM 节点
  - getDefaultProps 和 getInitialState 方法，都是只执行一次
  - getDerivedStateFromProps:called right before rendering the element(s) in the DOM
    + the natural place to set the state object based on the initial props
    + takes state as an argument, and returns an object with changes to the state
* Updating：重新渲染
  - getDerivedStateFromProps
    + the first method that is called when a component gets updated
  - shouldComponentUpdate
    + return a Boolean value that specifies whether React should continue with the rendering or not
    + default value is true
  - getSnapshotBeforeUpdate
    + you have access to the props and state before the update, meaning that even after the update, you can check what the values were before the update
    + If the getSnapshotBeforeUpdate() method is present, you should also include the componentDidUpdate() method, otherwise you will get an error
  - componentWillUpdate(object nextProps, object nextState)
    + called after the component is updated in the DOM.
    + 一旦shouldComponentUpdate返回true，componentWillUpdate就会执行，主要用于为即将到来的更新做准备工作
  - componentDidUpdate(object prevProps, object prevState) 每次组件重新渲染（render方法）后执行
    + 可以操作组件所在的 DOM，用于操作数据已经更新之后的组件
    + 可能 DOM 还没有完全生成:可以使用requestAnimationFrame或setTimeout方法，保证操作时 DOM 已经生成
* Unmounting：已移出真实 DOM
  - componentWillUnmount():在组件从 DOM 移除后调用。一种用途是清除componentDidMount方法中添加的定时器
* 两种特殊状态处理函数
  - componentWillReceiveProps(object nextProps)：已加载组件收到新参数时调用
    + 在shouldComponentUpdate和componentWillUpdate之前调用
    + 用来在render()调用之前，对props进行调整，然后通过this.setState()设置state。老的props可以用this.props拿到
    + 父组件每次重新传给当前组件参数时调用，在当前组件的render()之前调用。组件的第一次渲染不会调用这个方法
    + 只在父组件更新props时执行
    + 当前组件本身调用setState而引发重新渲染，是不会执行这个方法的。在此方法中调用setState也不会二次渲染的
    + 可以根据已有props和刚刚传入的props，进行state的更新，而不会触发组件的重新更新
  - shouldComponentUpdate(object nextProps, object nextState)：组件判断是否重新渲染时调用
  - 会在每次重新渲染（render方法）之前，自动调用。它返回一个布尔值，决定是否应该进行此次渲染
    + 默认为true，表示进行渲染
    + false，就表示中止渲染
* 重新挂载组件
  - getInitialState:
    + 初始化 this.state 的值，只在组件装载之前调用一次
    + 使用 ES6 的语法，可以在构造函数中初始化状态
    + Cannot read property:在ES6的实现中去掉了getInitialState这个hook函数，规定state在constructor中实现
  - componentWillMount
  - render
  - componentDidMount
* 再次渲染组件时，组件接受到父组件传来新参数
  - 更新 Props
  - componentWillReceiveProps
  - shouldComponentUpdate
  - componentWillUpdate
  - render
  - componentDidUpdate
* 组件自身state更新
  - 更新 state
  - shouldComponentUpdate
  - componentWillUpdate
  - render
  - componentDidUpdate
* 调用顺序
  - 当 <Clock /> 被传给 ReactDOM.render()的时候，React 会调用 Clock 组件的构造函数。因为 Clock 需要显示当前的时间，所以它会用一个包含当前时间的对象来初始化 this.state。会在之后更新 state。
  - 之后 React 会调用组件的 render() 方法。这就是 React 确定该在页面上展示什么的方式。然后 React 更新 DOM 来匹配 Clock 渲染的输出。
  - 当 Clock 的输出被插入到 DOM 中后，React 就会调用 ComponentDidMount() 生命周期方法。在这个方法中，Clock 组件向浏览器请求设置一个计时器来每秒调用一次组件的 tick() 方法。
  - 浏览器每秒都会调用一次 tick() 方法。 在这方法之中，Clock 组件会通过调用 setState() 来计划进行一次 UI 更新。得益于 setState() 的调用，React 能够知道 state 已经改变了，然后会重新调用 render() 方法来确定页面上该显示什么。这一次，render() 方法中的 this.state.date 就不一样了，如此以来就会渲染输出更新过的时间。React 也会相应的更新 DOM。
  - 一旦 Clock 组件从 DOM 中被移除，React 就会调用 componentWillUnmount() 生命周期方法，这样计时器就停止了

![生命周期](../../_static/react_lifecircle.png "生命周期")

```
// 写法一
const component = <Component name={name} value={value} />;

// 写法二
const component = <Component />;
component.props.name = name;
component.props.value = value;

// 写法三
const data = { name: 'foo', value: 'bar' };
const component = <Component {...data} />;
```

## props 组件参数

* 用法与原生的 HTML 标签完全一致，可以任意加入属性
  - 可以在组件类的 this.props 对象上获取
* 向组件传递参数，可以使用 this.props 对象
* props是父子组件交互的唯一方式。要修改一个子组件，需要通过的新的props来重新渲染
* props相当于组件的数据流，总是会从父组件向下传递至所有的子组件中
* getDefaultProps() 方法为 props 设置默认值
* 所有 React 组件都必须像纯函数一样保护它们的 props 不被更改
* defaultProps 指定props默认值
* 验证使用 propTypes
* `setProps(object nextProps[, function callback])` 当和一个外部JavaScript应用集成时，可能会需要向组件传递数据或通知React.render()组件需要重新渲染，可以使用setProps()
* `replaceProps(object nextProps[, function callback])` 删除原有 props
* forceUpdate([function callback])
  - 会使组件调用自身的render()方法重新渲染组件，组件的子组件也会调用自己的render()
  - 组件重新渲染时，依然会读取this.props和this.state，如果状态没有改变，那么React只会更新DOM
* 向组件传递数据，React组件从props拿到数据，然后返回视图。表示那些一旦定义，就不再改变的特性
  + like function arguments
  + component has a constructor function, the props should always be passed to the constructor and also to the React.Component via the super() method
  + Readonly
  + PropType Check 验证使用，可以保证应用组件被正确使用，React.PropTypes 提供很多验证器 (validator) 来验证传入数据是否有效
  + Have to be passed from parent
  + 使用
    * 向一个组件传递数据的方法是将数据写在组件的标签中 `<Content value = {this.state.value}/>`
    * 获取props `{props.value}`

## state 对象 内部变量

* 把组件看成是一个状态机（State Machines）。通过与用户的交互，实现不同状态，然后渲染 UI，让用户界面和数据保持一致
* 只需更新组件的 state，然后根据新的 state 重新渲染用户界面，不要操作 DOM
* getInitialState 方法用于定义初始状态，也就是一个对象
* 通过 this.state 属性读取
* `setState(object nextState[, function callback])` 合并nextState和当前state，每次修改以后，自动调用 this.render 方法，再次渲染组件
  - 不能在组件内部通过this.state修改状态，因为该状态会在调用setState()后被替换。
  - setState()并不会立即改变this.state，而是创建一个即将处理的state。setState()并不一定是同步的，为了提升性能React会批量执行state和DOM渲染
  - setState()总是会触发一次组件重绘，除非在shouldComponentUpdate()中实现了一些条件渲染逻辑
  - state 包含几个独立的变量,用 setState() 来单独地更新它们
* replaceState(object nextState[, function callback]) 只会保留nextState中状态，原state不在nextState中的状态都会被删除
* 内部状态 local state 或者局部状态，会随着用户互动而产生变化的特性,组件私有内部参数，不应暴露到外部
  + store property values that belongs to the component
  + Changeable
  + Local value have to be self managed
  + Do Not Modify State Directly,use setState()
  + State Updates May Be Asynchronous:React may batch multiple setState() calls into a single update for performance
    * this.props and this.state may be updated asynchronously, you should not rely on their values for calculating the next state.
  + State Updates are Merged
  + 每当state发生变化，render方法就会自动调用，从而更新组件
  + 使用
    * 初始化内部状态：React构造函数中
    * 更新内部状态：this.setstate
      - 参数
        + 对象:这个对象会被合并进入this.state，然后重新渲染组件
        + 函数:该函数执行后返回的对象会合并进this.state
        + 接受一个回调函数当作第二个参数，当状态改变成功、组件重新渲染后，立即调用
      - 总是会引起组件的重新渲染，除非shouldComponentUpdate()方法返回false
      - 有时this.setState设置的状态在render方法中并没有用到，即不改变 UI 的呈现，但是这时也会引起组件的重新渲染
      - Cannot read property 'setState' of undefined,方法中的this已经不是组件里的this了
        + 要将类的原型方法通过 props 传给子组件，传统写法需要 bind(this)，否则方法执行时 this 会找不到,constructor 中手动绑定this `this.handleClick = this.handleClick.bind(this);`
        + 用箭头函数代替普通函数:this是由声明该函数时候定义的，一般是隐性定义为声明该函数时的作用域this
    * 获取内部状态：this.state
  + 内部状态的操作配合React事件系统，可以实现用户交互的功能

## state vs props

* props 是不可变的，而 state 可以根据与用户交互来改变
* 父组件中设置｜更新 state， 并通过在子组件上使用 props 将其传递到子组件上
* 尽管 this.props 和 this.state 是 React 本身设置的，且都拥有特殊的含义，但是其实你可以向 class 中随意添加不参与数据流的额外字段
* this.props 和 this.state 可能会异步更新，所以你不要依赖他们的值来更新下一个状态
  - 可以让 setState() 接收一个函数而不是一个对象。这个函数用上一个 state 作为第一个参数，将此次更新被应用时的 props 做为第二个参数
* 称 state 为局部或是封装:除了拥有并设置了它的组件，其他组件都无法访问
* 自上而下”或是“单向”的数据流:组件可以选择把它的 state 作为 props 向下传递到它的子组件中

## The Data Flows Down 数据是向下流动的

* A component may choose to pass its state down as props to its child components
* top-down" or "unidirectional" data flow:Any state is always owned by some specific component, and any data or UI derived from that state can only affect components "below" them in the tree.

## 状态提升

* 多个组件需要反映相同的变化数据，这时建议将共享状态提升到最近的共同父组件中去
* 任何可变数据应当只有一个相对应的唯一“数据源”
  - state 都是首先添加到需要渲染数据的组件中去
  - 如果其他组件也需要这个 state，那么可以将它提升至这些组件的最近共同父组件中
  - 如果某些数据可以由 props 或 state 推导得出，那么它就不应该存在于 state 中

## 列表

* key 帮助 React 识别哪些元素改变了，比如被添加或删除。因此你应当给数组中的每一个元素赋予一个确定的标识
* 一个元素的 key 最好是这个元素在列表中拥有的一个独一无二的字符串。通常，我们使用数据中的 id 来作为元素的 key，万不得已可以使用元素索引 index 作为 key
  - 如果列表项目的顺序可能会变化，我们不建议使用索引来用作 key 值，因为这样做会导致性能变差，还可能引起组件状态的问题
* key 只是在兄弟节点之间必须唯一,不需要是全局唯一的。当生成两个不同的数组时，我们可以使用相同的 key 值

## 组合 vs 继承

* 包含关系
  - 组件无法提前知晓它们子组件的具体内容，组件使用一个特殊的 children prop 来将子组件传递到渲染结果中
  - 自行约定：将所需内容传入 props，并使用相应的 prop
* 特例关系:一些组件看作是其他组件的特殊实例,可以通过 props 定制并渲染“一般”组件
* Props 和组合 提供了清晰而安全地定制组件外观和行为的灵活方式。注意：组件可以接受任意 props，包括基本数据类型，React 元素以及函数
* 在组件间复用非 UI 的功能，建议将其提取为一个单独的 JavaScript 模块，如函数、对象或者类
  - 组件可以直接引入（import）而无需通过 extend 继承它们

## Refs

* 受控组件
  - React中，可变状态（mutable state）通常保存在组件的 state 属性中，并且只能通过 setState()来更新。
  - 将 React的state作为唯一的数据源，通过渲染表单的React组件来控制用户输入过程中表单发送的操作。通过此种方式控制取值的表单输入元素”被成为受控组件
* 不受控制组件
  - 表单数据由DOM本身处理。文件输入标签就是一个典型的不受控制组件，它的值只能由用户设置，通过DOM自身提供的一些特性来获取
* 受控组件和不受控组件最大的区别就是前者自身维护的状态值变化，可以配合自身的change事件，很容易进行修改或者校验用户的输入
* Refs的出现使得 不受控制组件自身状态值的维护变得容易了许多
* Refs 是一个 获取 DOM节点或 React元素实例的工具
* 需要在数据流之外强制修改子组件。被修改的子组件可能是一个React组件实例，也可能是一个DOM元素。对于这两种情况，React 都通过 Refs的使用提供了具体的解决方案
* 场景
  - 对DOM 元素焦点的控制、内容选择或者媒体播放；
  - 通过对DOM元素控制，触发动画特效；
  - 通第三方DOM库的集成
* 通过 React.createRef() API 使用
* 当ref属性用于普通 HTML 元素时，构造函数中使用 React.createRef() 创建的 ref 接收底层 DOM 元素作为其 current 属性
* 当 ref 属性用于自定义 class 组件时，ref 对象接收组件的挂载实例作为其 current 属性

* 指定一个回调函数，在组件加载到DOM之后调用
* 设为一个字符串
* 可以用来绑定到 render() 输出的任何组件上.允许引用 render() 返回的相应的支撑实例（backing instance）。这样就可以确保在任何时间总是拿到正确的实例

## Elements API

* 类就是组件（component），element是描述组件实例的对象
* Element上面不能调用任何方法，只是实例的一个不可变（immutable）描述，一旦创建，就不再发生变化
* 定义了最基本的渲染单位，是一个描述组件如何显示在屏幕上的对象
* 属性
  - type
    + 字符串 DOM节点，type是标签名，props是属性
    + 函数或对应React组件的类
  - props
    + children：子元素
* React.createElement方法用来生成一个React组件实例
  - 参数
    + React组件类
    + 一个对象:生成实例参数

## Events

* 事件的命名采用小驼峰式（camelCase），而不是纯小写
* 使用 JSX 语法时需要传入一个函数作为事件处理函数，而不是一个字符串
* 不能通过返回 false 的方式阻止默认行为,必须显式的使用 preventDefault
  - e 是一个合成事件。React 根据 W3C 规范来定义这些合成事件，所以你不需要担心跨浏览器的兼容性问题。React 事件与原生事件不完全相同
* In class components, the this keyword is not defined by default, so with regular functions the this keyword represents the object that called the method, which can be the global window object,binding this in the constructor function
* 一般不需要使用 addEventListener 为已创建的 DOM 元素添加监听器。事实上只需要在该元素初始渲染的时候添加监听器即可
  - 必须谨慎对待 JSX 回调函数中的 this，在 JavaScript 中，class 的方法默认不会绑定 this。如果你忘记绑定 this.handleClick 并把它传入了 onClick，当你调用这个函数的时候 this 的值为 undefined
  - 没有在方法后面添加 ()，例如 onClick={this.handleClick}，应该为这个方法绑定 this
  - 使用实验性的 public class fields 语法,
  - 在回调中使用箭头函数
* 向事件处理程序传递参数
  - `<button onClick={(e) => this.deleteRow(id, e)}>Delete Row</button>`
  - `<button onClick={this.deleteRow.bind(this, id)}>Delete Row</button>`

## Context

* 组件间跨级传递数据
* 使用
  - 根组件添加 childContextTypes 和 getChildContext 属性，React自动将context信息传向子树上的所有组件
  - 子组件通过定义contextTypes属性，可以获取context对象上的信息
    + 如果contextTypes属性没有定义，那么this.context将是一个空对象
    + 定义了contextTypes方法，那么生命周期方法会接收到一个额外的参数context对象
* 无状态函数组件也能够引用context对象
* 只要state或props发生变化，getChildContext就会被调用。后代组件就会接收到一个新的context对象
* 场景
  - 和全局变量相似，应避免使用
  - 场景包括：传递登录信息、语言选择、样式选择以及主题信息
* 如果只传递一些功能模块数据，则尽量不要使用context，使用props传递数据会更加清晰
* 会使组件复用性降低，因为组件依赖'上下文'，在别的地方渲染的时候，可能会出现差异
* Props与context用于在组件间传递数据
  - props传递数据简单清晰，但是跨级传递非常麻烦
  - context可以跨级传递数据，但是会降低组件的复用性，因为这些组件依赖“上下文”
  - 尽量只使用context传递登录状态、颜色主题等全局数据

## Form

* 在大多数情况下，推荐使用受控组件 来处理表单数据。在一个受控组件中，表单数据是由 React 组件来管理的
  - 受控组件:使 React 的 state 成为“唯一数据源”。渲染表单的 React 组件还控制着用户输入过程中表单发生的操作。被 React 以这种方式控制取值的表单输入元素就叫做“受控组件”
  - 指定 value 的 prop 会阻止用户更改输入。如果指定了 value，但输入仍可编辑，则可能是意外地将value 设置为 undefined 或 null
* 另一种替代方案是使用非受控组件，这时表单数据将交由 DOM 节点来处理

## [React-Router](https://github.com/reactjs/react-router)

* 嵌套路由
  - 访问子组件：先加载父组件，然后在它的内部再加载子组件

## ReactDOM

* 方法
  - findDOMNode 只对已经挂载组件有效，因此一般只在componentDidMount和componentDidUpdate方法中使用
  - unmountComponentAtNode
  - render 将组件挂载到真实DOM之中,并且返回该组件的实例
    + 如果是无状态组件，render会返回null
    + 当组件挂载完毕，会执行回调函数
* ReactDOMServer.renderToString():将一个React组件转成HTML字符串，一般用于服务器渲染
  - 如果ReactDOM.render()在一个已经完成服务器渲染的DOM节点上面挂载React组件，那么该组件不会挂载，只会添加事件监听到这个DOM节点

## class vs function

* 类（class）是数据和逻辑的封装。 也就是说，组件的状态和操作方法是封装在一起的。如果选择了类的写法，就应该把相关的数据和操作，都写在同一个 class 里面
* 函数一般来说，只应该做一件事，就是返回一个值。如果有多个操作，每个操作应该写成一个单独的函数。而且，数据的状态应该与操作方法分离。根据这种理念，React 的函数组件只应该做一件事情：返回组件的 HTML 代码，而没有其他的功能

## Hook

* 从 React Hooks 发布以来，基于函数的组件已升格为 React 的一等公民。使函数组件能够以新的方式编写、重用和共享 React 代码
* React 函数组件的副效应解决方案，用来为函数组件引入副效应。 函数组件的主体只应该用来返回组件的 HTML 代码，所有的其他操作（副效应）都必须通过钩子引入
* 规则
  - 仅在顶级调用 Hooks:不要在循环、条件和嵌套函数内调用 Hooks:确保Hook总是以相同的顺序调用
  - 当想有条件地使用某些 Hooks 时，请在这些 Hooks 中写入条件
  - 仅从函数组件调用 Hooks
  - 以正确的顺序创建函数组件:首先调用构造器并启动状态。然后编写生命周期函数，接着编写与组件作业相关的所有函数。最后编写 render 方法
* useState【维护状态】Stateful component 为组件提供了定义为函数的状态
  - 为函数组件引入状态（state）。纯函数不能有状态，所以把状态放在钩子里面
  - 用法可以和类组件的状态完全一致，不只用于单个值
  - Event handler is a function:
* useEffect【完成副作用操作】
  - 指定一个副效应函数，组件每渲染一次，该函数就自动执行一次。组件首次在网页 DOM 加载后，副效应函数也会执行
  - 以理解成它替换了componentDidMount, componentDidUpdate, componentWillUnmount 这三个生命周期
  - 参数是一个函数，它就是所要完成的副效应,组件加载以后，React 就会执行这个函数
  - 第二个参数:使用一个数组指定副效应函数的依赖项，只有依赖项发生变化，才会重新渲染
    + 一个空数组，就表明副效应参数没有任何依赖项。因此，副效应函数这时只会在组件加载进入 DOM 后执行一次，后面组件重新渲染，就不会再次执行
  - 用途
    + 获取数据（data fetching）
    + 事件监听或订阅（setting up a subscription）
    + 改变 DOM（changing the DOM）
    + 输出日志（logging）
  - 允许返回一个函数，在组件卸载时，执行该函数，清理副效应。如果不需要清理副效应，就不用返回任何值
  - 注意
    + 如果有多个副效应，应该调用多个useEffect()，而不应该合并写在一起
* useContext
  - 提供了一种在组件之间共享此类值的方式，而不必显式地通过组件树 的逐层传递 props
* useReducer【类似redux】
  - React 本身不提供状态管理功能，通常需要使用外部库。这方面最常用的库是 Redux
  - 组件发出 action 与状态管理器通信。状态管理器收到 action 以后，使用 Reducer 函数算出新的状态，Reducer 函数的形式是`(state, action) => newState`
  - Hooks 可以提供共享状态和 Reducer 函数，所以它在这些方面可以取代 Redux。但是，它没法提供中间件（middleware）和时间旅行（time travel），如果你需要这两个功能，还是要用 Redux
* useCallback【缓存函数】
* useMemo【缓存值】
* useRef【访问DOM】
* useImperativeHandle【使用子组件暴露的值/方法】
* useLayoutEffect【完成副作用操作，会阻塞浏览器绘制】
* 参考
  - [hooks](https://github.com/alibaba/hooks):React Hooks Library <https://ahooks.js.org/>
  - [awesome-react-hooks](https://github.com/rehooks/awesome-react-hooks):Awesome React Hooks
  - [swr](https://github.com/zeit/swr):React Hooks library for remote data fetching <https://swr.now.sh>
  - [用好这9个钩子](https://juejin.cn/post/6895966927500345351)

## [redux](https://github.com/reduxjs/redux)

Predictable state container for JavaScript apps <http://redux.js.org>

* 设计思路
  - Web 应用是一个状态机，视图与状态是一一对应的
  - 所有状态保存在一个对象里面
* 场景
  - UI 可以根据应用程序状态显着变化
  - 并不总是以一种线性的，单向的方式流动
  - 许多不相关的组件以相同的方式更新状态
  - 状态树并不简单
  - 状态以许多不同的方式更新
  - 需要能够撤消以前的用户操作
  - 某个组件的状态，需要共享
  - 某个状态需要在任何地方都可以拿到
  - 一个组件需要改变全局状态
  - 一个组件需要改变另一个组件的状态
  - 用户的使用方式复杂
  - 不同身份的用户有不同的使用方式（比如普通用户和管理员）
  - 多个用户之间可以协作
  - 与服务器大量交互，或者使用了WebSocket
  - View要从多个来源获取数据
* 基本概念和 API
  - Store 保存数据的地方，可以看成一个容器。整个应用只能有一个 Store
    + createStore函数用来生成 Store
      * 第二个参数，表示 State 的最初状态。这通常是服务器给出的
    + Store对象包含所有数据。如果想得到某个时点的数据，就要对 Store 生成快照。这种时点的数据集合，就叫做 State
      * 当前时刻的 State，可以通过store.getState()拿到
      * 一个 State 对应一个 View。只要 State 相同，View 就相同
  - State 变化必须是 View 导致的。Action 就是 View 发出的通知，表示 State 应该要发生变化了
    + Action 描述当前发生的事情
    + 改变 State 的唯一办法，就是使用 Action。它会运送数据到 Store
    + Action Creator:View 要发送多少种消息，就会有多少种 Action,定义一个函数来生成 Action
  - store.dispatch()是 View 发出 Action 的唯一方法
    + 接受一个 Action 对象作为参数，将它发送出去
  - Reducer:Store 收到 Action 以后，必须给出一个新的 State，这样 View 才会发生变化。这种 State 的计算过程就叫做 Reducer,描述状态如何变化,不改变原来状态，每次都生成一个新状态
    + 是一个函数，它接受 Action 和当前 State 作为参数，返回一个新的 State
    + store.dispatch方法会触发 Reducer 的自动执行。为此，Store 需要知道 Reducer 函数，做法就是在生成 Store 的时候，将 Reducer 传入createStore方法.createStore接受 Reducer 作为参数，生成一个新的 Store。以后每当store.dispatch发送过来一个新的 Action，就会自动调用 Reducer，得到新的 State
    + 为什么这个函数叫做 Reducer 呢？因为它可以作为数组的reduce方法的参数
    + 最重要的特征:一个纯函数，只要是同样的输入，必定得到同样的输出.Reducer 函数里面不能改变 State，必须返回一个全新的对象
  - 纯函数是函数式编程的概念，必须遵守以下一些约束
    + 不得改写参数
    + 不能调用系统 I/O 的API
    + 不能调用Date.now()或者Math.random()等不纯的方法，因为每次会得到不一样的结果
  - store.subscribe方法设置监听函数，一旦 State 发生变化，就自动执行这个函数
    + 只要把 View 的更新函数（对于 React 项目，就是组件的render方法或setState方法）放入listen，就会实现 View 的自动渲染
    + store.subscribe方法返回一个函数，调用这个函数就可以解除监听
  - Reducer 函数拆分:不同的函数负责处理不同属性，最终合并成一个大的 Reducer 即可
    + combineReducers方法:用于 Reducer 的拆分。只要定义各个子 Reducer 函数，然后用这个方法，将它们合成一个大的 Reducer
      * 该函数根据 State 的 key 去执行相应的子 Reducer，并将返回结果合并成一个大的 State 对象
* Store 实现
  - store.getState()
  - store.dispatch()
  - store.subscribe()
* 异步:Action 发出以后，过一段时间再执行 Reducer,用到新的工具：中间件（middleware）
  - 中间件就是一个函数，对store.dispatch方法进行了改造，在发出 Action 和执行 Reducer 这两步之间，添加了其他功能
  - 三种 Action
    + 操作发起时的 Action
    + 操作成功时的 Action
    + 操作失败时的 Action
  - State 也要进行改造，反映不同的操作状态
  - 流程
    + 操作开始时，送出一个 Action，触发 State 更新为"正在操作"状态，View 重新渲染
    + 操作结束后，再送出一个 Action，触发 State 更新为"操作结束"状态，View 再一次重新渲染
  - 在操作结束时，系统自动送出第二个 Action
    + 在 Action Creator 之中
* createStore方法可以接受整个应用的初始状态作为参数，那样的话，applyMiddleware就是第三个参数了
  - 中间件次序有讲究
  - applyMiddlewares:将所有中间件组成一个数组，依次执行
* 中间件
  - [redux-logger](https://github.com/evgenyrodionov/redux-logger)
  - [redux-thunk](https://github.com/gaearon/redux-thunk):改造store.dispatch，使得可以接受函数作为参数
  - [redux-promise](link)让 Action Creator 返回一个 Promise 对象
* Redux + React develop steps
  - 按任务分工来分步讲解：按照开发的内容，可以把前端团队分为两个小组： “布局组” 和 “逻辑组”
    + 布局组 - 负责 contianer、component 部分，要求对 HTML + CSS 布局比较熟悉，只需要会简单的 js 即可， 不需要完整地理解redux流程
      * 任务1：静态布局 - 使用 HTML + CSS 静态布局
      * 任务2：动态布局 - 使用 JSX 语法对静态布局做动态渲染处理， 设计State的结构
    + 逻辑组 - 负责 action、reducer 部分，要求对 js 比较熟悉，最好可以比较完整地理解redux流程， 但基本不需要涉及HTML + CSS布局工作
      * 任务1：action 开发 - 制作 redux 流程的 action： action调用时，考虑是远程的API call+ store 更新，还是仅仅只是store更新
      * 任务2：reducer 开发 - 制作 redux 流程的 reducer：相应需要更新store的action,注意数据的不可修改性.这里需要考虑state是深拷贝还是浅拷贝：深拷贝性能低，浅拷贝高效 且能达到同样的效果
* 参考
  - [Redux Basic](https://www.zybuluo.com/zhongjianxin/note/1218332)
  - [awesome-redux](https://github.com/xgrommx/awesome-redux):Awesome list of Redux examples and middlewares
  - [redux-in-chinese](https://github.com/camsong/redux-in-chinese):Redux 中文文档 <http://cn.redux.js.org/>
  - [redux-persist](https://github.com/rt2zz/redux-persist):persist and rehydrate a redux store
  - [react-redux-starter-kit](https://github.com/davezuko/react-redux-starter-kit):Get started with React, Redux, and React-Router.

![Redux 工作流程](../_static/redux_flow.jpg "Optional title")

```js
const createStore = (reducer) => {
  let state;
  let listeners = [];

  const getState = () => state;

  const dispatch = (action) => {
    state = reducer(state, action);
    listeners.forEach(listener => listener());
  };

  const subscribe = (listener) => {
    listeners.push(listener);
    return () => {
      listeners = listeners.filter(l => l !== listener);
    }
  };

  dispatch({});

  return { getState, dispatch, subscribe };
};

const combineReducers = reducers => {
  return (state = {}, action) => {
    return Object.keys(reducers).reduce(
      (nextState, key) => {
        nextState[key] = reducers[key](state[key], action);
        return nextState;
      },
      {}
    );
  };
};
```

## [redux-saga](https://github.com/redux-saga/redux-saga)

An alternative side effect model for Redux apps <https://redux-saga.js.org/>

## [react-redux](https://github.com/reduxjs/react-redux)

* Official React bindings for Redux <https://redux.js.org/basics/usagewithreact>
* 可以选用的。实际项目中应该权衡一下，是直接使用 Redux，还是使用 React-Redux。后者虽然提供了便利，但是需要掌握额外的 API，并且要遵守它的组件拆分规范
* 组件分类
  - UI 组件（presentational component）
    + 只负责 UI 的呈现，不带有任何业务逻辑
    + 没有状态（即不使用this.state这个变量）
    + 所有数据都由参数（this.props）提供
    + 不使用任何 Redux 的 API
  - 容器组件（container component）接入转换层
    + 负责管理数据和业务逻辑，不负责 UI 的呈现
    + 带有内部状态
    + 使用 Redux 的 API
* 外面是一个容器组件，里面包了一个UI 组件。前者负责与外部的通信，将数据传给后者，由后者渲染出视图
* React-Redux 规定，所有的 UI 组件都由用户提供，容器组件则是由 React-Redux 自动生成。也就是说，用户负责视觉层，状态管理则是全部交给它
* connect方法，用于从 UI 组件生成容器组件
  - mapStateToProps 负责输入逻辑，即将state映射到 UI 组件的参数（props），UI组件props转化state
    + 一个函数。作用就是像它的名字那样，建立一个从（外部的）state对象到（UI 组件的）props对象的映射关系
    + 执行后应该返回一个对象，里面的每一个键值对就是一个映射
    + 会订阅 Store，每当state更新的时候，就会自动执行，重新计算 UI 组件的参数，从而触发 UI 组件的重新渲染
    + 第一个参数总是state对象，还可以使用第二个参数，代表容器组件的props对象
    + connect方法可以省略mapStateToProps参数，那样的话，UI 组件就不会订阅Store，就是说 Store 的更新不会引起 UI 组件的更新
  - mapDispatchToProps 负责输出逻辑，即将用户对 UI 组件的操作映射成 Action,建立 UI 组件的参数到store.dispatch方法的映射
    + 是一个函数，使用dispatch和ownProps（容器组件的props对象）两个参数
    + 返回一个对象，该对象的每个键值对都是一个映射，定义了 UI 组件的参数怎样发出 Action
  - connect方法生成容器组件以后，需要让容器组件拿到state对象，才能生成 UI 组件的参数
    + 将state对象作为参数，传入容器组件。但是，这样做比较麻烦，尤其是容器组件可能在很深的层级，一级级将state传下去就很麻烦
    + React-Redux 提供Provider组件，可以让容器组件拿到state
      * 原理是React组件的context属性
      * store放在了上下文对象context上面。然后，子组件就可以从context拿到store

## 测试

* `console.log('props value is', props)` 用逗号分隔的项目都可以在浏览器控制台中进行进一步检查
* 组件
  - 测试内容
    + 给定属性（property)和状态（state），会渲染出什么结果？
    + 对于渲染的结果，进行某种输入（用户的互动），有没有可能从状态A转化成状态B？
  - 方法
    + 测试结构
      * mocha-jsdom
      * react-addons-test-utils
    + 测试行为

## [preact](https://github.com/developit/preact)

Fast 3kb React alternative with the same ES6 API. Components & Virtual DOM. <https://preactjs.com>

## 图书

* [React 学习之道 The Road to learn React](https://github.com/the-road-to-learn-react/the-road-to-learn-react-chinese)

## 教程

* [react-from-zero](https://github.com/kay-is/react-from-zero):A simple (99% ES2015 less) tutorial for React
* [reactjs101](https://github.com/kdchang/reactjs101):從零開始學 ReactJS（ReactJS 101）是一本希望讓初學者一看就懂的 ReactJS 中文入門教學書，由淺入深學習 ReactJS 生態系 (Flux, Redux, React Router, ImmutableJS, React Native, Relay/GraphQL etc.)。 <https://www.gitbook.com/book/kdchang/>
* [TypeScript-React-Starter](https://github.com/Microsoft/TypeScript-React-Starter):A starter template for TypeScript and React with a detailed README describing how to use the two together.
* [react-typescript-cheatsheet](https://github.com/sw-yx/react-typescript-cheatsheet)
* [react-redux-typescript-guide](https://github.com/piotrwitek/react-redux-typescript-guide):The complete guide to static typing in "React & Redux" apps using TypeScript <https://piotrwitek.github.io/react-redux-typescript-guide/>
* [React - The Complete Guide (incl Hooks, React Router, Redux)](https://www.udemy.com/course/react-the-complete-guide-incl-redux/)
* [react-basic](https://github.com/reactjs/react-basic):A description of the conceptual model of React without implementation burden.
* [react-demos](https://github.com/ruanyf/react-demos):a collection of simple demos of React.js
* [react-redux-universal-hot-example](https://github.com/erikras/react-redux-universal-hot-example)  A starter boilerplate for a universal webapp using express, react, redux, webpack, and react-transform
* [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi):网易云音乐nodejs api <https://binaryify.github.io/NeteaseCl>
* [yorpw_ui_web](https://github.com/JonJam/yorpw_ui_web):Password manager SPA built using React and Redux
* [react-redux-ts](https://github.com/JonJam/react-redux-ts):React/Redux TypeScript starter project
* [react](https://github.com/duxianwei520/react):一个react+redux+webpack+ES6+antd的SPA的后台管理底层框架

## UI

* [Chakra UI](https://chakra-ui.com/) :Build accessible React apps & websites with speed

## 项目

* [react-pxq](https://github.com/bailicangdu/react-pxq)一个 react + redux 的完整项目 和 个人总结

## 工具

* [flux](https://github.com/facebook/flux) Application Architecture for Building User Interfaces <https://facebook.github.io/flux/>
* [react-admin](https://github.com/marmelab/react-admin):A frontend Framework for building admin applications running in the browser on top of REST/GraphQL APIs, using ES6, React and Material Design <http://marmelab.com/react-admin>
* [react-table](https://github.com/tannerlinsley/react-table):atom_symbol Hooks for building fast and extendable tables and datagrids for React <https://react-table-omega.vercel.app/>
* [react-query](https://github.com/tannerlinsley/react-query):atom_symbol Hooks for fetching, caching and updating asynchronous data in React
* [react-starter-kit](https://github.com/kriasoft/react-starter-kit) React Starter Kit — isomorphic web app boilerplate (Node.js, Express, GraphQL, React.js, Babel, PostCSS, Webpack, Browsersync) <https://reactstarter.com/>

## 参考

* [react-developer-roadmap](https://github.com/adam-golab/react-developer-roadmap):Roadmap to becoming a React developer in 2018s
* [30-seconds-of-react](https://github.com/30-seconds/30-seconds-of-react):Curated collection of useful React snippets that you can understand in 30 seconds or less.
* [Reactjs docs](https://reactjs.org/docs/hello-world.html)
* [react-bits](https://github.com/vasanthk/react-bits)✨ React patterns, techniques, tips and tricks ✨<https://vasanthk.gitbooks.io/react-bits>
* [awesome-react](https://github.com/enaqx/awesome-react)A collection of awesome things regarding React ecosystem.
