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
```

## 配置

```sh
# 项目配置 build.gradle
repositories {
    maven {
        url "http://maven.aliyun.com/nexus/content/groups/public"
    }
}
# 验证 build.gradle 文件内增加一个任务
task showRepos {
    doLast {
        repositories.each {
            println "repository: ${it.name} ('${it.url}')"
        }
    }
gradle -q showRepos

# 配置全局 (用户家目录)/.gradle/init.gradle
allprojects {
    repositories {
        maven {
            url "http://maven.aliyun.com/nexus/content/groups/public"
        }
    }
}
```

## 使用

* 配置文件:build.gradle 

```sh
gradle build
./gradlew wrapper --gradle-version=4.4 --distribution-type=bin
./gradlew tasks
```

## 参考

* 正式build工具： https://developer.android.com/studio/build/
* 基于Kotlin的DSL： https://github.com/gradle/kotlin-dsl
* 将Ant build导入： https://docs.gradle.org/current/userguide/ant.html
* 增量build: https://blog.gradle.org/introducing-incremental-build-support
* 性能报告： https://gradle.org/gradle-vs-maven-performance/
* build缓存： https://blog.gradle.org/introducing-gradle-build-cache
* daemon： https://docs.gradle.org/current/userguide/gradle_daemon.html
* [Gradle学习系列之一——Gradle快速入门](https://www.cnblogs.com/davenkin/p/gradle-learning-1.html)
