# js代码规范

## Eslint

是一个开源的 JavaScript 代码检查工具，使用 Node.js 编写，由 Nicholas C. Zakas 于 2013 年 6 月创建。ESLint 的初衷是为了让程序员可以创建自己的检测规则，使其可以在编码的过程中发现问题而不是在执行的过程中。ESLint 的所有规则都被设计成可插入的，为了方便使用，ESLint 内置了一些规则，在这基础上也可以增加自定义规则。

* vscode中使用，安装ESLint扩展
* [Configuring ESLint](http://eslint.cn/docs/user-guide/configuring)

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

## 参考

* [airbnb/javascript](https://github.com/airbnb/javascript):JavaScript Style Guide
* [standard/standard](https://github.com/standard/standard):JavaScript Style Guide, with linter & automatic code fixer <https://standardjs.com>
* [rwaldron/idiomatic.js](https://github.com/rwaldron/idiomatic.js):Principles of Writing Consistent, Idiomatic JavaScript
