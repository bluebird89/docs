# [ansible](https://github.com/ansible/ansible)

<https://www.ansible.com>

* 一款开源的、功能强大的IT自动化工具，常用于软件部署、系统配置、运维管理等应用场景
* 不需要一个唯一的中控节点。通过可编辑的Inventory文件形式来保存节点信息，任意一台可运行Ansible的主机均可以作为管理节点来进行策略的执行
* 采取了agentless的理念，通过SSH的方式来实现管理节点与被管理节点的通信，而不需要在被管理节点上安装额外的通信媒介，简化的同时也确保了通信的安全
* 设计目标
  - 轻量化。管理系统不应该要求环境搭载附加依赖。
  - 一致性。借助Jinja的模板化、合理的任务执行策略，使用Ansible应当能够搭建高一致性的环境。
  - 安全。被管理节点无需配置agent，仅需要其支持OpenSSH与Python即可。
  - 可靠性。一个编写规范的Ansible Playbook应当具有幂等性，避免在管理节点过程中出现意料之外的行为。
  - 易上手。由于Playbook基于YAML和Jinja template编写实现，学习成本低

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

sudo yum install ansible
wget https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.9.9-1.el7.ans.noarch.rpm -O ansible.rpm
sudo yum localinstall ansible.rpm
```

## 概念

* 模块（Modules）
  - Ansible执行命令或者Playbook时实际调用的即模块，执行某个模块实际上是在目标机上执行，Ansible控制机连接被控制节点，分发模块的执行脚本，执行完成后删除，最后获取返回结果，以此得以在远程主机上执行特定任务。用户可以按照自己的需求自己编写模块使用。
* 插件（Plugins）
  - Ansible的核心功能主要由插件提供，相对于模块在远程主机上执行，插件则是在控制机上执行，负责诸如数据变形、日志输出、连接远程Inventory等工作。用户同样被允许自定义编写插件
* Control Node
  - 任何安装了Ansible的（非Windows）机器都可以作为控制节点（Control Node），通过调用/usr/bin/ansible执行命令或调用/usr/bin/ansible-playbook执行playbook来管理被管理主机（Managed Nodes）。
  - 允许有多个控制节点，多个控制节点间的配置（如Inventory和Playbook）同步，可以通过一个统一的远程仓库管理实现
* Managed Nodes
  - 利用Ansible管理的网络设备、服务器称作被管理节点（Managed Nodes），或者简称主机（hosts）
  - 在这些设备上无需安装Ansible，只需其能够与控制节点建立ssh连接，即可实现设备的“被管理”
* inventory
  - Ansible用一个Inventory文件来描述、存放被管理节点信息
  - 可以在Inventory文件中组织被管理节点的拓扑结构、进行分组，以便轻松实现扩缩容 scaling
  - 默认情况下，会将 /etc/ansible/hosts 文件作为inventory文件，通过 `ansible -i inventory` 来指定自己定义
  - 用[]括起来的是组名，用以将不同主机分类分组。Ansible规定了两个默认组
    + all组包含了所有的主机
    + ungrouped组则包含所有未显式分组的主机
  - 别名用来标识一台主机
  - 变量则用来指定主机对应的一些属性，变量可以是Ansible内置变量，也可以是自定义的变量以在后续的playbook中使用
  - 支持一次性给一个组里的所有主机赋值变量
  - 参数
    + ansible_host：host域名或者IP地址
    + ansible_port：ssh到远程机器的端口
    + ansible_user： ssh到远程机器的默认用户名，会被playbook中的remote_user替代
    + ansible_become：是否已另一个用户执行ansible，默认的用户为root
    + ansible_ssh_host ansible通过ssh连接的IP或者FQDN
    + ansible_ssh_port SSH连接端口
    + ansible_ssh_user  默认SSH连接用户
    + ansible_ssh_pass SSH连接的密码（这是不安全的，ansible极力推荐使用--ask-pass选项或使用SSH keys）
    + ansible_sudo_pass sudo用户密码
    + ansible_ssh_private_key_file：ssh到远程机器时所使用的密钥
    + ansible_connection SSH连接类型
      * local
      * ssh
      * paramiko
      * ansible 1.2之前默认是paramiko，后来智能选择，优先使用基于ControlPersist的ssh（支持的前提）
    + ansible_shell_type 指定主机所使用的shell解释器，默认是sh，你可以设置成csh, fish等shell解释器
    + ansible_python_interpreter 用来指定python解释器的路径
    + `ansible_*_interpreter` 指定主机上其他语法解释器的路径，例如ruby，perl等
  - 不再inventory文件中存储变量，而是存于 `/etc/ansible/host_vars` 和 `/etc/ansible/group_vars`文件夹下，ansible会自动应用文件夹中的主机和组来定义变量
  - 如果同时inventory和playbook所在文件夹同时有host_vars/group_vars，那么playbook的会覆盖inventory的
  - 变量可以存在于多个地方，但是在ansible运行时，所有地方的变量将针对于某个host机器进行合并。基于group和host的变量通过以下顺序进行覆盖，后面的覆盖前面的
    + all group (because it is the ‘parent’ of all other groups)
    + parent group
    + child group
    + host
* role.yml文件：一个入口文件，ansible-playbook命令可以通过-e传入参数到role.yml里面，然后role.yml根据传入的参数，执行对应的roles文件夹里面的项目
  - `ansible-playbook -i inventory -e target=all -e role=ping role.yml`:读取inventory文件夹里面的hosts，把role.yml里面的target替换成all，把role替换成ping，来进行执行
  - roles目录:把不同的操作按子目录进行分离，通过上面的role传入的参数，选择对应名称的子目录，比如上面role=ping，则就在下面找到ping的目录，进行后续对应的操作。在每个子目录中（eg： files，handlers等等），Ansible将自动搜索并读取叫做main.yml的yaml文件
    + defaults: This directory lets you set default variables for included or dependent roles. Any defaults set here can be overridden in playbooks or inventory files.
    + files: This directory contains static files and script files that might be copied to or executed on a remote server. 要复制到服务器中的文件
    + handlers: All handlers that were in your playbook previously can now be added into this directory.表示相应的事件，必须包含main.yml文件 Handlers里面的每一个handler，也是对module的一次调用。而handlers与tasks不同，tasks会默认的按定义顺序执行每一个task，handlers则不会，它需要在tasks中被调用，才有可能被执行。
    + meta: This directory is reserved for role metadata, typically used for dependency management.. For example, you can define a list of roles that must be applied before the current role is invoked. 文件包含Role元数据，包含的依赖关系。如果这个角色依赖于另一个角色，可以在这里定义
    + templates: This directory is reserved for templates that will generate files on remote hosts. Templates typically use variables defined on files located in the vars directory, and on host information that is collected at runtime. 表示模版文件，模版中可以使用对应的变量，读取vars里面的变量
    + tasks: This directory contains one or more files with tasks that would normally be defined in the tasks section of a regular Ansible playbook. These tasks can directly reference files and templates contained in their respective directories within the role, without the need to provide a full path to the file.表示执行的任务，运行的主文件是tasks/main.yml文件
      * tasks 是从上到下顺序执行，如果中间发生错误，那么整个playbook会中止。你可以改修文件后，再重新执行。
      * 每一个task的对module的一次调用。使用不同的参数和变量而已。
      * 每一个task最好有name属性，这个是供人读的，没有实际的操作。然后会在命令行里面输出，提示用户执行情况。
      * Tasks中的任务都是有状态的，changed或者ok。 在Ansible中，只在task的执行状态为changed的时候，才会执行该task调用的handler，这也是handler与普通的event机制不同的地方。
    + vars: Variables for a role can be specified in files inside this directory and then referenced elsewhere in a role. 包含一个main.yml文件，列出将要使用的所有变量
* 动态Inventory的配置方式
  - Inventory Plugins
  - Inventory Scripts
  - 原理是从某个源获取到关于主机的信息，进而动态地生成Inventory文件，保证生成结果中的主机信息都是最新且有效的
* Tasks
  - 一个任务（Task），是Ansible所执行动作的最小单位。根据需求的不同，可以把一个或多个任务串在一个playbook顺序执行，也可以通过单次调用/usr/bin/ansible执行某个任务
* Playbooks
  - 一个Playbook由用户以YAML格式文件的形式编写,可以包含变量，由于使用YAML来编写，其具有着易读、易写、易共享、易理解的特点
    + 可以在其中按人为顺序组织完成一个大型任务所需要的各个子任务,运行一个playbook将会按顺序执行其中的所有任务
    + 允许不同的任务步骤在不同的主机间按特定顺序相互跳转；任务的执行同时支持同步和异步两种方式
  - 运行剧本时第一行总是“收集事实”，收集有关其配置的系统的信息，这些被称为事实
    + `ansible -m setup --connection=local localhost`
    + `ansible -i ./hosts remote -m setup`
    + `ansible-playbook playbook.yml`
  - 参数
    + -m 跟一个模块名
  - 借助Ansible内置关键字，可以不用写任何的实际命令，只需传入几个参数，就可以令Ansible自动生成并完成理想的任务
  - 在某些场景下，任务的执行并不是顺序的，而是依赖事件响应的
    + notify关键字指定了当目标配置文件发生改变时，应该响应任务进行执行动作,notify下的任务动作不应放在tasks栏下，因为它们有个专门的称呼：handlers，用以区分顺序执行的任务和事件响应式执行的任务

```sh
# /etc/ansible/ansible.cfg
[defaults]
inventory=/etc/ansible/inventorys/
remote_user = czp

## /etc/ansible/hosts
[load_balancer]
nginx ansible_host=192.168.4.2 ansible_port=22 ansible_user=vagrant

[server]
server-node1 ansible_host=192.168.4.3 ansible_port=22 ansible_user=vagrant
server-node2 ansible_host=192.168.4.4 ansible_port=22 ansible_user=vagrant

[test]
jenkis236 ansible_ssh_port=22 ansible_ssh_host=192.168.1.236

[database]
db-[a:f].lightcloud.com

## /etc/ansible/group_vars/nginx01
worker_processes: 4
num_cpus: 4
max_open_file: 65506
root: /data
remote_user: root

## roles入口文件 /etc/ansible/site.yml
- hosts: webservers
  roles:
  - base_env
- hosts: nginx01
  roles:
  - nginx01
- hosts: nginx02
  roles:
  - nginx02
## roles入口文件 /etc/ansible/site.yml

## 全局role base_env /etc/ansible/roles/base_env/tasks/main.yml
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
## 全局role base_env /etc/ansible/roles/base_env/tasks/main.yml

# 拷贝到远程的文件复制到base_env/files目录
mkdir -p  /etc/ansible/roles/base_env/files
cp /etc/yum.repos.d/epel.repo /etc/ansible/roles/base_env/files
cp /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6 /etc/ansible/roles/base_env/files

# 定义nginx01和ngnix02 role
mkdir -p /etc/ansible/roles/nginx{01,02}/tasks
## /etc/ansible/roles/nginx01/tasks/main.yml
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
## /etc/ansible/roles/nginx01/tasks/main.yml

cp /home/ansible/roles/nginx01/tasks/main.yml /home/ansible/roles/nginx02/tasks/main.yml

# mkdir -p /etc/ansible/roles/nginx{01,02}/templates
## /etc/ansible/roles/nginx01/templates/nginx.conf
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
## /etc/ansible/roles/nginx01/templates/nginx.conf

cp /etc/ansible/roles/nginx01/templates/nginx.conf  /etc/ansible/roles/nginx02/templates/nginx.conf
```

## 命令

* 参数
  - -i inventory.ini表示使用当前路径下的inventory.ini作为inventory文件
  - node1表示在node1这台机器上执行ansible指令，node1需要在inventory.ini中存在
  - -m command表示在node1机器上执行command模块，默认即为command模块
  - -a "whoami" 模块参数，与-m配合使用
  - -u aUser表示ansible通过aUser用户登录远程机器，默认使用本机当前用户
  - --private-key key/ansible_id_rsa表示在用aUser登录是使用指定的密钥文件
  - -k表示在用aUser登录时提示输入aUser的密码，通常的做法是-k和--private-key任选其一，但是如果同时使用了两者，那么-k生效。
  - -b表示登录之后变成另外一个用户执行ansible指令
  - --become-user user0表示在-b的情况下要变成哪个用户，默认为root用户
  - --become-method sudo 表示通过什么方式变为那个用户，默认为sudo，也可以指定su等
  - -K表示需要变成用户时需要提示输入密码，对于become-method=sudo来说，如果user0已经有免密执行sudo的权限，那么便没有必要配置-K，否则反而会让你输入密码
  - -i PATH --inventory=PATH 指定host文件的路径，默认是/etc/ansible/hosts
  - remote，local，all 使用这个标签的下定义的服务器hosts清单文件。“all”是针对文件中定义的每个服务器运行的特殊关键字
  - -m ping  使用“ping”模块，它只是运行ping命令并返回结果
  - -c local|--connection=local 在本地服务器上运行命令，而不是SSH 建立连接的类型，一般有ssh ，local
  - --private-key=PRIVATE_KEY_FILE_PATH 使用指定路径的秘钥建立认证连接
  - -m DIRECTORY --module-path=DIRECTORY 指定module的目录来加载module，默认是/usr/share/ansible
  - -b|--become-user=root - “成为”，在运行命令时告诉可以成为另一个用户。 以用户“root”运行以下命令（例如，使用命令使用“sudo”）
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
ansible all -m ping # 检查所有机器是否能ping通
ansible -i inventory.ini node1 -m command -a "whoami"  -u aUser --private-key key/ansible_id_rsa  -k  -b --become-user user0 --become-method sudo -K  # 用ansible在远程机器上执行whoami命令

ansible all -m ping --ask-pass # 管理主机测试
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

ansible webservers -m service -a "name=crond state=stopped|restarted|reloaded"

ansible webservers -m user -a "name=johnd comment='John Doe'" # 添加用户
ansible webservers -m user -a "name=johnd state=absent remove=yes" # 删除用户
```

## ansible-playbook

* `ansible-playbook [options] playbook.yml [playbook2 ...]`
* 参数：
  - -b：启用become
  - -become_user：指定运行指令的用户，默认为root
  - -u：指定ssh登录用户
  - --private-key：指定登录用户的密钥文件
  - -i：指定inentory文件
  - --vault-password-file：指定vault的密码文件
  - --list-hosts：输出命中的host列表
* 变量处理:可以在多个地方声明ansible所使用的变量，优先级从高到低：
  - 运行ansible-playbook命令时的命令行参数
  - playbook文件
  - inventory文件

```sh
- hosts: all
  remote_user: root
  vars:
    favcolor: blue
  vars_files:
    - /vars/external_vars.yml

  tasks:
  - name: this is just a placeholder
    command: /bin/echo foo

ansible-playbook -i /etc/ansible/hosts /etc/ansible/site.yml -f 10 # -f 为启动10个并行进程执行playbook, -i 定义inventory host文件, site.yml 为入口文件


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

ansible-playbook -i ./hosts nginx.yml

#####
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
#####
```

## template

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

## 最佳实践

```
production                # inventory file for production servers
staging                   # inventory file for staging environment

group_vars/
   group1                 # here we assign variables to particular groups
   group2                 # ""
   atlanta.yaml
host_vars/
   hostname1              # if systems need specific variables, put them here
   hostname2              # ""

library/                  # if any custom modules, put them here (optional)
module_utils/             # if any custom module_utils to support modules, put them here (optional)
filter_plugins/           # if any custom filter plugins, put them here (optional)

site.yml                  # master playbook
webservers.yml            # playbook for webserver tier
dbservers.yml             # playbook for dbserver tier

roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/
```

## ansible-vault

* 用于加密一些yaml格式的变量文件，比如host_vars和group_vars文件夹下的文件等，而不会加密Role中的文件或者模板，只能使用Yaml文件
* 在创建加密文件时，系统会询问您必须使用的密码，以便稍后在调用角色或Playbook时进行编辑。 将密码保存在安全的地方 `ansible-vault create vars/main.yml`

```sh
ansible-vault create foo.yml # 创建
ansible-vault edit foo.yml # 编辑
ansible-vault encrypt｜decrypt foo.yml # 编辑加解密文件
ansible-vault view foo.yml # 查看
```

## [ansible-galaxy](https://galaxy.ansible.com/docs/)

```sh
ansible-galaxy init my-role  # 创建一个role
```

## 工具

* [deploy](https://github.com/ansistrano/deploy#installation):Ansible role to deploy scripting applications like PHP, Python, Ruby, etc. in a capistrano style <https://ansistrano.com>

## 参考

* [文档](http://docs.ansible.com/ansible/latest/)
* [Ansible中文权威指南](http://www.ansible.com.cn/)
* [ansible-tuto](https://github.com/leucos/ansible-tuto):Ansible tutorial
* [ansible-examples](https://github.com/ansible/ansible-examples): A few starter examples of ansible playbooks, to show features and how they work together. See <http://galaxy.ansible.com> for example roles from the Ansible community for deploying many popular applications.
* [ansible-for-devops](https://github.com/geerlingguy/ansible-for-devops)
* [ansible-container](https://github.com/ansible/ansible-container)

* <https://www.redhat.com/en/blog/integrating-ansible-jenkins-cicd-process>
* <https://linux.cn/article-4215-1.html>
* [非常好的Ansible入门教程](https://blog.csdn.net/pushiqiang/article/details/78126063)
* [An Ansible2 Tutoria](https://serversforhackers.com/c/an-ansible2-tutorial)
