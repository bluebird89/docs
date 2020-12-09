# [WordPress](https://github.com/WordPress/WordPress)

WordPress, Git-ified. Synced via SVN every 15 minutes, including branches and tags! This repository is just a mirror of the WordPress subversion repository. Please do not send pull requests. Submit patches to <https://core.trac.wordpress.org/> instead. <https://wordpress.org/>

* 到 wordpress.com 注册帐户，获取用户的 API-Key，用来启用 Akismet 插件。Akismet 是 WordPress 下非常著名的反垃圾评论插件。
* 修改永久链接结构：默认情况下，WordPress 的永久链接结构类似于 ../?p=123 ，但我们推荐使用有利于搜索引擎优化的 URL 结构。本文作者建议采用 …/%category%/%postname%
* 使用系统缓存:Super Cache
* 创建网站地图：这是最基本一步，因为网站地图可以帮助搜索引擎来更轻松地抓取你网站的内容。可以使用 Google XML sitemap 插件来创建网站地图。
* 将 Feed 重定向到 feedburner：比如在你的博客的每个设计里修改所有的链接（尤其是 single.php, sidebar.php, footer.php 等）。我推荐使用 FeedSmith 插件来减少手动工作量。
* 添加跟踪代码：跟踪统计网站的性能是很必要的。你可以添加 Google 分析，StatCounter 或者其他的统计代码。根据我的额经验，Statcounter 是比较可靠并且载入速度快的。
* 提交网站到站长工具箱：我几乎没有注意到这点。不过，Google 站长工具箱有全部的功能，可以让你提交网站地图，显示网站搜索分析结果和网站上的错误。确实配得上站长工具箱的名字。
* 创建 robots.txt ：尽管有了站长工具箱，我还要说这个很重要。如果你有这个文件，可以分析一下；如果还没有，也可以使用 WordPress 的选项来创建一个。
* 设计：博客网站给读者的第一印象就是它的设计。注意好的设计应该包括重要的元素，比如搜索功能，Feed 订阅图标，导航菜单，并且便于阅读。你可以从这里挑选一些精选的 WordPress 主题。
* 开始写博客：告诉世界你要开始写博客了，说说你要写的内容，介绍一下你自己。要和访问者进行交流，你可以使用 Wp-contact form 插件来建立一个联系页面。
* 同时，别忘了创建 about 页面，因为访问者想了解你更多一些。

## 安装

* [安装地址](http://example.com/wp-admin/install.php)

## 插件

* [gutenberg](https://github.com/WordPress/gutenberg):Printing since 1440. Development hub for the editor focus in core. Plugin is available from the official WordPress repository. <https://wordpress.org/plugins/gutenberg/>

## 主题

* [sage](https://github.com/roots/sage):WordPress starter theme with a modern development workflow <https://roots.io/sage/>

## 优化

* 启动gzip压缩、安装wp super cache、使用公共cdn服务器

## [calypso](https://github.com/Automattic/wp-calypso)

The JavaScript and API powered WordPress.com <https://developer.wordpress.com/calypso/>

## 参考

* [kinsta](https://kinsta.com/):<https://kinsta.com/resources/>

## 工具

* [VVV](https://github.com/Varying-Vagrant-Vagrants/VVV):An open source Vagrant configuration for developing with WordPress <https://varyingvagrantvagrants.org>
* [headless-wp-starter](https://github.com/postlight/headless-wp-starter):🔪 WordPress + React Starter kit
* [Apps](https://apps.wordpress.com)
* <https://sarah.dev/writing/>
* <https://github.com/brickspert/blog>
* <https://github.com/GavinZhuLei/vue-form-making>
* <https://github.com/fangzesheng/free-api>
* <https://github.com/zhisheng17/flink-learning>
* <https://github.com/DevinVinson/WordPress-Plugin-Boilerplate>
* <https://github.com/benweet/stackedit>
* <https://github.com/roots/sage>
* <https://github.com/digitalocean/nginxconfig.io>
* <https://github.com/future-architect/vuls>
* <https://github.com/woocommerce/woocommerce>
* <https://github.com/roots/bedrock>
* <https://github.com/wpscanteam/wpscan>
* <https://wp-cli.org/>
