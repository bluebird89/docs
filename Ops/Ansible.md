# [Ansible](https://www.ansible.com)

Ansible是一种配置和管理工具，面向客户端的软件部署和配置，支持Unix、Linux和Windows。配置自己的基础架构并且自动化部署.

* 使用JSON和YAML，而不是IAC，根本不需要节点代理就可以安装。
* 可以通过OpenStack在内部系统上使用，也可以在亚马逊EC2上使用。

## Install

```sh
vagrant init ansible/tower
vagrant up --provider virtualbox
vagrant ssh
```

### 使用

```sh
ansible all -m ping --ask-pass # 管理主机测试
```
## mac

* ansible
* ansible-lint
* ansible@2.0
* ansible-cmdb
* ansible@1.9
* terraform-provisioner-ansible
* caskroom/cask/ansible-dk

## Usage:

* [geerlingguy/ansible-vagrant-examples](https://github.com/geerlingguy/ansible-vagrant-examples)
* [ansible-for-devops](https://github.com/geerlingguy/ansible-for-devops)
* [ansible/ansible-container](https://github.com/ansible/ansible-container)
* [ansible/ansible-examples](https://github.com/ansible/ansible-examples)
* [ansible/ansible](https://github.com/ansible/ansible)

## 参考

* [文档](http://docs.ansible.com/ansible/latest/intro_installation.html)
* [ansible/ansible-examples](https://github.com/ansible/ansible-examples):A few starter examples of ansible playbooks, to show features and how they work together. See http://galaxy.ansible.com for example roles from the Ansible community for deploying many popular applications
* [Ansible中文权威指南](http://www.ansible.com.cn/?wztf_magedu)
* Ansible： https://www.ansible.com/
* 一些模块： https://docs.ansible.com/ansible/latest/modules/modules_by_category.html
* 博文： https://www.redhat.com/en/blog/integrating-ansible-jenkins-cicd-process
