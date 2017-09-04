# ubuntu安装

```
sudo git clone https://github.com/nodejs/node.git
sudo chmod -R 755 node
cd node
sudo ./configure
sudo make
sudo make install

curl http://npmjs.org/install.sh | sh

# Mac
brew install nvm
nvm install 4.4.5
nvm use 4.4.5

brew install node
```

# 配置

```
npm config set registry https://registry.npm.taobao.org
npmp配置文件`package.json`
scripts：script会安装一定顺序寻找命令对应位置，本地的node_modules/.bin路径就在这个寻找清单中.`npm run {script name}`,将构建命令提到外部指令来
```
