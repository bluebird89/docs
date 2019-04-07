# [django/django](https://github.com/django/django)

The Web framework for perfectionists with deadlines. <https://www.djangoproject.com/>.
自身带有轻量级服务器，部署用 Apache with mod_wsgi，每个django项目中可以包含多个APP，相当于一个大型项目中的分系统、子模块、功能部件等等，相互之间比较独立，但也有联系。

## 安装

```sh
git clone https://github.com/django/django.git
cd django
sudo python3 setup.py install  # 会注册脚本django-admin.py

sudo apt-get install python-pip
pip install --upgrade pip
pip install Django[==1.11.3]

pip install django gunicorn psycopg2
```

## 管理命令 django-admin.py

## 项目结构

* django-admin.py:全局脚本
* manage.py: 一个实用的命令行工具，以各种方式与该 Django 项目进行交互
* Django_app: 项目的容器
    - urls.py: 网址入口，关联到对应的views.py中的一个函数（或generic类）
    - views.py：处理用户发出的请求，与urls.py对应, 通过渲染templates中的网页可以将显示内容
    - models.py：与数据库操作相关，存入或读取数据时用到
    - forms.py：表单，用户在浏览器上输入数据提交，对数据的验证工作以及输入框的生成等工作
    - templates文件夹：views.py中的函数渲染templates中的html模板，得到动态内容的网页，可以用缓存来提高速度。
    - admin.py：后台，可以用很少的代码就拥有一个强大的后台
    - settings.py: Django 的配置文件，如 DEBUG 的开关，静态文件的位置
    - __init__.py: 一个空文件，告诉 Python 该目录是一个 Python 包
    - wsgi.py: 一个 WSGI 兼容的 Web 服务器的入口，以便运行你的项目

## 配置

```sh
# 配置setting.py
#  list the IP addresses or domain names that are associated with your Django server.
ALLOWED_HOSTS = ['your_server_domain_or_IP', 'second_domain_or_IP', . . .]

# mysql:
# sudo apt-get install python-mysqldb
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

# postgresql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'myproject',
        'USER': 'myprojectuser',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '',
    }
}

# add a setting indicating where the static files should be placed. This is necessary so that Nginx can handle requests for these items. 
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static/')
```

## 使用

* 建立项目
* 数据库配置
* 数据迁移
* 运行服务
* 进入管理页面：127.0.0.1：8080/admin

```sh
django-admin.py startproject Django_app ~/myproject # 新建项目

python manage.py startapp cmdb  # 一般一个项目有多个app, 当然通用的app也可以在多个项目中使用
django-admin.py startapp app-name

sudo pip3 install mysqlclient #  mysql驱动

cd Django_app

python manage.py collectstatic

# migrate the initial database schema to our PostgreSQL database using the management script
~/myproject/manage.py makemigrations
~/myproject/manage.py migrate

~/myproject/manage.py createsuperuser # Create an administrative user for the project

python3 manage.py makemigrations TestModel  # 让 Django 知道我们在我们的模型有一些变更
python3 manage.py migrate TestModel   # 创建表结构

python manage.py createsuperuser

# 开启服务
sudo ufw allow 8000
python manage.py runserver 0.0.0.0:8000 # 让其它电脑可连接到服务器，监听机器上所有ip的8000端口，访问时用电脑的ip代替
python manage.py runserver # 在本电脑访问服务器，访问http://server_domain_or_IP:8000
```

## 模版标签

## 服务器搭建

* 静态文件的处理都直接由nginx完成
搭建uwsgi

```
pip install uwsgi

# test.py
def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return b"Hello World"
# 测试 uwsgi
uwsgi --http :8000 --wsgi-file test.py

[uwsgi]
socket = 127.0.0.1:9090 # /tmp/www.wangzhy.com.socket
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

uwsgi --ini uwsgi.ini

server {
    listen       80;
    server_name  localhost;

    location / {
        include  uwsgi_params;
        uwsgi_pass  127.0.0.1:9090;              //必须和uwsgi中的设置一致 unix:/tmp/www.wangzhy.com.socket;
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

## 工具

* [django-extensions/django-extensions](https://github.com/django-extensions/django-extensions):This is a repository for collecting global custom management extensions for the Django Framework.
* [jazzband/django-debug-toolbar](https://github.com/jazzband/django-debug-toolbar):A configurable set of panels that display various debug information about the current request/response.
* [django-guardian/django-guardian](https://github.com/django-guardian/django-guardian):Per object permissions for Django https://django-guardian.readthedocs.io/
* [viewflow/django-material](https://github.com/viewflow/django-material):Material Design for Django http://forms.viewflow.io/
* [jcalazan/ansible-django-stack](https://github.com/jcalazan/ansible-django-stack):Ansible Playbook for setting up a Django app with Nginx, Gunicorn, PostgreSQL, Celery, RabbitMQ, Supervisor, Virtualenv, and Memcached. A Vagrantfile for provisioning a VirtualBox virtual machine is included as well.

## Taiga

* [Taiga Documentation](http://taigaio.github.io/taiga-doc/dist/#_installation_guide)
* [taigaio/taiga-front](https://github.com/taigaio/taiga-front):Project management web application with scrum in mind! Built on top of Django and AngularJS (Front) http://taiga.io
* [taigaio/taiga-back](https://github.com/taigaio/taiga-back):Project management web application with scrum in mind! Built on top of Django and AngularJS (Backend Code)

## 框架

* [encode/django-rest-framework](https://github.com/encode/django-rest-framework):Web APIs for Django. ⚡️ https://www.django-rest-framework.org
* [geex-arts/django-jet](https://github.com/geex-arts/django-jet):Modern responsive template for the Django admin interface with improved functionality http://jet.geex-arts.com/
* [nioperas06/awesome-django-rest-framework](https://github.com/nioperas06/awesome-django-rest-framework):Tools, processes and resources you need to create an awesome API with Django REST Framework
* [divio/django-cms](https://github.com/divio/django-cms):The easy-to-use and developer-friendly CMS http://www.django-cms.org


## 参考

* [rosarior/awesome-django](https://github.com/rosarior/awesome-django):Repository mirror of GitLab: https://gitlab.com/rosarior/awesome-django http://awesome-django.com
* [文档](https://docs.djangoproject.com/en/dev/releases/2.0/)
* [How To Set Up Django with Postgres, Nginx, and Gunicorn on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu-16-04)
* [Python/WSGI 应用快速入门](https://uwsgi-docs-cn.readthedocs.io/zh_CN/latest/WSGIquickstart.html)
