# [thrift](http://thrift.apache.org)

for scalable cross-language services development, combines a software stack with a code generation engine to build services that work efficiently and seamlessly between C++, Java, Python, PHP, Ruby, Erlang, Perl, Haskell, C#, Cocoa, JavaScript, Node.js, Smalltalk, OCaml and Delphi and other languages.

## Install

* [Boost](https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.7z)
* [libevent](https://github.com/libevent/libevent/releases/download/release-2.1.10-stable/libevent-2.1.10-stable.tar.gz)
* [Trift](http://mirrors.tuna.tsinghua.edu.cn/apache/thrift/0.12.0/thrift-0.12.0.tar.gz )

```sh
## Mac
#  Install Boost
./bootstrap.sh
sudo ./b2 threading=multi address-model=64 variant=release stage install

# Install libevent
./configure --prefix=/usr/local
make
sudo make install

# Building Apache Thrift
./configure --prefix=/usr/local/ --with-boost=/usr/local --with-libevent=/usr/local
```


## 数据类型：

* 基本
    - bool: 布尔类型(true / false)
    - byte: 8位带符号整数
    - i16: 16位带符号整数
    - i32: 32位带符号整数
    - i64: 64位带符号整数
    - double: 64位浮点数
    - string: 采用UTF-8编码的字符串
    - map<t1,t2> 键值对
    - list<t1> 列表
    - set<t1> 集合
```language
# 结构：
struct User {
1: i32 uid,
2: string name,
3: string age,
4: string sex
}

# service，对外扩展的接口：
service UserStorage {
void addUser(1: User user),
User getUser(1: i32 uid)
}

# 使用 thrift 命令生成相应的接口文件：
thrift -out ../python --gen py test.thrift
thrift -out 存储路径 --gen 接口语言 thrift 文件名
```

