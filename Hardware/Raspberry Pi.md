# [入手](http://www.ruanyifeng.com/blog/2017/06/raspberry-pi-tutorial.html)

## 准备

* 型号：Raspberry Pi 3代 B 型 Raspberry Pi zero
* 电源：输出必须是 5V 电压、至少 2A 电流 Micro SD 卡就是硬盘，推荐使用16G和32G的卡;
* 显示器只在安装系统时需要，后面可以 SSH 登录，就不需要了，HDMI 输出
* 鼠键:蓝牙或USB
* 系统安装：通过NOOBs安装Raspbian
* 开启SSH：通过sudo ifconfig,登录 `ssh pa@192.168.1.5` sudo adduser pi gpio
* 安装node
* 程序配置

```sh
mkdir led-demo && cd led-demo
npm init -y
npm install -S rpio
node led-on.js

npm install -S server
node server.js
curl http://localhost:8080

// led-on.js
var rpio = require('rpio');

// 打开 11 号针脚（GPIO17) 作为输出
rpio.open(11, rpio.OUTPUT);

// 指定 11 号针脚输出电流（HIGH）
rpio.write(11, rpio.HIGH);

// server.js
var server = require('server');
var { get } = server.router;

server({ port: 8080 }, [
  get('/' ,  ctx => {
    console.log('a request is coming...');
    blink();
  }),
]);

console.log('server starts on 8080 port');}
```

## HomeAssistant和Homebridge

## Homekit

## 教程

* [Learning operating system development using Linux kernel and Raspberry Pi](https://s-matyukevich.github.io/raspberry-pi-os/)

## 工具

* [hzeller/rpi-rgb-led-matrix](https://github.com/hzeller/rpi-rgb-led-matrix):Controlling up to three chains of 64x64, 32x32, 16x32 or similar RGB LED displays using Raspberry Pi GPIO
