# [parcel-bundler/parcel](https://github.com/parcel-bundler/parcel)

📦🚀 Blazing fast, zero configuration web application bundler https://parceljs.org

## 使用

```sh
npm install -g parcel-bundler

npm init -y
npm install parcel-bundler -S

"scripts": {
 "dev": "parcel index.html -p 3030",
 "build": "parcel build index.html"
 }

npm install babel-preset-env -S
# .babelrc 文件，添加以下配置
{
 "presets": ["env"]
}

npm install postcss-modules autoprefixer -S
# 创建 .postcssrc 文件
{
 "modules": true,
 "plugins": {
 "autoprefixer": {
"grid": true
 }
 }
}
```
