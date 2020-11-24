## [eslint](https://github.com/eslint/eslint)

A fully pluggable tool for identifying and reporting on patterns in JavaScript https://eslint.org

## install

```sh
npm i -g eslint
```

## 配置

* 主目录（通常 ~/）有一个配置文件，ESLint 只有在无法找到其他配置文件时才使用它
* package.json 文件里的 eslintConfig
* 独立的 .eslintrc.* 配置文件
* 允许指定想要支持的 JavaScript 语言选项。默认情况下支持 ECMAScript 5 语法，可以覆盖该设置，以启用对 ECMAScript 其它版本和 JSX 的支持
* 属性
  - Environments - 指定脚本的运行环境。每种环境都有一组特定的预定义全局变量。
  - Globals - 脚本在执行期间访问的额外的全局变量。
  - Rules - 启用的规则及其各自的错误级别。
  - parserOptions
    + ecmaVersion - 默认设置为 3，5（默认）， 可以使用 6、7、8、9 或 10 来指定你想要使用的 ECMAScript 版本
    + sourceType - 设置为 "script" (默认) 或 "module"（如果代码是 ECMAScript 模块)
    + ecmaFeatures - 这是个对象，表示你想使用的额外的语言特性:
    + globalReturn - 允许在全局作用域下使用 return 语句
    + impliedStrict - 启用全局 strict mode (如果 ecmaVersion 是 5 或更高)
    + jsx - 启用 JSX
    + experimentalObjectRestSpread - 启用实验性的 object rest/spread properties 支持。(重要：这是一个实验性的功能,在未来可能会有明显改变。 建议写的规则 不要 依赖该功能，除非当它发生改变时你愿意承担维护成本。)
  - Specifying Parser:默认使用Espree作为其解析器，你可以在配置文件中指定一个不同的解析器，只要该解析器符合下列要求：
    + 必须是一个 Node 模块，可以从它出现的配置文件中加载。通常，这意味着应该使用 npm 单独安装解析器包
    + 必须符合 parser interface
    + Esprima
    + Babel-ESLint - 一个对Babel解析器的包装，使其能够与 ESLint 兼容。
    + @typescript-eslint/parser - 将 TypeScript 转换成与 estree 兼容的形式，以便在ESLint中使用
  - Specifying Processor:插件可以提供处理器。处理器可以从另一种文件中提取 JavaScript 代码，然后让 ESLint 检测 JavaScript 代码。或者处理器可以在预处理中转换 JavaScript 代码。
    + 为特定类型的文件指定处理器，请使用 overrides 键和 processor 键的组合

```json
// .eslintrc.json
{
    "parserOptions": {
        "ecmaVersion": 6,
        "sourceType": "module",
        "ecmaFeatures": {
            "jsx": true
        }
    },
    "parser": "esprima",
    "rules": {
        "semi": "error"
    },
    "plugins": ["a-plugin"], // 启用插件 a-plugin 提供的处理器 a-processor
    "processor": "a-plugin/a-processor",
    "overrides": [
        {
            "files": ["*.md"],
            "processor": "a-plugin/markdown"
        },
        {
            "files": ["**/*.md/*.js"],
            "rules": {
                "strict": "off"
            }
        }
    ]
}

// 对于新的 ES6 全局变量，使用   { "env": { "es6": true } } 自动启用es6语法
{ "env":{ "es6": true } }
```

## 使用

* 预置规则

```sh
eslint index.js

npm i -g babel-eslint eslint-config-airbnb
```

## 工具

* [standard/eslint-config-standard](https://github.com/standard/eslint-config-standard):ESLint Config for JavaScript Standard Style https://standardjs.com
* [eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react) React specific linting rules for ESLint
