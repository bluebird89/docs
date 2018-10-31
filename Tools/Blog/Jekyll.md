# 说明

static website generator，搭建静态博客，通过markdown文件自动生成html文件。Github Pages即靠Jekyll实现的。[官网](https://jekyllrb.com)

# install:

```
gem install jekyll bundler
gem new myblog
bundle exec jekyll serve：本地查看效果
```

# 文件说明

- _config.yml 是配置文件，最为重要，包含了所有配置信息
- _includes 文件夹包含了将被反复利用的文件，比如footer，header
- _layouts 文件夹包含了主页面的排版布局
- _posts 文件夹将包含所有的日志文件，Markdown格式

# 配置

- github新仓库 开启Github pages
- 将代码推送到仓库
- [访问页面](https://bluebird89.github.io/)

## 主题

* [mmistakes/so-simple-theme](https://github.com/mmistakes/so-simple-theme):A simple Jekyll theme for words and pictures. 
