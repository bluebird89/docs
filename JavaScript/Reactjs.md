# [facebook/react](https://github.com/facebook/react)

A declarative, efficient, and flexible JavaScript library for building user interfaces. https://reactjs.org

* 与Jquery对比
  - DSL:声明式设计 - HTML这种语义话标签是不是很容易学习？
  - Jquery直接操作Dom, 是野战，正规作战需要战术，就如抽象MVC模型，用router提前声明路由轮转的逻辑，实现的时候就不需要大量的switch case
  - 组件重用 - 无状态
  - Model 与 View的同步机制
* 为什么会出现
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

## 工作机制

* ReactDOM.render 将模板转为 HTML 语言，并插入指定的 DOM 节点
* 支持一种非常特殊的属性 Ref ，可以用来绑定到 render() 输出的任何组件上.允许引用 render() 返回的相应的支撑实例（ backing instance ）。这样就可以确保在任何时间总是拿到正确的实例

生命周期
![](../../_static/react_lifecircle.png)

```JSX
ReactDOM.render(
 <h1>Hello, world!</h1>,
 document.getElementById('example'));

var MyComponent = React.createClass({
  handleClick: function() {
    // 使用原生的 DOM API 获取焦点
    this.refs.myInput.focus();
  },
  render: function() {
    //  当组件插入到 DOM 后，ref 属性添加一个组件的引用于到 this.refs
    return (
      <div>
        <input type="text" ref="myInput" />
        <input
          type="button"
          value="点我输入框获取焦点"
          onClick={this.handleClick}
        />
      </div>
    );
  }
});
ReactDOM.render(
  <MyComponent />,
  document.getElementById('example')
);
```

## JSX

* HTML 语言直接写在 JavaScript 语言之中，不加任何引号
* 允许 HTML 与 JavaScript 的混写
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

## Component

* 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。React.createClass 方法就用于生成一个组件类
* 将组件看成是一个状态机，一开始有一个初始状态，然后用户互动，导致状态变化，从而触发重新渲染 UI
* 所有组件类都必须有自己的 render 方法，用于输出组件
* 组件类的第一个字母必须大写，否则会报错
* 组件类只能包含一个顶层标签，否则也会报错
* 用法与原生的 HTML 标签完全一致，可以任意加入属性
  - 组件的属性可以在组件类的 this.props 对象上获取
* 组合组件
  - class 属性需要写成 className
  - for 属性需要写成 htmlFor ，这是因为 class 和 for 是 JavaScript 的保留字
* this.props 使用它向组件传递数据，React组件从props拿到数据，然后返回视图。表示那些一旦定义，就不再改变的特性
  - Readonly
  - PropType Check
  - Have to be passed from parent
  - 使用
    + 向一个组件传递数据的方法是将数据写在组件的标签中 `<Content value = {this.state.value}/>`
    + 获取props `{props.value}`
* this.state 内部状态（local state）或者局部状态，会随着用户互动而产生变化的特性
  - Changeable
  - Local value have to be self managed
  - Do Not Modify State Directly,use setState()
  - State Updates May Be Asynchronous:React may batch multiple setState() calls into a single update for performance.
    + this.props and this.state may be updated asynchronously, you should not rely on their values for calculating the next state.
  - State Updates are Merged
  - 使用
    + 初始化内部状态：React构造函数中
    + 更新内部状态：this.setstate
    + 获取内部状态：this.state
  - 内部状态的操作配合React事件系统，可以实现用户交互的功能
* 组合使用 state 和 props
  - 通过Counter组件更新state.value,然后将更新的state.value通过props传递给Content组件
  - 在 render 函数中, 设置 name 和 site 来获取父组件传递过来的数据
* Context 组件间跨级传递数据
  - 场景
    + 和全局变量相似，应避免使用
    + 场景包括：传递登录信息、当前语音以及主题信息
    + 如果只传递一些功能模块数据，则尽量不要使用context，使用props传递数据会更加清晰
    + 使用context会使组件的复用性降低，因为这些组件依赖'上下文'，当你在别的地方渲染的时候，可能会出现差异
* Props与context则用于在组件间传递数据
  - props传递数据简单清晰，但是跨级传递非常麻烦
  - context可以跨级传递数据，但是会降低组件的复用性，因为这些组件依赖“上下文”
  - 所有尽量只使用context传递登录状态、颜色主题等全局数据
* 生命周期状态:为每个状态都提供了两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用
  - Mounting：已插入真实 DOM
    + componentWillMount()
    + componentDidMount()
  - Updating：正在被重新渲染
    + componentWillUpdate(object nextProps, object nextState)
    + componentDidUpdate(object prevProps, object prevState)
  - Unmounting：已移出真实 DOM
    + componentWillUnmount()
  - 两种特殊状态的处理函数
    + componentWillReceiveProps(object nextProps)：已加载组件收到新的参数时调用
    + shouldComponentUpdate(object nextProps, object nextState)：组件判断是否重新渲染时调用
* The Data Flows Down
  - A component may choose to pass its state down as props to its child components
  - top-down" or "unidirectional" data flow:Any state is always owned by some specific component, and any data or UI derived from that state can only affect components "below" them in the tree.
* 场景
  - State
  - Lifecycle
* Container Component
* Presentation Component

```react
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

## [reduxjs/react-redux](https://github.com/reduxjs/react-redux)

* Official React bindings for Redux https://redux.js.org/basics/usagewithreact
* [reduxjs/redux](https://github.com/reduxjs/redux):Predictable state container for JavaScript apps http://redux.js.org
* 设计思路
  - Web 应用是一个状态机，视图与状态是一一对应的。
  - 所有的状态，保存在一个对象里面
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
	- [ tannerlinsley / react-table ](https://github.com/tannerlinsley/react-table):atom_symbol Hooks for building fast and extendable tables and datagrids for React https://react-table-omega.vercel.app/
* [react-query)](https://github.com/tannerlinsley/react-query):atom_symbol Hooks for fetching, caching and updating asynchronous data in React
* Hooks
  - [alibaba/hooks](https://github.com/alibaba/hooks):React Hooks Library https://ahooks.js.org/

## 参考

* [Reactjs docs](https://reactjs.org/docs/hello-world.html)
* [awesome-react-hooks](https://github.com/rehooks/awesome-react-hooks):Awesome React Hooks
