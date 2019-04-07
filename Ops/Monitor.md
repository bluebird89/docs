# 监控

## Raygun

Raygun是领先的错误监控以及崩溃报告的平台。应用程序性能监控（APM）是其最近的项目。Raygun的DevOps工具帮助用户分析性能问题，并且定位到代码的某一行，某个function或者API调用。APM工具和Raygun的错误管理工作流可以协同工作。比如，它自动定位最高优先级的问题，并创建issue。

### 参考

* Raygun： https://raygun.com/
* 应用程序性能监控： https://raygun.com/platform/apm

## Nagios

最流行的免费并开源的DevOps监控工具。它可以监控基础架构从而帮助用户发现并解决问题。使用Nagios，用户可以记录事件，运行中断以及故障。用户还可以通过Nagios的图表和报告监控趋势。这样，可以预测运行中断和错误，并且发现安全攻击。因为其丰富的插件生态而脱颖而出。提供了四中开源监控解决方案：

* Nagios Core：一个命令行工具，提供了所有基本功能
* Nagios XI：提供了基于网页的GUI以及监控向导程序
* Nagios Log Server
* Nagios Fusion

## datadog

### 参考

* Nagios： https://www.nagios.org/
* 插件生态： https://exchange.nagios.org/
* 功能的比对： https://www.nagios.org/downloads/nagios-core/

## 工具

* [pyflame](https://github.com/uber/pyflame):非侵入式得对运行中的 python 进程做 snapshot, 输出成 svg
    - `pyflame -s 60 -r 0.01 ${pid} | flamegraph.pl > myprofile.svg`
