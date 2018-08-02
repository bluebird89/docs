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
