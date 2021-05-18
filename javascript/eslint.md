## [eslint](https://github.com/eslint/eslint)

A fully pluggable tool for identifying and reporting on patterns in JavaScript <https://eslint.org>

* 一个开源的 JavaScript 代码检查工具，使用 Node.js 编写，由 Nicholas C. Zakas 于 2013 年 6 月创建
* ESLint 的初衷是为了让程序员可以创建自己的检测规则，使其可以在编码的过程中发现问题而不是在执行的过程中
* ESLint 的所有规则都被设计成可插入的，为了方便使用，ESLint 内置了一些规则，在这基础上也可以增加自定义规则

* vscode中使用，安装ESLint扩展
* [Configuring ESLint](http://eslint.cn/docs/user-guide/configuring)

## install

```sh
# 安装
npm install eslint --save-dev
npm install -g eslint

# 配置
eslint --init # 自定义，会生成文件.eslintrc.js

# 指定要启用的环境，将其设置为 true，以保证在进行代码检测时不会把这些环境预定义的全局变量识别成未定义的变量而报错
"env": {
    "browser": true,
    "commonjs": true,
    "es6": true,
    "jquery": true
}

# 想启用对 ECMAScript 其它版本和 JSX 等的支持 指定想要支持的 JavaScript 语言选项，不过你可能需要自行安装 eslint-plugin-react 等插件
"parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
        "jsx": true
    }
}

# "extends": "eslint:recommended" 选项表示启用推荐规则，在推荐规则的基础上我们还可以根据需要使用 rules 新增自定义规则，每个规则的第一个值都是代表该规则检测后显示的错误级别。完整的可配置规则列表可访问：http://eslint.cn/docs/rules/
# "off" 或 0 - 关闭规则
# "warn" 或 1 - 将规则视为一个警告
# "error" 或 2 - 将规则视为一个错误
"rules": {
    "indent": [
        "error",
        4
    ],
    "linebreak-style": [
        "error",
        "windows"
    ],
    "quotes": [
        "error",
        "single"
    ],
    "semi": [
        "error",
        "never"
    ]
}

npm install --save-dev eslint-config-vue eslint-plugin-vue
extends: 'eslint:recommended', # "vue"

# 编辑器设置配置检测文件，由于 ESLint 默认只支持 js 文件的脚本检测，如果我们需要支持类 html 文件（如 vue）的内联脚本检测，还需要安装 eslint-plugin-html 插件。
npm install -g eslint-plugin-html

"eslint.options": {
    "configFile": "E:/git/github/styleguide/eslint/.eslintrc.js",
    "plugins": ["html"]
},
"eslint.validate": [
    "javascript",
    "javascriptreact",
    "html",
    "vue"
]
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

* [eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react) React specific linting rules for ESLint

## 参考

* [eslint-config-standard](https://github.com/standard/eslint-config-standard):ESLint Config for JavaScript Standard Style <https://standardjs.com>
* [javascript](https://github.com/airbnb/javascript):JavaScript Style Guide
* [standard](https://github.com/standard/standard):JavaScript Style Guide, with linter & automatic code fixer <https://standardjs.com>
* [idiomatic.js](https://github.com/rwaldron/idiomatic.js):Principles of Writing Consistent, Idiomatic JavaScript
* [clean-code-javascript](https://github.com/ryanmcdermott/clean-code-javascript):🛁 Clean Code concepts adapted for JavaScript
