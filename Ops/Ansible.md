# [ansible/ansible](https://github.com/ansible/ansible) https://www.ansible.com

一种配置和管理工具，面向客户端的软件部署和配置，支持Unix、Linux和Windows。配置基础架构并且自动化部署

* 使用JSON和YAML，而不是IAC，根本不需要节点代理就可以安装
* 可以通过OpenStack在内部系统上使用，也可以在亚马逊EC2上使用

## Install

* mac
  - ansible
  - ansible-lint
  - ansible@2.0
  - ansible-cmdb
  - ansible@1.9
  - terraform-provisioner-ansible
  - caskroom/cask/ansible-dk
* 配置
  - ANSIBLE_CONFIG (environment variable if set)
  - ansible.cfg (in the current directory)
  - `~/.ansible.cfg(in the home directory)`
  - `/etc/ansible/ansible.cfg`

```sh
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Virtualenv's
# Install python2.7 (Ubuntu 16.04 comes with python 3 out of the box) and Pip
sudo apt-get install -y python2.7 python-pip

## Use Pip to install virtualenv
### -U updates it if the package is already installed
sudo pip install -U virtualenv

vagrant init ansible/tower
vagrant up --provider virtualbox
vagrant ssh

ansible --version
ansible-config list # 查看配置
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.0.203
```

## 概念

* inventory目录
  - INI格式文件的主机清单，配置管理主机列表
  - 默认情况下，会将 /etc/ansible/hosts 文件作为inventory文件，通过 `ansible -i inventory` 来指定自己定义
  - 参数
    + ansible_host：host域名或者IP地址
    + ansible_port：ssh到远程机器的端口
    + ansible_user： ssh到远程机器的默认用户名，会被playbook中的remote_user替代
    + ansible_become：是否已另一个用户执行ansible，默认的用户为root
    + ansible_ssh_host ansible通过ssh连接的IP或者FQDN
    + ansible_ssh_port SSH连接端口
    + ansible_ssh_user  默认SSH连接用户
    + ansible_ssh_pass SSH连接的密码（这是不安全的，ansible极力推荐使用--ask-pass选项或使用SSH keys）
    + ansible_sudo_pass sudo用户的密码
    + ansible_ssh_private_key_file：ssh到远程机器时所使用的密钥
    + ansible_connection SSH连接的类型：local,ssh,paramiko，在ansible 1.2之前默认是paramiko，后来智能选择，优先使用基于ControlPersist的ssh（支持的前提）
    + ansible_shell_type 指定主机所使用的shell解释器，默认是sh，你可以设置成csh, fish等shell解释器
    + ansible_python_interpreter 用来指定python解释器的路径
    + `ansible\_\*\_interpreter` 用来指定主机上其他语法解释器的路径，例如ruby，perl等
  - 可以定义 `/etc/ansible/host_vars` 和 `/etc/ansible/group_vars`目录，来根据主机和组来定义变量，使得变量更加灵活
* role.yml文件：一个入口文件，ansible-playbook命令可以通过-e传入参数到role.yml里面，然后role.yml根据传入的参数，执行对应的roles文件夹里面的项目: 例子：`ansible-playbook -i inventory -e target=all -e role=ping role.yml` 上面的命令，表示读取inventory文件夹里面的hosts，把role.yml里面的target替换成all，把role替换成ping，来进行执行。
* roles目录:把不同的操作按子目录进行分离，通过上面的role传入的参数，选择对应名称的子目录，比如上面role=ping，则就在下面找到ping的目录，进行后续对应的操作。在每个子目录中（eg： files，handlers等等），Ansible将自动搜索并读取叫做main.yml的yaml文件
  - rolename
    + files：要复制到我们的服务器中的文件
    + meta：ain.yml文件包含Role元数据，包含的依赖关系。如果这个角色依赖于另一个角色，可以在这里定义
    + templates：包含.j2后缀的模板文件
    + vars：包含一个main.yml文件，列出将要使用的所有变量
    - tasks  表示执行的任务，运行的主文件是tasks/main.yml文件
        + tasks是从上到下顺序执行，如果中间发生错误，那么整个playbook会中止。你可以改修文件后，再重新执行。
        + 每一个task的对module的一次调用。使用不同的参数和变量而已。
        + 每一个task最好有name属性，这个是供人读的，没有实际的操作。然后会在命令行里面输出，提示用户执行情况。
    - handlers  表示相应的事件，必须包含main.yml文件
        + Handlers里面的每一个handler，也是对module的一次调用。而handlers与tasks不同，tasks会默认的按定义顺序执行每一个task，handlers则不会，它需要在tasks中被调用，才有可能被执行。
        + Tasks中的任务都是有状态的，changed或者ok。 在Ansible中，只在task的执行状态为changed的时候，才会执行该task调用的handler，这也是handler与普通的event机制不同的地方。
        + templates  表示模版文件，模版中可以使用对应的变量，读取vars里面的变量
        + vars   表示变量文件，可以定义变量
        + files   定义文件
* Playbooks:将大量命令行配置集成到一起形成一个可定制的多主机配置管理部署工具，模块组织结构清晰，由ansible自动执行
  - 运行剧本时的第一行总是“收集事实”，收集有关其配置的系统的信息，这些被称为事实
    + `ansible -m setup --connection=local localhost`
    + `ansible -i ./hosts remote -m setup`
* 目录
  - defaults: This directory lets you set default variables for included or dependent roles. Any defaults set here can be overridden in playbooks or inventory files.
  - files: This directory contains static files and script files that might be copied to or executed on a remote server.
  - handlers: All handlers that were in your playbook previously can now be added into this directory.
  - meta: This directory is reserved for role metadata, typically used for dependency management.. For example, you can define a list of roles that must be applied before the current role is invoked.
  - templates: This directory is reserved for templates that will generate files on remote hosts. Templates typically use variables defined on files located in the vars directory, and on host information that is collected at runtime.
  - tasks: This directory contains one or more files with tasks that would normally be defined in the tasks section of a regular Ansible playbook. These tasks can directly reference files and templates contained in their respective directories within the role, without the need to provide a full path to the file.
  - vars: Variables for a role can be specified in files inside this directory and then referenced elsewhere in a role.

```sh
# ansible.cfg
[defaults]
inventory=/etc/ansible/inventorys/        /**放置节点服务器名目录**/
remote_user = czp               /**免密节点服务器用户名**/

## /etc/ansible/hosts
[load_balancer]
nginx ansible_host=192.168.4.2 ansible_port=22 ansible_user=vagrant

[server]
server-node1 ansible_host=192.168.4.3 ansible_port=22 ansible_user=vagrant
server-node2 ansible_host=192.168.4.4 ansible_port=22 ansible_user=vagrant



/etc/ansible/
├── ansible.cfg
├── group_vars
│   ├── nginx01
│   └── nginx02
├── hosts
├── hosts.bak
├── roles
│   ├── base_env
│   │   ├── files
│   │   │   ├── epel.repo
│   │   │   └── RPM-GPG-KEY-EPEL-6
│   │   └── tasks
│   │       └── main.yml
│   ├── nginx01
│   │   ├── tasks
│   │   │   └── main.yml
│   │   └── templates
│   │       └── nginx.conf
│   └── nginx02
│       ├── tasks
│       │   └── main.yml
│       └── templates
│           └── nginx.conf
└── site.yml

# /etc/ansible/hosts
[web]
192.168.22.10
192.168.22.11
[test]
jenkis236 ansible_ssh_port=22 ansible_ssh_host=192.168.1.236
[database]
db-[a:f].lightcloud.com
[webservers]
client01.example.com
client02.example.com
[nginx01]
client01.example.com
[nginx02]
client02.example.com

# 定义变量
# /etc/ansible/group_vars/nginx01
worker_processes: 4
num_cpus: 4
max_open_file: 65506
root: /data
remote_user: root
# /etc/ansible/group_vars/nginx02
worker_processes: 2
num_cpus: 2
max_open_file: 35506
root: /www
remote_user: root

# roles入口文件 /etc/ansible/site.yml
- hosts: webservers
  roles:
  - base_env
- hosts: nginx01
  roles:
  - nginx01
- hosts: nginx02
  roles:
  - nginx02

# 全局role base_env /etc/ansible/roles/base_env/tasks/main.yml
# 将EPEL的yum源配置文件传送到客户端
- name: Create the contains common plays that will run on all nodes
  copy: src=epel.repo dest=/etc/yum.repos.d/epel.repo
- name: Create the GPG key for EPEL
  copy: src=RPM-GPG-KEY-EPEL-6 dest=/etc/pki/rpm-gpg

# 关闭SELINUX
- name: test to see if selling is running
  command: getenforce
  register: sestatus
  changed_when: false

# 删除iptables默认规则并保存
- name: remove the default iptables rules
  command: iptables -F
- name: save iptables rules
  command: service iptables save

# 需要拷贝到远程的文件复制到base_env/files目录
mkdir -p  /etc/ansible/roles/base_env/files
cp /etc/yum.repos.d/epel.repo /etc/ansible/roles/base_env/files
cp /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6 /etc/ansible/roles/base_env/files

# 定义nginx01和ngnix02 role
mkdir -p /etc/ansible/roles/nginx{01,02}/tasks
# /etc/ansible/roles/nginx01/tasks/main.yml
# 安装nginx最新版本
- name: ensure nginx is at the latest version
  yum: pkg=nginx state=latest

# 将nginx配置文件传送到远程目录
- name: write the nginx config file
  template: src=nginx.conf dest=/etc/nginx/nginx.conf
  notify: restart nginx # 重启nginx

# 创建nginx根目录
- name: Create Web Root
  file: dest={{ root }} mode=775 state=directory owner=nginx group=nginx
  notify: reload nginx
- name: ensure nginx is running
  service: name=nginx state=restarted
cp /home/ansible/roles/nginx01/tasks/main.yml /home/ansible/roles/nginx02/tasks/main.yml

# mkdir -p /etc/ansible/roles/nginx{01,02}/templates
# /etc/ansible/roles/nginx01/templates/nginx.conf
user              nginx;
worker_processes  {{ worker_processes }};
{% if num_cpus == 2 %}
worker_cpu_affinity 01 10;
{% elif num_cpus == 4 %}
worker_cpu_affinity 1000 0100 0010 0001;
{% elif num_cpus >= 8 %}
worker_cpu_affinity 00000001 00000010 00000100 00001000 00010000 00100000 01000000 10000000;
{% else %}
worker_cpu_affinity 1000 0100 0010 0001;
{% endif %}
worker_rlimit_nofile {{ max_open_file }};

error_log  /var/log/nginx/error.log;
#error_log  /var/log/nginx/error.log  notice;
#error_log  /var/log/nginx/error.log  info;

pid        /var/run/nginx.pid;

events {
    worker_connections  {{ max_open_file }};
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    # Load config files from the /etc/nginx/conf.d directory
    # The default server is in conf.d/default.conf
    #include /etc/nginx/conf.d/*.conf;
    server {
        listen       80 default_server;
        server_name  _;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   {{ root }};
            index  index.html index.htm;
        }

        error_page  404              /404.html;
        location = /404.html {
            root   /usr/share/nginx/html;
        }

        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/share/nginx/html;
        }

    }
}
cp /etc/ansible/roles/nginx01/templates/nginx.conf  /etc/ansible/roles/nginx02/templates/nginx.conf

ansible-playbook -i /etc/ansible/hosts /etc/ansible/site.yml -f 10 # -f 为启动10个并行进程执行playbook, -i 定义inventory host文件, site.yml 为入口文件

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
     notify:
      - Start Nginx

  handlers:
   - name: Start Nginx
     service:
       name: nginx
       state: started

ansible-playbook -i ./hosts nginx.yml

---
# Example shows using the local machine still
# Remove 'connection' and set hosts to 'remote' for a remote connection
- hosts: local
  connection: local
  become: yes
  become_user: root
  vars:
   - docroot: /var/www/serversforhackers.com/public
  tasks:
   - name: Add Nginx Repository
     apt_repository:
       repo: ppa:nginx/stable
       state: present
     register: ppastable

   - name: Install Nginx
     apt:
       pkg: nginx
       state: installed
       update_cache: true
     when: ppastable|success
     notify:
      - Start Nginx

   - name: Create Web Root
     file:
      path: '{{ docroot }}'
      mode: 775
      state: directory
      owner: www-data
      group: www-data
     notify:
      - Reload Nginx

  handlers:
   - name: Start Nginx
     service:
       name: nginx
       state: started

    - name: Reload Nginx
      service:
        name: nginx
        state: reloaded

- hosts: all
  become: true
  vars:
    doc_root: /var/www/example
  tasks:
    - name: Update apt
      apt: update_cache=yes

    - name: Install Apache
      apt: name=apache2 state=latest

    - name: Create custom document root
      file: path={{ doc_root }} state=directory owner=www-data group=www-data

    - name: Set up HTML file
      copy: src=index.html dest={{ doc_root }}/index.html owner=www-data group=www-data mode=0644

    - name: Set up Apache virtual host file
      template: src=vhost.tpl dest=/etc/apache2/sites-available/000-default.conf
      notify: restart apache

  handlers:
    - name: restart apache
      service: name=apache2 state=restarted
```

## 语法

* template

```
## loop
- name: Install Packages
  apt: name={{ item }} state=latest
  with_items:
     - vim
     - git
     - curl

- hosts: all
  become: true
  vars:
     packages: [ 'vim', 'git', 'curl' ]
  tasks:
     - name: Install Package
       apt: name={{ item }} state=latest
       with_items: "{{ packages }}"

- name: Shutdown Debian Based Systems
  command: /sbin/shutdown -t now
  when: ansible_os_family == "Debian"

## conditions
- name: Check if PHP is installed
  register: php_installed
  command: php -v
  ignore_errors: true

- name: This task is only executed if PHP is installed
  debug: var=php_install
  when: php_installed|success

- name: This task is only executed if PHP is NOT installed
  debug: msg='PHP is NOT installed'
  when: php_installed|failed
```

### 常用模块及API

* 参数
  - -i PATH --inventory=PATH 指定host文件的路径，默认是/etc/ansible/hosts
  - remote，local，all 使用这个标签的下定义的服务器hosts清单文件。“all”是针对文件中定义的每个服务器运行的特殊关键字
  - -m ping  使用“ping”模块，它只是运行ping命令并返回结果
  - -c local| --connection=local 在本地服务器上运行命令，而不是SSH 建立连接的类型，一般有ssh ，local
  - --private-key=PRIVATE_KEY_FILE_PATH 使用指定路径的秘钥建立认证连接
  - -m DIRECTORY --module-path=DIRECTORY 指定module的目录来加载module，默认是/usr/share/ansible
  - -b| --become-user=root - “成为”，在运行命令时告诉可以成为另一个用户。 以用户“root”运行以下命令（例如，使用命令使用“sudo”）
* 模块（Modules），使用可用的上下文（“Facts”），以便确定要完成任务需要做什么操作
  - command: 执行远程主机SHELL命令
  - script: 远程执行MASTER本地SHELL脚本.(类似scp+shell)
  - copy：实现主控端向目标主机拷贝文件, 类似scp功能
  - stat：获取远程文件状态信息, 包括atime, ctime, mtime, md5, uid, gid等信息
  - get_url:实现在远程主机下载指定URL到本地
  - yum:Linux包管理平台操作, 常见都会有yum和apt, 此处会调用yum管理模式
  - cron:远程主机crontab配置
  - service:远程主机系统服务管理
  - user:用户管理

```sh
ansible all -m ping --ask-pass # 管理主机测试
ansible -i ./hosts --connection=local local -m ping

ansible -i ./hosts --connection=local local -m ping
ansible -i ./hosts local --connection=local -b --become-user=root  -m shell -a 'apt-get install nginx'

ansible -i ./hosts remote -b --become-user=root all -m shell -a 'apt-get install nginx'

ansible all -i /Users/jenkins/jenkins/lirbary/ansible_hosts/hosts_test -m command -a "ifconfig"
ansible test -i /Users/jenkins/jenkins/lirbary/ansible_hosts/hosts_test -m script -a "../Env_update_shell/test.sh"
ansible test -i /Users/jenkins/jenkins/lirbary/ansible_hosts/hosts -m copy -a "src=~/test.sh dest=/tmp/ owner=root group=root mode=0755"
ansible test -i /Users/jenkins/jenkins/lirbary/ansible_hosts/hosts_test -m stat -a "path=/Users/jenkins/jenkins/"

ansible test -i /Users/jenkins/jenkins/lirbary/ansible_hosts/hosts_test -m get_url -a "url=http://www.cnblogs.com/yatho dest=/tmp/index.html mode=0400 force=yes"
ansible servers -m yum -a "name=curl state=latest"
ansible webservers -m cron -a "name='check dir' hour='5,2' job='ls -alh > /dev/null'"

ansible webservers -m service -a "name=crond state=stopped"
ansible webservers -m service -a "name=crond state=restarted"
ansible webservers -m service -a "name=crond state=reloaded"

ansible webservers -m user -a "name=johnd comment='John Doe'" # 添加用户
ansible webservers -m user -a "name=johnd state=absent remove=yes" # 删除用户
```

## ansible-vault

* Vault允许加密任何Yaml文件，通常将其作用与变量文件，Vault不会加密文件和模板，只能使用Yaml文件
* 在创建加密文件时，系统会询问您必须使用的密码，以便稍后在调用角色或Playbook时进行编辑。 将密码保存在安全的地方 `ansible-vault create vars/main.yml`

## [ansible-galaxy](https://galaxy.ansible.com/docs/)

## Usage

* [leucos/ansible-tuto](https://github.com/leucos/ansible-tuto):Ansible tutorial
* [geerlingguy/ansible-vagrant-examples](https://github.com/geerlingguy/ansible-vagrant-examples)
* [ansible-for-devops](https://github.com/geerlingguy/ansible-for-devops)
* [ansible/ansible-container](https://github.com/ansible/ansible-container)
* [ansible/ansible-examples](https://github.com/ansible/ansible-examples): A few starter examples of ansible playbooks, to show features and how they work together. See http://galaxy.ansible.com for example roles from the Ansible community for deploying many popular applications.

## 参考

* [文档](http://docs.ansible.com/ansible/latest/intro_installation.html)
* [Ansible中文权威指南](http://www.ansible.com.cn/?wztf_magedu)
* [非常好的Ansible入门教程](https://blog.csdn.net/pushiqiang/article/details/78126063)
* [An Ansible2 Tutoria](https://serversforhackers.com/c/an-ansible2-tutorial)
* [模块](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html)
* 博文： https://www.redhat.com/en/blog/integrating-ansible-jenkins-cicd-process
* https://linux.cn/article-4215-1.html
