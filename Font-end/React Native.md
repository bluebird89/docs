# React Native

## 资源

- [react-native](https://github.com/facebook/react-native)
- [网站](http://facebook.github.io/react-native/)
- [react-native-elements](https://github.com/react-native-training/react-native-elements)
- [awesome-react-native](https://github.com/jondot/awesome-react-native)
- [f8app](https://github.com/fbsamples/f8app)<http://makeitopen.com/>
- [仓库](https://github.com/facebook/react)
- [设计含结构](https://github.com/airbnb/react-sketchapp)
- [文档](http://airbnb.io/react-sketchapp/docs/)
- [页面设计](https://github.com/ant-design/ant-design/)
- [react-native-guide](https://github.com/reactnativecn/react-native-guide)
- [react-native-macos](https://github.com/ptmt/react-native-macos)
- [storybook](https://github.com/storybooks/storybook)
- [jondot/awesome-react-native](https://github.com/jondot/awesome-react-native)
- [enaqx/awesome-react](https://github.com/enaqx/awesome-react)A collection of awesome things regarding React ecosystem.
- [davezuko/react-redux-starter-kit](https://github.com/davezuko/react-redux-starter-kit)

## [安装](https://facebook.github.io/react-native/docs/getting-started.html)

- Chocolatey（ 基于Nuget的Windows包管理工具）安装与使用

```
// 以管理员身份运行cmd：
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

// choco install/uninstall/upgrade package/package
choco install python2
choco install nodejs  // 优化npm镜像
choco install jdk8
```

- 安装 Android Studio

  - Android Studio的欢迎界面中选择Configure | SDK Manager

    - SDK Platforms(Android 6.0 (Marshmallow):Show Package Details)

      - Google APIs
      - Android SDK Platform 23
      - Intel x86 Atom_64 System Image
      - Google APIs Intel x86 Atom_64 System Image

    - SDK Tools(Show Package Details)

      - Android SDK Build-Tools:23.0.1

  - 添加用户变量ANDROID_HOME，sdk地址：D:\Tool\Android\sdk

  - 新建项目运行，保证有物理机或者一个AVD

- 项目构建

```
// 安装react-native-cli
npm install -g react-native-cli
// 初始化项目
react-native init AwesomeProject
//  运行应用
cd AwesomeProject
react-native run-android
```

## 扩展

- [youzan/zent-kit](https://github.com/youzan/zent-kit)React 组件库开发脚手架
- [youzan/zent](https://github.com/youzan/zent)A collection of essential UI components written with React.

<http://blog.csdn.net/gitchat/article/details/77978708>
