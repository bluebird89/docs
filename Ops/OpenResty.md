# [openresty/openresty](https://github.com/openresty/openresty)

Turning Nginx into a Full-Fledged Scriptable Web Platform https://openresty.org

* 基于 Nginx 的一个 C 模块（lua-nginx-module）,将 LuaJIT 嵌入到 Nginx 服务器中，并对外提供一套完整的 Lua API，透明地支持非阻塞 I/O，提供了轻量级线程、定时器等高级抽象。
* 围绕这个模块，OpenResty 构建了一套完备的测试框架、调试技术和由 Lua 实现的周边功能库。

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
```

## [LuaRocks](https://github.com/luarocks/luarocks)

LuaRocks is the package manager for the Lua programming language. http://www.luarocks.org

```sh
brew install luarocks
```

## 工具

* [SkyLothar/lua-resty-jwt](https://github.com/SkyLothar/lua-resty-jwt):JWT For The Great Openresty
* [bungle/lua-resty-validation](https://github.com/bungle/lua-resty-validation):Validation Library (Input Validation and Filtering) for Lua and OpenResty. 

## 参考

* [openresty实践](https://openresty.net.cn/index.html)
