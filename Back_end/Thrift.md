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
