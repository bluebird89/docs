# [elixir-lang/elixir](https://github.com/elixir-lang/elixir)

Elixir is a dynamic, functional language designed for building scalable and maintainable applications http://elixir-lang.org/

## 特点

* erlang VM 自带的 observer 是个非常棒的工具，能够帮助了解系统运行的状态
  - 服务在 epmd 注册的端口是动态的:需要保持一个范围内的端口全开，但是必须限制访问的源 IP
* shell 也可以用来做运行系统的 introspection

```
# observer，需要在 mix.exs 里加入 runtime_tools application，这样 observer backend 才会运行
# 要想在本地远程连接生产环境的 node，需要知道其在 epmd 下注册的端口。这样的需求一般都用 ssh port forwarding 来完成
PORT_PROD=$(shell ssh prod-cms-service "epmd -names" | grep cms_service | sed 's/[^0-9]//g') # 显示本机在 epmd 注册的服务的端口号,找到生产环境下当前运行的服务的端口号，我们需要 ssh 上去运行这条命令

ssh-tunnel-prod:
  @ssh -L 4369:localhost:4369 -L $(PORT_PROD):localhost:$(PORT_PROD) prod-cms-service

observer:
  @iex --name observer@127.0.0.1 --cookie '$(COOKIE)' --hidden -e ":observer.start"

remsh:
  @iex --name observer@127.0.0.1 --cookie '$(COOKIE)' --remsh cms_
```

## 安装

```sh
brew install elixir

# Add Erlang Solutions repo
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
# Install the Erlang/OTP platform and all of its applications
sudo apt-get install esl-erlang
sudo apt-get install elixir
```

## 配置

* Linting / testing：credo
* 项目和现有的 CI pipeline 集成
* 清晰的版本管理方案:根目录下放一个 version 文件，然后各种地方都从这个文件中读取 version 信息。在代码中读取很简单
* 和现有的系统无缝对接:因为 rest API 是浅浅的一层，所以使用了 plug
* 完善的部署脚本
* 和现有的日志系统以及错误报告系统集成
  - 使用文件日志，可以用 logstash 或者 file beat 将日志文件送入 elasticsearch 进行 aggregation
  - sentry 官方有 elixir 的客户端，只要注册一个新的 app，把 dsn 写入到配置文件中即可实现和错误报系统的集成
* 和现有的监控系统集成

```sh
# .git/hooks/pre-commit
#!/bin/sh

mix test_all
RES=$?
if [ $RES -ne 0  ]
then
  exit $RES
fi

# .travis.yml
language: elixir
elixir:
  - 1.4.0
otp_release:
  - 19.1
branches:
  only:
    - master
install:
  - mix local.hex --force
  - mix local.rebar --force
  - mix deps.get
services:
  - mongodb
  - postgresql
script:
  - mix test_all
env:
  - MIX_ENV=test
before_script:
  - make test-prepare


File.cwd!() |> Path.join("version") |> File.read! |> String.trim
# 在 makefile 里也可以通过 VERSION=$(strip $(shell cat version))

RELEASE_VERSION=v$(VERSION)
GIT_VERSION=$(strip $(shell git rev-parse --short HEAD))

...

version-bump:
  @git tag -a $(RELEASE_VERSION) -m "bump to $(RELEASE_VERSION) on $(GIT_VERSION)"
  @git push origin $(RELEASE_VERSION)
```

## 使用

```
iex
```

## 类库

* [absinthe-graphql/absinthe](https://github.com/absinthe-graphql/absinthe):The GraphQL toolkit for Elixir http://absinthe-graphql.org
