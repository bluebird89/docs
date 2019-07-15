# [ansible/ansible](https://github.com/ansible/ansible) https://www.ansible.com

Ansible是一种配置和管理工具，面向客户端的软件部署和配置，支持Unix、Linux和Windows。配置自己的基础架构并且自动化部署.

* 使用JSON和YAML，而不是IAC，根本不需要节点代理就可以安装。
* 可以通过OpenStack在内部系统上使用，也可以在亚马逊EC2上使用。

## Install

* 配置
    - ansible.cfg (in the current directory)
    - ANSIBLE_CONFIG (an environment variable)
    - `~/.ansible.cfg`
    - `/etc/ansible/ansible.cfg`

```sh
vagrant init ansible/tower
vagrant up --provider virtualbox
vagrant ssh
```

## 概念

* inventory目录：里面加入hosts文件，来对机器进行管理和设置。在运行的时候 通过 `ansible -i inventory` 来进行指定，ansible会读取里面的hosts文件，另外可以定义 host_vars和group_vars目录， 来根据主机和组来定义变量，使得变量更加灵活。
* role.yml文件：一个入口文件，ansible-playbook命令可以通过-e传入参数到role.yml里面，然后role.yml根据传入的参数，执行对应的roles文件夹里面的项目: 例子：`ansible-playbook -i inventory -e target=all -e role=ping role.yml` 上面的命令，表示读取inventory文件夹里面的hosts，把role.yml里面的target替换成all，把role替换成ping，来进行执行。
* roles目录:把不同的操作按子目录进行分离，通过上面的role传入的参数，选择对应名称的子目录，比如上面role=ping，则就在下面找到ping的目录，进行后续对应的操作。后面的操作常用的主要有
    - tasks  表示执行的任务
        + tasks是从上到下顺序执行，如果中间发生错误，那么整个playbook会中止。你可以改修文件后，再重新执行。
        + 每一个task的对module的一次调用。使用不同的参数和变量而已。
        + 每一个task最好有name属性，这个是供人读的，没有实际的操作。然后会在命令行里面输出，提示用户执行情况。
    - handlers  表示相应的事件
        + Handlers里面的每一个handler，也是对module的一次调用。而handlers与tasks不同，tasks会默认的按定义顺序执行每一个task，handlers则不会，它需要在tasks中被调用，才有可能被执行。
        + Tasks中的任务都是有状态的，changed或者ok。 在Ansible中，只在task的执行状态为changed的时候，才会执行该task调用的handler，这也是handler与普通的event机制不同的地方。
        + templates  表示模版文件，模版中可以使用对应的变量，读取vars里面的变量
        + vars   表示变量文件，可以定义变量
        + files   定义文件
* Playbooks

```yml
---
# hosts could have been "remote" or "all" as well
- hosts: local
  connection: local
  become: yes
  become_user: root
  tasks:
   - name: Install Nginx
     apt:
       name: nginx
       state: installed
       update_cache: true

ansible-playbook -i ./hosts nginx.yml
```

### 使用

```sh
ansible all -m ping --ask-pass # 管理主机测试

ansible -i ./hosts --connection=local local -m ping
ansible -i ./hosts local --connection=local -b --become-user=root \
    -m shell -a 'apt-get install nginx'

ansible -i ./hosts remote -b --become-user=root all -m shell -a 'apt-get install nginx'
```

## mac

* ansible
* ansible-lint
* ansible@2.0
* ansible-cmdb
* ansible@1.9
* terraform-provisioner-ansible
* caskroom/cask/ansible-dk

## Usage

* [leucos/ansible-tuto](https://github.com/leucos/ansible-tuto):Ansible tutorial
* [geerlingguy/ansible-vagrant-examples](https://github.com/geerlingguy/ansible-vagrant-examples)
* [ansible-for-devops](https://github.com/geerlingguy/ansible-for-devops)
* [ansible/ansible-container](https://github.com/ansible/ansible-container)
* [ansible/ansible-examples](https://github.com/ansible/ansible-examples): A few starter examples of ansible playbooks, to show features and how they work together. See http://galaxy.ansible.com for example roles from the Ansible community for deploying many popular applications.

## 参考

* [文档](http://docs.ansible.com/ansible/latest/intro_installation.html)
* [Ansible中文权威指南](http://www.ansible.com.cn/?wztf_magedu)
* 一些模块： https://docs.ansible.com/ansible/latest/modules/modules_by_category.html
* 博文： https://www.redhat.com/en/blog/integrating-ansible-jenkins-cicd-process
* https://linux.cn/article-4215-1.html
