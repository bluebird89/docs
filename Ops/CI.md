# CI

持续集成（CI）是每次团队成员提交版本控制更改时自动构建和测试代码的过程。这鼓励开发人员通过在每个小任务完成后将更改合并到共享版本控制存储库来共享代码和单元测试。

代码仓库更新后，通过在 GitLab 设置的 CI-CD 配置，自动打包镜像，然后触发 WebHook 自动更新

## [travis-ci/travis-ci](https://github.com/travis-ci/travis-ci)

Free continuous integration platform for GitHub projects. https://travis-ci.org

 用来构建托管在GitHub上的代码，最主要工作是自动运行项目的单元测试并生成报告，同时根据的配置文件，生成一个Linux虚拟机来运行命令，通常这些命令用于测试，构建等。默认设置下，每次对项目进行Push时，都会触发Travis CI运行一次测试。同时提供了一个项目状态图标，可以放置在项目主页告知用户当前的测试情况.

- 配置文件.travis.yml

```
language: php
php:
  - 5.3
  - 5.4
before_script:
  - composer install
  - cd tests
script: phpunit -v
```

## circleci

## Webhooks

* [GitHub Developer](https://developer.github.com/webhooks/)
* [adnanh/webhook](https://github.com/adnanh/webhook):webhook is a lightweight configurable tool written in Go, that allows you to easily create HTTP endpoints (hooks) on your server, which you can use to execute configured commands.
* [NetEaseGame/git-webhook](https://github.com/NetEaseGame/git-webhook):使用 Python Flask + SQLAchemy + Celery + Redis + React 开发的用于迅速搭建并使用 WebHook 进行自动化部署和运维，支持 Github / GitLab / Gogs / GitOsc。
* [sovereign/sovereign](https://github.com/sovereign/sovereign)

## 教程

* [dwyl/learn-travis](https://github.com/dwyl/learn-travis):A quick Travis CI (Continuous Integration) Tutorial for Node.js developers

## 工具

* [TeamCity](https://www.jetbrains.com/teamcity/)
* [danger/danger-js](https://github.com/danger/danger-js):⚠️ Stop saying "you forgot to …" in code review http://danger.systems/js/
