# [electron](https://github.com/electron/electron)

Build cross-platform desktop apps with JavaScript, HTML, and CSS <https://electronjs.org>

* 自动更新
* 崩溃报告
* Windows 安装
* 调试和分析
* 原生菜单和通知

## 架构

* Node.js runtime、V8和嵌套的微型 Chromium 浏览器
* 在多个进程中运行：主进程运行的是应用的 package.json 声明的 main 脚本。为了显示一个用户界面，该脚本可以打开 窗口
* 这些脚本的每一个都运行在独立的进程中（一个所谓的渲染进程），就像 web 浏览器的 tab 标签

## 教程

* [electron/electron-quick-start](https://github.com/electron/electron-quick-start):Clone to try a simple Electron app <https://electron.atom.io/docs/tutoria>…
* [electron/electron-api-docs](https://github.com/electron/electron-api-docs):Electron's API documentation in a structured JSON format
* [electron/electron-api-demos](https://github.com/electron/electron-api-demos):Explore the Electron APIs <http://electronjs.org/#get-started>

## 工具

* 框架
  - [mherrmann/fbs](https://github.com/mherrmann/fbs):Electron alternative based on Python and Qt <https://build-system.fman.io>
* [chentsulin/electron-react-boilerplate](https://github.com/chentsulin/electron-react-boilerplate):Live editing development on desktop app
* [electron/devtron](https://github.com/electron/devtron):An Electron DevTools Extension <http://electron.atom.io/devtron>
* [fraserxu/electron-pdf](https://github.com/fraserxu/electron-pdf)：A command line tool to generate PDF from URL, HTML or Markdown files.
* [connors/photon](https://github.com/connors/photon):The fastest way to build beautiful Electron apps using simple HTML and CSS <http://photonkit.com>
* [electron/fiddle](https://github.com/electron/fiddle):🚀 The easiest way to get started with Electron
* [maxogden/menubar](https://github.com/maxogden/menubar):➖ high level way to create menubar desktop applications with electron
* [zeit/hazel](https://github.com/zeit/hazel):Lightweight update server for Electron apps
* [electron-userland/electron-packager](https://github.com/electron-userland/electron-packager):Customize and package your Electron app with OS-specific bundles (.app, .exe, etc.) via JS or CLI <http://npm.im/electron-packager>
* [electron/spectron](https://github.com/electron/spectron):🔎 Test Electron apps using ChromeDriver <http://electronjs.org/spectron>
* [electron-userland/electron-forge](https://github.com/electron-userland/electron-forge):A complete tool for creating, publishing, and installing modern Electron applications <https://electronforge.io>

## 参考

* [awesome-electron](https://github.com/sindresorhus/awesome-electron):Useful resources for creating apps with Electron
