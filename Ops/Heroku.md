# Heroku

Heroku is a Platform-as-a-Service (PaaS) that simplifies deploying your apps online.

## 安装

注册账户

```sh
brew install heroku-toolbelt

heroku keys:add
cd myapp/
heroku create myapp
git push heroku master
heroku ps
heroku logs -t
```
