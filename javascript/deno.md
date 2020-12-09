# [deno](https://github.com/ry/deno)

A secure TypeScript runtime on V8

```sh
curl -fsSL https://x.deno.js.cn/install.sh | sh

cargo install deno
```

* 内置了 V8 引擎，用来解释 JavaScript
* 内置了 tsc 引擎，解释 TypeScript
* 使用 Rust 语言开发，由于 Rust 原生支持 WebAssembly，所以也能直接运行 WebAssembly
* 异步操作不使用 libuv 这个库，而是使用 Rust 语言的 Tokio 库，来实现事件循环（event loop）

* 模块通过 URL 加载
  - import { bar } from "https://foo.com/bar.ts"（绝对 URL）
  - import { bar } from './foo/bar.ts'（相对 URL）

## 参考

* [deno_handbook](https://handbook.deno.js.cn/)
