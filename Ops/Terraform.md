# [hashicorp/terraform](https://github.com/hashicorp/terraform)

Terraform is a tool for building, changing, and combining infrastructure safely and efficiently. https://www.terraform.io/

* 缺点
	- 状态管理还处在原始社会
	- 缺乏可视化的手段
	- 代码表现力一般
	- terraform cloud 才刚刚起步

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

  owners = ["xxxx"] # 我个人的 aws 账号 ID
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

## 工具

* [gruntwork-io/terragrunt](https://github.com/gruntwork-io/terragrunt):Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules. https://www.gruntwork.io
* [terraform-aws-modules/terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks):A Terraform module to create an Elastic Kubernetes (EKS) cluster and associated worker instances on AWS.
* [dtan4/terraforming](https://github.com/dtan4/terraforming):Export existing AWS resources to Terraform style (tf, tfstate) http://terraforming.dtan4.net/
* [terraform-providers/terraform-provider-aws](https://github.com/terraform-providers/terraform-provider-aws):Terraform AWS provider https://www.terraform.io/docs/providers/aws/
