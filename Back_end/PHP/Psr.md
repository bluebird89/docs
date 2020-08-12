# * [PSR](http://www.php-fig.org/)

组织制定的PHP语言开发规范，约定了很多方面的规则，如命名空间、类名 规范、编码风格标准、Autoload、公共接口等

1   Basic Coding Standard   Paul M. Jones   N/A N/A
3   Logger Interface    Jordi Boggiano  N/A N/A
4   Autoloading Standard    Paul M. Jones   Phil Sturgeon   Larry Garfield
6   Caching Interface   Larry Garfield  Paul Dragoonis  Robert Hafner
7   HTTP Message Interface  Matthew Weier O’Phinney Beau Simensen   Paul M. Jones
11  Container Interface Matthieu Napoli, David Négrier  Matthew Weier O’Phinney Korvin Szanto
12  Extended Coding Style Guide Korvin Szanto   Alexander Makarov   Chris Tankersley
13  Hypermedia Links    Larry Garfield  Matthew Weier O’Phinney Marc Alexander
14  Event Dispatcher    Larry Garfield  N/A Cees-Jan Kiewiet
15  HTTP Handlers   Woody Gilk  N/A Matthew Weier O’Phinney
16  Simple Cache    Paul Dragoonis  Jordi Boggiano  Fabien Potencier
17  HTTP Factories  Woody Gilk  N/A Matthew Weier O’Phinney
18  HTTP Client Tobias Nyholm   N/A Sara Golemon

### PSR0

类自动加载

* 一个完全标准的命名空间(namespace)和类(class)的结构是这样的：\<Vendor Name>\(<Namespace>\)*<Class Name>
* 每个命名空间(namespace)都必须有一个顶级的空间名(namespace)("组织名(Vendor Name)")。
* 每个命名空间(namespace)中可以根据需要使用任意数量的子命名空间(sub-namespace)。
* 从文件系统中加载源文件时，空间名(namespace)中的分隔符将被转换为 DIRECTORY_SEPARATOR。
* 类名(class name)中的每个下划线_都将被转换为一个DIRECTORY_SEPARATOR。下划线_在空间名(namespace)中没有什么特殊的意义。
* 完全标准的命名空间(namespace)和类(class)从文件系统加载源文件时将会加上.php后缀。
* 组织名(vendor name)，空间名(namespace)，类名(class name)都由大小写字母组合而成。
* 自动加载

```php
function autoload($className)
{
    $className = ltrim($className, '\\');
    $fileName  = '';
    $namespace = '';
    if ($lastNsPos = strrpos($className, '\\')) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName  = str_replace('\\', DIRECTORY_SEPARATOR, $namespace) . DIRECTORY_SEPARATOR;
    }
    $fileName .= str_replace('_', DIRECTORY_SEPARATOR, $className) . '.php';

    require $fileName;
}
spl_autoload_register('autoload');
```

### PSR4

描述的是通过文件路径自动载入类的指南；它作为对 PSR-0 的补充；根据这个 指导如何规范存放文件来自动载入；

* 术语「类」是一个泛称；它包含类，接口，traits 以及其他类似的结构；
* 完全限定类名应该类似如下范例：<NamespaceName>(<SubNamespaceNames>)*<ClassName>
    - 完全限定类名必须有一个顶级命名空间（Vendor Name）；
    - 完全限定类名可以有多个子命名空间；
    - 完全限定类名应该有一个终止类名；
    - 下划线在完全限定类名中是没有特殊含义的；
    - 字母在完全限定类名中可以是任何大小写的组合；
    - 所有类名必须以大小写敏感的方式引用；
* 当从完全限定类名载入文件时：
    - 在完全限定类名中，连续的一个或几个子命名空间构成的命名空间前缀（不包括顶级命名空间的分隔符），至少对应着至少一个基础目录。
    - 在「命名空间前缀」后的连续子命名空间名称对应一个「基础目录」下的子目录，其中的命名 空间分隔符表示目录分隔符。子目录名称必须和子命名空间名大小写匹配；
    - 终止类名对应一个以 .php 结尾的文件。文件名必须和终止类名大小写匹配；
* 自动载入器的实现不可抛出任何异常，不可引发任何等级的错误；也不应返回值；
* 自动生成的PSR4配置文件名称为autoload_psr4.php（PSR0的是autoload_namespace.php），配置文件返回一个关联数组，键是名称空间的前缀，值是名称空间前缀对应的路径。
* 只需要给类库正确定义所在的命名空间，并且命名空间的路径与类库文件的目录一致，那么就可以实现类的自动加载，从而实现真正的惰性加载

### 自动加载

* psr0 中类名的下划线将会转化为目录层级和相应的命名空间，如一个叫 Swift_mail 的类名存在于./Swift/Mail.php 文件中，并且命名空间为当前命名空间\Swift

### PSR-14 compatible event dispatcher provides an ability to dispatch events and listen to events dispatched

## 实践

* 通过配置实现根命名空间与指定目录的映射，进而在创建 PHP 类时通过 PSR-4 自动载入标准根据类所在的目录路径生成对应的命名空间
* 通过外部 PHP Code Sniffer 工具对代码进行自动修复从而使其遵循 PSR-2 编码风格，提升工作效率
