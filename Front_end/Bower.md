# bower

Bower can manage components that contain HTML, CSS, JavaScript, fonts or even image files. Bower doesn't concatenate or minify code or do anything else - it just installs the right versions of the packages you need and their dependencies.客户端技术的软件包管理器，它可用于搜索、安装和卸载如JavaScript、HTML、CSS之类的网络资源

```sh
# installs the project dependencies listed in bower.json
npm install -g bower
# Create a bower.json
bower init

# registered package
bower search|info|install|update|uninstall jquery underscore
# GitHub shorthand:添加到依赖文件中
bower install --save desandro/masonry
# Git endpoint
bower install git://github.com/user/package.git
# URL
bower install <http://example.com/script.js>

# use
<script src="bower_components/jquery/dist/jquery.min.js">
</script>
```

## 配置

加一个.bowerrc文件

```json
{
  "directory" : "js/lib"
}
```
