# C++

## 学习

学好C++，一定要学习C++11，搞懂内存管理，熟悉智能指针和RAII等基本内存管理原则，搞懂虚函数和继承，函数重载与重写，熟悉C++调试等。推荐阅读《The C++ Programming Language》和Effect C++系列。不要死抠语法细节，了解Big picture，从做项目中去掌握和理解C++的这些特性。这些书的阅读也是有技巧的，不要一开始试图把整本书看完再去写代码，看完基本的C++语法，类，继承之后就可以开始写代码了。遇到模板或者STL容器不懂的时候，再去针对性地阅读相关的章节和Google查找资料来学习。Effective C++系列书籍，再你写过几万行C++代码之后，再去阅读会更好。而且推荐每年都至少读一遍。

## 环境搭建

### Mac

```sh
gcc file.c # 编译

## sublime  C++.sublime-build
{
    "shell_cmd": "g++ \"${file}\" -o \"${file_path}/${file_base_name}\"",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c, source.c++",

    "variants":
    [
        {
            "name": "Run",
            "shell_cmd": "g++ \"${file}\" -o \"${file_path}/${file_base_name}\" && \"${file_path}/${file_base_name}\""
        }
    ]
}
```

## 图书

* 《C Primer Plus》

## 工具

* IDE
    - [Code::Blocks](http://www.codeblocks.org)
    - Qtcreator
* 队列
    - [cameron314/concurrentqueue](https://github.com/cameron314/concurrentqueue):A fast multi-producer, multi-consumer lock-free concurrent queue for C++11
* [Tencent/phxpaxos](https://github.com/Tencent/phxpaxos)：The Paxos library implemented in C++ that has been used in the WeChat production environment.
* JSON
    - [nlohmann / json](https://github.com/nlohmann/json):JSON for Modern C++ https://nlohmann.github.io/json/
    - [Tencent/rapidjson](https://github.com/Tencent/rapidjson):A fast JSON parser/generator for C++ with both SAX/DOM style API http://rapidjson.org/
* [Tencent/libco](https://github.com/Tencent/libco)libco is a coroutine library which is widely used in wechat back-end service.
* [envoyproxy/envoy](https://github.com/envoyproxy/envoy):C++ front/service proxy https://www.envoyproxy.io
* [lupoDharkael/flameshot](https://github.com/lupoDharkael/flameshot):Powerful yet simple to use screenshot software
* [onqtam/doctest](https://github.com/onqtam/doctest):The fastest feature-rich C++11 single-header testing framework for unit tests and TDD http://bit.ly/doctest-docs
* package manager
    - [Microsoft/vcpkg](https://github.com/Microsoft/vcpkg):C++ Library Manager for Windows, Linux, and MacOS
* [catchorg/Catch2](https://github.com/catchorg/Catch2):A modern, C++-native, header-only, test framework for unit-tests, TDD and BDD - using C++11, C++14, C++17 and later (or C++03 on the Catch1.x branch) https://discord.gg/4CWS9zD
* [Boost.Hana](https://www.boost.org/doc/libs/1_61_0/libs/hana/doc/html/index.html):Hana is a header-only library for C++ metaprogramming suited for computations on both types and values
* [google / benchmark](https://github.com/google/benchmark):A microbenchmark support library

## 参考

* [C/C++ 开源库及示例代码](https://github.com/programthink/opensource/blob/master/libs/cpp.wiki)
* [isocpp/CppCoreGuidelines](https://github.com/isocpp/CppCoreGuidelines):The C++ Core Guidelines are a set of tried-and-true guidelines, rules, and best practices about coding in C++http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines
* [fffaraz/awesome-cpp](https://github.com/fffaraz/awesome-cpp):A curated list of awesome C++ (or C) frameworks, libraries, resources, and shiny things. Inspired by awesome-... stuff. http://fffaraz.github.io/awesome-cpp/
* [changkun/modern-cpp-tutorial](https://github.com/changkun/modern-cpp-tutorial):📚 C++11/14/17 On the Fly https://changkun.de/modern-cpp/
* [huihut/interview](https://github.com/huihut/interview):📚 C/C++面试知识总结
* [cppreference](http://en.cppreference.com/book/)：`C++`官方参考文档
* [Awesome C/C++](https://fffaraz.github.io/awesome-cpp/)：一系列优秀的`C/C++`框架、库和资源
* [Awesome Qt](https://github.com/fffaraz/awesome-qt)：一系列优秀的`Qt`库和资源
* [3rd-party-applications](https://github.com/Razor-qt/razor-qt/wiki/3rd-party-applications)：一系列优秀的`Qt`第三方程序
