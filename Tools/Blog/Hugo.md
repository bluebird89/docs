
# [hugo](https://gohugo.io)Hugo is a fast and modern static site generator written in Go,

## install && use

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

## deploy 通过Aerobatic[<https://gohugo.io/hosting-and-deployment/hosting-on-bitbucket/>]

## 参考

* [barretlee/hexo-admin](https://github.com/barretlee/hexo-admin)
* https://jimmysong.io/hugo-handbook
