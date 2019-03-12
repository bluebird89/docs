# [gradle/gradle](https://github.com/gradle/gradle)

Adaptable, fast automation for all https://gradle.org

## 安装

```shell
java -version

brew install gradle
export PATH=$PATH:/opt/gradle/gradle-4.4/bin

scoop install gradle # Scoop is a command-line installer for Windows inspired by Homebrew.
choco install gradle # Chocolatey is “the package manager for Windows”.

gradle -v

./gradlew wrapper --gradle-version=4.4 --distribution-type=bin
./gradlew tasks
```

## 参考

* Gradle： https://gradle.org/
* 正式build工具： https://developer.android.com/studio/build/
* 基于Kotlin的DSL： https://github.com/gradle/kotlin-dsl
* 将Ant build导入： https://docs.gradle.org/current/userguide/ant.html
* 增量build: https://blog.gradle.org/introducing-incremental-build-support
* 性能报告： https://gradle.org/gradle-vs-maven-performance/
* build缓存： https://blog.gradle.org/introducing-gradle-build-cache
* daemon： https://docs.gradle.org/current/userguide/gradle_daemon.html
