# [ruby/ruby](https://github.com/ruby/ruby)

The Ruby Programming Language https://www.ruby-lang.org/

* Convention over configuration;
* DRY - Don't Repeat You;
* KISS - Keep it simple and stupid;
* Don't reinventing the wheel;
* Optimized for programmer happiness and sustainable productivity

## [安装](https://gorails.com/setup/ubuntu/14.04)

```sh
# Ubuntu 依赖nodejs
sudo apt-get update
# install ruby depency
sudo apt install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
# install the ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

## 更新rbenv
cd ~/.rbenv
git pull

# 卸载 rbenv,屏蔽~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

rm -rf `rbenv root`

## list all the available versions of Ruby
rbenv install -l
rbenv install 2.5.1
#  set it asy our default version of Ruby
rbenv global 2.5.1
#  卸载
rbenv uninstall 2.1.3

ruby -v
# turn off local documentation generation
echo "gem: --no-document" > ~/.gemrc
# Bundler is a tool that manages gem dependencies for projects
gem install bundler
#  learn more about the environment and configuration of gems
gem env home

gem install rails
#  install a specific version of Rails
gem search '^rails$' --all
gem install rails -v 4.2.7
# rbenv works by creating a directory of shims, which point to the files used by the Ruby version that's currently enabled. Through the rehash sub-command, rbenv maintains shims in that directory to match every Ruby command across every installed version of Ruby on your server.
rbenv rehash

rails -v

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0 --default

# Mac
brew install rbenv ruby-build rbenv-default-gems rbenv-gemset
# echo 'eval "$(rbenv init -)"' >> ~/Projects/config/env.sh
rbenv install 2.1.1
rbenv global 2.1.1

# rvm 是 Ruby 的版本管理工具，其作用是在系统中安装若干个不同版本的 Ruby，且不让它们之间发生冲突
curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.3.1
rvm use 2.3.1
rvm uninstall 1.9.2

# Managing gems in application
gem install bundler
echo 'bundler' >> "$(brew --prefix rbenv)/default-gems"

echo 'gem: --no-document' >> ~/.gemrc
```

## install rails

```sh
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
gem install rails -v 5.0.1
rbenv rehash
rails -v
```

### SQL

```sh
#### MySQL
sudo apt-get install mysql-server mysql-client libmysqlclient-dev

#### postgreSQL
sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.5 libpq-dev
sudo -u postgres createuser chris -s
sudo -u postgres psql
postgres=# \password chris

#### If you want to use SQLite (not recommended)
rails new myapp

#### If you want to use MySQL
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

## 包管理

* [Gems](https://rubygems.org):Find, install, and publish RubyGems.

##  项目

* [discourse/discourse](https://github.com/discourse/discourse):A platform for community discussion. Free, open, simple. https://www.discourse.org
* [mame/quine-relay](https://github.com/mame/quine-relay):An uroboros program with 100+ programming languages 

## 工具

* [rbenv/rbenv](https://github.com/rbenv/rbenv):Groom your app’s Ruby environment
* [Bundler](https://bundler.io/)
* [activeadmin/activeadmin](https://github.com/activeadmin/activeadmin):The administration framework for Ruby on Rails applications. https://activeadmin.info
* [tj/commander](https://github.com/tj/commander):The complete solution for Ruby command-line executables http://visionmedia.github.com/commander
* [discourse/discourse](https://github.com/discourse/discourse):A platform for community discussion. Free, open, simple. https://www.discourse.org
* [thoughtbot/factory_bot](https://github.com/thoughtbot/factory_bot):A library for setting up Ruby objects as test data. https://thoughtbot.com/open-source
* [thoughtbot/administrate](https://github.com/thoughtbot/administrate):A Rails engine that helps you put together a super-flexible admin dashboard.
* [thoughtbot/paperclip](https://github.com/thoughtbot/paperclip):Easy file attachment management for ActiveRecord https://thoughtbot.com/open-source
* [plataformatec/devise](https://github.com/plataformatec/devise):Flexible authentication solution for Rails with Warden. http://blog.plataformatec.com.br/tag/devise/
* [sferik/rails_admin](https://github.com/sferik/rails_admin):RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data
* [capistrano/capistrano](https://github.com/capistrano/capistrano):Remote multi-server automation tool http://www.capistranorb.com

## 参考

* [rubocop-hq/ruby-style-guide](https://github.com/rubocop-hq/ruby-style-guide):A community-driven Ruby coding style guide
