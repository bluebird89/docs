# [gunicorn](https://github.com/benoitc/gunicorn)

gunicorn 'Green Unicorn' is a WSGI HTTP Server for UNIX, fast clients and sleepy applications. <http://www.gunicorn.org>

## 原理

pre-fork模型中

* master（gunicorn 中Arbiter）会fork出指定数量的worker进程
* worker进程在同样的端口上监听，谁先监听到网络连接请求，谁就提供服务，这也是worker进程之间的负载均衡。

## 使用

```sh
cd ~/myproject
gunicorn --bind 0.0.0.0:8000 myproject.wsgi # 不是实体配置文件
deactivate

sudo nano /etc/systemd/system/gunicorn.service

[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=sammy
Group=www-data
WorkingDirectory=/home/sammy/myproject
ExecStart=/home/sammy/myproject/myprojectenv/bin/gunicorn --access-logfile - --workers 3 --bind unix:/home/sammy/myproject/myproject.sock myproject.wsgi:application

[Install]
WantedBy=multi-user.target

## 服务重启
sudo systemctl start gunicorn
sudo systemctl enable gunicorn

## Check for the Gunicorn Socket File
sudo systemctl status gunicorn
ls /home/sammy/myproject

sudo journalctl -u gunicorn

sudo systemctl daemon-reload
sudo systemctl restart gunicorn

# Configure Nginx to Proxy Pass to Gunicorn
sudo nano /etc/nginx/sites-available/myproject

server {
    listen 80;
    server_name server_domain_or_IP;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/sammy/myproject;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/sammy/myproject/myproject.sock;
    }
}

sudo ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled

sudo systemctl restart nginx

sudo ufw delete allow 8000
sudo ufw allow 'Nginx Full'

sudo tail -F /var/log/nginx/error.log
```
