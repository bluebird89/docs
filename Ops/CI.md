# CI


## Travis CI

用来构建托管在GitHub上的代码，最主要工作是自动运行项目的单元测试并生成报告，同时根据的配置文件，生成一个Linux虚拟机来运行你的命令，通常这些命令用于测试，构建等。默认设置下，每次对项目进行Push时，都会触发Travis CI运行一次测试。同时提供了一个项目状态图标，可以放置在项目主页告知用户当前的测试情况.

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

## 工具

* [TeamCity](https://www.jetbrains.com/teamcity/)
* [danger/danger-js](https://github.com/danger/danger-js):⚠️ Stop saying "you forgot to …" in code review http://danger.systems/js/

## 教程

- [dwyl/learn-travis](https://github.com/dwyl/learn-travis):A quick Travis CI (Continuous Integration) Tutorial for Node.js developers
