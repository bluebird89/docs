# CMake

* 一个跨平台的自动化建构系统，它是用一个名为CMakeLists.txt的文件来描述构建过程，可以产生标准的构建文件

```sh
sudo apt install cmake
sudo yum install cmake

wget https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz --no-check-certificatell
cd cmake-3.10.2/
./bootstrap
gmake -v
```


```
# makefile
hello.out:max.o min.o hello.c
      gcc max.o min.o hello.c -o hello.out
max.o:max.c
      gcc -c max.c
min.o:min.c
      gcc -c min.c
```

## 图书

* 《CMake实践》
* 《Mastering CMake》
