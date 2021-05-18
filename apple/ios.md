# IOS

* 硬件的确扮演了重要的角色, 但能够差异化体验的则是跟软件的结合带来完整的用户体验
* I Skate to where the puck is going to be, not where it has been.

## 版本

* 14
  - 重新设计的主屏幕，支持小部件
    + 只能存放于负一屏的小组件现在也能放置在主屏幕上，而且还有大、中、小三种尺寸可选
    + 支持叠放，最多可同时叠放 10 个，上下轻扫即可在不同小组件之间切换
    + 长按小组件并选择“编辑小组件”可以编辑该小组件的展示形式
    + App 资源库
  - 全新翻译功能
  - 紧凑型电话来电 / Siri 界面
  - 画中画
  - 隐私细节
    + 当有 app 使用你的麦克风或相机时，iOS 会同时在 app 内及控制中心显示一个指示器，麦克风被调用时会显示黄色圆点，相机被调用时会显示绿色圆点

## 符合直觉

* 不违背人性
* 面对如此之多的国家、地区和文化

## Face ID

* 提供了更多直觉可能
* 增加了机器的主动认知
  - 认知:你的手机认识你。Face ID 的识别从「用户主动」变为「iPhone 主动」，所以你的 iPhone 随时都在甄别 你到底是不是你
  - 了解你的状态。由于 Face ID 是结构的立体模型，所以 iPhone 可以判断你的视线。于是 iOS 发现你在看屏幕时，它就不会熄灭屏幕
* 用来解锁的硬件，iPhone 就通过 iOS 的软件，对它一步一步的延展，最终完成了一个新的「魔法」：「你的手机像一个真实的人一样和你相处

## 影像哲学

* 相机越来越便携了，相机越来越简单了。
* 最好的相机，就是当你拍摄一张照片时，你手上的这部。
* 面对大众删繁就简
  - 对于大众，追求用最极致的简单获得更加专业的画面。而所有捕捉的出发点，以决定性瞬间为核心。iPhone 对于「绝对性瞬间的理解」绝对是所有手机品牌里最深刻的一位。
    + iPhone 中快门的低延迟一直是最为重要的核心参数
    + iPhone 连拍张数一直无出其右，连拍数量可以高达 600 张左右
    + iPhone 是给了用户选择权的,最新的 iOS 14 中 iPhone 直接提供了一个开关，你可以自由地选择是看中画质，还是看中响应速度。
    + 相比专注像素数量，我们更关注如何用最简单的方式，拍摄更加精彩的照片。
    + 计算摄影也是自成体系的。这种体系的出发点是「在任何光线环境下都能进行拍摄」。所以强光对应智能 HDR ，弱光对应深度融合，夜晚对应夜景模式。
* 面对专业有的放矢
  - 保留个性化发挥的空间，同时努力去掉机械流程
  - 今天的 iPhone 智能 HDR 对于曝光的理解其实已经远超许多专业用户。
* 在各种铺垫盖地的图片短视频琳琅满目的内容制作产业中，iPhone 有着独领风骚的地位

## 账号

* 每个ID只能购买一次歌曲，而且ID、IP、信用卡必须都要求是当地的，这样才能保证本地榜单反映当地人对音乐的消费情况。所以，iTunes是从规定上表明是不提倡也不允许刷榜的

## 调试

* 苹果手机：设置 > Safari浏览器 > 高级 > 开启Web检查器
* Mac：Safari浏览器 > 偏好设置 > 高级 > 在菜单栏中显示“开发”菜单
* 连接电脑，打开手机浏览器页面；Mac中的develop 中手机的页面列表

## 功能

* 屏幕录制
* live photo：效果：循环视频，以及长曝光照片
* photo
  - 编辑视频
  - 标记图片
* 相机识别二维码
* 备忘录
  - 扫描文档，制作PDF
* 语音输入
* 浏览器
  - 网页制作PDF
  - 左上角url前面点击切换阅读模式
* notes中打开拍照与扫描文档手机自动进入照相机页面
* AirDrop
* HandOff：双方都打开
* 手机解锁MAc：Near Lock
* Phone 变身Mac遥控器：无线鼠标、Rowmote Pro
* 多屏幕显示:让iPad或者iphone（虽然有点小，但如果你愿意也可以啦）化身外接显示器
  - Splashtop Wired XDisplay
* MAC投影手机
  - 手机线连MAC
  - Mac打开QuickTime Player,新建影片录制
  - 点击红点旁边那个箭头, 选择 iPhone
* shortcut
  - <https://shortcuts.sspai.com/#/main/workflow>
* 将 iPhone 转到横排模式就可以 科学计算器

## 打包发布

* 提供一个存放软件包的仓库，可供用户下载软件包
* 开发
* 打包:将源码转换成iOS系统的软件包-ipa文件iPhone application archive
  - 选择发布方式
    * App Store Connect -上架App Store以及TestFlight的app，用于生产环境发布
    + Ad Hoc - 部分机器可安装的app，用于非生产环境的测试
    + Enterprise - 企业级应用发布
      * 需要Apple企业账号，Apple对于企业级账号的发放是非常严格的
      * Apple规定企业级应用的下载途径不可公开，若发现公开则会有封号，应用失效的后果
    + Development - 与Ad Hoc类似，只有后续步骤所需要的证书和描述文件不同
    + App Store中app和企业级应用没有安装数量上的限制
  - 选择证书和描述文件
    + 证书、描述文件等资源被维护在Member Center中。它是开发者的资源管理中心，可以全生命周期管理
    + 登陆Member Center需要开发者账号Apple Developer Account,不同类型的开发者账号对应的Member Center拥有不同的能力
      * 个人
      * 组织
        - 公司
        - 企业级：无法将应用上架App Store，只能生成发布企业应用所需的证书，无法生成App Store Connect的发布方式所需的证书，当然也就没有上架App Store的能力
        - 二者之间除了账号的年费不一样之外，最重要的区别在于能否将应用上架App Store
      * 教育机构
      * 公司和个人类型的账号只有能否有团队成员这一个区别。因此实际上很多开发者会把个人类型的账号转为公司类型，便于团队协作
      * 因为大多数应用都需要不止一个DEV来开发，所以比较常用的开发者账号类型就是支持development team的公司和企业级应用
    + 全生命周期管理ID、设备、证书、描述文件
      * ID - 唯一标识符，根据用途分为App ID、Music ID、Merchant IDs等
        - App ID需要指定应用平台
        - App ID与Team ID绑定在一起。即，Apple知道一个应用的ID是注册在哪个开发者账号下的，也只允许这个账号内的成员在真机上调试或打包。
        - App ID指定了应用的capabilities，如：获取WI-FI信息、使用钱包、健康、SIRI....
      * 设备 - 能安装该开发者账号下的应用的设备
        - 每个苹果设备都有一个唯一标识符UDID - Unique Device Identifier。将某个设备注册到开发者账号下，就是在注册时将该设备的UDID填入。同一台设备可以被注册到多个开发者账号下.可以理解为开发者账号通过UDID列表，形成自己的设备资源池
      * 证书 - 由Apple 证书认证中心颁发的，用于确保应用内容可靠性和完整性的凭证
        - 开发证书，用于日常开发;
        - 发布证书，用于应用发布
        - 生成一个证书的步骤:在借助keychain在本地生成一个CSR文件，然后通过开发者账号上传，成功后就会存在于证书资源池中，在失效前可随时使用下载
      * 描述文件 - 一个ID，设备，证书的集合,描述文件会被打包到应用中，描述该应用的App ID、持有的发布证书、以及能被哪些设备安装
        - 也分开发和发布两大类型。其中，发布又被细分为Ad Hoc、App Store、Enterprise类型,与发布方式是一一对应的
    + 证书生成
      * 生成　CSR(Certificate Signing Reque)　文件: Keychain -> 证书助理 -> 从证书颁发机构请求证书,包含了请求证书者的个人信息的，用于向Apple证书颁发机构(Apple Worldwide Developer Relations Certification Authority，为了简单理解，后文统称Apple Root CA)申请证书的一个文件.Apple Root CA就相当于银行，证书相当于储蓄卡，CSR文件就相当于储蓄卡的申请单。
        - 通过非对称加密，在本地生成了证书的公钥和私钥，保存在Keychain中（虽然与非对称加密的方式并不一致，但为了便于理解，我们把私钥类比成储蓄卡密码）
        - 将公钥和个人信息一起组合形成了CSR
      * 通过开发者账号将CSR上传至Member Center
        - Apple Root CA是有一个由自己颁发的证书的(CA证书)。同样，这个证书也有它对应的公钥和私钥
        - 将CSR传给Apple Root CA，它会在验证身份之后，后用CA证书的私钥，对公钥和部分个人信息做加密，然后连同CSR中的公钥一起，形成证书，并记录在Member Center中
      * 从Member Center下载证书:下载证书到本地并安装。由于证书中包含证书的公钥，我们本地保存着证书的私钥，所以它们在Keychain中可以匹配得上
  - 编译 & 签名
    + 签名:用证书的私钥加密应用的内容。签名会一并打包到应用中.需要证书的私钥。 证书的私钥保存在证书申请人的keychain中
    + 作为非证书申请人，如果你想在本地打包，则需要向证书申请人请求私钥。
    + 作为证书申请人，请像保护银行卡密码一样保护私钥，尽量不分发私钥。分发私钥意味着其他人可以以你的名义打包和发布应用
    + 用证书验证签名，从而保证App来源可信
      * 用Apple Root CA证书，验证应用证书的有效性:用Apple Root CA证书中的公钥，能解密应用证书的签名得到应用证书上公钥，则能证明应用证书是由Apple颁发的
      * 用验证过的应用证书，验证应用签名的有效性:用应用证书中的公钥，能解密应用签名得到应用的内容，则能证明签名有效，应用可信
  - 导出ipa文件
* 发布:把软件包上传到发布平台,通过发布方式上的限制，确保真正public的应用只能通过Apple审核 ，App Store下载安装
* 下载安装:无论选择哪种安装方式或发布方式，都需要证书，签名，描述文件
  - App Store: App Store是Apple官方的App发布平台。在App Store中搜索并安装App，也是作为一个普通用户最常用的安装方式。
  - TestFlight:TestFlight是Apple官方的App测试平台。在上架到App Store之前，可以通过TestFlight邀请一部分用户参与测试，类似于网络游戏的公测。
  - App Center, FIR... 除了官方的Apple Store之外，市面上还存在着App Center, FIR等非Apple官方的App管理平台。在开发过程中，我们通常会将各个环境的App上传到这些非官方的平台中，用于日常测试；另外，我们也会将其作为企业级应用的最终发布平台
  - 通过Xcode安装到真机
  - 通过Xcode安装到模拟器:在开发过程中，DEV们作为特殊的iOS用户，也会通过IDE直接在真机或模拟器上进行开发和测试。这里把真机和模拟器分开，是因为它们确有不同。关于不同之处，我们将会在后文中谈到。

## UI

* [QMUI_iOS](https://github.com/QMUI/QMUI_iOS)：QMUI iOS——致力于提高项目 UI 开发效率的解决方案 <http://qmuiteam.com/ios>

## app

* Launch Center Pro
* 时光进度 bProgress：一个简单的 iOS 进度管理 App
* Cinema Time

## 课程

* [iOSCourse](https://github.com/eseedo/iOSCourse):iOS开发初学者入门 <http://icode.fun/>
* [斯坦福大学 iOS 开发公开课](https://cs193p.sites.stanford.edu/):斯坦福大学的高质量免费课程，使用了最新的 SwiftUI，充分展示了 APP 开发的整个流程，适合新手进行 iOS 的开发入门

## 图书

* 《[iOS编程实战](https://www.amazon.cn/gp/product/B00NKZCM3U)》
* 《[iOS编程（第4版）](https://www.amazon.cn/gp/product/B013UG2ULW)》
* 《[Objective-C高级编程](https://www.amazon.cn/gp/product/B00DE60G3S)》
* 《[Effective Objective-C 2.0：编写高质量iOS与OS X代码的52个有效方法](https://www.amazon.cn/gp/product/B00IDSGY06)》

## 工具

* [CocoaDebug](https://github.com/CocoaDebug/CocoaDebug):🚀 iOS Debugging Tool
* [StreamingKit](https://github.com/tumtumtum/StreamingKit):A fast and extensible gapless AudioPlayer/AudioStreamer for OSX and iOS (iPhone, iPad)
* [ish](https://github.com/tbodt/ish):Linux shell for iOS <https://ish.app>
* [XLPagerTabStrip](https://github.com/xmartlabs/XLPagerTabStrip):Android PagerTabStrip for iOS.
* [Potatso](https://github.com/haxpor/Potatso):Potatso is an iOS client that implements Shadowsocks proxy with the leverage of NetworkExtension framework.
* [FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture):A UINavigationController's category to enable fullscreen pop gesture with iOS7+ system style.
* [HandyJSON](https://github.com/alibaba/HandyJSON):一个用于 Swift 语言中的 JSON 序列化 / 反序列化库

## 参考

* [Ejecta](https://github.com/phoboslab/Ejecta):A Fast, Open Source JavaScript, Canvas & Audio Implementation for iOS
* [Apple Developer Documentation](https://developer.apple.com/documentation)
* [my-ios](https://github.com/nikitavoloboev/my-ios):List of applications and tools that make my iOS experience even more amazing
* [iOS-Weekly](https://github.com/SwiftOldDriver/iOS-Weekly):🇨🇳 老司机 iOS 周报
* [Buyer's Guide](https://buyersguide.macrumors.com/)
