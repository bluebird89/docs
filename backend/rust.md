# [rust](https://www.rust-lang.org)

Empowering everyone to build reliable and efficient software.

* 由 Mozilla 主导开发的通用、编译型编程语言。设计准则为“安全、并发、实用”，支持函数式、并发式、过程式以及面向对象的编程风格。帮助开发者创造高速与安全的应用，同时能享受到现代多核处理器的强大特性
* Rust 语言原本是 Mozilla 员工 Graydon Hoare 的私人项目，而 Mozilla 于 2009 年开始赞助这个项目，并且在 2010 年首次揭露了它的存在.全新的开源系统编程语言
* 易懂的语法避免了段错误 (segmentation faults) 并保证了线程安全
* 提供了零成本抽象，更多语义，内存安全保证，不会发生竞争的线程，基于特性 (trait) 的泛型，模式匹配，类型推导，高效的 C 绑定，和最小运行时大小
* 方向
  - 高性能 Web。Rust + WASM
  - 更高性能地跨平台应用。Rust + Electron + Node.js，结合 Neon Binding，可以编译为 Node.js 的模块，并在 Electron 应用中调用，开发跨平台桌面应用。
* 优点：
  - 优秀的 Macro 宏定义机制
  - 可 OO。基于 Traits 的简洁而强大的范型系统
  - 错误处理。基于 Option & Result 的空值和错误处理
  - 防 OOM。基于 Ownership、Borrowing、Lifetime 的内存管理机制
  - 新的范式（paramdigm）。子曾经曰过：如果一门编程语言没有带给你新的 paradigm，就不一定值得学，就好像学了 .net 再去学 java，或者学了 python 再学 ruby，从拓宽边界的角度，意义不大。
  - 可以编译成 webassembly —— 未来的也许会真正实现「一次编译到处运行」的可执行体：浏览器内，IoT 设备，各种服务器，手机等。
  - 接近于 C/C++ 性能，不输于 ruby / elixir 表现力的语言。
* 缺点
  - 处理更多的细节
  - 复杂的所有权机制:在没有垃圾回收机制的前提下保障内存安全。这是一个相当复杂的概念
* 原因
  - 未来几年的软件开发，protable binary（平台无关的受控可执行代码）会越来越重要，而 webassembly 似乎是目前唯一受到几大厂商全力支持的方向。
  - webassembly 的应用场景不仅仅是 web（比如大型游戏的 web 化），更是服务端虚拟化的一个新的，也许是更优的解决方案
  - 随着 5G 时代的到来，高带宽会带来网络边界的模糊：数据变得灵动起来，从而带动计算会时而发生在客户端，时而发生在服务端。当越来越多的计算可以直接发生在客户端时，一个平台无关的，安全的代码运行环境就变得至关重要，这也是 webassembly 的机会
  - webassebmly 目前支持最好的语言是什么？Rust

## 安装

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
brew install rustup

rustup update # 更新
rustup self uninstall

rustc --version

rustup doc # 本地阅读核心文档

rustc  main.rs
./main
```

## 配置

* `$HOME/.cargo/env` 或者 `export PATH="$HOME/.cargo/bin:$PATH"`
* 所有工具安装 ~/.cargo/bin 目录， 并且能够找到 Rust 工具链，包括 rustc、cargo 及 rustup

```sh
# $HOME/.cargo/config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'

[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"

[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"

[source.sjtu]
registry = "https://mirrors.sjtug.sjtu.edu.cn/git/crates.io-index"

[source.rustcc]
registry = "git://crates.rustcc.cn/crates.io-index"

[source.aliyun]
registry = "https://code.aliyun.com/rustcc/crates.io-index"
```

## Project Setup

```sh
cargo new hello_rust

cargo install wasm-pack          # Compile Rust to Wasm and generate JS interop code
cargo install cargo-make         # Task runner
cargo install simple-http-server # Simple server to serve assets
cargo new --lib rustmart && cd rustmart
```

## Dependency

* [cargo](https://github.com/rust-lang/cargo)Rust’s build system and package manager. <https://doc.rust-lang.org/cargo>

```sh
# Cargo.toml
cargo --verison
cargo new project
cargo build --realse
cargo run|check|update

rustup component add rls --toolchain stable-x86_64-apple-darwin
```

## Tooling Ecosystem

* Version Manager nvm rustup
* Package Manager npm Cargo
* Package Registry    npmjs.com   crates.io
* Package Manifest    package.json    Cargo.toml
* Dependency Lockfile package-lock.json   Cargo.lock
* Task Runner npm scripts, gulp etc   make, cargo-make
* Live Reload nodemon cargo-watch
* Linter  ESLint, TSLint, JSLint  Clippy
* Formatter   Prettier    rustfmt
* Dependency Vulnerability Checker    npm audit   cargo-audit

## Variables

* let immutable:You won’t be able to change the value after it’s assigned.
* want to make variable mutable, you need to explicitly mention it using the mut keyword `let mut a = 123;`
* const:think of Rust’s const as a “label” to a constant value. During compile time they get replaced by their actual values in all the places they are used. It’s usually used for constants like port numbers, timeout values, error codes etc
* Destructuring:extracting the inner fields of an array or struct into separate variables

## Data Types

* Numbers:for both integers (numbers without decimal point) and floats (numbers with decimal point).
* Booleans
* Strings
  - String:growable whereas &str is immutable and fixed size
  - &str
* Arrays
  - fixed size (simply referred to as “Array”)
  - can grow/shrink in size (called “Vectors”)
* Objects
  - Bag of data:

## function

* return
  - without an explicit return
  - returning implicitly, make sure to remove the semicolon from that line
* closure
* Iterators
  - & is the reference operator
  - the * is the dereference operator

## Pattern Matching

```sh
match VALUE {
  PATTERN1 => EXPRESSION1,
  PATTERN2 => EXPRESSION2,
  PATTERN3 => EXPRESSION3,
}
```

## 教程

* [rust-lang/book](https://github.com/rust-lang/book):The Rust Programming Language <https://doc.rust-lang.org/book/>
  - [trpl-zh-cn](https://github.com/KaiserY/trpl-zh-cn):Rust 程序设计语言（第二版） <https://kaisery.github.io/trpl-zh-cn/>
* [rustlings](https://github.com/rust-lang/rustlings/):crab Small exercises to get you used to reading and writing Rust code!
* [rust-by-example](https://github.com/rust-lang/rust-by-example):Learn Rust with examples (Live code editor included) <https://doc.rust-lang.org/stable/rust-by-example/>
  - [rust-by-example-cn](https://github.com/rust-lang-cn/rust-by-example-cn):Rust By Example 中文版
* [The Rust Reference](https://doc.rust-lang.org/reference/index.html)
* [The Rustonomicon](https://doc.rust-lang.org/nomicon/index.html):The Dark Arts of Unsafe Rust
* [tour_of_rust](https://github.com/richardanaya/tour_of_rust):A tour of rust's language features <https://tourofrust.com/>
* [Command line apps in Rust](https://rust-cli.github.io/book/index.html)

## 项目

* [bevy](https://github.com/bevyengine/bevy):A refreshingly simple data-driven game engine built in Rust <https://bevyengine.org/>

## 图书

* [Rust程序设计](https://kaisery.github.io/trpl-zh-cn/) [美]吉姆·布兰迪（Jim Blandy）[美]贾森·奥伦多夫（Jason Orendorff）李松峰 (译)

## 工具

* 包管理
  - [rustup](https://crates.io/):The Rust community’s crate registry `curl https://sh.rustup.rs -sSf | sh`
  - [rayon](https://github.com/rayon-rs/rayon):Rayon: A data parallelism library for Rust
  - [Docs.rs](https://docs.rs/)
* [cargo-watch](https://github.com/passcod/cargo-watch):Watches over your Cargo project's source <https://crates.io/crates/cargo-watch>
* 框架
  - [tokio](https://github.com/tokio-rs/tokio):A runtime for writing reliable, asynchronous, and slim applications with the Rust programming language. <https://tokio.rs>
  - [yew](https://github.com/yewstack/yew):Rust / Wasm framework for building client web apps <https://yew.rs/docs/>
  - [actix-web](https://github.com/actix/actix-web):Actix web is a small, pragmatic, and extremely fast rust web framework. <https://actix.rs>
  - [nickel.rs](https://github.com/nickel-org/nickel.rs):An expressjs inspired web framework for Rust <http://nickel-org.github.io/>
  - [nannou](https://github.com/nannou-org/nannou) A Creative Coding Framework for Rust.https://nannou.cc/
* [rustup.rs](https://github.com/rust-lang/rustup.rs):The Rust toolchain installer
* [wasm-pack](https://github.com/rustwasm/wasm-pack):📦✨ your favorite rust -> wasm workflow tool! <https://rustwasm.github.io/wasm-pack/>
* [clap](https://github.com/clap-rs/clap):A full featured, fast Command Line Argument Parser for Rust <https://clap.rs>
* [crossbeam](https://github.com/crossbeam-rs/crossbeam):Tools for concurrent programming in Rust
* 工具
  - Task Runner cargo-make
  - Live Reload  cargo-watch
  - Linter and Formatter cargo-husky
  - Vulnerability Checking  cargo-audit
  - [racer](https://github.com/racer-rust/racer):Rust Code Completion utility
  - [remacs](https://github.com/Wilfred/remacs):Rust heart Emacs
  - [cross](https://github.com/rust-embedded/cross):“Zero setup” cross compilation and “cross testing” of Rust crates
* search
  - [tantivy](https://github.com/tantivy-search/tantivy):Tantivy is a full-text search engine library inspired by Apache Lucene and written in Rust
  - [Toshi](https://github.com/toshi-search/Toshi):A full-text search engine in rust
* [pest](https://github.com/pest-parser/pest):The Elegant Parser <https://pest.rs>
* [hyper](https://github.com/hyperium/hyper):An HTTP library for Rust <https://hyper.rs/>
* MQ
  - [flume](https://github.com/zesterer/flume):A safe and fast multi-producer, single-consumer channel. <https://crates.io/crates/flume>
* GUI
  - [iced](https://github.com/hecrj/iced):A cross-platform GUI library for Rust, inspired by Elm
* IDE
  - Clion + Rust 插件

## 参考

* [文档](https://kaisery.gitbooks.io/rust-book-chinese/content/)
* [rust-gentle-intro](https://stevedonovan.github.io/rust-gentle-intro/)
* [patterns](https://github.com/rust-unofficial/patterns):A catalogue of Rust design patterns
* [awesome-rust](https://github.com/rust-unofficial/awesome-rust):A curated list of Rust code and resources.
* [rust-lang-nursery/futures-rs](https://github.com/rust-lang-nursery/futures-rs):Zero-cost asynchronous programming in Rust <http://rust-lang-nursery.github.io/futures-rs>
* [flosse/rust-web-framework-comparison](https://github.com/flosse/rust-web-framework-comparison):A comparison of some web frameworks and libs written in Rust
* [RUST语言的编程范式](https://coolshell.cn/articles/20845.html)
