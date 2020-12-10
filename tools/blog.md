# [hexo](https://github.com/hexojs/hexo)

A fast, simple & powerful blog framework, powered by Node.js. <https://hexo.io>

* 配置：站点目录下的_config.yml为站点配置文件，主题目录下的_config.yml为主题配置文件
* [hexo-admin](https://github.com/jaredly/hexo-admin):An Admin Interface for Hexo <http://jaredly.github.io/hexo-admin/>
* [hexo-admin](https://github.com/barretlee/hexo-admin):小胡子优化版本
  - 按照官方的方式安装 hexo-admin
  - 下载修改的代码到一个文件夹，执行 `npm link`
  - 在 hexo 根目录下执行 `npm link hexo-admin`

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

## [hugo](https://github.com/gohugoio/hugo)

The world’s fastest framework for building websites. <https://gohugo.io>

* deploy 通过Aerobatic[<https://gohugo.io/hosting-and-deployment/hosting-on-bitbucket/>]
* [hugo-academic](https://github.com/gcushen/hugo-academic):📝 The website builder for Hugo. Build and deploy a beautiful website in minutes! <https://sourcethemes.com/academic/>
* Theme
  - [Hugo Themes](https://themes.gohugo.io)
* <https://jimmysong.io/hugo-handbook>

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

## [jekyll](https://github.com/jekyll/jekyll)

🌐 Jekyll is a blog-aware static site generator in Ruby <https://jekyllrb.com> static website generator，搭建静态博客，通过markdown文件自动生成html文件。Github Pages即靠Jekyll实现的。[官网](https://jekyllrb.com)

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
  - [so-simple-theme](https://github.com/mmistakes/so-simple-theme):A simple Jekyll theme for words and pictures.
  - [jekyll-bootstrap](https://github.com/plusjade/jekyll-bootstrap):The quickest way to start and publish your Jekyll powered blog. 100% compatible with GitHub pages. <http://jekyllbootstrap.com>

```sh
gem install jekyll bundler
gem new myblog
bundle exec
jekyll serve
```

## [docsify](https://github.com/docsifyjs/docsify)

🃏 A magical documentation site generator. <https://docsify.js.org>

* 直接运行时转换 md 为 html, `/#/guide` => guide.md

```sh
npm i docsify-cli -g
makdir blog
docsify init ./

blog/     # Github Pages 根目录
   ├ _images/       # 图片
   ├ _media/        # 多媒体文件
   ├ basic/         # 基础知识
   ├ develop/       # 编程开发
   ├ keys/          # 热键速查
   ├ links/         # 友情链接
   ├ offer/         # 求职应聘
   ├ writing/       # 写作排版
   ├ _coverpage.md  # 封面
   ├ _navbar.md     # 导航栏
   ├ _sidebar.md    # 侧边栏
   ├ README.md   # docs README 文件
   ├ index.html  # 首页，在这里配置 docsify
   ├ CNAME       # 绑定自定义域名 notes.abelsu7.top
   ├ .nojekyll   # 阻止 GitHub Pages 忽略命名是下划线开头的文件
   ├ README.md  # Github 仓库 README 文件
   └ LICENSE    # MIT License

docsify serve ./
```

## [Halo](https://github.com/halo-dev/halo)

## [Typecho](http://typecho.org/)

* 外观
* 插件

```
# 登录 typecho提示 URL 为 http://127.0.0.1/index.php/action/login?name=admin&password=admin&referer=http%3A%2F%2F127.0.0.1%2Fadmin%2Findex.php&_=a6ca5a4fff943b47824c6b1f8af93cde 页面为 404 Not Found
# location ~ \.php$ {
location ~ .*\.php(\/.*)*$ {
```

## [gollum](https://github.com/gollum/gollum)

A simple, Git-powered wiki with a sweet API and local frontend.

## 博客资源

* [Work life](https://www.atlassian.com/blog)
* 分发
  - [OpenWrite](https://openwrite.cn/)
  - [crawlab-team / artipub](https://github.com/crawlab-team/artipub):Article publishing platform that automatically distributes your articles to various media channels
* [一只特立独行的猪](http://guanzhou.pub/tag/)
* [schollz](https://schollz.com/)
* [lifesinger](https://github.com/lifesinger/blog):岁月如歌
* [前端精读](https://github.com/dt-fe/)

## 文章

* [ProtoTeam](https://github.com/ProtoTeam/blog):蚂蚁数据体验技术团队的文章仓库
* [没有了老师，该如何学习？](http://www.cnblogs.com/qianqian-li/p/6028745.html)
* [How To Ask Questions The Smart Way](http://www.catb.org/esr/faqs/smart-questions.html)
