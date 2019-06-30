# Lua

## install

Lua 的环境有两种： Lua
LuaJIT:实行效率提升几十倍

```sh
apt-get install lua5.2

curl -R -O http://www.lua.org/ftp/lua-5.3.4.tar.gz
tar zxf lua-5.3.4.tar.gz
cd lua-5.3.4
make linux test
```

## 数据

* nil	表示无效值，在条件表达式中表示 false
* boolean	布尔值，包含 true 和 false 两个值
* number	表示双精度类型的实浮点数
* string	表示字符串，通过双引号或单引号括住
* userdata	表示任意存储在变量中的 C 数据结
* function	表示 C 或 Lua 编写的函
* thread	表示执行的独立线程，用于执行协同程序
* table	表示一个关联数组，数组索引可以是数字或字符串

## 编辑器

* hammerspoon

## 框架

* [torch/torch7](https://github.com/torch/torch7):Torch is a scientific computing framework with wide support for machine learning algorithms that puts GPUs first. It is easy to use and efficient, thanks to an easy and fast scripting language, LuaJIT, and an underlying C/CUDA implementation. http://torch.ch/

## 工具

* [Azure/golua](https://github.com/Azure/golua):A Lua 5.3 engine implemented in Go
* [tboox/ltui](https://github.com/tboox/ltui):🍯A cross-platform terminal ui library based on Lua https://tboox.org
* [tboox/xmake](https://github.com/tboox/xmake):🔥 A cross-platform build utility based on Lua https://xmake.io
* [yuin/gopher-lua](https://github.com/yuin/gopher-lua):GopherLua: VM and compiler for Lua in Go

## 参考

* [cloudwu/lua53doc](https://github.com/cloudwu/lua53doc):The Chinese Translation of Lua 5.3 document
* [Tinywan/lua-nginx-redis](https://github.com/Tinywan/lua-nginx-redis):🌺 Redis、Lua、Nginx、OpenResty笔记
* [torch/nn](https://github.com/torch/nn)
* [openresty/lua-nginx-module](https://github.com/openresty/lua-nginx-module):Embed the Power of Lua into NGINX HTTP servers https://openresty.org/
