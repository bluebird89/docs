# [ protocolbuffers / protobuf ](https://github.com/protocolbuffers/protobuf/)

Protocol Buffers - Google's data interchange format  https://developers.google.com/protocol-buffers/

* Google公司开发的一种数据描述语言，用于描述一种轻便高效的结构化数据存储格式，并于2008年对外开源
* 可以用于结构化数据串行化，或者说序列化。设计非常适用于在网络通讯中的数据载体，很适合做数据存储或 RPC 数据交换格式，它序列化出来的数据量少再加上以 K-V 的方式来存储数据，对消息的版本兼容性非常强，可用于通讯协议、数据存储等领域的语言无关、平台无关、可扩展的序列化结构数据格式。
* 开发者可以通过Protobuf附带的工具生成代码并实现将结构化数据序列化的功能

## 语法

* 注释使用// 和 /* ... */
* 必须是文件中非空非注释行的第一行指定了使用 proto3语法。如果省略 protocol buffer编译器默认使用 proto2语法

## message

* 最基本的数据单元是message，是类似Go语言中结构体的存在
* 在message中可以嵌套message或其它的基础数据类型的成员
* 定义中每个字段都有一个唯一的编号，这些编号被用来在二进制消息体中识别你定义的这些字段，一旦message类型被用到后就不应该在修改这些编号了
* 注意在将message编码成二进制消息体时字段编号1-15将会占用1个字节，16-2047将占用两个字节。所以在一些频繁使用用的message中，你应该总是先使用前面1-15字段编号
* 可以指定的最小编号是1，最大是2E29 - 1（536,870,911）。其中19000到19999是给protocol buffers实现保留的字段标号，定义message时不能使用
* 也不能重复使用任何当前message定义里已经使用过和预留的字段编号
* 定义字段规则
	- ingular：一个遵循singular规则的字段，在一个结构良好的message消息体(编码后的message)可以有0或1个该字段（但是不可以有多个）。这是proto3语法的默认字段规则。（这个理解起来有些晦涩，举例来说上面例子中三个字段都是singular类型的字段，在编码后的消息体中可以有0或者1个query字段，但不会有多个。）
	- repeated：遵循repeated规则的字段在消息体重可以有任意多个该字段值，这些值的顺序在消息体重可以保持（就是数组类型的字段）
* 可以使用其他message类型作为字段的类型
* 导入消息定义
	- 任何导入包含 importpublic语句的 proto文件都可以传递依赖导入公共依赖项
* 使用proto2的消息类型
	- proto2的枚举类型不能直接应用到proto3的语法中
* 更新
	- 不要更改任何已存字段的字段编号。
	- 如果添加了新字段，任何由旧版消息格式生成的代码所序列化的消息，仍能被依据新消息格式生成的代码所解析。你应该记住这些元素的默认值这些新生成的代码就能够正确地与由旧代码序列化创建的消息交互了。类似的，新代码创建的消息也能由旧版代码解析：旧版消息（二进制）在解析时简单地忽略了新增的字段，查看下面的未知字段章节了解更多。
	- 只要在更新后的消息类型中不再重用字段编号，就可以删除该字段。你也可以重命名字段，比如说添加 OBSOLETE_前缀或者将字段编号设置为 reserved，这些未来其他用户就不会意外地重用该字段编号了。
* 未知字段是格式良好的协议缓冲区序列化数据，表示解析器无法识别的字段
	- proto3消息在解析期间总是丢弃未知字段
	- 在3.5版本中，我们重新引入了未知字段的保留以匹配proto2行为
	- 版本3.5及更高版本中，未知字段在解析期间保留，并包含在序列化输出中
* 映射类型 `map<key_type, value_type> map_field = N;`
	- `key_type`可以是任意整数或者字符串（除了浮点数和bytes以外的所有标量类型）。注意 enum不是一个有效的 `key_type`
	- `value_type`可以是除了映射以外的任意类型（意思是protocol buffers的消息体中不允许有嵌套map）
	- 映射里的字段不能是follow repeated规则的（意思是映射里字段的值不能是数组）。
	- 映射里的值是无序的，所以不能依赖映射里元素的顺序。
	- 生成.proto的文本格式时，映射按键排序。数字键按数字排序。
	- 从线路解析或合并时，如果有重复的映射键，则使用最后看到的键。从文本格式解析映射时，如果存在重复键，则解析可能会失败。
	- 如果未给映射的字段指定值，字段被序列化时的行为依语言而定。在C++， Java和Python中字段类型的默认值会被序列化作为字段值，而其他语言则不会
* 预定义消息类型
	- Protobufs带有一组预定义的消息，称为众所周知的类型（WKT）。这些类型可以用于与其他服务的互操作性，或者仅仅因为它们简洁地表示了常见的有用模式
	- WKT的预生成Go代码作为Go protobuf库的一部分进行分发，如果message中使用了WKT，则生成的消息的Go代码会引用此代码
* Varint编码:使用一个或多个字节编码整数的方法
	- 除了最后一个字节外，varint编码中的每个字节都设置了最高有效位（most significant bit - msb）
		+ 为1则表明后面的字节还是属于当前数据的
		+ 0那么这是当前数据的最后一个字节数据。
	- 每个字节的低7位用于以7位为一组存储数字的二进制补码表示，最低有效组在前，或者叫最低有效字节在前。这表明varint编码后数据的字节是按照小端序排列的
	- 计算出来是300的
		+ 需要把每个字节的msb去掉，因为它只用来告诉是否已经到达数字的最后一个字节
		+ 将两组7位反转
	- 所有与有线类型0关联的类型都会被编码为varint
	- 在编码负数时，带符号的int类型（sint32和sint64）与“标准” int类型（int32和int64）之间存在着巨大区别。如果将int32或int64用作负数的类型，则结果varint总是十个字节长––实际上，它被视为一个非常大的无符号整数。如果使用带符号类型(sint32和sint64)之一，则生成的varint使用ZigZag编码，效率更高
* [编解码](https://mp.weixin.qq.com/s?__biz=MzUzNTY5MzU2MA==&mid=2247483873&idx=1&sn=2ff1ecdfc2760d054de944612786b59f)
	- 当一个消息被编码时，键和值会被连接放入字节流中
	- 当消息被解码时，分析器需要能够跳过未识别的字段。这样，新加入消息的字段就不会破坏不知道他们存在的那些老程序
	- 有线格式消息中每个对的“键”实际上是两个值：-.proto文件中的字段编号，加上 一种有线类型，该类型仅提供足够的信息来查找随后的值的长度

```
# 300
1010 1100 0000 0010
 010 1100  000 0010
 000 0010  010 1100
1 0010 1100

# 可用的有线类型
Type	Meaning	Used For
0	Varint	int32, int64, uint32, uint64, sint32, sint64, bool, enum
1	64-bit	fixed64, sfixed64, double
2	Length-delimited	string, bytes, embedded messages, packed repeated fields
3	Start group	groups (deprecated)
4	End group	groups (deprecated)
5	32-bit	fixed32, sfixed32, float
```

## 标量类型

* 默认值
	- 对于字符串，默认值为空字符串。
	- 对于字节，默认值为空字节。
	- 对于bools，默认值为false。
	- 对于数字类型，默认值为零。
	- 对于枚举，默认值是第一个定义的枚举值，该值必须为0。
	- 对于消息字段，未设置该字段。它的确切值取决于语言
* 枚举类型:都需要包含一个常量映射到0并且作为定义的首行，因为：
	- 必须有0值，这样就可以将0作为枚举的默认值
	- proto2语法中首行的枚举值总是默认值，为了兼容0值必须作为定义的首行

```
.proto Type	Notes	C++ 	Java	Go 	PHP
double
double	double	float64	float
float
float	float	float32	float
int32	使用可变长度编码。编码负数的效率低 - 如果您的字段可能有负值，请改用sint32。	int32	int	int32	integer
int64	使用可变长度编码。编码负数的效率低 - 如果您的字段可能有负值，请改用sint64。	int64	long	int64	integer/string[5]
uint32	使用可变长度编码	uint32	int	uint32	integer
uint64	使用可变长度编码.	uint64	long	uint64	integer/string[5]
sint32	使用可变长度编码。签名的int值。这些比常规int32更有效地编码负数。	int32	int	int32	integer
sint64	使用可变长度编码。签名的int值。这些比常规int64更有效地编码负数。	int64	long	int64	integer/string[5]
fixed32	总是四个字节。如果值通常大于228，则比uint32更有效。	uint32	int	uint32	integer
fixed64	总是八个字节。如果值通常大于256，则比uint64更有效	uint64	long	uint64	integer/string[5]
sfixed32	总是四个字节	int32	int	int32	integer
sfixed64	总是八个字节	int64	long	int64	integer/string[5]
bool
bool	boolean	bool	boolean
string	字符串必须始终包含UTF-8编码或7位ASCII文本，且不能超过232。	string	String	string	string
bytes	可以包含不超过232的任意字节序列。	string	ByteString	[]byte	string
```
## 服务

* 定义一个RPC服务接口，然后protocol buffer编译器将会根据选择的编程语言生成服务接口代码和stub，加入要定义一个服务

## JSON编解码

* Proto3支持JSON中的规范编码，使得在系统之间共享数据变得更加容易
* 如果JSON编码数据中缺少某个值，或者其值为null，则在解析为protocol buffer时，将被解释为相应的默认值
* 如果字段在protocol buffer中具有默认值，则默认情况下将在JSON编码的数据中省略该字段以节省空间。
* 编写编解码实现可以覆盖这个默认行为在JSON编码的输出中保留具有默认值的字段的选项

```
proto3	JSON	JSON example	Notes
message	object	{"fooBar":v,"g":null,…}	生成JSON对象。消息字段名称会被转换为小驼峰并成为JSON对象键。如果指定了 json_name字段选项，则将指定的值用作键。解析器接受小驼峰名称（或由 json_name选项指定的名称）和原始proto字段名称。 null是所有字段类型的可接受值，并被视为相应字段类型的默认值。
enum	string	"FOO_BAR"	使用proto中指定的枚举值的名称。解析器接受枚举名称和整数值。
map	object	{"k":v,…}	所有键都将被转换为字符串
repeated V	array	[v,…]	null会被转换为空列表[]
bool	true, false	true,false
string	string	"Hello World!"
bytes	base64 string	"YWJjMTIzIT8kKiYoKSctPUB+"	JSON值将是使用带填充的标准base64编码编码为字符串的数据。接受带有/不带填充的标准或URL安全base64编码。
int32, fixed32, uint32	number	1,-10,0	JSON value will be a decimal number. Either numbers or strings are accepted.
int64, fixed64, uint64	string	"1","-10"	JSON value will be a decimal string. Either numbers or strings are accepted.
float, double	number	1.1,-10.0,0,"NaN","Infinity"	JSON value will be a number or one of the special string values "NaN", "Infinity", and "-Infinity". Either numbers or strings are accepted. Exponent notation is also accepted.
Any	object	{"@type":"url","f":v,…}	If the Any contains a value that has a special JSON mapping, it will be converted as follows: {"@type":xxx,"value":yyy}. Otherwise, the value will be converted into a JSON object, and the "@type" field will be inserted to indicate the actual data type.
Timestamp	string	"1972-01-01T10:00:20.021Z"	Uses RFC 3339, where generated output will always be Z-normalized and uses 0, 3, 6 or 9 fractional digits. Offsets other than "Z" are also accepted.
Duration	string	"1.000340012s","1s"	Generated output always contains 0, 3, 6, or 9 fractional digits, depending on required precision, followed by the suffix "s". Accepted are any fractional digits (also none) as long as they fit into nano-seconds precision and the suffix "s" is required.
Struct	object	{…}	Any JSON object. See struct.proto.
Wrapper types	various types	2,"2","foo",true,"true",null,0,…	Wrappers use the same representation in JSON as the wrapped primitive type, except that null is allowed and preserved during data conversion and transfer.
FieldMask	string	"f.fooBar,h"	See field_mask.proto.
ListValue	array	[foo,bar,…]
Value	value
Any JSON value
NullValue	null
JSON null
Empty	object	{}	An empty JSON object
```

## 生成代码

* 使用 .proto文件中定义的消息类型，需要在 .proto上运行protocol buffer编译器 protoc
* 如果尚未安装编译器，请下载该软件包并按照README文件中的说明进行操作
* 对于Go，需要为编译器安装一个特殊的代码生成器插件：可以在GitHub上的golang/protobuf项目中找到这个插件和安装说明
	- 如果一个 .proto文件中有包声明，生成的源代码将会使用它来作为Go的包
	- 如果 .proto的包名中有 . 在Go包名中会将 .转换为 _
	- 在 .proto文件中可以使用option go_package指令来覆盖上面默认生成Go包名的规则
	- 如果一个 .proto文件中不包含package声明，生成的源代码将会使用 .proto文件的文件名(去掉扩展名)作为Go包名， .会被首先转换为 `_`。举例: `high.score.proto`不包含pack声明的文件将会生成文件 high.score.pb.go，Go包名是 high_score
* 内嵌消息编译器会生成多个结构体
* 编译器会为每个在message中定义的字段生成一个Go结构体的字段，字段的确切性质取决于它的类型以及它是 singular， repeated， map还是 oneof字段
	- 生成的Go结构体的字段将始终使用驼峰命名，即使在 .proto文件中消息字段用的是小写加下划线（应该这样）。大小写转换的原理如下：
		+ 首字母会大些，如果message中字段的第一个字符是 _，将被替换为X。
		+ 如果内部下划线后跟小写字母，则删除下划线，并将后面跟随的字母大写
	- 单一标量字段:生成字段和获取该字段的get方法
	- 单一message字段：字段可以设置为nil，这意味着该字段未设置，有效清除该字段。这不等同于将值设置为消息结构体的“空”实例
	- 可重复字段：在Go中的结构中生成一个T类型的slice，其中T是字段的元素类型。对于带有重复字段的此消息
	- 映射字段：在Go的结构体中生成一个 map[TKey]TValue类型的字段，其中 TKey是字段的键类型 TValue是字段的值类型
* 默认情况下，Go代码生成器不会为服务生成输出。如果您启用gRPC插件（请参阅gRPC Go快速入门指南），则会生成代码以支持gRPC

```sh
protoc --proto_path=IMPORT_PATH --cpp_out=DST_DIR --java_out=DST_DIR --python_out=DST_DIR --go_out=DST_DIR --ruby_out=DST_DIR --objc_out=DST_DIR --csharp_out=DST_DIR path/to/file.proto

## Go代码指南
go get github.com/golang/protobuf/protoc-gen-go
go get -u github.com/micro/protoc-gen-micro
go get github.com/micro/micro/v2/cmd/protoc-gen-micro@master # 替代
go get -u github.com/golang/protobuf/protoc-gen-go
go get github.com/micro/micro/v2

option go_package = "./proto";
option go_package = ".;hello";

protoc --proto_path=src --go_out=build/gen src/foo.proto src/bar/baz.proto

package example.high_score;
option go_package = "hs";

protoc --go_out=$GOPATH/src/github.com/protocolbuffers/protobuf/examples/tutorial ./addressbook.proto
```



## 问题

```sh
# spawnSync clang-format ENOENT
sudo apt install clang-format
```
