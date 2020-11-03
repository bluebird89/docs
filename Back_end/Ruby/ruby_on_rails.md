# [rails](https://github.com/rails/rails)

Ruby on Rails http://rubyonrails.org

## 安装

```sh
gem install rails
rails --version

rails new blog
```

## 结构

* app/    Contains the controllers, models, views, helpers, mailers, channels, jobs, and assets for your application. You'll focus on this folder for the remainder of this guide.
* bin/    Contains the rails script that starts your app and can contain other scripts you use to setup, update, deploy, or run your application.
* config/ Configure your application's routes, database, and more. This is covered in more detail in Configuring Rails Applications.
* config.ru   Rack configuration for Rack based servers used to start the application. For more information about Rack, see the Rack website.
* db/ Contains your current database schema, as well as the database migrations.
* Gemfile
* Gemfile.lock    These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem. For more information about Bundler, see the Bundler website.
* lib/    Extended modules for your application.
* log/    Application log files.
* package.json    This file allows you to specify what npm dependencies are needed for your Rails application. This file is used by Yarn. For more information about Yarn, see the Yarn website.
* public/ The only folder seen by the world as-is. Contains static files and compiled assets.
* Rakefile    This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing Rakefile, you should add your own tasks by adding files to the lib/tasks directory of your application.
* README.md   This is a brief instruction manual for your application. You should edit this file to tell others what your application does, how to set it up, and so on.
* storage/    Active Storage files for Disk Service. This is covered in Active Storage Overview.
* test/   Unit tests, fixtures, and other test apparatus. These are covered in Testing Rails Applications.
* tmp/    Temporary files (like cache and pid files).
* vendor/ A place for all third-party code. In a typical Rails application this includes vendored gems.
* .gitignore  This file tells git which files (or patterns) it should ignore. See GitHub - Ignoring files for more info about ignoring files.
* .ruby-version   This file contains the default Ruby version.

```sh
rails server #  http://localhost:3000
rails routes

rails generate controller Articles
rails generate model Article title:string text:text
rails db:migrate

rails generate model Comment commenter:string body:text article:references
```
