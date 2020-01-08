# [rust-lang/rust]

Empowering everyone to build reliable and efficient software. https://www.rust-lang.org

## 安装

```sh
curl https://sh.rustup.rs -sSf | sh

brew install rustup
rustup update # 更新
rustup self uninstall

rustc --version
```

## 配置

* `$HOME/.cargo/env` 或者 `export PATH="$HOME/.cargo/bin:$PATH"`
* 所有工具都安装到 ~/.cargo/bin 目录， 并且您能够在这里找到 Rust 工具链，包括 rustc、cargo 及 rustup。

```sh
# $HOME/.cargo/config
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'ustc'
[source.ustc]
registry = "git://mirrors.ustc.edu.cn/crates.io-index"

[source.crates-io]
replace-with = "rustcc"

[source.rustcc]
registry = "https://code.aliyun.com/rustcc/crates.io-index"
```

## Cargo

Rust’s build system and package manager.

```sh
cargo --verison
cargo new project
cargo build --realse
cargo run|check|update

rustup component add rls --toolchain stable-x86_64-apple-darwin
```

## 工具

* 包资源
    - [rayon-rs/rayon](https://github.com/rayon-rs/rayon):Rayon: A data parallelism library for Rust
* 框架
    - [tokio-rs/tokio](https://github.com/tokio-rs/tokio):A runtime for writing reliable, asynchronous, and slim applications with the Rust programming language. https://tokio.rs
    - [yewstack/yew](https://github.com/yewstack/yew):Rust / Wasm framework for building client web apps https://yew.rs/docs/
    - [actix/actix-web](https://github.com/actix/actix-web):Actix web is a small, pragmatic, and extremely fast rust web framework. https://actix.rs
* [rustwasm/wasm-pack](https://github.com/rustwasm/wasm-pack):📦✨ your favorite rust -> wasm workflow tool! https://rustwasm.github.io/wasm-pack/
* [clap-rs/clap](https://github.com/clap-rs/clap):A full featured, fast Command Line Argument Parser for Rust https://clap.rs
* [nickel-org/nickel.rs](https://github.com/nickel-org/nickel.rs):An expressjs inspired web framework for Rust http://nickel-org.github.io/
* [racer-rust/racer](https://github.com/racer-rust/racer):Rust Code Completion utility
* [crossbeam-rs/crossbeam](https://github.com/crossbeam-rs/crossbeam):Tools for concurrent programming in Rust
* [rust-lang/rustup.rs](https://github.com/rust-lang/rustup.rs):The Rust toolchain installer
* search
    - [tantivy-search/tantivy](https://github.com/tantivy-search/tantivy):Tantivy is a full-text search engine library inspired by Apache Lucene and written in Rust
    - [toshi-search/Toshi](https://github.com/toshi-search/Toshi):A full-text search engine in rust
* [rust-lang-nursery/futures-rs](https://github.com/rust-lang-nursery/futures-rs):Zero-cost asynchronous programming in Rust http://rust-lang-nursery.github.io/futures-rs
* [flosse/rust-web-framework-comparison](https://github.com/flosse/rust-web-framework-comparison):A comparison of some web frameworks and libs written in Rust
* [pest-parser/pest](https://github.com/pest-parser/pest):The Elegant Parser https://pest.rs
* [Wilfred/remacs](https://github.com/Wilfred/remacs):Rust heart Emacs

## 参考

* [文档](https://kaisery.gitbooks.io/rust-book-chinese/content/)
* [rust-lang/book](https://github.com/rust-lang/book):The Rust Programming Language https://doc.rust-lang.org/book/
* [The Rust Programming Language](https://doc.rust-lang.org/book/second-edition/index.html)
* [rust-gentle-intro](https://stevedonovan.github.io/rust-gentle-intro/)
* [KaiserY/trpl-zh-cn](https://github.com/KaiserY/trpl-zh-cn):Rust 程序设计语言（第二版） https://kaisery.github.io/trpl-zh-cn/
* [rust-unofficial/patterns](https://github.com/rust-unofficial/patterns):A catalogue of Rust design patterns
* [rust-unofficial/awesome-rust](https://github.com/rust-unofficial/awesome-rust):A curated list of Rust code and resources.
