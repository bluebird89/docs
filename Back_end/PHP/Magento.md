# [magento2](https://github.com/magento/magento2)

All Submissions you make to Magento Inc. (“Magento") through GitHub are subject to the following terms and conditions: (1) You grant Magento a perpetual, worldwide, non-exclusive, no charge, royalty free, irrevocable license under your applicable copyrights and patents to reproduce, prepare derivative works of, display, publically perform, subli… http://www.magento.com

* 默认开启了 N 多个模块，靠禁用相应模块这个方法来给产品加速
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
* upgrade
    - Generating non-existent classes such as factories and interceptors for plug-ins
    - generating the dependency injection configuration for the object manager.

```sh
# php.ini cgi.fix_pathinfo line and change the value to 0
# fpm/php.ini cli/php.ini
memory_limit = 2G
max_execution_time = 1800
dzlib.output_compression = On

# www.conf in an editor.
user = nginx
group = nginx
listen = /run/php-fpm/php-fpm.sock
listen.owner = nginx
listen.group = nginx
listen.mode = 0660

# ~/.composer/auth.json
{
    "github-oauth": {
        "github.com": "<your GitHub personal access token>"
    },
    "http-basic": {
        "repo.magento.com": {
            "username": "<public key>",
            "password": "<private key>"
        }
    }
}

composer create-project --repository=https://repo.magento.com/ magento/project-community-edition magento2

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +
find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +
chown -R :www-data . # Ubuntu  chown -R :<your web server group name>
chmod u+x bin/magento

ps aux | grep nginx
usermod -a -G www-data <username>
groups henry
sudo chown -R :<web server group> .

## 通过 http://dowmian//setup 安装
# 命令行安装
create USER 'magento'@'%' IDENTIFIED BY 'magento';
GRANT ALL PRIVILEGES ON magento.* TO 'magento'@'localhost';
SHOW GRANTS FOR 'magento'@'localhost';
flush privileges;

php bin/magento setup:install \ 
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

php bin/magento deploy:mode:set developer

php bin/magento setup:upgrade
php bin/magento setup:di:compile
php bin/magento setup:static-content:Deploy -f
chmod -R 777 var/ generated/

# nginx config
 upstream fastcgi_backend {
   server  unix:/run/php/php7.2-fpm.sock;
 }

 server {

   listen 80;
   server_name www.magento-dev.com;
   set $MAGE_ROOT /var/www/html/magento2;
   include /var/www/html/magento2/nginx.conf.sample;
 }


<VirtualHost *:80>
        ServerName packagist.domain.com
 
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
 
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# Sample data
bin/magento sampledata:deploy
```

## Websites, Stores, and Views

* Global->websites->stores->store views(different languages)
* Magento installations begin with a single website which by default, is called “Main Website.”
* All stores under the same website share the same Admin and checkout
* store_code

## Theme

* Manually
  - Extract the file which named the file “themes.zip”
  - Then upload it into webroot folder
  - php bin/magento setup:upgrade –keep-generated
  - php bin/magento setup:static-content:deploy
  - admin panel >> Ves Setup >> Import >> Choose profile json file -> install
  - Stores >> Configuration >> General >> Web >> Default Pages >> Choose default cms homepage

## Cli

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
bin/magento setup:di:compile # recreate Interceptor
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

bin/magento admin:user:create --admin-user=henry --admin-password=111111 --admin-email=11111@qq.com --admin-firstname=henry --admin-lastname=li
```

## Flow

* When a customer adds an item to their shopping cart for the first time, Magento creates a quote. Magento uses a quote to perform tasks such as
* Track each item the customer wants to buy, including the quantity and base cost
* Gather information about the customer, including billing and shipping addresses
* Determine shipping costs
* Calculate the subtotal, add costs (shipping fees, taxes, etc.) and apply coupons to determine the grand total
* Determine the payment method
* Place the order so that the merchant can fulfill it.
* cart quote-》checkout quote
    - 添加item到cart前验证：agento\CatalogInventory\Model\Quote\Item\QuantityValidator
* re-order
    - out of stock
    - disable

## Product

* Configuration > Catalog > Inventory > Product Stock Options: Product Stock Options, find 2 sections: Maximum Qty Allowed in Shopping Cart and Minimum Qty Allowed in Shopping Cart.


## module

* 更新版本號，composer require 會拉取最新版本號代碼
* 可以定義後臺配置的路由（重寫）

## WebAPI

* `http://<:host:>/rest/<:store_code:>/<:api_path:>`
* 结构
    - module.xml
    - registeration.php
    - Api
    - Api/Data
    - etc\webapi.xml
      + Route:This is the URL which will be used to call our API https://{{MagentoBaseURL}}/index.php/rest/V1/custom/{{categoryId}}/products
      + Service Class – This is the interface class of our API and the main method “getAssignedProducts” will be called with {{categoryId}} as the parameter
      + Resources- This defines who has the permission to call this API. It could be anonymous (everyone) or self (customer) or specific admin user with specific permission for example Scommerce_Custom::custom which can be added in acl.xml
        + the ‘self’ permission allows a customer to access the /V1/customers/me route and retrieve information about itself only. In the handling code the PHP session cookie is used to verify that the customer is legitimate and matches the supplied customer_id parameter. Session authentication is discussed further below.
        + the ‘anonymous’ permission, as its name suggests, allows access to the /V1/customers route – even for a user who’s not logged-in. The route is used to create a customer when data is posted to it, so it makes sense that access needs to be open. This might seem like a security risk, but the POST data also requires a valid form key to process the request.
    - Scommerce\Custom\Api\CategoryLinkManagementInterface.php:the main interface file
* Authentication
    - Token  Mobile application  Yes     Yes 可以通过token解析出来，比如用户信息
    - OAuth  Third-party application (integration)   No  Yes
    - Session Javascript application on the frontend site or admin site   Yes     Yes
* Intergered[Swagger](http://website-base-url/swagger)
* 参数：接口定义接受参数，与返回值类型

```
<route url="/V1/custom/:categoryId/products" method="GET">
    <service class="Scommerce\Custom\Api\CategoryLinkManagementInterface" method="getAssignedProducts" />
    <resources>
        <resource ref="self"/>
    </resources>
</route>

# CategoryLinkManagementInterface.php under Scommerce\Custom\Api\namespace Scommerce\Custom\Api;

/**
 * @api
 */
interface CategoryLinkManagementInterface
{
    /**
     * Get products assigned to a category
     *
     * @param int $categoryId
     * @return \Scommerce\Custom\Api\Data\CategoryProductLinkInterface[]
     */
    public function getAssignedProducts($categoryId);
}


#  CategoryProductLinkInterface.php under \Scommerce\Custom\Api\Data\
namespace Scommerce\Custom\Api\Data;

/**
 * @api
 */
interface CategoryProductLinkInterface
{
    /**
     * @return string|null
     */
    public function getSku();

    /**
     * @param string $sku
     * @return $this
     */
    public function setSku($sku);

    /**
     * @return string|null
     */
    public function getName();

    /**
     * @param string $name
     * @return $this
     */
    public function setName($name);

    /**
     * @return float|null
     */
    public function getPrice();

    /**
     * @param float $price
     * @return $this
     */
    public function setPrice($price);

    /**
     * @return int|null
     */
    public function getPosition();

    /**
     * @param int $position
     * @return $this
     */
    public function setPosition($position);

    /**
     * @return string|null
     */
    public function getCategoryDescription();

    /**
     * @param string $description
     * @return $this
     */
    public function setCategoryDescription($description);
}

# \Scommerce\Custom\etc\di.xml
<config ...>
    <preference for="Scommerce\Custom\Api\CategoryLinkManagementInterface" type="Scommerce\Custom\Model\CategoryLinkManagement" />
    <preference for="Scommerce\Custom\Api\Data\CategoryProductLinkInterface" type="Scommerce\Custom\Model\CategoryProductLink" />
</config>

# under Scommerce\Custom\Model\CategoryLinkManagement.php as specified in di.xml
namespace Scommerce\Custom\Model;

/**
 * Class CategoryLinkManagement
 */
class CategoryLinkManagement implements  \Scommerce\Custom\Api\CategoryLinkManagementInterface
{
    /**
     * @var \Magento\Catalog\Api\CategoryRepositoryInterface
     */
    protected $categoryRepository;

    /**
     * @var \Scommerce\Custom\Api\Data\CategoryProductLinkInterfaceFactory
     */
    protected $productLinkFactory;

    /**
     * CategoryLinkManagement constructor.
     *
     * @param \Magento\Catalog\Api\CategoryRepositoryInterface $categoryRepository
     * @param \Scommerce\Custom\Api\Data\CategoryProductLinkInterfaceFactory $productLinkFactory
     */
    public function __construct(
        \Magento\Catalog\Api\CategoryRepositoryInterface $categoryRepository,
        \Scommerce\Custom\Api\Data\CategoryProductLinkInterfaceFactory $productLinkFactory
    ) {
        $this->categoryRepository = $categoryRepository;
        $this->productLinkFactory = $productLinkFactory;
    }

    /**
     * {@inheritdoc}
     */
    public function getAssignedProducts($categoryId)
    {
        $category = $this->categoryRepository->get($categoryId);
        if (!$category->getIsActive()) {
            return [[
                'error' => true,
                'error_desc' => 'Category is disabled'
            ]];
        }
        $categoryDesc = $category->getDescription();

        /** @var \Magento\Catalog\Model\ResourceModel\Product\Collection $products */
        $products = $category->getProductCollection()
            ->addFieldToSelect('position')
            ->addFieldToSelect('name')
            ->addFieldToSelect('price');

        /** @var \Scommerce\Custom\Api\Data\CategoryProductLinkInterface[] $links */
        $links = [];

        /** @var \Magento\Catalog\Model\Product $product */
        foreach ($products->getItems() as $product) {
            /** @var \Scommerce\Custom\Api\Data\CategoryProductLinkInterface $link */
            $link = $this->productLinkFactory->create();
            $link->setSku($product->getSku())
                ->setName($product->getName())
                ->setPrice($product->getFinalPrice())
                ->setPosition($product->getData('cat_index_position'))
                ->setCategoryDescription($categoryDesc);
            $links[] = $link;
        }

        return $links;
    }
}

# Scommerce\Custom\Model\CategoryProductLink.php
namespace Scommerce\Custom\Model;

/**
 * @codeCoverageIgnore
 */
class CategoryProductLink implements \Scommerce\Custom\Api\Data\CategoryProductLinkInterface
{
    /**#@+
     * Constant for confirmation status
     */
    const KEY_SKU                   = 'sku';
    const KEY_NAME                  = 'name';
    const KEY_PRICE                 = 'price';
    const KEY_CATEGORY_DESC         = 'category_description';
    const KEY_POSITION              = 'position';
    /**#@-*/

    /**
     * {@inheritdoc}
     */
    public function getSku()
    {
        return $this->_get(self::KEY_SKU);
    }

    /**
     * {@inheritdoc}
     */
    public function getName()
    {
        return $this->_get(self::KEY_NAME);
    }

    /**
     * {@inheritdoc}
     */
    public function getPosition()
    {
        return $this->_get(self::KEY_POSITION);
    }

    /**
     * {@inheritdoc}
     */
    public function getPrice()
    {
        return $this->_get(self::KEY_PRICE);
    }

    /**
     * {@inheritdoc}
     */
    public function getCategoryDescription()
    {
        return $this->_get(self::KEY_CATEGORY_DESC);
    }

    /**
     * @param string $sku
     * @return $this
     */
    public function setSku($sku)
    {
        return $this->setData(self::KEY_SKU, $sku);
    }

    /**
     * @param string $name
     * @return $this
     */
    public function setName($name)
    {
        return $this->setData(self::KEY_NAME, $name);
    }

    /**
     * @param int $position
     * @return $this
     */
    public function setPosition($position)
    {
        return $this->setData(self::KEY_POSITION, $position);
    }

    /**
     * @param float $price
     * @return $this
     */
    public function setPrice($price)
    {
        return $this->setData(self::KEY_PRICE, $price);
    }

    /**
     * @param string $description
     * @return $this
     */
    public function setCategoryDescription($description)
    {
        return $this->setData(self::KEY_CATEGORY_DESC, $description);
    }

}

# generate admin level access key
curl -XPOST -H 'Content-Type: application/json' http://magento-url/rest/V1/integration/admin/token -d '{ "username": "user-name", "password": "admin-password" }'
```

## Backend

* system configuration
  - system.xml:Tab => Section => Group => Filed
    + translate: it is used to translate the label text that is used for tab rendering.
    + `sort_order`: It describe the tab position with other tabs.
    + id : it is unique name to identify tab of configuration
    + showInDefault: means this section will be shown when default value is selected in current configuration scope.
    + showInWebsite: means this section will be shown when a website is selected in current configuration scope.
    + showInStore: means this section will be shown store is selected in current configuration scope.
    + fields type
        + checkbox,
        + checkboxes,
        + column,
        + date,
        + editablemultiselect,
        + editor,
        + fieldset,
        + file,
        + gallery,
        + hidden,
        + image,
        + imagefile,
        + label,
        + link,
        + multiline,
        + multiselect,
        + note,
        + obscure,
        + password,
        + radio,
        + radios,
        + reset,
        + select,
        + submit,
        + text,
        + textarea,
        + time
  - configuration option values are store in `core_config_data` table.

```XML
<?xml version="1.0"?>
<!--
/**
 * file dir: magento2_root/app/code/JRB/Customconfig/etc/adminhtml/system.xml
 */
-->
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="urn:magento:module:Magento_Config:etc/system_file.xsd">
    <system>
        <tab id="my_custom_tab" translate="label" sortOrder="1000">
            <label>Custom tab</label>
        </tab>
        <section id="my_custom_section" translate="label" type="text" sortOrder="100" showInDefault="1" showInWebsite="1" showInStore="1">
            <label>Custom section</label>
            <tab>my_custom_tab</tab>
            <resource>JRB_Customconfig::config</resource>
            <group id="my_custom_group" translate="label" type="text" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                <label>Custom Group</label>
                <field id="my_custom_field" translate="label" type="text" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
                    <label>Custom field</label>
            <comment><![CDATA[Custom text field]]></comment>
                </field>
                <field id="mycustom_image" type="image" sortOrder="10" showInDefault="1" showInWebsite="1" showInStore="1">
    <label>My custom image</label>
    <backend_model>Magento\Config\Model\Config\Backend\Image</backend_model>
    <upload_dir config="system/filesystem/media" scope_info="1">catalog/product/custom_image</upload_dir>
    <base_url type="media" scope_info="1">catalog/product/custom_image</base_url>
</field>
            </group>
        </section>
    </system>
</config>
```

## method

* `_forward()`:not change the request url
* `_redirect()`:change the request url

## DB

* 修改脚本后要修改模块版本号,升级跟版本号有关
* type
  - static: 升级数据库
  - int: 字段添加到到customer_entity_int中,eav_attribute:字段映射表,升级数据就行
* script
    - installSchema：for the first time when installing the module,只在第一次安装模块时执行
        + remove the information that let Magento know your module has installed in the system. Please open the table ‘setup_module’, find and remove a row has module equals to vendor_module `DELETE FROM setup_module WHERE module='<Vendor>_<Module>'`
        + install by composer:`php bin/magento module:uninstall -r <Vendor>_<Module>`
    - UpgradeSchema：If you installed the module before, you will need to upgrade module and write the table create code to the UpgradeSchema.php. change attribute setup_version greater than current setup version in module.xml
    - InstallSchema:This file is executed first just after your modules registration (Means just after your module & its version entries are done in to the table -> setup_module ). This file is used to create tables with their columns attribute into your database that are later used by the new installed module.
    - InstallData: This file is executed after InstallSchema.php: . It is used to add data to the newly created table or any existing table.
    - UpgradeSchema: This file comes with the module & runs only then, if you are already having that modules previous version installed in your magento(Means it has entry of its previous version into the table -> setup_module ). It is used to manipulate the table related to the module(Means it is used to alter the table schema means columns attribute & to add new column into that table).change attribute setup_version greater than current setup version in module.xml
    - UpgradeData: runs after UpgradeSchema.php . It is having the same concept as InstallData: has but using this file you can change/alter the database contents without the use of model files. You can also use this file to add new content to the database same us But same like UpgradeSchema.php it will also runs only then if you are having that modules previous version installed in your magento.

```php
bin/magento setup:db:status
bin/magento setup:db-schema:upgrade
bin/magento setup:db-data:upgrade
bin/magento dev:query-log:enable

if (version_compare($context->getVersion(), '0.9.2', '<')) {
    $customerSetup->addAttribute(
        Customer::ENTITY,
        'agreed_status',
        [
            'type' => 'int',
            'label' => 'Agreed Status',
            'input' => 'text',
            'visible' => true,
            'required' => false,
            'system' => false,
            'sort_order' => 150,
            'position' => 150
        ]
    );
    $customerSetup->getEavConfig()->getAttribute(Customer::ENTITY, 'jde_accountno')
        ->setData('used_in_forms', ['adminhtml_customer'])
        ->save();
}
```

## 获取数据

```php
Authorization: Bearer <authentication token>

$customer->getId()　　# 通过token获取用户信息
$customer = $this->customerRepository->getById($customerId);
```

## Indexer

```
bin/magento indexer:reindex
bin/magento indexer:status
```

## observer

hook action

## auth

* New public and private keys are now associated with your account that you can click to copy
* Save this information or keep the page open when working with your Magento project
* Use the Public key as your username and the Private key as your password
* 在根目录中创建一个新文件auth.json
* 后台接口:需要admin token `<resource ref="Magento_Customer::customer"/>`

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

## Model

* required cache clear:IdentityInterface. The IdentityInterface will force Model class define the getIdentities() method which will return a unique id for the model.
* model file contain overall database logic
* The resource model will execute sql queries
* collection model is considered a resource model which allow us to filter and fetch a collection table data

## GRAPHQL

* module/etc/schema.graphqls
* type
    - Query:search object
    - Mutation:performing CRUD operations
* filters
    - input:query conditons
* result obejct fileds
* 聲明module
* 添加graphQL
* 添加後臺配置
* 客户端工具会自动拉取文档
* 使用快捷鍵生成query

```
# http://www.magento-dev.com/graphql
{
  products(
    filter:{
      price:{
        gt:"45"
      }
    }
  )
  {
    items {
      name
    }
  }
}
```

## plugin

* interceptor system:A class which will intercept and modify the behaviour of a public method is referred to as plugins
  - Intercepting a method call can be done by running code before, after, and around that method call
  - This allows you to substitute or extend the behaviour of original, public methods for any class or interface.
  - Field
    + type name: The class or interface to which your module wants interfere
    + plugin name: An unique name that identifies your plugin name. It also used to merge the configurations for the plugin
      + plugin type: Name of plugin’s class or its virtual type. e.g: \Vendor\Module\Plugin\<ModelName>\Plugin

```xml
# di.xml
<config>
    <type name="observed_type">
        <plugin name="plugin_name" type="plugin_class_name" sortOrder="sort_order_number" disable="true|false"></plugin>
    </type>
</config>
```
```php
namespace \Vendor\Module\Plugin\ModelName;

class ProductPlugin
{
    public function aroundSave(\Magento\Catalog\Model\Product $subject, callable $proceed)
    {
        doSomethingBeforeGettingSave
        $returnValue = $proceed();
        if ($returnValue){
            $this->doSomeOtherWork()
        }

        return $returnValue;
    }

    public function afterGetPrice(\Magento\Catalog\Model\Product $subject, $result)
    {
        return $result + 1;
    }

    public function beforeSetPrice(\Magento\Catalog\Model\Product $subject, $price)
    {
        return [$price + 1];
    }
}
```

## Order

* Order Status
    - Processing Pending->Payment Suspected Fraud->Payment Review->Pending On Hold Complete Closed Canceled Pending PayPal
* Order State
    - ->submit->Pending Payment->Processing->Order shipped->Order shipped->Complete->in_transit->Closed Canceled On Hold Payment Review

CHECKOUT, PAYMENT, & SHIPPING
One-Page Online Checkout
Integrated for Real-Time Shipping Rates from UPS®, FedEx®, and USPS®
Option on Credit Card Transactions to Authorize and Charge or Authorize Only and Charge on Creation of Invoices
Integrated with Amazon Payments, PayPal, Authorize.net, and Google Checkout
Ability to Accept Checks, Money Order, and Online Purchase Orders
SSL Security Support for All Online Order and Sensitive Transactions
Online Tax and Shipping Calculation and Prior to Checkout Estimates
Option to Create Account as Part of Online Checkout Process
Gift Message Management
Configurable Saved Cart Expiration
Multiple Shipping Address Management
Online Order Tracking from Customer Account
Ability to Manage Multiple Shipments on a Single Online Order
Destination Country Management
Per Order and Per Item Flat Rate Shipping Option
Free Shipping Functionality
Manage Shipping by Weight and Destination
 
SEARCH ENGINE OPTIMIZATION (SEO)
Light Footprint Design for Fast Load Time and Search Engine Optimization
Google Site Map Creation and Site Map Auto Generation
Search Engine Friendly URL’s Including URL ReWrite Controls
META Information Management at Product and Category Levels
Auto-Generated Popular Search Terms Page
 
ANALYTICS AND REPORTING
Integration with Google Analytics
Admin Report Dashboard with Business Overview
Sales Reports Including Total Sales and Returns
Tax Reports
Abandoned Shopping Cart Reports
Best Viewed Products Reports
Top Sold Products Report
Low Stock Item Report
Onsite Search Terms Report
Product Reviews Report with RSS Support
Tags Report with RSS Support
Coupon Usage Report
 
MARKETING PROMOTIONS AND TOOS
Online Poll Creation and Management
Newsletter Management
Landing Page Creation Tools
Catalog Promotional Pricing and Controls
Flexible Coupons Rule and Pricing Restrictions
Free Shipping Promotion Management
Multi-Tier Pricing for Volume Discounts
Bundled Products Options
Customer Group Pricing
Recently Viewed Products
New Items Promotional Tool
On Page and In Shopping Cart Upsells and Cross Sells
Send to a Friend and Wishlist Management
 
ORDER MANAGEMENT
View, edit, create and fulfill orders from admin panel
Create one or multiple invoices, shipments and credit memos per order to allow for split fulfillment
Print invoices and packing slips
-
 Call Center (phone) order creation − Includes ability to create new
customer, or select existing customer and view - shopping cart,
wishlist, last ordered items, and compared products list, as well as
select addresses, give discounts and assign custom prices
Create re-orders for customers from administration panel
Email Notifications of Orders
RSS feed of New Orders
 
CUSTOMER SERVICE
Contact Us form
Feature-rich Customer Accounts
Order History with Status Updates
Order Tracking from Account
Password Reset email from front-end and admin panel
Order and Account Update Emails
Customizable Order Emails
Create and Edit Orders from the Admin Panel
 
CUSTOMER ACCOUNTS
Order status and history
Re-orders from account
Recently ordered items
Address Book with unlimited addresses
Default Billing and Shipping addresses
Wishlist with ability to add comments
Email or Send RSS feed of Wishlist
Newsletter Subscription management
Product Reviews submitted
Product Tags submitted
 
CATALOG MANAGEMENT
Inventory Management with Backordered items, Minimum and Maximum quantities
Batch Import and Export of catalog
Batch Updates to products in admin panel
Google Base Integration
Simple, Configurable (e.g. size, color, etc.), Bundled and Grouped Products
Virtual Products
Downloadable/Digital Products
Customer Personalized Products – upload text for embroidery, monogramming, etc.
Tax Rates per location, customer group and product type
Attribute Sets for quick product creation of different item types
Create Store-specific attributes on the fly
Media Manager with automatic image resizing and watermarking
Advanced Pricing Rules and support for Special Prices (see marketing tools)
Search Results rewrites and redirects
Approve, Edit and Delete Product Tags
Approve, Edit and Delete Product Reviews
-
 RSS feed for Low Inventory Alerts Customer Personalized Products –
Upload text for embroidery, monogramming, etc. (this one is
already there, but want to have the following shown after it)
Customer Personalized Products – Upload Image
Customer Personalized Products – Select Date/Time options for products
Customer Sorting – Define Attributes for Customer
Sorting on category (price, brand, etc.)
 
PRODUCT BROWSING
Multiple Images Per Product
Product Image Zoom-in Capability
Product Reviews
Related Products
Stock Availability
Multi-Tier Pricing Upsell
Product Option Selection
Grouped Products View
Add to Wishlist
Send to a Friend with Email
 
CATALOG BROWSING
Layered / Faceted Navigation for filtering of products in categories
Layered / Faceted Navigation for filtering of products in search results
Flat Catalog Module for Improved Performance with large catalogs
Static Block tool to create category landing pages
Ability to assign designs on category and product level (unique design per product/category)
Configurable search with auto-suggested terms
Recently viewed products
Product comparisons
Recently compared products
Cross-sells, Up-sells and Related Items
Popular Search Terms Cloud
Filter by Product Tags
Product Reviews
Product listing in grid or list format
Breadcrumbs

## varnish

* 两级缓存：框架->varnish
* https://varnish-cache.org/docs/6.3/
* https://www.linode.com/docs/websites/varnish/getting-started-with-varnish-cache/

```
varnishncsa -F '%U%q %{Varnish:hitmiss}x'
```

## Exception

* magento 定義各種exception
    - \Magento\Framework\Exception\LocalizedException
* 方便前端错误封装以及不同语言的对应

```php
 public function massCopyToCheckout($customerId, $cartId, $itemIds = []) {
        try {
            if (!empty($itemIds)) {
                $checkoutQuote = $this->getCheckoutQuote($customerId);
                $cartItems = $this->quoteItemRepository->getList($cartId);

                foreach ($itemIds as $itemId) {
                    $itemAlreadyInCart = false;
                    foreach ($checkoutQuote->getItems() as $item) {
                        if ($item->getLinkedItemId() == $itemId) {
                            $itemAlreadyInCart = true;
                            continue;
                        }
                    }

                    if (!$itemAlreadyInCart) {
                        foreach ($cartItems as $item) {
                            if ($item->getId() == $itemId) {
                                $checkoutItem = clone $item;
                                $checkoutItem->setId(null);
                                $checkoutItem->setLinkedItemId($item->getId());
                                $checkoutQuote->addItem($checkoutItem);
                            }
                        }
                    }
                }

                $checkoutQuote->collectTotals();
                $this->quoteRepository->save($checkoutQuote);

                return true;
            }
        } catch (LocalizedException $e) {
            throw new LocalizedException(__('Parameter itemIds may be wrong'));
        }
    }

# 沒有exception,抓不到
```

## 用户

* 类型
    - Associate
    - Preferred

## 后台

* 配置level:website->store->storeview
* storecode: all stores 添加配置

```xml
<group id="success_tracker" translate="label"   type="text" sortOrder="1" showInDefault="1" showInWebsite="1" showInStore="1">
    <label>Success Tracker</label>
    <field id="success_tracker_blockid" translate="label comment" type="select" sortOrder="180" showInDefault="1" showInWebsite="1" showInStore="1">
        <label>Success Tracker T&amp;C Block</label>
        <source_model>Tmo\Backend\Model\Config\Source\Blocks</source_model>
    </field>
</group>
```

## Tax

* tax rules
* tax zones and Rates
* tax class
    - kind
        + Customer — You can create as many customer tax classes as you need, and assign them to customer groups. For example, in some jurisdictions, wholesale transactions are not taxed, but retail transactions are. You can associate members of the Wholesale Customer group with the Wholesale tax class.
        + Product — Product classes are used in calculations to determine the correct tax rate is applied in the shopping cart. When you create product, it is assigned to a specific tax class. For example, food might not be taxed, or be taxed at a different rate.
        + Shipping — If your store charges an additional tax on shipping, you should designate a specific product tax class for shipping. Then in the configuration, specify it as the tax class that is used for shipping.
    - setting:Stores > Settings > Configuration->sales->tax->tax class

## 框架

* class interface not found: 在code 中生成
* EVA
    - eav_entity_type  根据type 获取类型id
    - eav_attribute:获取类型属性id
* product 
    - image detail role:`SELECT * FROM catalog_product_entity_varchar where entity_id=59 and attribute_id in (87,88,89,128) order by store_id asc;`
    - `SELECT * FROM magento.catalog_product_entity_int where attribute_id =97;`

```sql
# 获取商品的enable 状态
SELECT entity_id FROM `catalog_product_entity_int` WHERE attribute_id = (SELECT attribute_id FROM `eav_attribute` WHERE `attribute_code` LIKE 'status') AND `catalog_product_entity_int`.value = 2

```

## 迁移数据库

* This project doesn't support inserting the domain automatically since it has two subdomains for different websites. update core_config_data set value='http://api.mannatech.com.test/' where config_id=22;

## 问题

* 不能直接获取数据结构：entity one big data can't var_dump
* Error 503 Backend fetch failed：access forbidden by rule, request: "GET /pub/health_check.php HTTP/1.1"
* Call to a member function getNext() on null in generated/code/Magento/User/Model/User/Interceptor.php/app/code/Magento/Backend/Model/Locale/Manager.php#L96-L100
* composer 後需要從新開啓cache
* new extension 返回404
* generate 權限問題：強力刪除，magento 密碼 magento

```php
// Add the following code
if ($userData) {
  $userData->___init();
}

if ($userData && $userData->getInterfaceLocale()) {
    $interfaceLocale = $userData->getInterfaceLocale();
} elseif ($this->getGeneralLocale()) {
    $interfaceLocale = $this->getGeneralLocale();
}

## accountLogin.php 权限验证：郵箱登錄問題：因爲websiteId 的問題
$customer = $this->accountAuthenticator->authenticateWithoutPassword($accountId);

public function authenticateWithoutPassword($username) {
    try {
        $customer = $this->customerRepository->get($username);
    } catch (NoSuchEntityException $e) {
        throw new InvalidEmailOrPasswordException(__('Invalid login or password.'));
    }
}

# health_check 500
<?php
/**
 * Copyright © Magento, Inc. All rights reserved.
 * See COPYING.txt for license details.
 */

use Magento\Framework\Config\ConfigOptionsListConstants;

register_shutdown_function("fatalErrorHandler");

try {
    require __DIR__ . '/../app/bootstrap.php';
    /** @var \Magento\Framework\App\ObjectManagerFactory $objectManagerFactory */
    $objectManagerFactory = \Magento\Framework\App\Bootstrap::createObjectManagerFactory(BP, []);
    /** @var \Magento\Framework\ObjectManagerInterface $objectManager */
    $objectManager = $objectManagerFactory->create([]);
    /** @var \Magento\Framework\App\DeploymentConfig $deploymentConfig */
    $deploymentConfig = $objectManager->get(\Magento\Framework\App\DeploymentConfig::class);
    /** @var \Psr\Log\LoggerInterface $logger */
    $logger = $objectManager->get(\Psr\Log\LoggerInterface::class);
} catch (\Exception $e) {
    http_response_code(500);
    exit(1);
}

// check mysql connectivity
foreach ($deploymentConfig->get(ConfigOptionsListConstants::CONFIG_PATH_DB_CONNECTIONS) as $connectionData) {
    try {
        /** @var \Magento\Framework\DB\Adapter\Pdo\Mysql $dbAdapter */
        $dbAdapter = $objectManager->create(
            \Magento\Framework\DB\Adapter\Pdo\Mysql::class,
            ['config' => $connectionData]
        );
        $dbAdapter->getConnection();
    } catch (\Exception $e) {
        http_response_code(500);
        $logger->error("MySQL connection failed: " . $e->getMessage());
        exit(1);
    }
}
// check cache storage availability
$cacheConfigs = $deploymentConfig->get(ConfigOptionsListConstants::KEY_CACHE_FRONTEND);
if ($cacheConfigs) {
    foreach ($cacheConfigs as $cacheConfig) {
        // allow config if only available "id_prefix"
        if (count($cacheConfig) === 1 && isset($cacheConfig['id_prefix'])) {
            continue;
        } elseif (!isset($cacheConfig[ConfigOptionsListConstants::CONFIG_PATH_BACKEND]) ||
            !isset($cacheConfig[ConfigOptionsListConstants::CONFIG_PATH_BACKEND_OPTIONS])) {
            http_response_code(500);
            $logger->error("Cache configuration is invalid");
            // phpcs:ignore Magento2.Security.LanguageConstruct
            exit(1);
        }
        $cacheBackendClass = $cacheConfig[ConfigOptionsListConstants::CONFIG_PATH_BACKEND];
        try {
            /** @var \Zend_Cache_Backend_Interface $backend */
            $backend = new $cacheBackendClass($cacheConfig[ConfigOptionsListConstants::CONFIG_PATH_BACKEND_OPTIONS]);
            $backend->test('test_cache_id');
        } catch (\Exception $e) {
            http_response_code(500);
            $logger->error("Cache storage is not accessible");
            // phpcs:ignore Magento2.Security.LanguageConstruct
            exit(1);
        }
    }
}

/**
 * Handle any fatal errors
 *
 * @return void
 */
function fatalErrorHandler()
{
    $error = error_get_last();
    if ($error !== null && $error['type'] === E_ERROR) {
        http_response_code(500);
    }
}

```

## 工具

* ERP
    - SAP Business One 拥有小型的在线商务，这款Magento的ERP解决方案非常适合满足你所有当前和未来的商业需求。合理的价格也是选择这个系统的一大优点。SAP的功能包括销售流程管理，仓库详细信息跟踪，人力资源和潜在客户数据维护等。Magento平台加入SAP可以处理以下任务：将客户数据从SAP导入到Magento；将订单信息从Magento平台导出到SAP；同步库存，定价和目录清单。
    - NetSuite这个基于云的ERP系统在全球范围内非常流行，服务于100多个国家的20000多家企业。它提供实时可见性和报告功能，使你的决策过程非常快速和及时。 你可以轻松地配置、定制和升级任何已排序的模块或任何各种业务操作。与Magento平台一起，它可以提供以下内容：从NetSuite进口货物到Magento;使用Magento Side Queuing函数处理NetSuite中的数据;管理NetSuite中的产品信息，以便在Magento中进一步更新;将订单和客户数据从Magento导出到NetSuite;将数据直接提取或加载到NetSuite中以集成碎片数据
    - Microsoft Dynamics AXMS Dynamics是一个成熟的数字解决方案，通过智能客户账户管理和订单创建工具简化工作流程。 它有助于快速简单的订购流程，从而增强客户体验。 作为最好的Magento ERP系统之一，它为你提供了许多非常有用的电子商务功能，如多种语言和货币支持，以及强大的交付，营销和SEO优化工具集等等。通过与Magento电子商务平台集成，你可以执行以下操作：将客户更新功能导入Magento;从Magento到MS Dynamics AX的订单结果导出;从Magento向Dynamics出口客户创建功能;将目录数据导入Magento;在Magento和MS Dynamics AX之间同步编辑/更新的订单数据。
    - Sage ERP.该ERP软件包适用于任何类型和规模的在线业务。 正如公司网站上报道的那样，Sage主要用于处理财务和企业管理。 此Magento ERP使你可以借助移动，云和内部部署管理工具来控制你的网上商店。 它非常适合制造，批发和服务流程。使用Sage ERP的Magento平台将能够：可跟踪库存细节;可跨部门、跨语言、跨立法合作；可使用总分类帐，预算，成本会计等管理财务流程;可控制采购，现金流;可更新客户信息。
    - Epicor这种价格低廉到中等价位的ERP完善了我们针对Magento平台的最佳ERP解决方案列表。 Epicor是一款端到端的ERP软件，可以帮助你有效地管理后台办公流程，如计划和调度，人力资本，生产，绩效和客户关系管理。 该数字解决方案在140个国家/地区拥有20,000多个客户，其本地化版本约有30种语言。 此外，Epicor在促进客户需求、项目执行、减少浪费和服务协调等方面具有很大的便利性和灵活性。与Magento平台Epicor保持一致可以让你：保存有信誉的产品的历史记录；提供可行的VAR（增值经销商）渠道;支持MS / SQL / SOA技术解决方案;在各部门之间获得更大的数据连通性;可采用强大的财务分析
* docker
    - https://github.com/markshust/docker-magento
    - https://github.com/magento-notes/magento2-exam-notes
    - https://github.com/clean-docker/Magento2
    - https://github.com/webkul/magento2-varnish-redis-ssl-docker-compose
    - https://github.com/fballiano/docker-magento2

## 参考

* [Magento2解决方案专家认证](https://u.magento.com/certified-magento2-solution-specialist):75个多项选择题 90分钟完成考试
* [marketplace](https://marketplace.magento.com)
* [Docs](https://devdocs.magento.com/)
* [samples](https://github.com/magento/magento2-samples)
* https://magento.com/technical-resources
* https://devdocs.magento.com/#/individual-contributors
* https://devdocs.magento.com/guides/v2.3/config-guide/
* [awesome-magento2](https://github.com/DavidLambauer/awesome-magento2)
* [](https://bbs.mallol.cn)
