# 搭建Hexo + Next + Github Pages

高效的静态站点生成框架,基于 Node.js。 通过 Hexo 你可以轻松地使用 Markdown 编写文章，除了 Markdown 本身的语法之外，还可以使用 Hexo 提供的 标签插件 来快速的插入特定形式的内容

```sh
brew install git
brew install node
npm install hexo-cli -g

cd filename
hexo init

# 新文章需先生成后再部署
hexo g(enerate)
hexo s(erver)

cd your-hexo-site
git clone https://github.com/iissnan/hexo-theme-next themes/next
npm install hexo-deployer-git --save
npm install(hexo 会找不到)

# 修改_config.yml,添加仓库
type: git
repo: git@github.com:bluebird89/bluebird89.github.io.git
branch: hexo
hexo deploy
```

## 自动化

```sh
atom ~/.aliases
alias hgs="hexo g&&hexo s"
alias hgd="hexo g&&hexo d"
```

## 扩展

* [jaredly/hexo-admin](https://github.com/jaredly/hexo-admin):An Admin Interface for Hexo http://jaredly.github.io/hexo-admin/
* [barretlee/hexo-admin](https://github.com/barretlee/hexo-admin):小胡子优化版本
    - 按照官方的方式安装 hexo-admin
    - 下载我修改的代码到一个文件夹，执行 npm link;
    - 在 hexo 根目录下执行 npm link hexo-admin;

## 配置

站点目录下的_config.yml为站点配置文件，主题目录下的_config.yml为主题配置文件
