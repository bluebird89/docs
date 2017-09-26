# Electron

用 web 技术构建跨平台的桌面应用。它有如下特性：

- 自动更新
- 崩溃报告
- Windows 安装
- 调试和分析
- 原生菜单和通知

Electron 的架构包括 Node.js runtime 和嵌套的微型 Chromium 浏览器。Electron 应用在多个进程中运行：主进程运行的是应用的 package.json 声明的 main 脚本。为了显示一个用户界面，该脚本可以打开 窗口。这些脚本的每一个都运行在独立的进程中（一个所谓的渲染进程），就像 web 浏览器的 tab 标签。
