# [hexojs/hexo](https://github.com/hexojs/hexo)

A fast, simple & powerful blog framework, powered by Node.js. https://hexo.io

* 配置：站点目录下的_config.yml为站点配置文件，主题目录下的_config.yml为主题配置文件
* [jaredly/hexo-admin](https://github.com/jaredly/hexo-admin):An Admin Interface for Hexo http://jaredly.github.io/hexo-admin/
* [barretlee/hexo-admin](https://github.com/barretlee/hexo-admin):小胡子优化版本
    - 按照官方的方式安装 hexo-admin
    - 下载修改的代码到一个文件夹，执行 `npm link`
    - 在 hexo 根目录下执行 `npm link hexo-admin`
* [barretlee/hexo-admin](https://github.com/barretlee/hexo-admin)

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

# hexo d ERROR Deployer not found: git
npm install hexo-deployer-git --save
# 修改_config.yml,添加仓库
type: git
repo: git@github.com:bluebird89/bluebird89.github.io.git
branch: hexo
hexo deploy

## 自动化
atom ~/.aliases
alias hgs="hexo g&&hexo s"
alias hgd="hexo g&&hexo d"
```

## [gohugoio/hugo](https://github.com/gohugoio/hugo)

The world’s fastest framework for building websites. https://gohugo.io

* deploy 通过Aerobatic[<https://gohugo.io/hosting-and-deployment/hosting-on-bitbucket/>]
* [gcushen/hugo-academic](https://github.com/gcushen/hugo-academic):📝 The website builder for Hugo. Build and deploy a beautiful website in minutes! https://sourcethemes.com/academic/
* https://jimmysong.io/hugo-handbook

```sh
brew install hugo
hugo version

hugo new site quickstart

cd quickstart;\
git init;\
git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke;\

# Edit your config.toml configuration file
# and add the Ananke theme.
echo 'theme = "ananke"' >> config.toml

hugo new posts/my-first-post.md

hugo server -D

config.toml  //配置文件

git clone --depth 1 --recursive https://github.com/gohugoio/hugoThemes.git themes // 获取所有主题，避免这样操作，没意义
cd themes
git clone https://github.com/spf13/hyde

hugo -t themename // 测试主题效果
hugo server -t themename
```

## [jekyll/jekyll](https://github.com/jekyll/jekyll)

🌐 Jekyll is a blog-aware static site generator in Ruby https://jekyllrb.com static website generator，搭建静态博客，通过markdown文件自动生成html文件。Github Pages即靠Jekyll实现的。[官网](https://jekyllrb.com)

* 结构
    - _config.yml 是配置文件，最为重要，包含了所有配置信息
    - _includes 文件夹包含了将被反复利用的文件，比如footer，header
    - _layouts 文件夹包含了主页面的排版布局
    - _posts 文件夹将包含所有的日志文件，Markdown格式
* 配置
    - github新仓库 开启Github pages
    - 将代码推送到仓库
    - [访问页面](https://bluebird89.github.io/)
* 主题
    - [mmistakes/so-simple-theme](https://github.com/mmistakes/so-simple-theme):A simple Jekyll theme for words and pictures.
    - [plusjade/jekyll-bootstrap](https://github.com/plusjade/jekyll-bootstrap):The quickest way to start and publish your Jekyll powered blog. 100% compatible with GitHub pages. http://jekyllbootstrap.com

```sh
gem install jekyll bundler
gem new myblog
bundle exec
jekyll serve
```

## [docsify](https://docsify.js.org/#/)

## [Halo](https://github.com/halo-dev/halo)

## 博客资源

* [Work life](https://www.atlassian.com/blog)
