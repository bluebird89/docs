# [安装](https://gorails.com/setup/ubuntu/14.04)

```sh
# Ubuntu
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0 --default
ruby -v
gem install bundler

# Mac
\curl -sSL https://get.rvm.io | bash -s stable
# rvm 是 Ruby 的版本管理工具，其作用是在系统中安装若干个不同版本的 Ruby，且不让它们之间发生冲突
rvm install 2.3.1
rvm use 2.3.1
rvm uninstall 1.9.2
```

## config git

```sh
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"
ssh-keygen -t rsa -b 4096 -C "YOUR@EMAIL.com"
cat ~/.ssh/id_rsa.pub
add key to github
ssh -T git@github.com # 检测
```

## install rails

```sh
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 5.0.1
rbenv rehash
rails -v
```

### setup mysql

```
sudo apt-get install mysql-server mysql-client libmysqlclient-dev
```

### setting up postgreSQL

```
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.5 libpq-dev
sudo -u postgres createuser chris -s
sudo -u postgres psql
postgres=# \password chris
```

#### first step

```
#### If you want to use SQLite (not recommended)
rails new myapp
```

#### If you want to use MySQL

```
rails new myapp -d mysql
```

#### If you want to use Postgres

# Note that this will expect a postgres user with the same username

# as your app, you may need to edit config/database.yml to match the

# user you created earlier

```
rails new myapp -d postgresql
```

# Move into the application directory

```
cd myapp
```

# If you setup MySQL or Postgres with a username/password, modify the

# config/database.yml file to contain the username/password that you specified

# Create the database

```
rake db:create

rails server
```

## Ruby on Rails

## 资源

* [rails/rails](https://github.com/rails/rails):Ruby on Rails http://rubyonrails.org
* [activeadmin/activeadmin](https://github.com/activeadmin/activeadmin):The administration framework for Ruby on Rails applications. https://activeadmin.info
* [tj/commander](https://github.com/tj/commander):The complete solution for Ruby command-line executables http://visionmedia.github.com/commander
* [discourse/discourse](https://github.com/discourse/discourse):A platform for community discussion. Free, open, simple. https://www.discourse.org