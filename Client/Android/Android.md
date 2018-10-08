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

## 刷系统

* ADB工具
    - 添加环境变量：D:\adb\
    - adb
* 刷机包
* 手机连接，重启同时按下电源键和音量下键重启，进入bootloader模式

```sh
fastboot devices  # 连接设备
fastboot oem unlock # 解锁
cd 刷机包解压文件夹

# 先root：OTA可能会失效
fastboot flash bootloader bootloader文件名 .img
fastboot flash radio radio文件名.img
fastboot reboot

fastboot flash recovery recovery.img # fastboot flash recovery recovery.img  可以刷TWRP
# 利用TWRP Recovery找到刚才放进设备储存的Super Su zip包刷入
fastboot flash boot boot.img
fastboot flash system system.img

fastboot flash cache cache.img
fastboot flash userdata userdata.img

fastboot reboot

fastboot erase bootfastboot erase cache
fastboot erase recovery
fastboot erase system
fastboot erase userdata
fastboot flash bootloader bootloader-mako-makoz10o.img（需要根据您自己情况换img名）
fastboot reboot-bootloaderfastboot -w update image-occam-jdq39.zip（需要根据您自己情况换.zip名）
```

## 调试

* Android 手机 设置 > 开发者选项 > USB调试。设置里面勾选 开发者选项
* 数据线连接你的电脑和 Android 手机，安装Chrome
* 电脑Chrome->more tools->remote devices
* 选取设备->网页列表->inspect

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
* [robolectric/robolectric](https://github.com/robolectric/robolectric):Android Unit Testing Framework http://robolectric.org

## 工具

* [iBotPeaches/Apktool](https://github.com/iBotPeaches/Apktool):A tool for reverse engineering Android apk files https://ibotpeaches.github.io/Apktool
* [tbruyelle/RxPermissions](https://github.com/tbruyelle/RxPermissions):Android runtime permissions powered by RxJava2
* [mzlogin/awesome-adb](https://github.com/mzlogin/awesome-adb):🍭 ADB Usage Complete / ADB 用法大全 https://mazhuang.org/awesome-adb/
* [bingoogolapple/BGAQRCode-Android](https://github.com/bingoogolapple/BGAQRCode-Android):QRCode 扫描二维码、扫描条形码、相册获取图片后识别、生成带 Logo 二维码、支持微博微信 QQ 二维码扫描样式
* [scottyab/secure-preferences](https://github.com/scottyab/secure-preferences):Android Shared preference wrapper than encrypts the values of Shared Preferences. It's not bullet proof security but rather a quick win for incrementally making your android app more secure.
* [hyb1996/Auto.js](https://github.com/hyb1996/Auto.js):A UiAutomator on android, does not need root access

## 模拟

* [asLody/VirtualApp](https://github.com/asLody/VirtualApp):Virtual Engine for Android(Support 9.0 in business version)
* [android-hacker/VirtualXposed](https://github.com/android-hacker/VirtualXposed):A simple app to use Xposed without root, unlock the bootloader or modify system image, etc. https://vxp.app
* [rovo89/Xposed](https://github.com/rovo89/Xposed):The native part of the Xposed framework (mainly the modified app_process binary).
