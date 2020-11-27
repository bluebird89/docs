# WebRTC Web Real Time Communication

音视频传输功能

* 免费使用 GIPS 先进的音视频引擎，之前都需要付费授权
* 由于音视频传输是基于点对点传输的，所以实现简单的 1 对 1 通话场景，需要较少的服务器资源，借助免费的 STUN/TURN 服务器可以大大节约成本开销
* 开发 Web 版本的应用非常方便，使用简单的 JS 接口，无需安装任何插件，即可实现音视频互通

## RTMP Real Time Messaging Protocol

* 实时消息传送协议是 Adobe Systems 公司为 Flash 播放器和服务器之间音频、视频和数据传输开发的开放协议
* 可以满足直播产品的需求，但由于其相对延时较高，不能满足视频互通的产品需求。于是大家很自然地将目光投向 UDP、QUIC（基于 UDP）一类延时更低的网络协议。

## 工具

* [RocketChat/Rocket.Chat](https://github.com/RocketChat/Rocket.Chat):Have your own Slack like online chat, built with Meteor. <https://rocket.chat/>
* [muaz-khan/RecordRTC](https://github.com/muaz-khan/RecordRTC):WebRTC JavaScript library for audio/video as well as screen activity recording. It supports Chrome, Firefox, Opera, Android, and Microsoft Edge. Platforms: Linux, Mac and Windows. <https://www.webrtc-experiment.com/RecordRTC/>
* [KITE](https://github.com/webrtc/KITE):KITE is a test engine designed to test WebRTC interoperability across browsers

## 参考

* [muaz-khan/WebRTC-Experiment](https://github.com/muaz-khan/WebRTC-Experiment):WebRTC, WebRTC and WebRTC. Everything here is all about WebRTC!! <https://www.webrtc-experiment.com/>
* Google WebRTC
* [webrtc-demo](https://nashaofu.github.io/webrtc-demo/)
* [WebRTC samples](https://webrtc.github.io/samples/)
* [WebRTC For The Curious](https://webrtcforthecurious.com/)
