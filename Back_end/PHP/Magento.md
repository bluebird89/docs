# [magento/magento2](https://github.com/magento/magento2)

All Submissions you make to Magento Inc. (“Magento") through GitHub are subject to the following terms and conditions: (1) You grant Magento a perpetual, worldwide, non-exclusive, no charge, royalty free, irrevocable license under your applicable copyrights and patents to reproduce, prepare derivative works of, display, publically perform, subli… http://www.magento.com

* 默认开启了 N 多个模块，很多是不需要的，靠禁用相应模块这个方法来给产品加速
* A module is a type of component. A component can be
    - A module (code that extends Magento behavior)
    - A theme (changes the look and feel of your Magento Admin or storefront)
    - Language package (used to translate text and messages in the Magento application)
* 文件是基于功能进行分组的，分组后的代码块叫做模块,结构如下
    - registration.php
    - etc/module.xml:specifies the setup version and loading sequence
    - service contract
    - block：view Model
    - Console
    - Controller

## install

* 文件有写权限
    - vendor
    - app/etc
    - var
    - pub/media
    - pub/static
    - generated

```sh
composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + 
chown -R :www-data . # Ubuntu  chown -R :<your web server group name> 
chmod u+x bin/magento

## 通过 http://dowmian//setup 安装
# 命令行安装
create USER 'magento'@'%' IDENTIFIED BY 'magento';
GRANT ALL PRIVILEGES ON magento.* TO 'magento'@'localhost';
SHOW GRANTS FOR 'magento'@'localhost';
flush privileges;

bin/magento setup:install \ 
--base-url=http://www.magento-dev.com/ \ 
--db-host=localhost \ 
--db-name=magento \ 
--db-user=magento \ 
--db-password=magento \ 
--backend-frontname=admin \ 
--admin-firstname=admin \ 
--admin-lastname=admin \ 
--admin-email=admin@admin.com \ 
--admin-user=admin \ 
--admin-password=admin123 \ 
--language=en_US \ 
--currency=USD \ 
--timezone=America/Chicago \ 
--use-rewrites=1

php bin/magento setup:upgrade
php bin/magento setup:di:compile
php bin/magento setup:static-content:Deploy -f
chmod -R 777 var/ generated/
```

## 命令

* module:版本号，数据库会记录，包与数据库不一致，命令行无法运行

```sh
composer require magento/product-community-edition 2.2.6 --no-update
rm -rf var

composer update && composer install

bin/magento list|help

bin/magento maintenance:enable
bin/magento maintenance:disable

bin/magento setup:install
bin/magento setup:upgrade
bin/magento setup:di:compile
bin/magento setup:static-content:deploy -f
bin/magento setup:uninstall
bin/magento setup:config:set
bin/magento setup:store-config:set # Sets storefront-related options

bin/magento setup:db:status
bin/magento setup:db-schema:upgrade
bin/magento setup:db-data:upgrade

bin/magento module:{enable/disable} AcmeWidgets_ProductPromotor


bin/magento indexer:reindex

bin/magento deploy:mode:show
bin/magento deploy:mode:set developer
bin/magento deploy:mode:set production

bin/magento cache:status
bin/magento cache:enable
bin/magento cache:disable
bin/magento cache:flush
bin/magento cache:clean

bin/magento cron:install
bin/magento info:adminuri

bin/magento setup:db:status
bin/magento setup:db-schema:upgrade
bin/magento setup:db-data:upgrade
bin/magento dev:query-log:enable

bin/magento admin:user:create --admin-user=henry --admin-password=111111 --admin-email=11111@qq.com --admin-firstname=henry --admin-lastname=li
```

## auth

* New public and private keys are now associated with your account that you can click to copy
* Save this information or keep the page open when working with your Magento project
* Use the Public key as your username and the Private key as your password
* 在根目录中创建一个新文件auth.json

```language
{
   "http-basic": {
      "repo.magento.com": {
         "username": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
         "password": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      }
   }
}
```


```language
$store_id = Mage::app()->getStore('default')->getId();
foreach($product_ids as $id){
    Mage::getSingleton('catalog/product_action')->updateAttributes(array($id), array('price'=>$price), $store_id);
}
```

## REST

## GraphSQL

## varnish

* 更新缓存

## 问题

* Error 503 Backend fetch failed：access forbidden by rule, request: "GET /pub/health_check.php HTTP/1.1"

## 工具

* ERP
    - SAP Business One 拥有小型的在线商务，这款Magento的ERP解决方案非常适合满足你所有当前和未来的商业需求。合理的价格也是选择这个系统的一大优点。SAP的功能包括销售流程管理，仓库详细信息跟踪，人力资源和潜在客户数据维护等。Magento平台加入SAP可以处理以下任务：将客户数据从SAP导入到Magento；将订单信息从Magento平台导出到SAP；同步库存，定价和目录清单。
    - NetSuite这个基于云的ERP系统在全球范围内非常流行，服务于100多个国家的20000多家企业。它提供实时可见性和报告功能，使你的决策过程非常快速和及时。 你可以轻松地配置、定制和升级任何已排序的模块或任何各种业务操作。与Magento平台一起，它可以提供以下内容：从NetSuite进口货物到Magento;使用Magento Side Queuing函数处理NetSuite中的数据;管理NetSuite中的产品信息，以便在Magento中进一步更新;将订单和客户数据从Magento导出到NetSuite;将数据直接提取或加载到NetSuite中以集成碎片数据
    - Microsoft Dynamics AXMS Dynamics是一个成熟的数字解决方案，通过智能客户账户管理和订单创建工具简化工作流程。 它有助于快速简单的订购流程，从而增强客户体验。 作为最好的Magento ERP系统之一，它为你提供了许多非常有用的电子商务功能，如多种语言和货币支持，以及强大的交付，营销和SEO优化工具集等等。通过与Magento电子商务平台集成，你可以执行以下操作：将客户更新功能导入Magento;从Magento到MS Dynamics AX的订单结果导出;从Magento向Dynamics出口客户创建功能;将目录数据导入Magento;在Magento和MS Dynamics AX之间同步编辑/更新的订单数据。
    - Sage ERP.该ERP软件包适用于任何类型和规模的在线业务。 正如公司网站上报道的那样，Sage主要用于处理财务和企业管理。 此Magento ERP使你可以借助移动，云和内部部署管理工具来控制你的网上商店。 它非常适合制造，批发和服务流程。使用Sage ERP的Magento平台将能够：可跟踪库存细节;可跨部门、跨语言、跨立法合作；可使用总分类帐，预算，成本会计等管理财务流程;可控制采购，现金流;可更新客户信息。
    - Epicor这种价格低廉到中等价位的ERP完善了我们针对Magento平台的最佳ERP解决方案列表。 Epicor是一款端到端的ERP软件，可以帮助你有效地管理后台办公流程，如计划和调度，人力资本，生产，绩效和客户关系管理。 该数字解决方案在140个国家/地区拥有20,000多个客户，其本地化版本约有30种语言。 此外，Epicor在促进客户需求、项目执行、减少浪费和服务协调等方面具有很大的便利性和灵活性。与Magento平台Epicor保持一致可以让你：保存有信誉的产品的历史记录；提供可行的VAR（增值经销商）渠道;支持MS / SQL / SOA技术解决方案;在各部门之间获得更大的数据连通性;可采用强大的财务分析

## 参考

* [Magento2解决方案专家认证](https://u.magento.com/certified-magento2-solution-specialist):75个多项选择题 90分钟完成考试
* [marketplace](https://marketplace.magento.com)
* https://magento.com/technical-resources
* https://devdocs.magento.com/#/individual-contributors
* https://devdocs.magento.com/guides/v2.3/config-guide/
* [awesome-magento2](https://github.com/DavidLambauer/awesome-magento2)
* [](https://bbs.mallol.cn)
