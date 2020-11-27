# [graphiql](https://github.com/graphql/graphiql)

GraphiQL & the GraphQL LSP Reference Ecosystem for building browser & IDE tools.

* 由 Facebook 在 2012 年创立的一门开源查询语言，作为通用REST架构的替代方案而被开发出来,旨在让 API 变得快速、灵活并且为开发人员提供便利
* 一个用于 API 的查询语言，使用基于类型系统来执行查询的服务端运行时（类型系统由数据定义）,灵活地添加或弃用字段，而不会影响现有查询
* 没有和任何特定数据库或者存储引擎绑定，依靠现有的代码和数据支撑
* 针对 Graph（图状数据）进行查询特别有优势的 Query Language
* 允许客户端只向服务端发送一次描述信息，允许开发人员构建相应的请求，从而通过单个 API 调用从多个数据源中提取数据，获得客户端所需所有数据
* 数据控制甚至可以精细到字段，达到一次请求获取所有所需数据目的
* 提供了极佳的关注点分离方式：客户端知道它需要什么数据，服务端知道数据的结构，以及如何从一些数据源（比如数据库、微服务、第三方 API）中拉取数据
* 优点
  - 设置单一事实来源 Single Source of Truth，提供了一种整合其整个 API 的方法
  - GraphQL Schema Definition Language SDL 严格定义数据类型减少客户端与服务器之间的通信错误
  - 声明式地数据获取：客户端根据其 UI 来决定在一个查询请求中需要的字段，选择需要的数据和相关的字段实体
  - 没有过度获取：按客户端需求选择数据，减少了传输数据的大小
  - Introspection 自检：允许通过 GraphQL API 检索 GraphQL schema，包含了 GraphQL API 可以获得的所有数据信息，本身就是一份完美的自动生成的 API 文档
  - 允许应用 API 进行更新优化，而无需破坏现有查询
  - 不指定特定的应用架构。能够以现有的 REST API 为基础，并与现有的 API 管理工具配合使用
* 缺点
  - 即便是熟悉 REST API 的开发人员，也需要一定时间才能掌握 GraphQL
  - 查询复杂性：一个客户端需要一次查询很多嵌套字段时，前端开发通常不能很清楚他正在通过服务端访问不同的数据库获取过多的数据
  - 根据不同的实施方式，GraphQL 可能需要不同于 REST API 的 API 管理策略，尤其是在考虑速率限制和定价的情况下
  - 缓存机制复杂
  - API 维护人员还会面临编写可维护 GraphQL 模式的额外任务
* 适用
  - 前提是数据已经以图的数据结构进行保存
* 通过 schema 拼接的方式引入一个 GraphQL 网关（gateway）

## 概念

* 一个 GraphQL 服务是通过定义类型和类型上的字段来创建，然后给每个类型上的每个字段提供解析函数
* 一旦一个 GraphQL 服务运行起来（通常在 web 服务的一个 URL 上）,就能接收 GraphQL 查询，并验证和执行。接收到的查询首先会被检查确保它只引用了已定义的类型和字段，然后运行指定的解析函数来生成结果
* 模式 Schema：描述客户端可通过该服务查询的所有可能数据
  - API 查询定义和验证语法
  - 由对象类型组成，表示可以请求哪种对象以及它有哪些字段
  - 将模式中的每个字段附加到名为解析器的函数中。执行期间，系统将调用解析器来生成相应的值
  - 查询时，GraphQL 会根据模式对查询进行验证。随后，GraphQL 将执行经过验证的查询
* 最常见的 GraphQL 操作可能就是查询和修改
  - query
  - mutation

```graphql
type Query {
  me: User
}

type User {
  id: ID
  name: String
}

function Query_me(request) {
  return request.auth.user;
}

function User_name(user) {
  return user.getName();
}

{
  me {
    name
  }
}
```

## 数据类型

* Scalar Type
  - ID
  - Int
  - Float
  - String
  - Boolean
* Object Type 定义对象类型
* input 定义接口输入类型
* !用来表示参数是非空的。[]表示查询这个字段返回的是数组(List)，[]里面是数组的类型

## 请求与响应

* 请求格式是根据 GraphQL 标准构造
* 一个 GraphQL 操作从前端应用到达后端应用，首先会在后端解释整个 GraphQL schema，然后再为前端解析相关的数据
* 请求体：描述要从服务器上取什么数据
  - 操作类型：指定本请求体要对数据做什么操作
    + query 查询
    + mutation 对数据进行操作，例如增删改操作
    + subscription 订阅
  - 操作名称：可选参数，对整个请求并不产生影响，只是赋予请求体一个名字，可以作为调试的依据
  - 变量：声明一个变量使用$符号开头，冒号后面紧跟着变量的传入类型。如果要使用变量，直接引用即可
  - 选择集：所需要字段合在一起
  - 字段请求的是一个数据单元。标量字段是粒度最细的一个数据单元了，同时作为返回 JSON 响应数据中的最后一个字段。如果是一个 Object，还必须选择至少其中的一个字段。
  - 请求体的结构确定了最终返回数据的结构

```
query myQry ($name: String!) {
  movie(name: $name) {
    name
    desc
    ratings
  }
}

author(id: "7") {
  id
  name
  avatarUrl
  articles(limit: 2) {
    name
    urlSlug
  }
}

{
  "data": {
    "author": {
      "id": "7",
      "name": "Robin Wieruch",
      "avatarUrl": "https://domain.com/authors/7",
      "articles": [
        {
          "name": "The Road to learn React",
          "urlSlug": "the-road-to-learn-react"
        },
        {
          "name": "React Testing Tutorial",
          "urlSlug": "react-testing-tutorial"
        }
      ]
    }
  }
}
```

## Server

* 类型的定义以及查询本身都是通过 Schema 去定义的。GraphQL 的 Schema 语言全称叫 Schema Definition Language。
* Schema 本身并不代表数据库中真实的数据结构，它的定义决定了这整个端点能干些什么事情，能向端点要什么，操作什么

## 项目

* [GitHub GraphQL API](https://developer.github.com/v4/explorer/) <https://developer.github.com/v4/>
* [vue-graphql-demo](https://github.com/JscramblerBlog/vue-graphql-demo)

## 工具

* [apollographql/graphql-tools](https://github.com/apollographql/graphql-tools)  Build and mock your GraphQL.js schema using the schema language <http://dev.apollodata.com/tools/graph>…
* [graphql/graphql-js](https://github.com/graphql/graphql-js):A reference implementation of GraphQL for JavaScript <http://graphql.org/graphql-js/>
* [graphcool/framework](https://github.com/graphcool/framework):Framework to develop & deploy serverless GraphQL backends <https://www.graph.cool>
* [hasura/graphql-engine](https://github.com/hasura/graphql-engine):Blazing fast, instant GraphQL APIs on Postgres with fine grained access control <https://hasura.io>
* [prisma/graphcool-framework](https://github.com/prisma/graphcool-framework)
* [slothking-online/graphql-editor](https://github.com/slothking-online/graphql-editor):GraphQL Visual Node Editor
* [apollographql/apollo-server](https://github.com/apollographql/apollo-server)GraphQL server for Express, Connect, Hapi and Koa
* [apollographql/apollo-ios](https://github.com/apollographql/apollo-ios):📱 A strongly-typed, caching GraphQL client for iOS, written in Swift <https://www.apollographql.com/docs/ios/>
* [hasura/graphql-engine](https://github.com/hasura/graphql-engine):Blazing fast, instant realtime GraphQL APIs on Postgres with fine grained access control, also trigger webhooks on database events. <https://hasura.io>
* client
  - [apollographql/apollo-client](https://github.com/apollographql/apollo-client)A fully-featured, production ready caching GraphQL client for every server or UI framework
  - [apollographql/react-apollo](https://github.com/apollographql/react-apollo)♻️ React integration for Apollo Client
* IDE
  - [prisma/graphql-playground](https://github.com/prisma/graphql-playground):🎮 GraphQL IDE for better development workflows (GraphQL Subscriptions, interactive docs & collaboration)
* 测试
  - [intuit/karate](https://github.com/intuit/karate):Web-Services Testing Made Simple
* vue
  - [Vue Apollo](https://vue-apollo.netlify.com)
* 插件
  - Apollo GraphQL VS Code

## 参考

* 《GraphQL 学习之道》
* [chentsulin/awesome-graphql](https://github.com/chentsulin/awesome-graphql):Awesome list of GraphQL & Relay## 实例
* [graphql/express-graphql](https://github.com/graphql/express-graphql):Create a GraphQL HTTP server with Express.

* [教程](https://www.howtographql.com/)
* [graphql-spec](https://github.com/graphql/graphql-spec)GraphQL is a query language and execution engine tied to any backend service. <https://spec.graphql.org>
* [learnapollo/learnapollo](https://github.com/learnapollo/learnapollo)
* [mugli/learning-graphql](https://github.com/mugli/learning-graphql):An attempt to learn GraphQL
* [graphQL PHP 中文文档](https://laravel-china.org/docs/graphql-php)
