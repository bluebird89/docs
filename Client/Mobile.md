# Mobile

在 App 里面显示网页，使用 WebView 控件作为网页引擎解析网页。不同的 App 技术栈要显示网页，区别仅仅在于怎么处理 WebView 这个原生控件。

## app类型

* Native apps：只能用于特定手机平台的开发技术。比如，安卓平台的 Java 技术栈，iOS 平台的 Object-C 技术栈或 Swift 技术栈。 这种技术栈只能用在一个平台，不能跨平台。指定的编程语言框架，本地apps拥有速度快和可靠的特性。用户界面使用的是本地框架。
    - Xcode
    - Android Studio
* Mobile web apps：移动web app是服务器端应用，使用了服务端技术如PHP,Java，ASP.NET，框架如jQuery Mobile，Sencha Touch等。渲染用户界面模仿本地UI.
* Hybird apps：把 Web 网页放到特定的容器中，然后再打包成各个平台的原生 App.通过web技术编写，如HTML5,CSS,JavaScript。使用移动设备的浏览器引擎渲染HTML,使用webview本地处理js。这使移动web应用程序无法访问本地设备功能,如相机、加速度计、传感器、和本地存储。其实是 Web 技术栈 + 容器技术栈，典型代表是 PhoneGap、Cordova、Ionic 等框架。
    - 技术栈就主要学习容器提供的 API Bridge，网页通过它们去调用底层硬件的 API
    - PhoneGap，诞生于2009年。后来在2011年被 Adobe 公司收购，改名为 Adobe PhoneGap。后来都捐给了 Apache 基金会，作为一个全新的开源项目，名为 Apache Cordova。
    - PhoneGap 和 Cordova 现在是两个独立发展的开源项目，但是彼此有密切的关系，可以简单理解成 Cordova 是 PhoneGap 的内核，PhoneGap 是 Cordova 的发行版。
    - 基于 Cordova 的开源框架，比较著名的有 Ionic、Monaca、Framework7 等。
* cross-platform technology stack:使用一种技术，同时支持多个手机平台。它与混合技术栈的区别是，不使用 Web 技术，即它的页面不是 HTML5 页面，而是使用自己的语法写的 UI 层，然后编译成各平台的原生 App。
    - React Native、Xamarin、Flutter 都属于这一类。学习时，除了学习容器的 API Bridge，还要学习容器提供的 UI 层，即怎么写页面
    - React框架是为网页开发设计的，核心思想是在网页之上，建立一个 UI 的抽象层，所有数据操作都在这个抽象层完成（即在内存里面完成），然后再渲染成网页的 DOM 结构，这样就提升了性能。
        + UI 抽象层本质上是一种数据结构，与底层设备无关，不仅可以渲染成网页，也可以渲染成手机的原生页面。这样的话，只要写一次 React 页面，就能分别编译成 iOS 和安卓的原生 App
    - Flutter：谷歌公司最新的跨平台开发框架。它为了解决 React Native 的平台差异问题，采用了一个完全不同的方案。实现了一套控件。打包的时候，会把这套控件打包进每一个 App，因此不存在调用原生控件的问题。不管什么平台，都调用内嵌的自己那套控件，就能做到 iOS 和安卓体验完全一致。

## 工具

* [nolimits4web/swiper](https://github.com/nolimits4web/swiper):Most modern mobile touch slider with hardware accelerated transitions http://idangero.us/swiper/
* [MobSF/Mobile-Security-Framework-MobSF](https://github.com/MobSF/Mobile-Security-Framework-MobSF):Mobile Security Framework is an automated, all-in-one mobile application (Android/iOS/Windows) pen-testing framework capable of performing static analysis, dynamic analysis, malware analysis and web API testing. https://opensecurity.in
* [be-fe/iSlider](https://github.com/be-fe/iSlider):Smooth mobile touch slider for Mobile WebApp, HTML5 App, Hybrid App http://be-fe.github.io/iSlider/

## 调试

* [Tencent/vConsole](https://github.com/Tencent/vConsole):A lightweight, extendable front-end developer tool for mobile web page.
* [weinre](https://people.apache.org/~pmuellr/weinre/docs/latest/Home.html):weinre is a debugger for web pages, like FireBug (for FireFox) and Web Inspector (for WebKit-based browsers), except it's designed to work remotely, and in particular, to allow you debug web pages on a mobile device such as a phone.
* [wix/detox](https://github.com/wix/detox):Gray Box End-to-End Testing and Automation Framework for Mobile Apps

## 参考

* [RubyLouvre/mobileHack](https://github.com/RubyLouvre/mobileHack):这里收集了许多移动端上遇到的各种坑
