# [ruby/ruby](https://github.com/ruby/ruby)

The Ruby Programming Language https://www.ruby-lang.org/

* Convention over configuration;
* DRY - Don't Repeat You;
* KISS - Keep it simple and stupid;
* Don't reinventing the wheel;
* Optimized for programmer happiness and sustainable productivity

## [安装](https://gorails.com/setup/ubuntu/14.04)

* [rbenv/rbenv](https://github.com/rbenv/rbenv):Groom your app’s Ruby environment

```
# ubuntu
sudo apt-get install ruby-full

sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn autoconf bison build-essential  libreadline6-dev libncurses5-dev  libgdbm5 libgdbm-dev
# install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install -l
rbenv install 2.7.0
rbenv global 2.7.0

#  卸载
rbenv uninstall 2.1.3
# 卸载 rbenv,屏蔽~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rm -rf `rbenv root`

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.4.0
rvm use 2.4.0 --default

# Mac
brew install rbenv ruby-build rbenv-default-gems rbenv-gemset
echo 'eval "$(rbenv init -)"' >> ~/Projects/config/env.sh
rbenv install 2.1.1
rbenv global 2.1.1

# rbenv works by creating a directory of shims, which point to the files used by the Ruby version that's currently enabled. Through the rehash sub-command, rbenv maintains shims in that directory to match every Ruby command across every installed version of Ruby on your server.
rbenv rehash

# rvm 是 Ruby 的版本管理工具，其作用是在系统中安装若干个不同版本的 Ruby，且不让它们之间发生冲突
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.7.0
rvm use 2.7.0 --default
rvm uninstall 1.9.2

## compile
wget http://ftp.ruby-lang.org/pub/ruby/2.7/ruby-2.7.0.tar.gz
tar -xzvf ruby-2.7.0.tar.gz
cd ruby-2.7.0/
./configure
make
sudo make install

## trouble
ERROR:  Loading command: install (LoadError) cannot load such file -- zlib
ERROR:  While executing gem ... (NoMethodError)    undefined method `invoke_with_build_args' for nil:NilClass

# ext/zlib ext/openssl
ruby ./extconf.rb
make
sudo make install

ruby -v

# Managing gems in application
echo 'bundler' >> "$(brew --prefix rbenv)/default-gems"
# turn off local documentation generation
echo "gem: --no-document" > ~/.gemrc
# Bundler is a tool that manages gem dependencies for projects
gem install bundler
#  learn more about the environment and configuration of gems
gem env home

gem install rails -v [5.0.1]
#  install a specific version of Rails
gem search '^rails$' --all
gem install rails -v 4.2.7

rails -v
```

## [Gems](https://rubygems.org)

Find, install, and publish RubyGems.

```
gem sources -l
gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
gem sources --remove https://rubygems.org/
gem sources -a https://mirrors.aliyun.com/rubygems/
```
## * [Bundler](https://bundler.io/)

provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed.

```sh
bundle init # reates a simple Gemfile which you can edit
bundle install|update|check
bundle install --deployment
```

### SQL

```
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

#### SQLite (not recommended)
rails new myapp
####  MySQL
rails new myapp -d mysql
#### If you want to use Postgres:Note that this will expect a postgres user with the same username as your app, you may need to edit config/database.yml to match the user you created earlier
rails new myapp -d postgresql

cd myapp

# config/database.yml file to contain the username/password that you specified
# Create the database
rake db:create

rails server
```

## 教程

* [Ruby on Rails Tutorial](https://www.railstutorial.org/book)

##  项目

* [discourse/discourse](https://github.com/discourse/discourse):A platform for community discussion. Free, open, simple. https://www.discourse.org
* [mame/quine-relay](https://github.com/mame/quine-relay):An uroboros program with 100+ programming languages

## 工具

* [activeadmin/activeadmin](https://github.com/activeadmin/activeadmin):The administration framework for Ruby on Rails applications. https://activeadmin.info
* [tj/commander](https://github.com/tj/commander):The complete solution for Ruby command-line executables http://visionmedia.github.com/commander
* [discourse/discourse](https://github.com/discourse/discourse):A platform for community discussion. Free, open, simple. https://www.discourse.org
* [thoughtbot/factory_bot](https://github.com/thoughtbot/factory_bot):A library for setting up Ruby objects as test data. https://thoughtbot.com/open-source
* [thoughtbot/administrate](https://github.com/thoughtbot/administrate):A Rails engine that helps you put together a super-flexible admin dashboard.
* [thoughtbot/paperclip](https://github.com/thoughtbot/paperclip):Easy file attachment management for ActiveRecord https://thoughtbot.com/open-source
* [plataformatec/devise](https://github.com/plataformatec/devise):Flexible authentication solution for Rails with Warden. http://blog.plataformatec.com.br/tag/devise/
* [sferik/rails_admin](https://github.com/sferik/rails_admin):RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data
* [capistrano/capistrano](https://github.com/capistrano/capistrano):Remote multi-server automation tool http://www.capistranorb.com
* [Ruby regular expression editor](https://rubular.com):a Ruby regular expression editor

## 参考

* [rubocop-hq/ruby-style-guide](https://github.com/rubocop-hq/ruby-style-guide):A community-driven Ruby coding style guide
* [bbatsov/rails-style-guide](https://github.com/bbatsov/rails-style-guide):A community-driven Ruby on Rails 4 style guide
* [bbatsov/ruby-style-guide](https://github.com/bbatsov/ruby-style-guide):A community-driven Ruby coding style guide
