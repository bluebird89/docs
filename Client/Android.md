# Android

## 安装

```sh
JAVA -version # JDK
brew cask install android-studio # IDE
# SDK
/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home # project Defaults Project Structure JDK location

Setting->Android SDK # android studio 安装android sdk

# 配置环境变量
export ANDROID_HOME=/Users/henry/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/platforms
export PATH=${PATH}:$ANDROID_HOME/platform-tools
export PATH=${PATH}:$ANDROID_HOME/tools
```

## ADB

adb的全称为Android Debug Bridge，就是调试桥的作用。借助这个工具，我们可以管理设备或手机模拟器的状态 ，还可以进行以下的操作：

* 快速更新设备或手机模拟器中的代码，如应用或Android系统升级；
* 在设备上运行Shell命令；
* 管理设备或手机模拟器上的预定端口；
* 在设备或手机模拟器上复制或粘贴文件。

采用监听Socket TCP 5554端口的方式让IDE和Qemu通信，默认情况下ADB会daemon相关的网络端口，所以当我们运行Eclipse时ADB进程就会自动运行，在Eclipse中通过DDMS来调试Android程序；

## 课程

* [kesenhoo/android-training-course-in-chinese](https://github.com/kesenhoo/android-training-course-in-chinese)

## 扩展

- [Tencent/tinker](https://github.com/Tencent/tinker)a hot-fix solution library for Android, it supports dex, library and resources update without reinstall apk.
- [airbnb/epoxy](https://github.com/airbnb/epoxy):Epoxy is an Android library for building complex screens in a RecyclerView https://goo.gl/eIK82p
- [bumptech/glide](https://github.com/bumptech/glide):An image loading and caching library for Android focused on smooth scrolling http://bumptech.github.io/glide/
- [square/okhttp](https://github.com/square/okhttp):An HTTP+HTTP/2 client for Android and Java applications. http://square.github.io/okhttp/
- [Android Studio](http://www.android-studio.org/)

## 测试

* [square/retrofit](https://github.com/square/retrofit):Type-safe HTTP client for Android and Java by Square, Inc. http://square.github.io/retrofit/
* [JakeWharton/butterknife](https://github.com/JakeWharton/butterknife):Bind Android views and callbacks to fields and methods. http://jakewharton.github.io/butterkn…
