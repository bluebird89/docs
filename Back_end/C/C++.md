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

## 工具

- [Tencent/libco](https://github.com/Tencent/libco)libco is a coroutine library which is widely used in wechat back-end service.
* [envoyproxy/envoy](https://github.com/envoyproxy/envoy):C++ front/service proxy https://www.envoyproxy.io
* [在线编译器](https://c.runoob.com/compile/12)

## 教程

* [runoob](http://www.runoob.com/cplusplus/cpp-tutorial.html)

## 资源

* [C/C++ 开源库及示例代码](https://github.com/programthink/opensource/blob/master/libs/cpp.wiki)
* [isocpp/CppCoreGuidelines](https://github.com/isocpp/CppCoreGuidelines):The C++ Core Guidelines are a set of tried-and-true guidelines, rules, and best practices about coding in C++http://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines
* [fffaraz/awesome-cpp](https://github.com/fffaraz/awesome-cpp):A curated list of awesome C++ (or C) frameworks, libraries, resources, and shiny things. Inspired by awesome-... stuff. http://fffaraz.github.io/awesome-cpp/
* [changkun/modern-cpp-tutorial](https://github.com/changkun/modern-cpp-tutorial):📚 C++11/14/17 On the Fly https://changkun.de/modern-cpp/
