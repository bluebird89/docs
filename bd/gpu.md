# GPU

```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt install nvidia-driver-440
nvidia-smi
```

## 概念

* GPU  Graphics Processing Unit，显卡
* CUDA ————** Compute Unified Device Architecture，英伟达 2006 年推出的计算 API
* VT/VT-x/VT-d —** Intel Virtualization Technology。-x 表示 x86 CPU，-d 表示 Device。
* SVM —————** AMD Secure Virtual Machine。AMD 的等价于 Intel VT-x 的技术。
* EPT —————** Extended Page Table，Intel 的 CPU 虚拟化中的页表虚拟化硬件支持。
* NPT —————** Nested Page Table，AMD 的等价于 Intel EPT 的技术。
* SR-IOV ———** Single Root I/O Virtualization。PCI-SIG 2007 年推出的 PCIe 虚拟化技术。
* PF —————** Physical Function，亦即物理卡
* VF —————** Virtual Function，亦即 SR-IOV 的虚拟 PCIe 设备
* MMIO ———** Memory Mapped I/O。设备上的寄存器或存储，CPU 以内存读写指令来访问。
* CSR ————** Control & Status Register，设备上的用于控制、或反映状态的寄存器。CSR 通常以 MMIO 的方式访问。
* UMD ————** User Mode Driver。GPU 的用户态驱动程序，例如 CUDA 的 UMD 是 libcuda.so
* KMD ————** Kernel Mode Driver。GPU 的 PCIe 驱动，例如英伟达 GPU 的 KMD 是 nvidia.ko
* GVA ————** Guest Virtual Address，VM 中的 CPU 虚拟地址
* GPA ————** Guest Physical Address，VM 中的物理地址
* HPA ————** Host Physical Address，Host 看到的物理地址
* IOVA ————** I/O Virtual Address，设备发出去的 DMA 地址
* PCIe TLP ——** PCIe Transaction Layer Packet
* BDF ————** Bus/Device/Function，一个 PCIe/PCI 功能的 ID
* MPT ————** Mediated Pass-Through，受控直通，一种设备虚拟化的实现方式
* MDEV ———** Mediated Device，Linux 中的 MPT 实现
* PRM ————** Programming Reference Manual，硬件的编程手册
* MIG ————** Multi-Instance GPU，Ampere 架构高端 GPU 如 A100 支持的一种 hardware partition 方案

## 场景

* 游戏渲染
* 媒体编解码
* 深度学习计算

## 桌面、服务器级别的 GPU 厂商:

* 英伟达：GPU 的王者。主要研发力量在美国和印度。
* AMD/ATI：ATI 于 2006 年被 AMD 收购。渲染稍逊英伟达，计算的差距更大。
* Intel：长期只有集成显卡，近年来开始推独立显卡。
* 2006 年，GPU 工业界发生三件事: ATI 被 AMD 收购；nVidia 黄仁勋提出了 CUDA 计算；Intel 宣布要研发独立显卡。
	* Intel 很快就放弃了它的独立显卡，直到 2018 才终于明白过来自己到底放弃了什么，开始决心生产独立显卡
	* AMD 整合 ATI 不太成功，整个公司差点被拖死，危急时公司股票跌到不足 2 美元
	* 当时不被看好的 CUDA，则在几年后取得了不可思议的成功

## 虚拟化：英伟达 GPU + CUDA 计算
## 工具

* [gpu.js](https://github.com/gpujs/gpu.js):GPU Accelerated JavaScript <http://gpu.rocks>

## 参考

* [GPU-Gems-Book-Source-Code](https://github.com/QianMo/GPU-Gems-Book-Source-Code):💿 CD Content ( Source Code ) Collection of Book <GPU Gems > 1~ 3 | 《GPU精粹》 1~ 3 随书CD（源代码）珍藏
* [coreutils](https://github.com/uutils/coreutils):Cross-platform Rust rewrite of the GNU coreutils
* [GPUOpen](https://gpuopen.com/)
