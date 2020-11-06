# [gradle](https://github.com/gradle/gradle)

Adaptable, fast automation for all https://gradle.org

## 安装

```sh
java -version

brew install gradle
scoop install gradle # Scoop is a command-line installer for Windows inspired by Homebrew.
choco install gradle # Chocolatey is “the package manager for Windows”.

# mkdir /opt/gradle
unzip -d /opt/gradle gradle-6.4.1-bin.zip
ls /opt/gradle/gradle-6.4.1

export GRADLE_HOME=/opt/gradle/gradle-6.4.1
export PATH=$PATH:${GRADLE_HOME}/bin

gradle -v

./gradlew wrapper --gradle-version=6.6.1 --distribution-type=bin
```

## 配置

* IDEA: gradle home

```
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
            url "http://maven.oschina.net/content/groups/public/"
        }
        maven {
            url 'http://maven.aliyun.com/nexus/content/groups/public/'
        }
        ## android
        maven{ url 'http://maven.aliyun.com/nexus/content/repositories/jcenter'}
    }
}

allprojects {
    repositories {
        def ALIYUN_REPOSITORY_URL = 'https://maven.aliyun.com/repository/public'
        def ALIYUN_GOOGLE_URL = 'https://maven.aliyun.com/repository/google'
        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2') || url.startsWith('https://jcenter.bintray.com')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_REPOSITORY_URL."
                    remove repo
                }
                if (url.startsWith('https://dl.google.com/dl/android/maven2')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_GOOGLE_URL."
                    remove repo
                }
            }
        }
        maven { url ALIYUN_REPOSITORY_URL }
        maven { url ALIYUN_GOOGLE_URL }
    }
}
gradle init
```

## 使用

* 配置文件:build.gradle
* 参数
  - --build-cache：把可以缓存的 task 输出都缓存住，在构建过程中，如果发现这个 task 的输入不变，就没必要重新执行任务了，直接从 task ouput 缓存里拿即可
    + 支持分布式的，可以统一把这些 cache 丢到一台机器上，本地机器要编译时统一去这台机器拉 cache，这样如果切换分支时执行构建也能用 Build Cache 来加快构建速度
  - --parallel ：并行执行在多项目编译的项目中能有效提升编译的速度，但是并行执行的前提是每个项目已经被模块化，每个项目之间没有耦合
  - 移除 --refresh-dependencies： 原来 gradle build 有加这个参数，这个参数会忽略缓存，强制重新下载，显然是编译的瓶颈

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
