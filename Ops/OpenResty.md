# [openresty/openresty](https://github.com/openresty/openresty)

Turning Nginx into a Full-Fledged Scriptable Web Platform https://openresty.org

* 一个基于 Nginx 与 Lua 的高性能 Web 平台，内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关
* 基于 Nginx 的一个 C 模块（lua-nginx-module）,将 LuaJIT 嵌入到 Nginx 服务器中，并对外提供一套完整的 Lua API，透明地支持非阻塞 I/O，提供了轻量级线程、定时器等高级抽象。
* 围绕这个模块，OpenResty 构建了一套完备的测试框架、调试技术和由 Lua 实现的周边功能库
* 通过汇聚各种设计精良的 Nginx 模块（主要由 OpenResty 团队自主开发），从而将 Nginx 有效地变成一个强大的通用 Web 应用平台。Web 开发人员和系统工程师可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K 乃至 1000K 以上单机并发连接的高性能 Web 应用系统
* 目标是让Web服务直接跑在 Nginx 服务内部，充分利用 Nginx 的非阻塞 I/O 模型，不仅仅对 HTTP 客户端请求,甚至于对远程后端诸如 MySQL、PostgreSQL、Memcached 以及 Redis 等都进行一致的高性能响应

## install

```sh
brew install openresty/brew/openresty

tar -xzvf openresty-VERSION.tar.gz
cd openresty-VERSION/
./configure --prefix=/opt/openresty \
            --with-luajit \
            --without-http_redis2_module \
            --with-http_iconv_module \
            --with-http_postgres_module
make
sudo make install

resty -e 'print("hello, world")'

nginx -p `pwd`/ -c conf/nginx.conf

ab -c10 -n50000 http://localhost:8080/

# install some prerequisites needed by adding GPG public keys (could be removed later)
sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
# import our GPG key:
wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
# add the our official APT repository:
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list
# to update the APT index:
sudo apt-get update
```

##

* Lua 接口还提供了一种特殊的空值，即 ngx.null，用来表示不同于 nil 的“空值”

```
nginx -p `pwd`/ -c conf/nginx.conf
```

## 工具

* [SkyLothar/lua-resty-jwt](https://github.com/SkyLothar/lua-resty-jwt):JWT For The Great Openresty
* [bungle/lua-resty-validation](https://github.com/bungle/lua-resty-validation):Validation Library (Input Validation and Filtering) for Lua and OpenResty.
* [openresty/lua-nginx-module](https://github.com/openresty/lua-nginx-module):Embed the Power of Lua into NGINX HTTP servers https://openresty.org/
* [loveshell / ngx_lua_waf](https://github.com/loveshell/ngx_lua_waf):一个基于lua-nginx-module(openresty)的web应用防火墙
* [openresty/lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic):Lua library for limiting and controlling traffic in OpenResty/ngx_lua

## 参考

* [openresty实践](https://openresty.net.cn/index.html)
* [OpenResty最佳实践](https://moonbingbing.gitbooks.io/openresty-best-practices/content/)
