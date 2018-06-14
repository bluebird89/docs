# [django/django](https://github.com/django/django)

The Web framework for perfectionists with deadlines. <https://www.djangoproject.com/>.自身带有轻量级服务器，部署用 Apache with mod_wsgi，每个django项目中可以包含多个APP，相当于一个大型项目中的分系统、子模块、功能部件等等，相互之间比较独立，但也有联系。

## 安装

```sh
git clone https://github.com/django/django.git
cd django
sudo python3 setup.py install  # 会注册脚本django-admin.py

sudo apt-get install python-pip
pip install --upgrade pip
pip install Django[==1.11.3]
```

### 管理命令 django-admin.py

### 项目结构

- Django_app: 项目的容器。
- manage.py: 一个实用的命令行工具，可让你以各种方式与该 Django 项目进行交互。`python3 manage.py runserver 0.0.0.0:8000` 0.0.0.0 让其它电脑可连接到开发服务器
- Django_app/__init__.py: 一个空文件，告诉 Python 该目录是一个 Python 包。
- Django_app/settings.py: 该 Django 项目的设置/配置。
- Django_app/urls.py: 该 Django 项目的 URL 声明; 一份由 Django 驱动的网站"目录"。
- Django_app/wsgi.py: 一个 WSGI 兼容的 Web 服务器的入口，以便运行你的项目。

## 使用

* 建立项目
* 数据库配置
* 数据迁移
* 运行服务
* 进入管理页面：127.0.0.1：8080/admin

```sh
django-admin.py startproject Django_app # 新建项目
python3 manage.py startapp cmdb  # 如果要使用模型，必须要创建一个app
sudo pip3 install mysqlclient #  mysql驱动

cd Django_app

python3 manage.py migrate   # 创建表结构
python3 manage.py makemigrations TestModel  # 让 Django 知道我们在我们的模型有一些变更
python3 manage.py migrate TestModel   # 创建表结构

python3 manage.py runserver
```

```
# 默认sqlite 数据库迁移到mysql:
sudo apt-get install python-mysqldb
# 修改setting.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 数据库名,
        'USER': '用户名',
        'PASSWORD': '密码',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```

## 模版标签

## 服务器搭建

搭建uwsgi

```
[uwsgi]
socket = 127.0.0.1:9090
master = true         # 主进程
vhost = true          # 多站模式
no-site = true        # 多站模式时不设置入口模块和文件
workers = 2           # 子进程数
reload-mercy = 10
vacuum = true         //退出、重启时清理文件
max-requests = 1000
limit-as = 512
buffer-size = 30000
pidfile = /var/run/uwsgi9090.pid    //pid文件，用于下面的脚本启动、停止该进程
daemonize = /website/uwsgi9090.log

server {
    listen       80;
    server_name  localhost;

    location / {
        include  uwsgi_params;
        uwsgi_pass  127.0.0.1:9090;              //必须和uwsgi中的设置一致
        uwsgi_param UWSGI_SCRIPT demosite.wsgi;  //入口文件，即wsgi.py相对于项目根目录的位置，“.”相当于一层目录
        uwsgi_param UWSGI_CHDIR /demosite;       //项目根目录
        index  index.html index.htm;
        client_max_body_size 35m;
    }
}
```

## 问题

```
Requested setting INSTALLED_APPS, but settings are not configured. You must either define the environment variable DJANGO_SETTINGS_MODULE or call settings.configure() before accessing settings.
```

## 资源

* [rosarior/awesome-django](https://github.com/rosarior/awesome-django):

## 工具

* [文档](https://docs.djangoproject.com/en/dev/releases/2.0/)
* [nioperas06/awesome-django-rest-framework](https://github.com/nioperas06/awesome-django-rest-framework):Tools, processes and resources you need to create an awesome API with Django REST Framework
* [django-extensions/django-extensions](https://github.com/django-extensions/django-extensions):This is a repository for collecting global custom management extensions for the Django Framework.
* [jazzband/django-debug-toolbar](https://github.com/jazzband/django-debug-toolbar):A configurable set of panels that display various debug information about the current request/response.
* [divio/django-cms](https://github.com/divio/django-cms):The easy-to-use and developer-friendly CMS http://www.django-cms.org
* [encode/django-rest-framework](https://github.com/encode/django-rest-framework):Web APIs for Django. http://www.django-rest-framework.org
* [Taiga Documentation](http://taigaio.github.io/taiga-doc/dist/#_installation_guide)
* [taigaio/taiga-front](https://github.com/taigaio/taiga-front):Project management web application with scrum in mind! Built on top of Django and AngularJS (Front) http://taiga.io
* [taigaio/taiga-back](https://github.com/taigaio/taiga-back):Project management web application with scrum in mind! Built on top of Django and AngularJS (Backend Code)
* [](https://github.com/django-guardian/django-guardian)
* [](https://github.com/viewflow/django-material)
* [](https://github.com/jcalazan/ansible-django-stack)
