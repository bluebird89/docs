# Flutter

> 安装

```sh
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

flutter doctor  # 安装相关依赖，可重复执行
```

> 问题

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

> 参考

* [Solido/awesome-flutter](https://github.com/Solido/awesome-flutters):A curated list of awesome Flutter components, frameworks, libraries, and softwares
* [flutter/flutter](https://github.com/flutter/flutter):Flutter makes it easy and fast to build beautiful mobile apps. https://flutter.io
