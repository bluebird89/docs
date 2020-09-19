## [GitHub](https://github.com/)

围绕Git 构建 SaaS 服务

* 集成其他功能：`repository > Settings > Integrations & services`
* give user private repositories
* github pages:必须使用master作为分支
  - hexo：添加文章后现hexo g（生成） hexo d（部署）
  - jekyll：直接push到master就好
* [import](https://github.com/new/import)
* 技巧
  - Fuzzy file finder: 按 t 可以快速进入模糊文件名搜索模式
  - 仓库主页，按 w 可以快速进行分支过滤
  - 任意 GitHub 页面中，按 ? 展示当前页面可用的快捷键
  - 在任意的 diff URL 添加 ?w=1 用来整理缩进
  - 按范围过滤提交记录: master@{time}..master
  - 按作者过滤提交记录: ?author=github_handle
  - 在命令行输入 hub pull-request 创建pull request
  - 在比较页面、合并请求页面或者评论页面的URL后增加 .diff 或者 .patch，可以得到 diff 或者 patch 的文本格式。
  - 可以直接在收到的 GitHub 通知邮件进行评论，不必在网站页面中评论
  - 在文件展示页面，点击某行或者通过按 SHIFT 选择多行，URL 会有相应的改变。如果你要给你的队友分享一段代码是非常方便的：
  - 在合并请求、问题或者任何评论中中提到用户会使用户关注全部的后续通知,sha和问题码(例如：#1)会被自动链接。并且也可以链接其它仓库的 sha 或者问题码，格式：user/repo@sha1 或者 user/repo#1
  - 插件 Octotree
* 速度慢
  - 添加本地dns， 通过[ipaddress](https://www.ipaddress.com/)查询ip,
  - <raw.githubusercontent.com>, 同上
  - 先通过码云导入 GitHub 上项目；码云clone；修改 .git/config 替换为原来 github地址
  - [GitHub 加速下载](https://toolwa.com/github/)

![Git 使用规范流程](../_static/bg2015080501.png)

```yaml
name: GitHub Actions Demo

on: [push, pull_request]
on:
  push:
    branches:
      - master

jobs:
  build-and-deploy:
    runs-on: ubuntu-18.04
    name: My first job
    steps:
    - name: Print a greeting
      env:
        MY_VAR: Hi there! My name is
        FIRST_NAME: Mona
        MIDDLE_NAME: The
        LAST_NAME: Octocat
      run: |
        echo $MY_VAR $FIRST_NAME $MIDDLE_NAME $LAST_NAME.
    - name: Checkout
      uses: actions/checkout@master

    - name: Build and Deploy
      uses: JamesIves/github-pages-deploy-action@master
      env:
        ACCESS_TOKEN: ${{ secrets.ACCESS_TOKEN }}
        BRANCH: gh-pages
        FOLDER: build
        BUILD_SCRIPT: npm install && npm run build
  my_second_job:
    name: My second job
    needs: build-and-deploy
  job3:
    needs: [build-and-deploy, job2]

# github
219.76.4.4 github-cloud.s3.amazonaws.com
192.30.253.112 github.com
151.101.185.194 github.global.ssl.fastly.net
```

## action

持续集成由很多操作组成，比如抓取代码、运行测试、登录远程服务器，发布到第三方服务等等,把每个操作写成独立的脚本文件，存放到代码仓库，使得其他开发者可以引用

* 原理：每个 action 就是一个独立脚本，因此可以做成代码仓库，使用userName/repoName的语法引用 action。用户可以引用某个具体版本的 action
  - 存放在代码仓库的.github/workflows目录
  - 文件采用 YAML 格式，后缀名统一为.yml，GitHub 只要发现.github/workflows目录里面有.yml文件，就会自动运行该文件
  - 仓库顶部的菜单会出现Actions一项
  - 密钥储存到当前仓库的Settings/Secrets里面
* 术语
  - workflow （工作流程）：持续集成一次运行的过程，就是一个 workflow。
  - job （任务）：一个 workflow 由一个或多个 jobs 构成，含义是一次持续集成的运行，可以完成多个任务。
  - step（步骤）：每个 job 由多个 step 构成，一步步完成。
  - action （动作）：每个 step 可以依次执行一个或多个命令（action）
* starter
  - [actions/starter-workflows](https://github.com/actions/starter-workflows):Accelerating new GitHub Actions workflows https://github.com/features/actions
* actions
  - [awesome-actions](https://github.com/sdras/awesome-actions):A curated list of awesome actions to use on GitHub
  - [github actions marketpalce](https://github.com/marketplace?type=actions)
  - [ github / super-linter ](https://github.com/github/super-linter):Combination of multiple linters to install as a GitHub Action

## [CLi](https://github.com/cli/cli)

* GitHub’s official command line tool https://cli.github.com
  - `brew install github/gh/gh`
  - `scoop bucket add github-gh https:scoop install gh`
  - `gh pr [status, list, view, checkout, create]gh issue [status, list, view, create]gh help`
* COMMANDS
  - gist:       Create gists
  - issue:      Manage issues
  - pr:         Manage pull requests
  - release:    Manage GitHub releases
  - repo:       Create, clone, fork, and view repositories
  - alias:      Create command shortcuts
  - api:        Make an authenticated GitHub API request
  - auth:       Login, logout, and refresh your authentication
  - completion: Generate shell completion scripts
  - config:     Manage configuration for gh
  - help:
* auth
* condi
* [文档](https://cli.github.com/manual/)

```sh
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
```

## [521xueweihan / GitHub520](https://github.com/521xueweihan/GitHub520)

kissing_heart让你“爱”上 GitHub，解决访问时图裂、加载慢的问题。 hellogithub.com

```
/etc/hosts
# GitHub520 Host Start
185.199.108.154               github.githubassets.com
199.232.68.133                camo.githubusercontent.com
13.68.241.146                 github.map.fastly.net
199.232.69.194                github.global.ssl.fastly.net
140.82.113.4                  github.com
140.82.114.6                  api.github.com
199.232.68.133                raw.githubusercontent.com
199.232.68.133                user-images.githubusercontent.com
199.232.68.133                favicons.githubusercontent.com
199.232.68.133                avatars5.githubusercontent.com
199.232.68.133                avatars4.githubusercontent.com
199.232.68.133                avatars3.githubusercontent.com
199.232.68.133                avatars2.githubusercontent.com
199.232.68.133                avatars1.githubusercontent.com
199.232.68.133                avatars0.githubusercontent.com
# Star me GitHub url: https://github.com/521xueweihan/GitHub520
# GitHub520 Host End

ipconfig /flushdns
sudo rcnscd restart
sudo killall -HUP mDNSResponder
```

## [anuraghazra/github-readme-stats](https://github.com/anuraghazra/github-readme-stats)

zap Dynamically generated stats for your github readmes

```md
# 同用户名 readme.md
[![Anurag's github stats](https://github-readme-stats.vercel.app/api?username=bluebird89&show_icons=true&&title_color=fff&icon_color=79ff97&text_color=9f9f9f&bg_color=151515)
[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=bluebird89&a&layout=compact)](https://github.com/anuraghazra/github-readme-stats)
```

## 参考

* [gitalk/gitalk](https://github.com/gitalk/gitalk):Gitalk is a modern comment component based on Github Issue and Preact. https://gitalk.github.io
* [desktop/desktop](https://github.com/desktop/desktop):Simple collaboration from your desktop https://desktop.github.com
* [OctoLinker/OctoLinker](https://github.com/OctoLinker/OctoLinker):OctoLinker – Available on Chrome, Firefox and Opera https://octolinker.github.iow
* [devhubapp/devhub](https://github.com/devhubapp/devhub):DevHub: TweetDeck for GitHub - Android, iOS and Web 👉 https://devhubapp.com/
* [unbug/codelf](https://github.com/unbug/codelf):Best GitHub stars, repositories tagger and organizer. Search over projects from Github, Bitbucket, Google Code, Codeplex, Sourceforge, Fedora Project, GitLab to find real-world usage variable names https://unbug.github.io/codelf/
* [pomber/git-history](https://github.com/pomber/git-history):Quickly browse the history of a file from any git repository https://githistory.xyz/
* [Tutorial](https://lab.github.com/courses)
* [GitHub Helps](https://help.github.com/)
* [GitHub规范](https://guides.github.com/)
* [github/hub](https://github.com/github/hub):A command-line tool that makes git easier to use with GitHub. https://hub.github.com/
