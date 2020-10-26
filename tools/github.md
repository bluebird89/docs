## [GitHub](https://github.com/)

围绕Git 构建 SaaS 服务

* give user private repositories
* [import](https://github.com/new/import)
* 速度慢
  - 添加本地dns， 通过[ipaddress](https://www.ipaddress.com/)查询ip,
  - <raw.githubusercontent.com>, 同上
  - 先通过码云导入 GitHub 上项目；码云clone；修改 .git/config 替换为原来 github地址
  - [GitHub 加速下载](https://toolwa.com/github/)
* 从 2020年 10 月 1 日开始，GitHub 上所有新创建的源代码库都将被命名为 main

## issue

* 内容
  - 一个软件的 bug
  - 一项功能建议
  - 一项待完成的任务
  - 文档缺失的报告
* 项目管理
  - 指定 Issue 的优先级
  - 指定 Issue 所在的阶段
  - 分配负责 Issue 的处理人员
  - 制定日程
  - 监控进度，提供统计
* 团队合作
  - 讨论
  - 邮件通知
* 代码管理
  - 将 Issue 关联源码
  - 将 Issue 关联代码提交与合并
* 配置项
  - Assignees：人员
  - Labels：标签
    + 至少应该有两个 Label
    + 性质
    + 优先级
      * 高优先级（High）：对系统有重大影响，只有解决它之后，才能去完成其他任务。
      * 普通优先级（Medium）：对系统的某个部分有影响，用户的一部分操作会达不到预期效果。
      * 低优先级（Low）：对系统的某个部分有影响，用户几乎感知不到。
      * 微不足道（Trivial）：对系统的功能没有影响，通常是视觉效果不理想，比如字体和颜色不满意
  - Projects：项目
  - Milestone：里程碑，用作 Issue 的容器。相关 Issue 可以放在一个 Milestone 里面。常见的例子是不同的版本（version）和迭代（sprint）
* [全局视图](github.com/issues)

## pull request

## Actions

持续集成由很多操作组成，比如抓取代码、运行测试、登录远程服务器，发布到第三方服务等等,把每个操作写成独立的脚本文件，存放到代码仓库，使得其他开发者可以引用

* 原理：每个 action 就是一个独立脚本，因此可以做成代码仓库，使用userName/repoName的语法引用 action。用户可以引用某个具体版本的 action
  - 存放在代码仓库的.github/workflows目录
  - 文件采用 YAML 格式，后缀名统一为.yml，GitHub 只要发现.github/workflows目录里面有.yml文件，就会自动运行该文件
  - 仓库顶部的菜单会出现Actions一项
  - 密钥储存到当前仓库的Settings/Secrets里面
* 术语
  - workflow （工作流程）：持续集成一次运行的过程，就是一个 workflow。
  - job （任务）：一个 workflow 由一个p或多个 jobs 构成，含义是一次持续集成的运行，可以完成多个任务。
  - step（步骤）：每个 job 由多个 step 构成，一步步完成。
  - action （动作）：每个 step 可以依次执行一个或多个命令（action）
* 教程
  - [actions/starter-workflows](https://github.com/actions/starter-workflows):Accelerating new GitHub Actions workflows https://github.com/features/actions
  - [weather-bot](link)
* actions
  - [awesome-actions](https://github.com/sdras/awesome-actions):A curated list of awesome actions to use on GitHub
  - [github actions marketpalce](https://github.com/marketplace?type=actions)
  - [super-linter](https://github.com/github/super-linter):Combination of multiple linters to install as a GitHub Action

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
```

## WIP

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

## github pages

* 必须使用master作为分支
* hexo：添加文章后现hexo g（生成） hexo d（部署）
* jekyll：直接push到master就好

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

## profiles

* [profile-summary-for-github](https://github.com/tipsy/profile-summary-for-github):Tool for visualizing GitHub profiles

## Trending

* [Trending](https://github.com/trending):See what the GitHub community is most excited about today.
* [521xueweihan/HelloGitHub](https://github.com/521xueweihan/HelloGitHub):octocat: Find pearls on open-source seashore 分享 GitHub 上有趣、入门级的开源项目 https://hellogithub.com/
* [sindresorhus/awesome](https://github.com/sindresorhus/awesome) Curated list of awesome lists
* [Aggregated Awesome](https://aggregatedawesome.com/):There are several awesome lists on GitHub that collect and curate the best resources for a specific programming language, framework, platform, etc.
* [wx-chevalier/Awesome-Lists](https://github.com/wx-chevalier/Awesome-Lists):📚 Guide to Galaxy, curated, worthy and up-to-date links/reading list for ITCS-Coding/Algorithm/SoftwareArchitecture/AI. 💫 ITCS-编程/算法/软件架构/人工智能等领域的文章/书籍/资料/项目链接精选，岁月沉淀的美好
* [jnv/lists](https://github.com/jnv/lists):The definitive list of lists (of lists) curated on GitHub and elsewhere
* [ kon9chunkit / GitHub-Chinese-Top-Charts ](https://github.com/kon9chunkit/GitHub-Chinese-Top-Charts):GitHub中文排行榜

## [anuraghazra/github-readme-stats](https://github.com/anuraghazra/github-readme-stats)

zap Dynamically generated stats for your github readmes

```
# 同用户名 readme.md
[![Anurag's github stats](https://github-readme-stats.vercel.app/api?username=bluebird89&show_icons=true&&title_color=fff&icon_color=79ff97&text_color=9f9f9f&bg_color=151515)
[![Top Langs](https://github-readme-stats.vercel.app/api/top-langs/?username=bluebird89&a&layout=compact)](https://github.com/anuraghazra/github-readme-stats)
```

## Integrations & services

* 集成其他功能：`repository > Settings > Integrations & services`
* 工具
  - [marketplace](https://github.com/marketplace)

## [zenhub](https://app.zenhub.com)

Agile project management integrated with GitHub

## 实践

* 收集：需求无时无刻，无处不在，anywhere anytime
  - 通过 GitHub Issues 收集需求
  - 以解决问题为导向，就是有什么需求就直接给 repo 建一个 issue 作为 Story Card
  - 通过ISSUE_TEMPLATE这样一个模板来新建某个issue，从而更快地定位问题所在和解析自己的想法，最主要的是能够输出更具体的 TODOs，即下一步行动的具体内容
    + issue 和 issue 之间是可以通过 # 相互连接，甚至可以跨仓库，被 reference 的 issue 也会出现在另外一边的 issue 里面；
    + 通过 #! 符号是可以在 comments 里面直接新建一个 issue ，这在思维爆炸的时候来得特别爽快；
    + 还可以随意艾特你的小伙伴们，互相监督、互相学习或者给出 Constructive Feedback 之类的，😂；
    + 更甚至于，若是在 Intellij 里面关联了 GitHub，就可以在 git commit 信息里面直接看到你所要关联的 issues 列表了
  - 移动端则可以通过 GitDo 这个 App 来轻松新建和管理自己的 Issues
* 整理：as BA，即分析，Elaboration & Estimation & IPM => 确定 MVP & Efforts
  - 整理GitHub Issues:把issues作为个人需求列表，需要解决的问题可以大到做一个开源项目，或者小到读一本书、写一篇文章。对于比较大的需求，还可以将其转化为 Epic 然后把拆分过后的小 issues 们加入到这个列表里面来
  - 使用 GitHub 新出的 Projects 特性或者使用 ZenHub 的 Boards 就可以让你瞬间拥有日常敏捷工作的感觉
* 执行：as Dev & QA，Developing & Testing & Review/Sign-Off
  - 制定迭代计划:新建一个 Milestone 来制定计划，也就是决定在一个 Iteration 里面你需要完成哪些 issues。在这里我所制定的阶段性计划周期为一个月，当然你也可以勤快一点，以2周作为一个 Iteration，享受一下自己的计划要完成不了、这个 Milestone 就要废了
    + 在月初做计划的时候给自己准备专门的时间来做 Elaboration，把 Backlog 里面的卡拖到 Rethink/Plan 这一列，经过分析和详细输出 TODOs 以及所对应的估点 points 之后便可以将其拖到 Ready For Todo 了，一般我给自己估的点数就是完成这件事情所需要的时间，一小时即对应一个 point
    + 选择 Filter Issues by Milestone 专注于当前 Iteration，专注于 In Progress 这一列所要做的事情，并且垂涎于 Ready For Todo 里面将要做的事情，每次做完还可以放到 Review/SignOff，在里面写写对这件事情的总结和感想什么的，每次挪卡都充满了敏捷的仪式感
  - 进度的把控
    + 拖动某个 item 进行排序，而且可以在前面的勾选项中直接打勾 ☑️ 标记为完成
    + 完成之后这个 issue 还能直接显示完成进度；前面所提到的 Epic 也能直接显示子 issues 的完成情况即 closed 比例，两者结合起来简直不能再美好
  - 专注当下
* 回顾：Retrospection，Introspection，持续反思，持续进步…
* [参考](https://github.com/JimmyLv/jimmylv.github.io)
* [实践](https://insights.thoughtworks.cn/agile-learning-method-base-on-github/)

![Git 使用规范流程](../_static/bg2015080501.png)

## 技巧

* Fuzzy file finder: 按 t 可以快速进入模糊文件名搜索模式
* 仓库主页，按 w 可以快速进行分支过滤
* 任意 GitHub 页面中，按 ? 展示当前页面可用的快捷键
* 在任意的 diff URL 添加 ?w=1 用来整理缩进
* 按范围过滤提交记录: master@{time}..master
* 按作者过滤提交记录: ?author=github_handle
* 在命令行输入 hub pull-request 创建pull request
* 在比较页面、合并请求页面或者评论页面的URL后增加 .diff 或者 .patch，可以得到 diff 或者 patch 的文本格式。
* 可以直接在收到的 GitHub 通知邮件进行评论，不必在网站页面中评论
* 在文件展示页面，点击某行或者通过按 SHIFT 选择多行，URL 会有相应的改变。如果你要给你的队友分享一段代码是非常方便的：
* 在合并请求、问题或者任何评论中中提到用户会使用户关注全部的后续通知,sha和问题码(例如：#1)会被自动链接。并且也可以链接其它仓库的 sha 或者问题码，格式：user/repo@sha1 或者 user/repo#1

## 工具

* [Octotree](https://www.octotree.io/)

## 参考

* [gitalk/gitalk](https://github.com/gitalk/gitalk):Gitalk is a modern comment component based on Github Issue and Preact. https://gitalk.github.io
* [desktop/desktop](https://github.com/desktop/desktop):Simple collaboration from your desktop https://desktop.github.com
* [OctoLinker/OctoLinker](https://github.com/OctoLinker/OctoLinker):OctoLinker – Available on Chrome, Firefox and Opera https://octolinker.github.iow
* [devhubapp/devhub](https://github.com/devhubapp/devhub):DevHub: TweetDeck for GitHub - Android, iOS and Web 👉 https://devhubapp.com/
* [unbug/codelf](https://github.com/unbug/codelf):Best GitHub stars, repositories tagger and organizer. Search over projects from Github, Bitbucket, Google Code, Codeplex, Sourceforge, Fedora Project, GitLab to find real-world usage variable names https://unbug.github.io/codelf/
* [pomber/git-history](https://github.com/pomber/git-history):Quickly browse the history of a file from any git repository https://githistory.xyz/
* [Docs](https://docs.github.com/en)
* [Tutorial](https://lab.github.com/courses)
* [GitHub Helps](https://help.github.com/)
* [GitHub规范](https://guides.github.com/)
* [github/hub](https://github.com/github/hub):A command-line tool that makes git easier to use with GitHub. https://hub.github.com/
