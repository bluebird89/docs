# [pulumi](https://github.com/pulumi/pulumi)

* Pulumi - Modern Infrastructure as Code. Any cloud, any language rocket https://www.pulumi.com/
* 诞生于 2017 年，是微软和亚马逊云服务的老兵 Joe Duffy（CEO） 和 Luke Hoban（CTO）创建的，对标 terraform 的一款软件
* 使用熟悉的编程语言来编写 devOps 代码
* 专注于原生云架构，包括容器、无服务器函数和数据服务，并为Kubernetes 提供了良好的支持

```
import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

const ami = pulumi.output(aws.getAmi({
    filters: [{
        name: "name",
        values: ["openresty-*"],
    }],
    owners: ["xxxx"], // 个人 aws 账号 ID
    mostRecent: true,
}));

const group = new aws.ec2.SecurityGroup("lb_sg", {
    ingress: [
        { protocol: "tcp", fromPort: 80, toPort: 80, cidrBlocks: ["0.0.0.0/0"] },
        { protocol: "tcp", fromPort: 443, toPort: 443, cidrBlocks: ["0.0.0.0/0"] },
    ],
    egress: [
        { protocol: "-1", fromPort: 0, toPort: 0, cidrBlocks: ["0.0.0.0/0"] },
    ]
});

export const server = new aws.ec2.Instance("lb", {
    instanceType: "t2.micro",
    securityGroups: ["default", group.name],
    ami: ami.id,
    tags: {
        "Name": "lb",
    },
});
```
