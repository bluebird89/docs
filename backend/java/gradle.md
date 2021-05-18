# [gradle](https://github.com/gradle/gradle)

Adaptable, fast automation for all <https://gradle.org>

* 使用groovy来描述项目构建过程中的一些任务。由于有编程语言的灵活性，它的表达能力更加强，结合一些强大的插件支持，可以使用少量的代码和配置来达到项目构建的目的

## 安装

* The Gradle Wrapper

```sh
java -version

sdk install gradle
brew install gradle
scoop install gradle # Scoop is a command-line installer for Windows inspired by Homebrew.
choco install gradle # Chocolatey is “the package manager for Windows”.

mkdir /opt/gradle
unzip -d /opt/gradle gradle-6.8-bin.zip
ls /opt/gradle/gradle-6.8

export GRADLE_HOME=/opt/gradle/gradle-6.4.1
export PATH=$PATH:${GRADLE_HOME}/bin

gradle -v

gradle wrapper --gradle-version 6.8 --distribution-type all
./gradlew wrapper --gradle-version 6.8
```

## 配置

* init `~/.gradle/init.gradle`
* IDEA: gradle home
    - `GRADLE_USER_HOME`需要配置的环境变量。该环境变量决定了执行 project/gradle/gradle-rapper.jar时下载 project/gradle/gradle-wrapper.properties中指定版本gradle的存放位置
    - 以gradlew的开头的命令会使用GRADLE_USER_HOME指定环境变量所在位置来存放下载的gradle

```
# 配置全局
gradle.projectsLoaded {
    rootProject.allprojects {
        buildscript {
            repositories {
                def JCENTER_URL = 'https://maven.aliyun.com/repository/jcenter'
                def GOOGLE_URL = 'https://maven.aliyun.com/repository/google'
                def NEXUS_URL = 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
                all { ArtifactRepository repo ->
                    if (repo instanceof MavenArtifactRepository) {
                        def url = repo.url.toString()
                        if (url.startsWith('https://jcenter.bintray.com/')) {
                            project.logger.lifecycle "Repository ${repo.url} replaced by $JCENTER_URL."
                            println("buildscript ${repo.url} replaced by $JCENTER_URL.")
                            remove repo
                        }
                        else if (url.startsWith('https://dl.google.com/dl/android/maven2/')) {
                            project.logger.lifecycle "Repository ${repo.url} replaced by $GOOGLE_URL."
                            println("buildscript ${repo.url} replaced by $GOOGLE_URL.")
                            remove repo
                        }
                        else if (url.startsWith('https://repo1.maven.org/maven2')) {
                            project.logger.lifecycle "Repository ${repo.url} replaced by $REPOSITORY_URL."
                            println("buildscript ${repo.url} replaced by $REPOSITORY_URL.")
                            remove repo
                        }
                    }
                }
                jcenter {
                    url JCENTER_URL
                }
                google {
                    url GOOGLE_URL
                }
                maven {
                    url NEXUS_URL
                }
            }
        }
        repositories {
            def JCENTER_URL = 'https://maven.aliyun.com/repository/jcenter'
            def GOOGLE_URL = 'https://maven.aliyun.com/repository/google'
            def NEXUS_URL = 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
            all { ArtifactRepository repo ->
                if (repo instanceof MavenArtifactRepository) {
                    def url = repo.url.toString()
                    if (url.startsWith('https://jcenter.bintray.com/')) {
                        project.logger.lifecycle "Repository ${repo.url} replaced by $JCENTER_URL."
                        println("buildscript ${repo.url} replaced by $JCENTER_URL.")
                        remove repo
                    }
                    else if (url.startsWith('https://dl.google.com/dl/android/maven2/')) {
                        project.logger.lifecycle "Repository ${repo.url} replaced by $GOOGLE_URL."
                        println("buildscript ${repo.url} replaced by $GOOGLE_URL.")
                        remove repo
                    }
                    else if (url.startsWith('https://repo1.maven.org/maven2')) {
                        project.logger.lifecycle "Repository ${repo.url} replaced by $REPOSITORY_URL."
                        println("buildscript ${repo.url} replaced by $REPOSITORY_URL.")
                        remove repo
                    }
                }
            }
            jcenter {
                url JCENTER_URL
            }
            google {
                url GOOGLE_URL
            }
            maven {
                url NEXUS_URL
            }
        }
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
}

gradle -q showRepos
```
* mavenLocal()：指定使用maven本地仓库，而本地仓库在配置maven时setting文件指定的仓库位置。如<localRepository>D:/repository</localRepository>，同时将setting文件拷贝到C:\Users\Administrator.m2目录下，一般该目录下是没有setting文件的，gradle查找jar包顺序如下：gradle默认会按以下顺序去查找本地的仓库：USER_HOME/.m2/settings.xml >> M2_HOME/conf/settings.xml >> USER_HOME/.m2/repository。
* maven { url "http://maven.aliyun.com/nexus/content/groups/public/"}：指定阿里云镜像加速地址
* mavenCentral()：这是Maven的中央仓库，无需配置，直接声明就可以使用
* jcenter():JCenter中央仓库，实际也是是用的maven搭建的，但相比Maven仓库更友好，通过CDN分发，并且支持https访问。
* maven { url 地址}，指定maven仓库，一般用私有仓库地址或其它的第三方库
* gradle按配置顺序寻找jar文件。如果本地存在就不会再去下载。不存在的再去maven仓库下载，这里注意下载下来的jar文件不在maven仓库里，而是在gradle的主工作目录下，如上面的D:.gradle目录

```
repositories {
    mavenLocal()
    maven { url "http://maven.aliyun.com/nexus/content/groups/public/"}
    mavenCentral()
    jcenter()
    maven { url "https://repo.spring.io/snapshot" }
    maven { url "https://repo.spring.io/milestone" }
    maven { url 'http://oss.jfrog.org/artifactory/oss-snapshot-local/' }  //转换pdf使用
}
```

## 使用

* 配置文件 build.gradle
    - build.gradle是Gradle默认的构建脚本文件，执行Gradle命令的时候，会默认加载当前目录下的build.gradle脚本文件
    - 可以通过 -b 参数指定想要加载执行的文件
* tasks
    - assemble: 编译
    - build：编译并执行测试
    - clean：删除build目录
    - jar： 生成jar包
    - test：执行单元测试
* 配置:将读取所有build.gradle文件的所有内容来配置Project和Task等
* 参数
  - --build-cache：把可以缓存的 task 输出都缓存住，在构建过程中，如果发现这个 task 的输入不变，就没必要重新执行任务了，直接从 task ouput 缓存里拿即可
    + 支持分布式的，可以统一把这些 cache 丢到一台机器上，本地机器要编译时统一去这台机器拉 cache，这样如果切换分支时执行构建也能用 Build Cache 来加快构建速度
  - --parallel ：并行执行在多项目编译的项目中能有效提升编译的速度，但是并行执行的前提是每个项目已经被模块化，每个项目之间没有耦合
  - 移除 --refresh-dependencies： 原来 gradle build 有加这个参数，这个参数会忽略缓存，强制重新下载，显然是编译的瓶颈
  - -x 用来排除不需要执行的任务

```sh
gralew clean

gradle init

gradle wrapper

gradle build
./gradlew wrapper --gradle-version=4.4 --distribution-type=bin
./gradlew tasks

# 构建打包
gradle clean build -x test
```

## Gradle Wrapper

* 对Gradle的一层包装，便于在团队开发过程中统一Gradle构建的版本
* gradlew和gradlew.bat分别是Linux和Window下的可执行脚本，用法和gradle原生命令是一样的
* gradle-wrapper.jar是具体业务逻辑实现的jar包，gradlew最终还是使用java执行的这个jar包来执行相关gradle操作
* gradle-wrapper.properties 配置文件，用于配置使用哪个版本的gradle
    - distributionBase 下载的gradle压缩包解压后存储的主目录
    - distributionPath 相对于distributionBase的解压后的gradle压缩包的路径
    - zipStoreBase 同distributionBase，只不过是存放zip压缩包的
    - zipStorePath 同distributionPath，只不过是存放zip压缩包的
    - distributionUrl gradle发行版压缩包的下载地址，也就是你现在这个项目将要依赖的gradle的版本。
* idea
    - 配置 `Gradle user home: /home/henry/.gradle` 而不是gradle 安装位置


```sh
# 生成内置 wrapper的task
gradle wrapper –gradle-version 2.14
```

## 参考

* 正式build工具： <https://developer.android.com/studio/build/>
* 基于Kotlin的DSL： <https://github.com/gradle/kotlin-dsl>
* 将Ant build导入： <https://docs.gradle.org/current/userguide/ant.html>
* 增量build: <https://blog.gradle.org/introducing-incremental-build-support>
* 性能报告： <https://gradle.org/gradle-vs-maven-performance/>
* build缓存： <https://blog.gradle.org/introducing-gradle-build-cache>
* daemon： <https://docs.gradle.org/current/userguide/gradle_daemon.html>
