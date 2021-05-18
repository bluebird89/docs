## Faas function as a service

* Ops:Blue/Green Deployments:版本切换
* Ops:金丝雀发布（Canary Releases）:允许你直接只导入指定量的流量到新的版本，API网关就可以帮你来做这件事情
* Ops:负载均衡（ Load Balancing）：API网关就可以利用诸如Consul或etcd这些服务发现工具来负载均衡请求（request）。每次你去请求一个DNS地址，服务发现（service‑discovery）工具就会给你一个新的IP地址。一般会在DNS这一层中做一些类似round-robin等策略的负载均衡
* Ops:断路器（Circuit Breakers）：超过了指定的阈值，API网关就会停止发送数据到那些失败的模块
