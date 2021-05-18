# Ecshop

* Update
  - appserver: use api to communicate with client
  - PC

## Install

* check_file.php: check and update
* domain
  - api.domain.com
  - www.domain.com

```sh
# nginx
chown -R www:www appserver/ ecshop/

chown -R apache:apache appserver/ ecshop/

LodaModule rewrite module modules/mod_rewrite.so

<VirtualHost *:80>
DocumentRoot "/data/httpd/ecshop/"
ServerName www.ecshopdemo.com
<Directory "/data/httpd/ecshop/">
    SetOutputFilter DEFLATE
    Options FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
    DirectoryIndex index.html index.php
RewriteEngine on
# Don't rewrite files or directories
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]
# Rewrite everything else to index.html to allow html5 state links
RewriteRule ^ index.php [L]
</Directory>
</VirtualHost>
</VirtualHost>

<VirtualHost *:80>
DocumentRoot "/data/httpd/appserver/public"
ServerName api.ecshopdemo.com
<Directory "/data/httpd/appserver/public">
    SetOutputFilter DEFLATE
    Options FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
    DirectoryIndex index.html index.php
RewriteEngine on
# Don't rewrite files or directories
RewriteCond %{REQUEST_FILENAME} -f [OR]
RewriteCond %{REQUEST_FILENAME} -d
RewriteRule ^ - [L]
# Rewrite everything else to index.html to allow html5 state links
RewriteRule ^ index.php [L]
</Directory>
</VirtualHost>
```
