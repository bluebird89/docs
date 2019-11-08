# [facebook/graphql](https://github.com/facebook/graphql)

GraphQL is a query language and execution engine tied to any backend service. https://graphql.org/

## 请求与响应

* 请求体：用来描述要从服务器上取什么数据
    - 操作类型：指定本请求体要对数据做什么操作
        + query 表示查询
        + mutation 表示对数据进行操作，例如增删改操作
        + subscription 订阅操作
    - 操作名称：可选参数，对整个请求并不产生影响，只是赋予请求体一个名字，可以作为调试的依据
    - 变量定义：声明一个变量使用$符号开头，冒号后面紧跟着变量的传入类型。如果要使用变量，直接引用即可
    - 选择集：所需要的字段合在一起
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

{
  "data": {
    "movie": {
      "name": "Manchester By the Sea",
      "desc": "A depressed uncle is asked to take care of his teenage nephew after the boy's father dies. ",
      "ratings": "R"
    }
  }
}
```

## Server

* 类型的定义以及查询本身都是通过 Schema 去定义的。GraphQL 的 Schema 语言全称叫 Schema Definition Language。Schema 本身并不代表你数据库中真实的数据结构，它的定义决定了这整个端点能干些什么事情，能向端点要什么，操作什么

## 项目

* <https://developer.github.com/v4/>
* [vue-graphql-demo](https://github.com/JscramblerBlog/vue-graphql-demo)

## 工具

* [apollographql/graphql-tools](https://github.com/apollographql/graphql-tools)  Build and mock your GraphQL.js schema using the schema language http://dev.apollodata.com/tools/graph…
* [graphql/graphql-js](https://github.com/graphql/graphql-js):A reference implementation of GraphQL for JavaScript http://graphql.org/graphql-js/
* [graphcool/framework](https://github.com/graphcool/framework):Framework to develop & deploy serverless GraphQL backends https://www.graph.cool
* [hasura/graphql-engine](https://github.com/hasura/graphql-engine):Blazing fast, instant GraphQL APIs on Postgres with fine grained access control https://hasura.io
* [prisma/graphcool-framework](https://github.com/prisma/graphcool-framework)
* [slothking-online/graphql-editor](https://github.com/slothking-online/graphql-editor):GraphQL Visual Node Editor
* [apollographql/react-apollo](https://github.com/apollographql/react-apollo)♻️ React integration for Apollo Client
* [apollographql/apollo-server](https://github.com/apollographql/apollo-server)GraphQL server for Express, Connect, Hapi and Koa
* [apollographql/apollo-ios](https://github.com/apollographql/apollo-ios):📱 A strongly-typed, caching GraphQL client for iOS, written in Swift https://www.apollographql.com/docs/ios/
* [hasura/graphql-engine](https://github.com/hasura/graphql-engine):Blazing fast, instant realtime GraphQL APIs on Postgres with fine grained access control, also trigger webhooks on database events. https://hasura.io
* client
    - [apollographql/apollo-client](https://github.com/apollographql/apollo-client)A fully-featured, production ready caching GraphQL client for every server or UI framework
* IDE
    - [prisma/graphql-playground](https://github.com/prisma/graphql-playground):🎮 GraphQL IDE for better development workflows (GraphQL Subscriptions, interactive docs & collaboration)
* 测试
    - [intuit/karate](https://github.com/intuit/karate):Web-Services Testing Made Simple
* vue
    - [Vue Apollo](https://vue-apollo.netlify.com)
* 插件
    - Apollo GraphQL VS Code

## 参考

* [教程](https://www.howtographql.com/)
* [chentsulin/awesome-graphql](https://github.com/chentsulin/awesome-graphql):Awesome list of GraphQL & Relay## 实例
* [learnapollo/learnapollo](https://github.com/learnapollo/learnapollo)
* [graphql/express-graphql](https://github.com/graphql/express-graphql):Create a GraphQL HTTP server with Express.
* [mugli/learning-graphql](https://github.com/mugli/learning-graphql):An attempt to learn GraphQL
* [graphQL PHP 中文文档](https://laravel-china.org/docs/graphql-php)

