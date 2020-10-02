# [flutter/flutter](https://github.com/flutter/flutter)

Flutter makes it easy and fast to build beautiful mobile apps. https://flutter.dev https://flutter.cn

* 一个移动应用程序的软件开发工具包（SDK），用一个代码库构建高性能、高保真的iOS和Android应用程序。目标是使开发人员能够为Android和iOS提供自然的高质量的应用，在滚动行为、排版、图标等方面实现零差异。Flutter 是 Fuchsia 的开发框架，支持导出 Android iOS 和 Fuchsia 三个平台的安装包
* 自建了一个绘制引擎，底层是由 C++ 编写的引擎，负责渲染，文本处理，Dart VM 等；上层的 Dart Framework 直接调用引擎。避免了以往 JS 解决方案的 JS Bridge、线程跳跃等问题。
* 引擎基于 Skia 绘制，操作 OpenGL、GPU，不需要依赖原生的组件渲染框架。
* Dart 的引入，Dart 有 AOT 和 JIT 两种模式，线上使用时以 AOT 的方式编译成机器代码，保证了线上运行时的效率；而在开发期，Dart 代码以 JIT 的方式运行，支持代码的即时生效（HotReload)，提高开发效率。
* Flutter 的页面和布局是基于 Widget 树的方式，看似不习惯，但这种树状结构解析简单，布局、绘制都可以单次遍历完成计算，而原生布局往往要往复多次计算，“simple is fast”的设计效果。

## 安装

```sh
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

export PUB_HOSTED_URL=https://pub.flutter-io.cn  # if you’re installing or using Flutter in China, it may be helpful to use a trustworthy local mirror site that hosts Flutter’s dependencies. https://dart-pub.mirrors.sjtug.sjtu.edu.cn/
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn # https://mirrors.sjtug.sjtu.edu.cn/

flutter precache
flutter doctor  # 安装相关依赖，可重复执行

# ios
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
# 运行模拟器
open -a Simulator

flutter create myapp
cd myapp
flutter run
open ios/Runner.xcworkspace

sudo xcodebuild -license

flutter upgrade

flutter doctor --android-licenses
```

## 问题

```
[!] Android toolchain - develop for Android devices (Android SDK 27.0.3)
    ✗ Android license status unknown.
[!] iOS toolchain - develop for iOS devices (Xcode 9.3)
    ✗ Xcode requires additional components to be installed in order to run.
      Launch Xcode and install additional required components when prompted.
    ✗ libimobiledevice and ideviceinstaller are not installed. To install, run:
        brew install --HEAD libimobiledevice
        brew install ideviceinstaller
    ✗ ios-deploy not installed. To install:
        brew install ios-deploy
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS platform side's plugin code that responds to your plugin usage on the Dart side.
        Without resolving iOS dependencies with CocoaPods, plugins will not work on iOS.
        For more info, see https://flutter.io/platform-plugins
      To install:
        brew install cocoapods
        pod setup

flutter doctor --android-licenses

brew install --HEAD libimobiledevice
brew install ideviceinstaller
brew install ios-deploy
brew install cocoapods
pod setup

> Development cannot be enabled while your device is locked

设置->通用->还原->还原位置与隐私

> Unable to mount developer disk image, (Error Domain=com.apple.dtdevicekit Code=-402653034 "The user has not yet responded to the pairing request." UserInfo={NSLocalizedDescription=The user has not yet responded to the pairing request

> Failed to create provisioning profile. The app ID "com.example.helloWorld" cannot be registered to your development team. Change your bundle identifier to a unique string to try again
```

## 教程

* [FilledStacks / flutter-tutorials](https://github.com/FilledStacks/flutter-tutorials):The repo contains the source code for all the tutorials on the FilledStacks Youtube channel.

## 项目

* [yubo725/flutter-osc](https://github.com/yubo725/flutter-osc):基于Google Flutter的开源中国客户端，支持Android和iOS。
* [pszklarska/FlutterShoppingCart](https://github.com/pszklarska/FlutterShoppingCart):Flutter example of shopping app using Redux architecture https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65
* [2d-inc/HistoryOfEverything](https://github.com/2d-inc/HistoryOfEverything):Flutter Launch Timeline Demo
* [Mayandev/morec](https://github.com/Mayandev/morec):💥非常精美的 Flutter 版电影客户端，利用豆瓣现有的 Api，打造了一个完整的电影展示 App(部分 UI 仿豆瓣电影🎥)。 A beautiful movie application build by flutter.
* [alibaba/flutter-go](https://github.com/alibaba/flutter-go):flutter 开发者帮助 APP，包含 flutter 常用 140+ 组件的demo 演示与中文文档
* [OpenFlutter/Flutter-Notebook](https://github.com/OpenFlutter/Flutter-Notebook):日更的FlutterDemo合集
* [CarGuo/gsy_github_app_flutter](https://github.com/CarGuo/gsy_github_app_flutter):超完整的Flutter项目，功能丰富，适合学习和日常使用。

## 工具

* [google/flutter-desktop-embedding](https://github.com/google/flutter-desktop-embedding):Desktop implementations of the Flutter embedding API
* [Drakirus/go-flutter-desktop-embedder](https://github.com/Drakirus/go-flutter-desktop-embedder):A Go (golang) Custom Flutter Engine Embedder for desktop
* [fish-redux](https://github.com/alibaba/fish-redux):Fish Redux 是一个基于 Redux 数据管理的组装式 flutter 应用框架，特别适用于构建中大型的复杂应用，它最显著的特征是函数式的编程模型、可预测的状态管理、可插拔的组件体系、最佳的性能表现
* UI
    - [mitesh77/Best-Flutter-UI-Templates](https://github.com/mitesh77/Best-Flutter-UI-Templates):completely free for everyone. Its build-in Flutter Dart.
    - [mitesh77 / Best-Flutter-UI-Templates](https://github.com/mitesh77/Best-Flutter-UI-Templates):completely free for everyone. Its build-in Flutter Dart.
* [cloudwebrtc / flutter-webrtc](https://github.com/cloudwebrtc/flutter-webrtc):WebRTC plugin for Flutter Mobile/Desktop/Web
* [ zino-app / graphql-flutter ](https://github.com/zino-app/graphql-flutter):A GraphQL client for Flutter, bringing all the features from a modern GraphQL client to one easy to use package.

## 参考

* [](https://flutter.dev/docs/cookbook)
* [](https://flutter.dev/docs/get-started/codelab)
* [Solido/awesome-flutter](https://github.com/Solido/awesome-flutters):A curated list of awesome Flutter components, frameworks, libraries, and softwares
* [flutter_gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
* [AweiLoveAndroid/Flutter-learning](https://github.com/AweiLoveAndroid/Flutter-learning)::octocat:🔥 👍 🌟 ⭐️ ⭐️⭐️ Flutter从配置安装到填坑指南详解，Flutter相关Demo解读，项目实例，Dart语法详解
* [alibaba/flutter-common-widgets-app](https://github.com/alibaba/flutter-common-widgets-app):flutter 菜鸟 APP，包含常用 flutter 组件的中文文档与 demo 演示
* [alibaba/flutter-go](https://github.com/alibaba/flutter-go):flutter 开发者帮助 APP，包含 flutter 常用 130+ 组件的中文文档与 demo 演示
