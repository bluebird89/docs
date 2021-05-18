# [sveltejs](https://github.com/sveltejs/svelte)

Cybernetically enhanced web apps <https://svelte.dev/>

* 编译期生成JavaScript，无运行时依赖
* 不担心框架抽象性能损耗
* 响应式

## 工程化

* rollup
* webpack

## 服务端 sapper

## [SvelteKit](https://kit.svelte.dev/)

*  引入了 snowpack 做构建，效率非常高，开发体验很好。
	*  不同于 webpack / parcel 这些 bundler，snowpack 不做任何打包，它仅仅在浏览器请求对应模块的时候进行相应的翻译（比如 svelte → js，typescript → js），所以任何修改，都是即时响应，开发效率很高

## 参考

*  [《Rethinking reactivity》](https://www.youtube.com/watch?v=AdNJ3fydeao) Rich Harris