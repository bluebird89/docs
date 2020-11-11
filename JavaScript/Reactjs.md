# [facebook/react](https://github.com/facebook/react)

A declarative, efficient, and flexible JavaScript library for building user interfaces. https://reactjs.org

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
      * JSX 执行更快，因为它在编译为 JavaScript 代码后进行了优化
      * 类型安全的，在编译过程中就能发现错误
      * 使用 JSX 编写模板更加简单快速
  - 组件 − 通过 React 构建组件，使得代码更加容易得到复用，能够很好的应用在大项目的开发中。——提高可维护性和复用性以及开发效率
  - 单向响应数据流 − React 实现了单向响应的数据流，从而减少了重复代码，这也是它为什么比传统数据绑定更简单。提高可维护性
  - 模块化：通过模块化工具库来解决模块化问题——提高可维护性和复用性

## 安装

* 在线体验
  -  CodePen
  -  CodeSandbox
  -  Glitch
  -  Stackblitz
* 在网站中添加 React
  - div
  - 添加 Script 标签
  - 创建一个 React 组件
* 工具链
  - 学习 React 或创建一个新单页应用，使用 Create React App
  - 用 Node.js 构建服务端渲染的网站: Next.js
  - 面向内容的静态网站:Gatsby
  - 组件库或将 React 集成到现有代码仓库，尝试更灵活的[工具链](https://blog.usejournal.com/creating-a-react-app-from-scratch-f3c693b84658)

```sh
npm install --save-dev @babel/core @babel/cli @babel/preset-env @babel/preset-react
npm install --save-dev webpack webpack-cli webpack-dev-server style-loader css-loader babel-loader

npm run --save react react-dom react-hot-loader
```

## 工作机制

* ReactDOM.render 将模板转为 HTML 语言，并插入指定的 DOM 节点

## JSX

* HTML 语言直接写在 JavaScript 语言之中，不加任何引号
* 允许 HTML 与 JavaScript 混写
* 注释 /* ... */
* 规则
  - 遇到 HTML 标签（以 < 开头），就用 HTML 规则解析
  - 遇到代码块（以 { 开头），就用 JavaScript 规则解析
  - 允许直接在模板插入 JavaScript 变量。如果这个变量是一个数组，则会展开这个数组的所有成员

```jsx
var arr = [
  <h1>Hello world!</h1>,
  <h2>React is awesome</h2>,
];
ReactDOM.render(
  <div>{arr}</div>,
  document.getElementById('example')
);
```

## 生命周期

* 每个状态都提供两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用
* Mounting：已插入真实 DOM
  - componentWillMount():在第一次渲染之前调用。它只会执行一次，在浏览器和服务器都会执行。一般用来对props和state进行初始化处理
  - componentDidMount():可以读取组件生成的 DOM。如果要与 DOM 互动，应该就在这个方法里面，而不是在render方法里面
* Updating：重新渲染
  - componentWillUpdate(object nextProps, object nextState)
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

* 首次挂载组件
  - getDefaultProps
  - getInitialState
  - componentWillMount
  - render
  - componentDidMount
  - getDefaultProps 和 getInitialState方法，都是只执行一次
* 重新挂载组件
  - getInitialState
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

![生命周期](../../_static/react_lifecircle.png "生命周期")

## Prototypes

## Components API

* UI使用数据结构表示。UI变化就是一种数据结构变成另一种数据结构，是一个纯函数，同样的数据结构，就得到同样的UI
* 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。React.createClass 方法就用于生成一个组件类
* 将组件看成是一个状态机，一开始有一个初始状态，然后用户互动，导致状态变化，从而触发重新渲染 UI
* 语法
  - 所有组件类必须有 render 方法，用于输出组件
  - 原生提供组件，都是HTML语言已经定义的标签,组件首字母小写.用户自定义组件，首字母必须大写
  - 组件最外层，只能有一个标签。因为，一个组件就相当于调用一个构造函数，如果有多个标签，就变成一个组件对应多个构造函数了
* 用法与原生的 HTML 标签完全一致，可以任意加入属性
  - 组件属性可以在组件类的 this.props 对象上获取
* 组合组件
* 属性
  - class 写成 className
  - for 写成 htmlFor ，因为 class 和 for 是 JavaScript 保留字
  - defaultProps 指定props默认值
  - 向原生组件提供自定义属性，要写成data-前缀
  - ref
    + 指定一个回调函数，在组件加载到DOM之后调用
    + 设为一个字符串
    + 可以用来绑定到 render() 输出的任何组件上.允许引用 render() 返回的相应的支撑实例（ backing instance ）。这样就可以确保在任何时间总是拿到正确的实例
  - this.props 向组件传递数据，React组件从props拿到数据，然后返回视图。表示那些一旦定义，就不再改变的特性
    + Readonly
    + PropType Check
    + Have to be passed from parent
    + 使用
      * 向一个组件传递数据的方法是将数据写在组件的标签中 `<Content value = {this.state.value}/>`
      * 获取props `{props.value}`
  - this.state 内部状态 local state 或者局部状态，会随着用户互动而产生变化的特性,组件私有内部参数，不应暴露到外部
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
      * 获取内部状态：this.state
    + 内部状态的操作配合React事件系统，可以实现用户交互的功能
* 组合使用 state 和 props
  - 通过Counter组件更新state.value,然后将更新的state.value通过props传递给Content组件
  - 在 render 函数中, 设置 name 和 site 来获取父组件传递过来的数据
* The Data Flows Down
  - A component may choose to pass its state down as props to its child components
  - top-down" or "unidirectional" data flow:Any state is always owned by some specific component, and any data or UI derived from that state can only affect components "below" them in the tree.
* 场景
  - State
  - Lifecycle
* 子组件：父组件内部组件
  - Parent可以通过this.props.children属性，读取子组件
  - 同级而且同类型的每个子组件，应该有一个key属性，用来区分
* 父组件
  - 操作子组件
    + 父组件向子组件传入一个新参数
    + 子组件在componentWillReceiveProps方法里面处理新的参数，必要时调用setState方法
    + 子组件在componentWillUpdate方法里面处理新的state，但是一般来说，只使用componentWillReceiveProps方法就足够了
* Container Component
* Presentation Component

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

class ListUI extends React.Component{
    render(){
        let data = this.props.data;
        return (
            <ul>
                {data.map(item => <li key={item.id} >{item.text}</li>)}
            </ul>
        )
    }
}

class List extends React.Component{
    constructor(){
        super();
        this.getData = this.getData.bind(this);
    }
    render(){
        let data = this.getData();
        return <ListUI data={data} />
    }
    getData(){
        return [{id : 1,text : 'hello'},{id : 2,text : 'world'}];
    }
}

var HelloMessage = React.createClass({
  render: function() {
    return <h1>Hello {this.props.name}</h1>;
  }
});
ReactDOM.render(
  <HelloMessage name="John" />,
  document.getElementById('example')
);

export default class Counter extends Component{
  constructor(){
    super(); //后才能用this获取实例化对象
    this.state{
      value: 0
    };
  }

  render(){
    return(
      <div>
        <button onClick = { () => this.setState({value：this.state.value+1})}>
          INCREMENT
        </button>
        Counter组件的内部状态
        <pre>JSON.stringify(this.state.value, null, 2)</pre>
      </div>
      );
  }
}

import React, {Component, ProTypes} from 'react';

function Content(props){
  return <p>Content组件的props.value: {props.value}</p>;
}

Content.ProTypes = {
  value: ProTypes.number.isRequired
};

export default Counter extends Component{
  constructor(){
    super();
    this.state{
      value: 0
    }
  }

  render(){
    return(
      <div>
        <button onClick= {() => {this.setstate({value: this.state.value+1})}}
          INCREMENT
        </button>
          Counter组件的内部状态：
        <pre>JSON.stringify(this.state.value, null, 2)</pre>
        <Content value = {this.state.value}/>
      </div>
      );
  }
}

# 组合组件
var WebSite = React.createClass({
  getInitialState: function() {
    return {
      name: "菜鸟教程",
      site: "http://www.runoob.com"
    };
  },
  render: function() {
    return (
      <div>
        <Name name={this.props.name} />
        <Link site={this.props.site} />
      </div>
    );
  }
});
var Name = React.createClass({
  render: function() {
    return (
      <h1>{this.props.name}</h1>
    );
  }
});
var Link = React.createClass({
  render: function() {
    return (
      <a href={this.props.site}>
        {this.props.site}
      </a>
    );
  }
});
ReactDOM.render(
  <WebSite name="菜鸟教程" site=" http://www.runoob.com" />,
  document.getElementById('example')
);

var LikeButton = React.createClass({
  getInitialState: function() {
    return {liked: false};
  },
  handleClick: function(event) {
    this.setState({liked: !this.state.liked});
  },
  render: function() {
    var text = this.state.liked ? 'like' : 'haven\'t liked';
    return (
      <p onClick={this.handleClick}>
        You {text} this. Click to toggle.
      </p>
    );
  }
});
ReactDOM.render(
  <LikeButton />,
  document.getElementById('example')
);

this.setState(function(prevState, props) {
  return {
    counter: prevState.counter + props.increment
  };
});
this.setState((prevState, props) => ({
  return {
    // Wrong
    <!-- counter: this.state.counter + this.props.increment, -->
    counter: prevState.counter + props.increment

  };
});
```

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
    + 一个对象，表示生成实例的参数

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

```
const Text = props => <input type="text" {...props}/>
const Select = ({options, ...others}) => (
  <select {...others}>
    {Object.keys(options)
      .map((optionKey, index) => (
        <option value={optionKey} key={index}>{options[optionKey]}</option>
      ))
    }
  </select>
)
```

## React-Router

## ReactDOM

* 方法
  - findDOMNode 只对已经挂载组件有效，因此一般只在componentDidMount和componentDidUpdate方法中使用
  - unmountComponentAtNode
  - render 将组件挂载到真实DOM之中,并且返回该组件的实例
    + 如果是无状态组件，render会返回null
    + 当组件挂载完毕，会执行回调函数
* ReactDOMServer.renderToString():将一个React组件转成HTML字符串，一般用于服务器渲染
  - 如果ReactDOM.render()在一个已经完成服务器渲染的DOM节点上面挂载React组件，那么该组件不会挂载，只会添加事件监听到这个DOM节点

## [facebookincubator/create-react-app](https://github.com/facebookincubator/create-react-app)

Create React apps with no build configuration. https://create-react-app.dev/

```sh
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

## 测试

* 组件
  - 测试内容
    + 给定属性（property)和状态（state），会渲染出什么结果？
    + 对于渲染的结果，进行某种输入（用户的互动），有没有可能从状态A转化成状态B？
  - 方法
    + 测试结构
      * mocha-jsdom
      * react-addons-test-utils
    + 测试行为

## [reduxjs/react-redux](https://github.com/reduxjs/react-redux)

* Official React bindings for Redux https://redux.js.org/basics/usagewithreact
* [reduxjs/redux](https://github.com/reduxjs/redux):Predictable state container for JavaScript apps http://redux.js.org
* 设计思路
  - Web 应用是一个状态机，视图与状态是一一对应的
  - 所有状态保存在一个对象里面
* Reducer描述状态如何变化,不改变原来状态，每次都生成一个新状态
* Redux + React develop steps
  - 按任务分工来分步讲解：按照开发的内容，可以把前端团队分为两个小组： “布局组” 和 “逻辑组”
    + 布局组 - 负责 contianer、component 部分，要求对 HTML + CSS 布局比较熟悉，只需要会简单的 js 即可， 不需要完整地理解redux流程
      * 任务1：静态布局 - 使用 HTML + CSS 静态布局
      * 任务2：动态布局 - 使用 JSX 语法对静态布局做动态渲染处理， 设计State的结构
    + 逻辑组 - 负责 action、reducer 部分，要求对 js 比较熟悉，最好可以比较完整地理解redux流程， 但基本不需要涉及HTML + CSS布局工作
      * 任务1：action 开发 - 制作 redux 流程的 action： action调用时，考虑是远程的API call+ store 更新，还是仅仅只是store更新
      * 任务2：reducer 开发 - 制作 redux 流程的 reducer：相应需要更新store的action,注意数据的不可修改性.这里需要考虑state是深拷贝还是浅拷贝：深拷贝性能低，浅拷贝高效 且能达到同样的效果
* When to use
  - UI 可以根据应用程序状态显着变化
  - 并不总是以一种线性的，单向的方式流动
  - 许多不相关的组件以相同的方式更新状态
  - 状态树并不简单
  - 状态以许多不同的方式更新
  - 需要能够撤消以前的用户操作
* 参考
  - [Redux Basic](https://www.zybuluo.com/zhongjianxin/note/1218332)
  - [xgrommx/awesome-redux](https://github.com/xgrommx/awesome-redux):Awesome list of Redux examples and middlewares
  - [camsong/redux-in-chinese](https://github.com/camsong/redux-in-chinese):Redux 中文文档 http://cn.redux.js.org/
  - [rt2zz/redux-persist](https://github.com/rt2zz/redux-persist):persist and rehydrate a redux store

## 图书

* [React 学习之道 The Road to learn React](https://github.com/the-road-to-learn-react/the-road-to-learn-react-chinese)

## 教程

* [kay-is/react-from-zero](https://github.com/kay-is/react-from-zero):A simple (99% ES2015 less) tutorial for React
* [kdchang/reactjs101](https://github.com/kdchang/reactjs101):從零開始學 ReactJS（ReactJS 101）是一本希望讓初學者一看就懂的 ReactJS 中文入門教學書，由淺入深學習 ReactJS 生態系 (Flux, Redux, React Router, ImmutableJS, React Native, Relay/GraphQL etc.)。 https://www.gitbook.com/book/kdchang/…
* [piotrwitek/react-redux-typescript-guide](https://github.com/piotrwitek/react-redux-typescript-guide):The complete guide to static typing in "React & Redux" apps using TypeScript https://piotrwitek.github.io/react-redux-typescript-guide/
* [Todo List App](link)
  - 展示Todo List
    + import css and use class directly
    + use className attr for assign class to html tag
  - 添加Todo Item - 重构组件内的数据是无副作用的，每次改变都是一个副本
  - 勾选Item完成
  - Filter Todo List - 重构filter样式，利用classname,动态定义样式，减少js界面逻辑操作
  - 编辑修改Todo Item
  - 实时显示为完成Todo Item 数量
  - 完成所有Todo Items
  - 清除已经完成Todo Items

## UI

* [Chakra UI](https://chakra-ui.com/) :Build accessible React apps & websites with speed

## 工具

* admin
  - [marmelab/react-admin](https://github.com/marmelab/react-admin):A frontend Framework for building admin applications running in the browser on top of REST/GraphQL APIs, using ES6, React and Material Design http://marmelab.com/react-admin
* table
	- [react-table](https://github.com/tannerlinsley/react-table):atom_symbol Hooks for building fast and extendable tables and datagrids for React https://react-table-omega.vercel.app/
* [react-query](https://github.com/tannerlinsley/react-query):atom_symbol Hooks for fetching, caching and updating asynchronous data in React
* Hooks
  - [alibaba/hooks](https://github.com/alibaba/hooks):React Hooks Library https://ahooks.js.org/

## 参考

* [Reactjs docs](https://reactjs.org/docs/hello-world.html)
* [awesome-react-hooks](https://github.com/rehooks/awesome-react-hooks):Awesome React Hooks
