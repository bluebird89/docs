# [rust-lang/rust]

Empowering everyone to build reliable and efficient software. https://www.rust-lang.org

## 安装

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
brew install rustup

rustup update # 更新
rustup self uninstall

rustc --version

rustup doc # 本地阅读核心文档
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

## 教程

* [rust-lang/book](https://github.com/rust-lang/book):The Rust Programming Language https://doc.rust-lang.org/book/
	- [KaiserY/trpl-zh-cn](https://github.com/KaiserY/trpl-zh-cn):Rust 程序设计语言（第二版） https://kaisery.github.io/trpl-zh-cn/
* [ rust-lang / rustlings ](https://github.com/rust-lang/rustlings/):crab Small exercises to get you used to reading and writing Rust code!
* [rust-lang / rust-by-example](https://github.com/rust-lang/rust-by-example):Learn Rust with examples (Live code editor included) https://doc.rust-lang.org/stable/rust-by-example/
	- [rust-lang-cn / rust-by-example-cn ](https://github.com/rust-lang-cn/rust-by-example-cn):Rust By Example 中文版
* [The Rust Reference](https://doc.rust-lang.org/reference/index.html)
* [The Rustonomicon](https://doc.rust-lang.org/nomicon/index.html):The Dark Arts of Unsafe Rust

## 工具

* 包管理
    - [](https://crates.io/):The Rust community’s crate registry `curl https://sh.rustup.rs -sSf | sh`
    - [rayon-rs/rayon](https://github.com/rayon-rs/rayon):Rayon: A data parallelism library for Rust
    - [Docs.rs](https://docs.rs/)
* 框架
    - [tokio-rs/tokio](https://github.com/tokio-rs/tokio):A runtime for writing reliable, asynchronous, and slim applications with the Rust programming language. https://tokio.rs
    - [yewstack/yew](https://github.com/yewstack/yew):Rust / Wasm framework for building client web apps https://yew.rs/docs/
    - [actix/actix-web](https://github.com/actix/actix-web):Actix web is a small, pragmatic, and extremely fast rust web framework. https://actix.rs
    - [nickel-org/nickel.rs](https://github.com/nickel-org/nickel.rs):An expressjs inspired web framework for Rust http://nickel-org.github.io/
* [rust-lang/rustup.rs](https://github.com/rust-lang/rustup.rs):The Rust toolchain installer
* [rustwasm/wasm-pack](https://github.com/rustwasm/wasm-pack):📦✨ your favorite rust -> wasm workflow tool! https://rustwasm.github.io/wasm-pack/
* [clap-rs/clap](https://github.com/clap-rs/clap):A full featured, fast Command Line Argument Parser for Rust https://clap.rs
* [crossbeam-rs/crossbeam](https://github.com/crossbeam-rs/crossbeam):Tools for concurrent programming in Rust
* 工具
	- [racer-rust/racer](https://github.com/racer-rust/racer):Rust Code Completion utility
	- [Wilfred/remacs](https://github.com/Wilfred/remacs):Rust heart Emacs
	- [ rust-embedded / cross ](https://github.com/rust-embedded/cross):“Zero setup” cross compilation and “cross testing” of Rust crates
* search
    - [tantivy-search/tantivy](https://github.com/tantivy-search/tantivy):Tantivy is a full-text search engine library inspired by Apache Lucene and written in Rust
    - [toshi-search/Toshi](https://github.com/toshi-search/Toshi):A full-text search engine in rust
* [pest-parser/pest](https://github.com/pest-parser/pest):The Elegant Parser https://pest.rs

* MQ
	- [zesterer / flume](https://github.com/zesterer/flume):A safe and fast multi-producer, single-consumer channel. https://crates.io/crates/flume
* GUI
    - [hecrj / iced](https://github.com/hecrj/iced):A cross-platform GUI library for Rust, inspired by Elm

## 参考

* [文档](https://kaisery.gitbooks.io/rust-book-chinese/content/)
* [rust-gentle-intro](https://stevedonovan.github.io/rust-gentle-intro/)
* [rust-unofficial/patterns](https://github.com/rust-unofficial/patterns):A catalogue of Rust design patterns
* [rust-unofficial/awesome-rust](https://github.com/rust-unofficial/awesome-rust):A curated list of Rust code and resources.
* [rust-lang-nursery/futures-rs](https://github.com/rust-lang-nursery/futures-rs):Zero-cost asynchronous programming in Rust http://rust-lang-nursery.github.io/futures-rs
* [flosse/rust-web-framework-comparison](https://github.com/flosse/rust-web-framework-comparison):A comparison of some web frameworks and libs written in Rust
