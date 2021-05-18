# Heroku

Heroku is a Platform-as-a-Service (PaaS) that simplifies deploying your apps online.

## 安装

注册账户

```sh
brew install heroku-toolbelt

heroku login [-i]
# heroku keys:add
# cd myapp/
heroku create --buildpack heroku/python
git push heroku master
heroku ps
heroku logs -t|--tail

heroku addons
# heroku: no default language could be detected for this app
pip freeze > requirements.txt
heroku logs --tail
heroku open
heroku addons:open heroku-postgresql
heroku config:set DJANGO_SECRET_KEY=


rm /usr/local/bin/heroku
rm -rf /usr/local/lib/heroku /usr/local/heroku
rm -rf ~/.local/share/heroku ~/.cache/heroku
```
