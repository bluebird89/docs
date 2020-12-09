# 自动化

工作流程的自动化以及对其的不断优化

* TTT (Time to commiT)：一个 feature 从 commit 开始到结束要花多长时间？
* TTDP (Time to DePendency)：一个 feature 从 dependency resolve 开始到结束要花多长时间？
* TTC (Time to Compile)：一个 feature 从 compile 开始到结束要花多长时间？
* TTCI (time to CI)：一个 feature 从 CI 开始到结束要花多长时间？
* TTPR (Time to PR)：一个 feature 从 commit 到创建出 PR 要花多长时间？
* TTR (Time to Release)：一个 feature 从 review 结束到 release 出来要花多长时间？
* TTD (Time to Deploy)：一个 feature 从开始 deploy 到结束要花多长时间？

## 实现

* commit hook：pre-commit-hook
* 代码自动化其实是一个桥接（bridging）的过程。我们不直接写最终形态的代码 Bob，而是写一个更为抽象（更加描述性）的代码 Alice，然后用一个 parser 将 Alice 转化为 Bob。ansible 其实就是一个很好的例子
* template repo 对拥有复杂项目结构的 framework 非常有用。如果把 framework 看成产品，工程师看成用户，那么 template repo 就是产品的 onboarding 功能。
* utility belt 是另外一种自动化方向，它把你的各种随机写就的 function，随机扔在某个 utils / helpers 目录里的 function，甚至顺手写在当前文件里的某个功能性的 private function，抽取出来，组织在一起 —— 它们可以被单独测试，单独 release，可以被更深刻地设计，可以在需要的时候做更合适的抽象。

## 统一工作接口

* make init：项目初始化 —— 安装 submodule，项目依赖的软件，设置 env（比如 python 建立 virtualenv）等等。
* make dep：安装 dependency，如果是 nodejs 项目，就是 npm install，elixir 是 mix deps.get，python 麻烦一些，是先 workon 到项目对应的 virtualenv，再 pip install。
* make build：对代码 compile，nodejs 是 webpack，elixir 是 mix compile 等。
* make run：在本地运行。
* make test：对代码做 unit testing。
* make build-release：将代码在不同环境下的编译结果打包成一个 tarball（方便上传到 github release）。
* make travis：给 travis 做 build 用的。
* make deploy：给 travis deploy release 用的。
* make create-pr：自动 bump version，生成 change log，并创建 github PR

优化自己的TTP时间：当一个组织里的工程师有就手 deploy 的能力时，整个世界会大大不同。工程师们会自然而然把 feature 切碎，一点点迭代，一点点发布。这很符合人性 —— 越小的发布可控性越强，出问题的几率越小，万一出问题，跟踪定位也更容易，回退更简单。

## 自动化测试

* automated tests 而不是automated test，一个产品只有一种，或者某一层级上的自动化测试是无法达到整体质量评估的，持续测试需要不同类型的自动化测试在交付的不同阶段为产品的不同层级提供反馈。
* delivery pipeline，immediate feedback，自动化测试一定是和交付流水线交合集成的，至少是同频运行的，不是孤立的，只有这样才能就团队每一次的新变更对产品质量的影响做出快速而及时的反馈。
* business risks，持续测试广义上来说包含交付中的所有质量反馈行为，既要测试左移，质量内建，也要测试右移，实现产品质量主动监控，不然无法识别业务风险。

* 测试工具的选择需要考虑项目的技术栈，也需要考虑QA自身的技术能力
* 合适的时候做自动化
  - 在MVP1(Minimum Viable Product)，特别是POC（Proof Of Concept)阶段的产品建议不要急于做自动化，项目的初期更别尝试做UI层面的自动化。当然对工具的spike是可以的，把框架搭建好，等待特性稳定了，就可以直接加测试用例了
  - 一定是要考虑项目是否存在客观的现实需求，在动手实施具体的自动化测试之前，一定要对自动化测试的投入产出比做一次客观理性地评估
* 自动化测试和产品代码一样重要，需要全员负责。
  - 为每套自动化测试编写清晰的README, 保证团队里除你以外其他的小伙伴，也都清楚明白如何运行自动化测试。
  - 除了实用的README引导团队如何运行测试，可视化良好的测试报告也非常必要。
  - 让UI测试更稳定，请求开发把页面的关键组件元素加上ID 属性，用唯一的ID去定位元素就稳定多了。
  - 建议每个Dev提交代码前，在本地自行运行测试脚本，保证自动化测试的及时性和正确性，并对新变更提供及时的质量反馈。
  - 项目上用的是Jenkins自带的 Build Monitor View。将对项目pipeline的监控投影到电视上，并配置相应的提示音，能非常及时地让团队知道最新的构建，部署，测试状态
* 具备Devops相关的技术
  - 测试工具相关
    + 在容器里安装puppeteer之前，需要手动下载Chromium包以及相关的依赖。
    + 在docker里面启动puppeteer，要么配置一个puppeteer的user，要么选择去掉默认的沙盒环境。
    + 当时还遇到因为docker默认的64MB内存空间不够，Chrome渲染页面崩溃
  - 测试报告可视化相关
    + CodeceptJS就提供多种不同形态的运行，并且可以运用Mocha生成各种类型的测试报告
    + Jenkins有非常丰富的插件库，在选择测试工具的时候可以把是否有Jenkins报告可视化支持考虑进去.对Jenkins和测试工具都相当熟悉，还需要知道如何通过将某一测试工具生成的某种格式的测试报告集成在Jenkins上以方便一键获取测试报告。像cucumber的测试报告插件
  - Pipeline as Code, 想要集成测试到流水线，不可避免是需要一些DevOps相关知识的
    + 如何通过Jenkinsfile 并行运行各种测试，也许是通过Jenkinsfile传递测试相关参数以为云上运行测试所用，还也许你需要在Jenkinsfile里添加调试信息用以线上调试
    + 如何在一个slave 上优雅地管理运行测试的容器，不出现容器占用，slave内存不足，测试失败之后报告不可得等等问题
