# [bpf Berkeley Packet Filter](https://ebpf.io/)

* 源于 1992 年伯克利实验室，Steven McCanne 和 Van Jacobson 写得一篇名为《The BSD Packet Filter: A New Architecture for User-level Packet Capture》的论文。该论文描述是在 BSD 系统上设计了一种新的用户级的数据包过滤架构
* Linux 内核一直是实现监控/可观察性、网络和安全性的理想场所。不幸的是，这往往是不切实际的，因为需要改变内核源代码或加载内核模块，并导致层层抽象叠加。
* eBPF 是一项革命性的技术，开发了全新一代的软件，能够对 Linux 内核的行为进行重新编程，甚至在传统上完全独立的多个子系统中应用逻辑。可以在 Linux 内核中运行沙盒程序，而无需改变内核源代码或加载内核模块。
  - 2013 年 ，Alexei Starovoitov 提出了对 BPF 进行重大改写。2013 年 9 月 Alexei 发布了补丁，名为「extended BPF」。eBPF 实现的最初目标是针对现代硬件进行优化。
  - eBPF 增加了寄存器数量，将原有的 2 个 32 位寄存器增加到 10 个 64 位寄存器。由于寄存器数量和宽度的增加，函数参数可以交换更多的信息，编写更复杂的程序。
  - eBPF 生成的指令集比旧的 BPF 解释器生成的机器码执行速度提高了 4 倍。
  - 2014 年 3 月， 经过 Alexei Starovoitov 和 Daniel Borkmann 的进一步开发， Daniel 将 eBPF 提交到 Linux 内核中。
  - 2014 年 6 月 BPF JIT 组件提交到 Linux 3.15 中。
  - 2014 年 12 月 系统调用 bpf 提交到 Linux 3.18 中。随后，Linux 4.x 加入了 BPF 对 kprobes、uprobe、tracepoints 和 perf_evnets 支持
  - Alexei 将 eBPF 改为 BPF。原来的 BPF 就被称为 cBPF「classic BPF」。现在 cBPF 已经基本废弃，Linux 内核只运行 eBPF，内核会将加载的 cBPF 字节码透明地转换成 eBPF 再执行。
* 通过使Linux内核可编程，基础架构软件可以利用现有的层，使其更加智能，功能更加丰富，而不会继续给系统增加额外的复杂度，也不会影响执行效率和安全性。
* 场景
  - 追踪和性能分析（Tracing & Profiling）
    + 将 eBPF 程序附加到跟踪点以及内核和用户应用探针点的能力，使得应用程序和系统本身的运行时行为具有前所未有的可见性。通过赋予应用程序和系统两方面的检测能力，可以将两种视图结合起来，从而获得强大而独特的洞察力来排除系统性能问题。先进的统计数据结构允许以高效的方式提取有意义的可见性数据，而不需要像类似系统那样，通常需要导出大量的采样数据。
  - 观测和监控（Obervability & Monitoring）
    + eBPF 不依赖于操作系统暴露的静态计数器和测量，而是实现了自定义指标的收集和内核内聚合，并基于广泛的可能来源生成可见性事件。这扩展了实现的可见性深度，并通过只收集所需的可见性数据，以及在事件源处生成直方图和类似的数据结构，而不是依赖样本的导出，大大降低了整体系统的开销。
    + 追踪和性能分析 vs 观测和监控:两者的区别主要在于数据的搜集和聚合是否在内测层面进行的，观测和监控主要是侧重于在内核导出指标、直方图或相关事件。
  - 网络（Network）
    + 可编程性和效率的结合使得 eBPF 自然而然地满足了网络解决方案的所有数据包处理要求。eBPF 的可编程性使其能够在不离开 Linux内核的包处理上下文的情况下，添加额外的协议解析器，并轻松编程任何转发逻辑以满足不断变化的需求。JIT 编译器提供的效率使其执行性能接近于本地编译的内核代码。
  - 安全（Security）
    + 在看到和理解所有系统调用的基础上，将其与所有网络操作的数据包和套接字级视图相结合，可以采用革命性的新方法来确保系统的安全。虽然系统调用过滤、网络级过滤和进程上下文跟踪等方面通常由完全独立的系统处理，但 eBPF 允许将所有方面的可视性和控制结合起来，以创建在更多上下文上运行的、具有更好控制水平的安全系统。
* 革新
  - 基于寄存器的过滤器，可以有效地工作在基于寄存器结构的 CPU 之上。
  - 使用简单无共享的缓存模型。数据包会先经过 BPF 过滤再拷贝到缓存，缓存不会拷贝所有数据包数据，这样可以最大程度地减少了处理的数据量从而提高性能。

![bpf_arch](../_static/bpf_arch.png "bpf_arch")

## 原理

* BPF 是一个通用执行引擎，能够高效地安全地执行基于系统事件的特定代码。BPF 内部由字节码指令，存储对象和帮助函数组成
* BPF 开发人员可以使用编译器 LLVM 将 C 代码编译成 BPF 字节码，字节码指令在内核执行前必须通过 BPF 验证器进行验证，同时使用内核中的 BPF JIT 模块，将字节码指令直接转成内核可执行的本地指令。编译后的程序附加到内核的各种事件上，以便在 Linux 内核中运行该 BPF 程序
* BPF 映射提供了内核和用户空间双向数据共享，允许用户从内核和用户空间读取和写入数据。BPF 映射的数据结构类型可以从简单数组、哈希映射到自定义类型映射
* BPF 程序不需要重新编译内核，并且 BPF 验证器会保证每个程序能够安全运行，确保内核本身不会崩溃。BPF 虚拟机会使用 BPF JIT 编译器将 BPF 字节码生成本地机器字节码，从而能获得本地编译后的程序运行速度
* BPF 实践中的第一公民：BPF 跟踪,Linux 可观测性的新方法,2013 年 12 月 Alexei 已将 eBPF 用于跟踪。BPF 跟踪支持的各种内核事件
  - kprobes：实现内核动态跟踪。kprobes 可以跟踪到 Linux 内核中的函数入口或返回点，但是不是稳定 ABI 接口，可能会因为内核版本变化导致，导致跟踪失效。
  - uprobes：用户级别的动态跟踪。与 kprobes 类似，只是跟踪的函数为用户程序中的函数。
  - tracepoints：内核静态跟踪。tracepoints 是内核开发人员维护的跟踪点，能够提供稳定的 ABI 接口，但是由于是研发人员维护，数量和场景可能受限。
  - USDT：为用户空间的应用程序提供了静态跟踪点。
  - perf_events：定时采样和 PMC。

![BPF 架构图](../_static/bpf_arch1.png "Optional title")

## 容器逃逸

* 危险配置:在这些年的迭代中，容器社区一直在努力将「纵深防御」、「最小权限」等理念和原则落地。例如，Docker 已经将容器运行时的 Capabilities 黑名单机制改为如今的默认禁止所有 Capabilities，再以白名单方式赋予容器运行所需的最小权限。如果容器启动，配置危险能力，或特权模式容器，或容器以 root 用户权限运行都会导致容器逃
* 危险挂载:Docker Socket 是 Docker 守护进程监听的 Unix 域套接字，用来与守护进程通信——查询信息或下发命令。如果在攻击者可控的容器内挂载了该套接字文件（/var/run/docker.sock），容器逃逸就相当容易了，除非有进一步的权限限制。

## 安装

* 编译错误
  - scripts/mod/modpos 报错:通过 make scripts 来补全脚本
  - ”asm/x.h” 头文件缺少 `sudo find / -name mmiowb.h`
  - “generated/x.h” 报错 `cp -r /usr/src/linux-headers-5.4.0-52-generic/include/generated/* ./include/generated`
* 从内核源码中直接编译 BPF 程序。这种方法需要对内核编译有一定了解，且需要善于运用搜索引擎解决编译过程中的各种问题。

```sh
sudo apt update
sudo apt install build-essential git make libelf-dev clang llvm strace tar bpfcc-tools linux-headers-$(uname -r) gcc-multilib  flex  bison libssl-dev -y

# apt 安装源码,源码安装至 /usr/src/ 目录下
apt-cache search linux-source
apt install linux-source-5.4.0

tar -jxvf linux-source-5.4.0.tar.bz2
make scripts     # 可选
cp -v /boot/config-$(uname -r) .config # make defconfig 或者 make menuconfig
make headers_install
make M=samples/bpf  # 如果配置出错，可以使用 make oldconfig && make prepare 修复

# 内核代码 Git 下载
git clone git://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/$(lsb_release -cs)
git checkout -b temp Ubuntu-5.4.0-52.57
```

```c
// # hello_kern.c：
#include <linux/bpf.h>
#include "bpf_helpers.h"

#define SEC(NAME) __attribute__((section(NAME), used))

SEC("tracepoint/syscalls/sys_enter_execve")
int bpf_prog(void *ctx)
{
 char msg[] = "Hello BPF!\n";
 bpf_trace_printk(msg, sizeof(msg));
 return 0;
}

char _license[] SEC("license") = "GPL";

// hello_user.c:
#include <stdio.h>
#include "bpf_load.h"

int main(int argc, char **argv)
{
 if( load_bpf_file("hello_kern.o") != 0)
 {
  printf("The kernel didn't load BPF program\n");
  return -1;
 }

 read_trace_pipe();
 return 0;
}

// Makefile 文件，添加以下三行：
hostprogs-y += hello
hello-objs := bpf_load.o hello_user.o
always += hello_kern.o

make M=samples/bpf V=1
```

## [BCC BPF Compiler Collection](https://github.com/iovisor/bcc)

* 在 eBPF 编程接口之上封装了 eBPF 程序的构建过程，提供了 Python、C++ 和 Lua 等高级语言接口，并基于 Python 接口实现了大量的工具，是新手入门体验 eBPF 的最好项目
  - 前端提供 Python API，而后端的 eBPF 程序还是通过 C 来实现。
  - 在运行的时候，BCC 会把 eBPF 程序编译成字节码、加载到内核执行，最后再通过用户空间的前端获取执行状态
* 安装后，BCC 会把所有示例（包括 Python 和 lua），放到 /usr/share/bcc/examples 目录中。发行版自带的 BCC 版本通常比较旧，并不包含很多已经修复的问题或者新的特性，在运行时可能会碰到意想不到的错误,推荐从源码安装最新版本
* BCC 工具会安装到 /usr/share/bcc 目录中
* 缺点
  - 启动时编译，导致启动缓慢，且编译也需要耗费较高的 CPU 和内存资源。
  - 编译 eBPF 要求所有主机上都安装内核头文件。
  - 编译错误只有在运行的时候才能检测到，排错困难。
* BCC 正在基于 libbpf 将所有工具转换为可直接执行的二进制文件，无需外部依赖，从而更易分发到实际生产环境中。转换后的工具，因无需动态编译和接口转换，可以获得更高的性能和更少的资源占用
* libbpf 还基于 BTF 和 CO-RE (Compile-Once Run-Everywhere) 提供了更好的便携性（兼容新旧内核版本）：
  - BTF 是 BPF 类型格式，用于避免依赖 Clang 和内核头文件。
  - CO-RE 则使得 BTF 字节码支持重定位，避免 LLVM 重新编译的需要
  - 借助于 BTF 和 CO-RE 的优势，可以在 /sys/kernel/btf/vmlinux 找到内核的 BTF 信息，甚至可以通过 bpftool 将其导出（一般放到文件 vmlinux.h 中）
  - libbpf 在使用上并不是很直观，所以 eBPF 维护者开发了一个脚手架项目 libbpf-bootstrap。结合了 BPF 社区的最佳开发实践，为初学者提供了一个简单易用的上手框架。

```sh
# Ubuntu
sudo apt-get install bpfcc-tools linux-headers-$(uname -r) linux-tools-common

# RHEL
sudo yum install bcc-tools

apt-get install -y build-essential git bison cmake flex  libedit-dev libllvm6.0 llvm-6.0-dev libclang-6.0-dev python zlib1g-dev libelf-dev python3-distutils libfl-dev
git clone https://github.com/iovisor/bcc.git
mkdir bcc/build && cd bcc/build
cmake ..
make && make install
cmake -DPYTHON_CMD=python3 .. # build python3 binding
pushd src/python/
make && make install

/usr/share/bcc/tools/tcpconnect

bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h

# libbpf
sudo apt install -y bison build-essential cmake flex git libedit-dev pkg-config libmnl-dev \
   python zlib1g-dev libssl-dev libelf-dev libcap-dev libfl-dev llvm clang pkg-config \
   gcc-multilib luajit libluajit-5.1-dev libncurses5-dev libclang-dev clang-tools
# checkout libbpf-bootstrap
git clone https://github.com/libbpf/libbpf-bootstrap
# update submodules
git submodule update --init --recursive
# build existing samples
cd src && make
```

## [bpftrace](https://github.com/iovisor/bpftrace)

* 类似于 DTrace 或 SystemTap，在 eBPF 之上构建了一个简化的跟踪语言，通过简单的几行脚本，就可以达到复杂的跟踪功能。
* 多行的跟踪指令也可以放到脚本文件中执行，脚本后缀通常为 .bt
* 在 Kubernetes 集群中，可以通过 kubectl trace 简化 bpftrace 的调度和运行
  - 支持单行方式或者脚本文件方式 通过 uprobe 直接跟踪一个 Pod

```sh
sudo apt-get install -y bpftrace

docker run -ti --rm -v /usr/src:/usr/src:ro \
       -v /lib/modules/:/lib/modules:ro \
       -v /sys/kernel/debug/:/sys/kernel/debug:rw \
       --net=host --pid=host --privileged \
       quay.io/iovisor/bpftrace:latest \
       tcplife.bt

# Files opened by process
bpftrace -e 'tracepoint:syscalls:sys_enter_open {printf("%s %s\n", comm, str(args->filename)); }'

# Syscall count by program
bpftrace -e 'tracepoint:raw_syscalls:sys_enter {@[comm] = count(); }'

# Read bytes by process:
bpftrace -e 'tracepoint:syscalls:sys_exit_read /args->ret/ {@[comm] = sum(args->ret); }'

# Read size distribution by process:
bpftrace -e 'tracepoint:syscalls:sys_exit_read {@[comm] = hist(args->ret); }'

# Show per-second syscall rates:
bpftrace -e 'tracepoint:raw_syscalls:sys_enter {@ = count(); } interval:s:1 { print(@); clear(@); }'

# Trace disk size by process
bpftrace -e 'tracepoint:block:block_rq_issue {printf("%d %s %d\n", pid, comm, args->bytes); }'

# Count page faults by process
bpftrace -e 'software:faults:1 {@[comm] = count(); }'

# Run a program from string literal
kubectl trace run node-1 -e "tracepoint:syscalls:sys_enter_* {@[probe] = count(); }"
# Run a program from file
kubectl trace run node-1 -f read.bt
```

## [学习路径](https://www.ebpf.top/post/ebpf_learn_path/)

* 先大体了解 BPF 技术的发展历史、优点、限制
* 使用 BCC 工具在环境中进行实践，并且初步了解相关工具的的运作机制
* 参考 BCC 样例，用原生的 C 代码进行实践并编写
* 通过 KubeCon 会议或者 [BPF Summit](https://ebpf.io/summit-2020) 学习当前主要的进展

## 书籍

* Linux Observability with BPF: Advanced Programming for Performance Analysis and Networking Linux内核观测技术BPF
  - 国外几大公司 Sysdig 、Floowmill 等在 BPF 的技术实践。
  - 主要是 Seccomp（基于传统的 cBPF）和 LSM 钩子两个方面的内容，主要是简单的介绍，内容不多；
  - Linux 网络和 BPF：涵盖数据包过滤和 cls_bpf 相关内容；
  - XDP：由于 XDP 在网络数据处理的特殊地位，单独成章，对于 XDP 进行了简单介绍和一个简单的原理实现，以及如何使用 BCC 进行 XDP 相关的验证；
  - BPF Trace：Trace 的基础知识（kprobe、tracepoint、usdt等）和几个 BCC 使用的样例；
  - BPF 相关工具（BPFTool & BPFTrace & kubectl-trace & eBPF Exportor）；
  - BPF 的历史及架构；
  - BPF 的程序类型和验证器：按照重要性依次介绍了各种程序类型；
  - BPF Map：BPF Map 类型，常见操作和以及 Map 相关虚拟系统；
  - BPF 基础知识
  - BPF Trace
  - BPF Network
  - 安全
  - 真实的用户案例
* [BPF Performance Tools: Linux System and Application Observability](http://www.brendangregg.com/bpf-performance-tools-book.html)
  - [BPF Performance Tools](https://github.com/iovisor/bcc/tree/master/tools)
  - BPF 技术介绍
  - 👍 技术背景
    + 绍的了 Trace 相关的技术点及实现原理，总结的非常简练和准确，值得多阅读几遍；
  - 性能分析总览
    + 本章节主要是介绍了各种性能分析维度（CPU/Mem/Network/System等）的背景知识、传统工具和BPF 工具使用。
  - BCC 工具介绍
    + 这个章节可以理解是 《Systems Performance: Enterprise and the Cloud》的缩减（背景知识、传统工具）和BPF 工具的补充，但是也增加了一些多的内容比如安全、容器和虚拟化的内容。
    + 这部分的内容有方法论、基础知识和使用实践，可以作为日常问题排查的参考工具书。
  - BPFTrace 工具介绍
    + BCC 和 BPFTrace 工具的介绍更多是从原理和使用层面介绍，详细的知识可以从两者的 github 网址学习到，贵在章节内容总结的有图有条理，可以快速对于整体架构有个快速的认知。
  - 附加主题
    + 作为 BPF 性能工具的补充，还有一些是使用 BPF 各种过程中的小知识、技巧和常见的问题。
  - 附录
    + 虽然是作为附录的内容，但是却是学习深入技术点的重要参考，主要是 bpftrace 工具的一览表、BCC Tools 开发、使用原生的 C 编写 BPF 和 BPF 指令集等。
    + 这部分内容面对的是希望对于 BPF 技术更加深入了解和希望参与到 BCC 工具开发的研发人员。

![Alt text](../_static/bpf_optim.png "Optional title")

## sample 样例

* BCC 参考 [tools](https://github.com/iovisor/bcc/tree/master/tools) 目录下全部文件
* BPFTrace 参考 [tools](https://github.com/iovisor/bpftrace/tree/master/tools) 目录
  - [samples/bpf](https://elixir.bootlin.com/linux/v5.8/source/samples/bpf)
  - [testing/bpf](https://elixir.bootlin.com/linux/v5.8/source/tools/testing/selftests/bpf)

## 参考

* 介绍
  - [大规模微服务利器：eBPF + Kubernetes（KubeCon, 2020）](http://arthurchiao.art/blog/ebpf-and-k8s-zh/)
  - [如何基于 Cilium 和 eBPF 打造可感知微服务的 Linux（2019）](https://github.com/DavadDi/bpf_study/blob/master/how-to-make-linux-microservice-aware-with-cilium-ebpf/index.md)
  - An eBPF overview 系列
    + [part 1: Introduction](https://www.collabora.com/news-and-blog/blog/2019/04/05/an-ebpf-overview-part-1-introduction/)
    + [part 2: Machine & bytecode](https://www.collabora.com/news-and-blog/blog/2019/04/15/an-ebpf-overview-part-2-machine-and-bytecode/)
    + [part 3: Walking up the software stack](https://www.collabora.com/news-and-blog/blog/2019/04/26/an-ebpf-overview-part-3-walking-up-the-software-stack/)
    + [part 4: Working with embedded systems](Working with embedded systems: https://www.collabora.com/news-and-blog/blog/2019/05/06/an-ebpf-overview-part-4-working-with-embedded-systems/)
    + [part 5: Tracing user processes](Tracing user processes: https://www.collabora.com/news-and-blog/blog/2019/05/14/an-ebpf-overview-part-5-tracing-user-processes/)
  - [The art of writing eBPF programs: a primer](https://github.com/DavadDi/bpf_study/blob/master/the-art-of-writing-ebpf-programs-a-primer/index.md)
  - [A Deep Dive into eBPF: The Technology that Powers Tracee](https://blog.aquasec.com/intro-ebpf-tracing-containers)
  - [Linux Extended BPF (eBPF) Tracing Tools Brendan Gregg](http://www.brendangregg.com/ebpf.html)
  - [A thorough introduction to eBPF](https://lwn.net/Articles/740157/)
  - [bpf-docs](https://github.com/iovisor/bpf-docs)
* 深入
  - [Linux 内核 BPF 文档](https://www.infradead.org/~mchehab/kernel_docs/bpf/index.html)
  - [Cillum BPF and XDP Reference Guide  [译] Cilium：BPF 和 XDP 参考指南（2019）](https://github.com/DavadDi/bpf_study/blob/master/how-to-make-linux-microservice-aware-with-cilium-ebpf/index.md)
  - [Dive into BPF: a list of reading material](https://qmonnet.github.io/whirl-offload/2016/09/01/dive-into-bpf/)
    + [中文](https://www.zcfy.cc/article/dive-into-bpf-a-list-of-reading-material)
  - [awesome-ebpf](https://github.com/icopy-site/awesome-cn/blob/master/docs/awesome/awesome-ebpf.md)
  -  [Cillum BPF and XDP Reference Guide Cilium：BPF 和 XDP 参考指南（2019）](https://docs.cilium.io/en/v1.8/bpf/)
    +  [中文](http://arthurchiao.art/blog/cilium-bpf-xdp-reference-guide-zh/)
  -  [lwn.net#Berkeley_Packet_Filter](https://lwn.net/Kernel/Index/#Berkeley_Packet_Filter) lwn.net 网站中与 BPF 相关的主题文章，对于了解 BPF 的历史非常有帮助
  - Oracle Blog 系列教程
    + [BPF program types](http://blogs.oracle.com/linux/notes-on-bpf-1):配合 [eBPF features by Linux version](https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md) 效果更好
    + [BPF helper functions for those programs](http://blogs.oracle.com/linux/notes-on-bpf-2)
    + [BPF userspace communication](http://blogs.oracle.com/linux/notes-on-bpf-3)
    + [BPF program build environment](http://blogs.oracle.com/linux/notes-on-bpf-4)
    + [BPF bytecodes and verifier](http://blogs.oracle.com/linux/notes-on-bpf-5)
    + [BPF Packet Transformation](http://blogs.oracle.com/linux/notes-on-bpf-6)
    + [The Power of XDP](https://blogs.oracle.com/linux/the-power-of-xdp)
    + [Notes on BPF (7) - BPF, tc and Generic Segmentation Offload](https://blogs.oracle.com/linux/notes-on-bpf-7)
    + [Taming Tracepoints in the Linux Kernel](https://blogs.oracle.com/linux/taming-tracepoints-in-the-linux-kernel)
  - [xdp-tutorial](https://github.com/xdp-project/xdp-tutorial) 详细的 xdp 的源码，是学习 xdp 的好地方
  - [深入理解 Cilium 的 eBPF 收发包路径（datapath）（KubeCon, 2019）](http://arthurchiao.art/blog/understanding-ebpf-datapath-in-cilium-zh/)
* [linux-bpf-learning](https://github.com/nevermosby/linux-bpf-learning):learn how to use BPF/eBPF
* [在线内核源码](https://elixir.bootlin.com/)
* [](https://github.com/DavadDi/bpf_study)
* [Linux超能力BPF技术介绍及学习分享](https://cloud.tencent.com/developer/article/1698426)
