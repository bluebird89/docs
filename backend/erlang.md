# [erlang/otp](https://github.com/erlang/otp)

* <http://erlang.org>
*  Joe 老爷子在其博士论文中提到对 erlang 的 worldview：
    - everything is a process.
    - process are strongly isolated.
    - process creation and destruction is a lightweight operation.
    - message passing is the only way for processes to interact.
    - processes have unique names.
    - if you know the name of a process you can send it a message.
    - processes share no resources.
    - error handling is non-local.
    - processes do what they are supposed to do or fail.

```sh
sudo apt-get install erlang

get https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-cache madison esl-erlang #列出一个软件的版本的命令是 sudo apt-cache madison soft_name
sudo apt install esl-erlang=1:20.0

erl --version
```

## 使用

* spawn：创建一个资源。对于 erlang，这资源是 process；对某个 service，是 service 本身。
* send / receive：给资源发指令和接受指令。对于 erlang，这指令是 message，封装成 erlang term，走的是 IPC/RPC；而对某个 http service，指令是 request，封装成 json / msgpack / protobuf，走的是 http / http2。
* register / whereis：资源怎么注册，怎么发现。对于 erlang，这是 process 在 name register 的注册和发现；对于某个 service，可以是 Consul / DNS。
* self：返回自己的 identity。在 erlang 里，这是 process 找寻自我的方式；在 micro service 的场景下，每个 service 隐含着有自己的 identity。

## 参考

* [官方文档](http://erlang.org/doc/)
