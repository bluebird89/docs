# Cloud Native

Matt Stine提出的一个概念，它是一个思想的集合，包括DevOps、持续交付（Continuous Delivery）、微服务（MicroServices）、敏捷基础设施（Agile Infrastructure）、康威定律（Conways Law）等，以及根据商业能力对公司进行重组。

* 威定律：业务云化推行，从某种意义上讲也是一种变革.组织决定系统架构！一个云系统最终长成什么样子，则完全是企业的组织结构决定的，是组织内部、组织之间的沟通结构。
* 英文Development和Operations的组合）是一组过程、方法与系统的统称，用 于促进开发（应用程序/软件工程）、运维和质量保障（QA）部门之间的沟通、协作与整合。它的出现是由于软件行业日益清晰地认识到：为了按时交付软件产品 和服务，开发和运维必须紧密合作。
* 持续交付（Continuous Delivery）：是一系列的开发实践方法，用来确保让代码能够快 速、安全的部署到产品环境中，它通过将每一次改动都提交到一个模拟产品环境中，使用严格的自动化测试，确保业务应用和服务能符合预期。因为使用完全的自动 化过程来把每个变更自动的提交到测试环境中，所以当业务开发完成时，你有信心只需要按一次按钮就能将应用安全的部署到产品环境中。持续交付可以采 用：CI（持续集成）、代码检查、UT（单元测试），持续部署等方式，打通开发、测试、生产的各个环节，持续的增量的交付产品。
*  敏捷基础设施（Agile Infrastructure）：提供弹性、按需的计算、存储、网络资源能力。可以通过Openstack、KVM、Ceph、OVS等技术手段实现。
* Container
* Orchestration
* Microservices

## 推行

* 组织变革：根据康威定律，如果要达到比较理想的云化效果，必须进行组织变革。一个合理的组织架构，将会极大提高云化的推行。相信很多公司，在决定搞云计算后，都大大小小进行了部门合并和组织结构调整。这块水比较深，相信很多人有变革的切肤之痛。
* 推行DevOps文化：在公司层面推行DevOps文化，倡导开放、合作的组织文化，打破“部门墙”。
* 推行持续交付：联合开发、质量、运维各个环节，打通代码提交、代码检查、UT、开发环境部署、staging环境部署、线上环境部署等流水线。
* 建设敏捷基础设施：这部分是整个Cloud Native的根基。这部分可以采纳的技术非常多，开源的、商用的都比较多。
* 采用微服务架构：微服务架构是Cloud Native的一个核心要素。微服务包含几方面的内容：
    - 有支撑微服务的平台。
    - 有符合微服务平台规范的APP。
    - 如何引入微服务。
    - 微服务核心技术点。

## 工具

* [Netflix/SimianArmy](https://github.com/Netflix/SimianArmy):Tools for keeping your cloud operating in top form. Chaos Monkey is a resiliency tool that helps applications tolerate random instance failures.

## Networks

* [Project Calico](https://www.projectcalico.org/):Secure networking for the cloud native era

## 路由

* [containous/traefik](https://github.com/containous/traefik):The Cloud Native Edge Router https://traefik.io

## 注册

* [goharbor/harbor](https://github.com/goharbor/harbor):An open source trusted cloud native registry project that stores, signs, and scans content. https://goharbor.io/

## Trace

* [jaegertracing/jaeger](https://github.com/jaegertracing/jaeger):CNCF Jaeger, a Distributed Tracing System https://jaegertracing.io/

## Monitor

* [netdata/netdata](https://github.com/netdata/netdata):Real-time performance monitoring, done right! https://my-netdata.io/

## 参考

* [Cloud Native Computing foundation](https://www.cncf.io/):Sustaining and Integrating Open Source Technologies
* [cncf/landscape](https://github.com/cncf/landscape):Static Cloud Native Landscapes and Interactive Landscape that filters and sorts hundreds of cloud native projects and products, and shows details including GitHub stars, funding or market cap, first and last commits, contributor counts, headquarters location, and recent tweets. https://l.cncf.io
