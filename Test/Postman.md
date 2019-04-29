# Postman

help your devleop APIs faster

* 创建 + 测试：创建和发送任何的HTTP请求，请求可以保存到历史中再次执行
* Organize:使用Postman Collections为更有效的测试及集成工作流管理和组织APIs
* document:依据你创建的Clollections自动生成API文档,并将其发布成规范的格式
* collarorate:通过同步连接你的team和你的api，以及权限控制，API库

## collections

收藏的测试Postman echo用例。官网有整理的api collection可以直接导入。
允许你运行collection，你可以运行任意的次数。选择collection，选择环境。点击运行按钮。
最后会给出一个整体运行的结果。会保存每一次运行的结果，提供给你比较每一次运行解雇的不同。
可以批量测试

* 组织：将请求分组到文件夹和集合中，以便我们不必重复搜索历史记录。
* 文档：为请求、文件夹和集合添加名称和描述，在Postman中，我们可以使用收集浏览器查看文档。而且在Postman Pro中，您可以创建和发布漂亮的API文档页面。
* 测试套件：将测试脚本附加到请求并构建集成测试套件。
* 条件工作流程：使用脚本在API请求之间传递数据，并构建反映实际API用例的工作流程。

输入集合名称和可选说明（Description）。
选择一种授权类型（Authorization）。
在集合运行之前输入一个预先请求脚本（Pre-request Scripts）来执行。
添加测试（Tests）以在集合运行后执行。
将变量（Variables）添加到集合及其请求。
点击创建（Create）按钮。

## environment

- 在不同的环境下跑相同的测试，此时可以通过设置环境变量来动态选择。添加环境变量base_url,使用{{base_url}}
多数测试参数一致，通过环境区分测试

request

左边的sidebar与右边的request builder：快速创建几乎所有的请求

HTTP请求的4部分:
    - URL：如果在输入参数时，没有自动decode到URL中，则可以选中参数右键后，选择EncodeURIComponent(通过右键)，同样也可以decode，将参数生成dictionary的形式
    - method:get post
    - headers：通过key-value添加，一些保密的可以解除限制.鼠标悬停在headers标签上，有详细的HTTP说明。
    - body
        + form-data：mutipart/form-data是网页表单用来传输数据的默认格式。可以模拟填写表单，并且提交表单。可以上传一个文件作为key的value提交(如上传文件)。但该文件不会作为历史保存，只能在每次需要发送请求的时候，重新添加文件。
        + x-www-form-urlencoded：application/x-www-from-urlencoded,会将表单内的数据转换为键值对.不能上传文件通过这个编码模式。该模式和表单模式会容易混淆。urlencoded中的key-value会写入URL，form-data模式的key-value不明显写入URL，而是直接提交。
        + raw request可以包含任何东西。所有填写的text都会随着请求发送。
        + binaryimage, audio or video files.text files 。也不能保存历史，每次选择文件，提交。
    - pre-requset script:对一些环境变量之类的进行设置，相当于数据初始化 。全局变量与环境变量
```js
postman.setGlobalVariable("username", "tester");  // 使用时代替
```

## response

保证API响应的正确性，就是你需要做的大部分工作。postman的response viewer部分会协助你完成该工作且使其变得简单。一个API的响应包含body,headers,响应状态码。postman将body和headers放在不同的tabs中。响应码和响应时间显示在tabs的旁边。将鼠标悬停在响应码上面可以查看更详细的信息。

* 保存responses
* 查看response
    - Pretty：格式化了JSON和XML,自动格式化body必须保证返回了正确的Content-Type.如果API没有返回，则可以点击”Force JSON“来设置。
    - Raw:是text。
    - preview:有的浏览器会返回HTML的错误，对于找问题比较方便。由于sandbox的限制，js和图片不会显示在这里的iframe中。你可以maximize该body窗口方便查看结果。
* cookies:可以显示browser cookies，需要开启Interceptor。
    - domain不能含有http://
    - bulk or key-value
* Headers

## 身份验证Authentication

* Basic Auth：填写用户名和密码，点击Refresh headers
* Digest Auth：要比Basic Auth复杂的多。使用当前填写的值生成authorization header。所以在生成header之前要确保设置的正确性。如果当前的header已经存在，postman会移除之前的header。
* OAuth 1.0a：postman的OAuth helper让你签署支持OAuth 1.0基于身份验证的请求。OAuth不用获取access token,你需要去API提供者获取的。OAuth 1.0可以在header或者查询参数中设置value。
* OAuth 2.0：postman支持获得OAuth 2.0 token并添加到requests中。

## 测试用例

test标签写测试用例。本质上是javascript code，可以为tests object设置values。这里使用描述性文字作为key，检验body中的各种情况，当然你可以创建任意多的key，这取决于你需要测试多少点。tests也会随着request保存到collection中。api测试保证前端后台都能正常的于api协作工作，而不用在出错时猜测是哪里的问题。每次执行request的时候，会执行tests。测试结果会在tests的tab上面显示一个通过的数量。

需要在request的test中创建了test后，再进行request，test的结果在body的test中查看。注意：
* 这里的key描述必须是唯一的，否则相同描述只会执行第一个。
* 这里的key可以使用中文。

实例`tests[“Body contains user_id”] = responseBody.has(“user_id”)`:描述性的key为：Body contains user_id。检测点为：responseBody.has(“user_id”)，意思是检测返回的body中是否包含”user_id”这个字段。

Testing Sandbox:postman的测试是运行在沙箱环境，是与app独立的。查看什么在沙箱中是可用的，参见Sandbox documentation.

snippets:快速添加常用的测试代码,可以自定义。

```
postman.setEnvironmentVariable("key", "value");   // 设置环境变量
postman.setGlobalVariable("key", "value");  // 设置全局变量
tests["Body matches string"] = responseBody.has("string_you_want_to_search"); // 检查response body中是否包含某个string
var data = JSON.parse(responseBody);  // 检测JSON中的某个值是否等于预期的值
tests["Your test name"] = data.value === 100;
var data = JSON.parse(responseBody);
tests["program's lenght"] = data.programs.length === 5;  // JSON.parse()方法，把json字符串转化为对象。parse()会进行json格式的检查是一个安全的函数。
var jsonObject = xml2Json(responseBody); // 转换XML body为JSON对象
tests["Body is correct"] = responseBody === "response_body_string";  // 检查response body是否与某个string相等
tests["Content-Type is present"] = postman.getResponseHeader("Content-Type");   // 测试response Headers中的某个元素是否存在(如:Content-Type) getResponseHeader()方法会返回header的值，如果该值存在
tests["Content-Type is present"] = responseHeaders.hasOwnProperty("Content-Type");
tests["Status code is 200"] = responseCode.code === 200;  // 验证Status code的值
tests["Response time is less than 200ms"] = responseTime < 200; // 验证Response time是否小于某个值
tests["Status code name has string"] = responseCode.name.has("Created"); // name是否包含某个值
tests["Successful POST request"] = responseCode.code === 201 || responseCode.code === 202; //POST 请求的状态响应码是否是某个值

# 很小的JSON数据验证器

var schema = {
 "items": {
 "type": "boolean"
 }
};
var data1 = [true, false];
var data2 = [true, 123];
console.log(tv4.error);
tests["Valid Data1"] = tv4.validate(data1, schema);
tests["Valid Data2"] = tv4.validate(data2, schema);
```

## mock

* 发送请求（R1）
* 将请求（R1）保存到集合里面（C1）
* 将请求结果（P1）保存到集合里面（C1）
* 为集合 C1 创建一个 Mock（M1）
* 使用 Mock 服务（M1）发送一个请求
    - 带上路由
* 使用查询参数进行匹配

## Team

* 团队共享接口实例

## 扩展

- 安装：`npm install newman`
- npm run -h

## headersnre

## 构建mock

## 接口实例

- [Postman API Network](https://www.getpostman.com/api-network/)
- [postman](http://lucia.xicp.cn/2016/05/21/test/postman%E7%AC%94%E8%AE%B0/)
- 研究自带实例Postman Echo collection
- Postman Interceptor

