# [flutter/flutter](https://github.com/flutter/flutter)

Flutter makes it easy and fast to build beautiful mobile apps. https://flutter.io

Flutter是一个移动应用程序的软件开发工具包（SDK），用一个代码库构建高性能、高保真的iOS和Android应用程序。目标是使开发人员能够为Android和iOS提供自然的高质量的应用，在滚动行为、排版、图标等方面实现零差异。

Flutter 是 Fuchsia 的开发框架，支持导出 Android iOS 和 Fuchsia 三个平台的安装包

* Flutter 自建了一个绘制引擎，底层是由 C++ 编写的引擎，负责渲染，文本处理，Dart VM 等；上层的 Dart Framework 直接调用引擎。避免了以往 JS 解决方案的 JS Bridge、线程跳跃等问题。
* 引擎基于 Skia 绘制，操作 OpenGL、GPU，不需要依赖原生的组件渲染框架。
* Dart 的引入，Dart 有 AOT 和 JIT 两种模式，线上使用时以 AOT 的方式编译成机器代码，保证了线上运行时的效率；而在开发期，Dart 代码以 JIT 的方式运行，支持代码的即时生效（HotReload)，提高开发效率。
* Flutter 的页面和布局是基于 Widget 树的方式，看似不习惯，但这种树状结构解析简单，布局、绘制都可以单次遍历完成计算，而原生布局往往要往复多次计算，“simple is fast”的设计效果。

## 安装

FLUTTER_STORAGE_BASE_URL: https://mirrors.sjtug.sjtu.edu.cn/
PUB_HOSTED_URL: https://dart-pub.mirrors.sjtug.sjtu.edu.cn/

```sh
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

export PUB_HOSTED_URL=https://pub.flutter-io.cn  # if you’re installing or using Flutter in China, it may be helpful to use a trustworthy local mirror site that hosts Flutter’s dependencies. 
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

flutter doctor  # 安装相关依赖，可重复执行

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
```

> Development cannot be enabled while your device is locked

设置->通用->还原->还原位置与隐私

> Unable to mount developer disk image, (Error Domain=com.apple.dtdevicekit Code=-402653034 "The user has not yet responded to the pairing request." UserInfo={NSLocalizedDescription=The user has not yet responded to the pairing request

> Failed to create provisioning profile. The app ID "com.example.helloWorld" cannot be registered to your development team. Change your bundle identifier to a unique string to try again

## 项目

* [yubo725/flutter-osc](https://github.com/yubo725/flutter-osc):基于Google Flutter的开源中国客户端，支持Android和iOS。
* [pszklarska/FlutterShoppingCart](https://github.com/pszklarska/FlutterShoppingCart):Flutter example of shopping app using Redux architecture https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65

## 工具

* vscode 插件
* [google/flutter-desktop-embedding](https://github.com/google/flutter-desktop-embedding):Desktop implementations of the Flutter embedding API

## 参考

* [Solido/awesome-flutter](https://github.com/Solido/awesome-flutters):A curated list of awesome Flutter components, frameworks, libraries, and softwares
* [flutter_gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
* [文档](https://flutter-io.cn/)
* [官网](https://flutter.io/)
* [AweiLoveAndroid/Flutter-learning](https://github.com/AweiLoveAndroid/Flutter-learning)::octocat:🔥 👍 🌟 ⭐️ ⭐️⭐️ Flutter从配置安装到填坑指南详解，Flutter相关Demo解读，项目实例，Dart语法详解
