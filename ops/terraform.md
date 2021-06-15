# [Terraform](https://github.com/hashicorp/terraform)

Terraform is a tool for building, changing, and combining infrastructure safely and efficiently. <https://www.terraform.io/>

* 缺点
  - 状态管理还处在原始社会
  - 缺乏可视化的手段
  - 代码表现力一般
  - terraform cloud 才刚刚起步

## 概念

* 管理云资源
* 基础设施和服务统称为资源，如私有网络、子网、物理机、虚拟机、镜像、专线、NAT 网关等等
* Provider：一个与 Open API 直接交互的后端驱动，Terraform 就是通过 Provider 来完成对基础设施资源的管理的。不同的基础设施提供商都需要提供一个 Provider
* data:一般是固定的一些可读资源，如可用区列表、镜像列表来实现对自家基础设施的统一管理
* resource
  - 一般是抽象的真正的云服务资源，支持增删改，如私有网络、NAT 网关、虚拟机实例,大部分情况下，
  - 会封装一个 data source 方法，用于资源查询
* state 创建和管理的所有资源都会保存到一个文件名为 terraform.tfstate 的文件
  - 默认存放在执行 Terraform 命令的本地目录下。
  - 这个 state 文件非常重要，如果该文件损坏，Terraform 将认为已创建的资源被破坏或者需要重建（实际的云资源通常不会受到影响）
  - 因为在执行 Terraform 命令是，Terraform 将会利用该文件与当前目录下的模板做 Diff 比较，如果出现不一致，Terraform 将按照模板中的定义重新创建或者修改已有资源，直到没有 Diff，因此可以认为 Terraform 是一个有状态服务。

```
provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "openresty" {
  most_recent = true

  filter {
    name   = "name"
    values = ["openresty-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["xxxx"] # 个人的 aws 账号 ID
}

resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "allow http/https access"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "lb" {
  ami           = "${data.aws_ami.openresty.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "lb"
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.lb_sg.id}"
  network_interface_id = "${aws_instance.lb.primary_network_interface_id}"
}
```

## 使用

* terraform plan，实现对于模板所定义资源的预览功能，在真正生产资源之前可以实时地去查看当前模板所要生产哪些资源。
  - 预览当前模板中定义的资源是否符合管理预期，和 Markdown 的预览功能类似
  - 如果当前模板已经存在对应的 state 文件，那么 plan 命令将会展示模板定义与 state 文件内容的 diff 结果，如果有变更，将会展示结果并在下方显示出来
  - 对 DataSource 而言，执行 plan 命令，即可直接获取并输出所要查询的资源及其属性
* terraform apply，这就是真正地生产资源的过程，执行这个命令就可以解析模板进而调用相应的 API 去实现对于资源的真实生产，资源后续的更新也会通过这个命令进行。
  - 创建新的资源
  - 通过修改模板参数来修改资源的属性
  - 如果从当前模板中删除某个资源的定义， apply 命令会将该资源彻底删除。可以理解为“资源的移除也是一种变更”

* terraform destroy，就是当需要去释放资源的时候，可以执行这个命令，从而达到对于模板所定义资源的全部释放销毁。


## 工具

* [terragrunt](https://github.com/gruntwork-io/terragrunt):Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules. <https://www.gruntwork.io>
* [terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks):A Terraform module to create an Elastic Kubernetes (EKS) cluster and associated worker instances on AWS.
* [terraforming](https://github.com/dtan4/terraforming):Export existing AWS resources to Terraform style (tf, tfstate) <http://terraforming.dtan4.net/>
* [terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws):Terraform AWS provider <https://www.terraform.io/docs/providers/aws/>

## 参考

* [Terraform 学习路径](https://wsgzao.github.io/post/terraform/)
* [Terraform tencentcloud 部署实践](https://wsgzao.github.io/post/terraform-tencentcloud/)
