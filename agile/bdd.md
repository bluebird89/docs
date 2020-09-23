# BDD，Behavior Driven Development，行为驱动开发

* 产生背景：开发软件系统最困难的部分就是准确说明开发什么” (“The hardest single part of building a software system is deciding precisely what to build” — No Silver Bullet, Fred Brooks)，不同角色有着不同的领域知识，说着不同的语言，必然会产生沟通代沟，导致理解的不一致性
* 提出者Dan North强调BDD不是关于测试的，它是在应用程序存在之前，写出用例与期望，从而描述应用程序的行为，并且促使在项目中的人们彼此互相沟通
* 定义
  - 关注的是业务领域，而不是技术：BDD强调用领域特定语言（DSL, domain specific language）描述用户行为，定义业务需求，而不会关心系统的技术实现
  - 不是工具，强调的是一种协作方式：BDD要求各个角色共同参与系统行为的挖掘和定义，以实现对业务价值的一致理解
  - 不是关于测试的：BDD源自TDD,目的不是自动化测试，但是可以有效指导自动化测试，基于BDD的自动化测试相当于维护了一份需求活文档，对项目需求的维护和管理非常有价值。所强调的沟通与协作可以指导更好的做自动化测试
  - 全栈敏捷方法：BDD促使团队所有角色从需求到最后的测试验证，进行高度的协作和沟通，以交付最有价值的功能。
* 采用统一的领域特定语言（DSL）来描述业务场景和用户行为，让团队各个不同角色对业务需求有一致认识，从而做到更有效的沟通和更高效的协作

## 愿景

* 协作：多个角色在一个团队，如何从一致理解需求开始高效协作？
* 语言：不同的角色业务、开发和测试人员分别说自己的语言，如何统一语言，更有效的沟通？
* 文档：编写和维护的成本都很高，如何低成本的维护一份有价值的文档？

## 怎么做

* 用例场景的描述格式“GIVEN... WHEN... THEN... ”
* 业务层抽取，业务语言描述
  - 根据业务层的数据流，在每个数据停留点进行纵切，抽取出一个个用例场景
  - 描述语言一定是业务领域可懂的，不要涉及任何实现相关的技术细节
  - 所描述的场景一定是从业务层抽象出来，体现真实业务价值的
* 技术人员可懂，自动化友好
  - 所描述的用例场景要能驱动开发，必须要让技术人员易于理解
  - 要指导自动化测试，还得要求对于自动化的实现是友好的。这一点似乎是跟第一点有些矛盾，但严格遵守BDD的格式要求还是可以做到的。
    + GIVEN从句描述的是场景的前提条件、初始状态，通常是一种现在完成时态
    + WHEN从句是采取某个动作或者是发生某个事件，一定是动词，通常是一般现在时
    + THEN从句用“应该…(should be…)”来描述一种期望的结果，而不用断言（assert），后者与测试关联更紧密
- 数据驱动，需求实例化
  + 抽象的业务语言描述的需求，往往由于太抽象而缺失掉很多关键信息，导致不同人员对需求理解的不一致。想要既抽象又能包含细节信息，就需要采用需求实例来描述。简单说来，就是给场景用例举例说明。
  + 举例就会需要列举数据，如果在场景用例描述里边直接添加数据实例，那样的用例将会很混乱，可读性和可维护性都非常差。
  + 如果能够在描述场景的用例里边用一些变量来代替，把变量对应的值（数据）提取出来存为一个表格或者独立的文件，这样将会使得用例的可读性很好，而且也不会缺失细节信息（数据），后期的维护和修改也较为方便。这就是数据驱动的方法来描述实例化的需求。

```
功能:
场景:
假设:
当:
并且:
那么:

# 检查收件箱，可以看出第三个清晰明了且能体现业务价值，比较符合上面
Scenario: Check Inbox
Given a user "Tom" with password "123"
And a user "Jerry" with password "abc"
And an email to "Tom" from "Jerry"
When I sign in as "Tom" with password "123"
Then I should see one email from "Jerry" in my inbox
Scenario: Check Inbox
Given a user "Tom"
And a user "Jerry"
And an email to "Tom" from "Jerry"
When I sign in as "Tom"
Then I should see one email from "Jerry" in my inbox
Scenario: Check Inbox
Given I have received an email from "Jerry"
When I sign in
Then I should see one email from "Jerry" in my inbox

# 限制非法用户查看某些受限内容，BDD强调什么（What），而不是怎么（How），第二个写的比较好。

Scenario: Redirect user to originally requested page after logging in
Given a user "Tom" exists with password "123"
And I am not logged in
When I navigate to the home page
Then I am redirected to the login form
When I fill in "Username" with "tom"
And I fill in "Password" with "123"
And I press "Login"
Then I should be on the home page
Scenario: Redirect user to originally requested page after logging in
Given I am an unauthenticated user
When I attempt to view some restricted content
Then I am shown a login form
When I authenticate with valid credentials
Then I should be shown the restricted content

# 添加图书到购物车并计算总额。

Scenario: Books add to shopping cart with correct number and total price
Given a book "BDD" with price "30.5"
And a book "Cucumber" with price "25.8"
When I select "BDD"
And I click the add to shopping cart button
Then I should see one "BDD" in my shopping cart
And the total price is "30.5"
When I select "Cucumber"
And I click the add to shopping cart button twice
Then I should see two books "Cucumber" in my shopping cart
And the total price is "82.1"
Scenario Outline: Books add to shopping cart with correct number and total price
Given book <name1> with <price1>
And book <name2> with <price2>
When I add <number1> book <name1> and <number2> book <name2> to shopping cart
Then I should see book <name1> and <name2> in my shopping cart
And the total price should be <total>
Examples:
| name1 | price1 | number1 | name2 | price2 | number2 | total |
| BDD | 30.5 | 1 | - | - | - | 30.5 |
| Cucumber | 25.8 | 2 | - | - | - | 51.6 |
| BDD | 30.5 | 1 | Cucumber | 25.8 | 2 | 82.1 |

SEE HomePage
DO [Click] "Login".Button
REACT Success: SHOW "Login Success".Toast with ANIMATE(bounce)
```

## 好处

把利益关系人、交付团队等不同方面的项目相关人员集中到一起，形成共同的理解，共同的价值观以及共同的期望值

* 关注用户行为
* 交付最有用的功能
* 在团队内部维护一致的术语
* 探究需求实例
* 编写和维护需求
* 创建活的文档
* 消除协作与沟通障碍

## 适合项目

* 简单的一次性项目，沟通交流成本都较低的情况下，没有必要使用BDD
* 业务比较轻量，重在技术方面的项目，可以只使用TDD，或者简单的白板上的BDD，不需要在BDD工具记录需求用例文档；
* 业务复杂、团队成员较多的项目，沟通成本高，BDD很有必要。

## 痛点

* Cucumber框架实现Web自动化测试包括两个部分：Feature（特性）文件和Step Definition（测试实现），在实际应用中人们普遍感觉到它的复杂。
* Cucumber特别强调的是协作，Feature文件通常由偏业务的人员来编写，要求遵循Given-When-Then的格式。这种固定的语法对编写人员要求较高，写起来比较费劲，尤其对新人不友好，很多团队反映要写出好的Feature文件特别费时费力
* Cucumber支持多种语言实现测试代码，但本身并不能实现自动化，对于Web自动化测试需要跟其他自动化工具结合，比如Selenium-WebDriver。实现代码不仅复杂，还有着元素定位难、执行时间长、不够稳定的痛点。

```
# Cucumber-js+Selenium WebDriver实现
Feature定义:
Feature: Google Search
  Scenario: Finding some cheese
    Given I am on the Google search page
    When I search for "Cheese!"
    Then the page title should start with "cheese"

Steps实现:
Given('I am on the Google search page', async function () {
  await driver.get('http://www.google.com');
});

When('I search for {string}', async function (searchTerm) {
  const element = await driver.findElement(By.name('q'));
  element.sendKeys(searchTerm, Key.RETURN);
  element.submit();
});

Then('the page title should start with {string}', {timeout: 60 * 1000}, async function (searchTerm) {
  const title = await driver.getTitle();
  const isTitleStartWithCheese = title.toLowerCase().lastIndexOf(`${searchTerm}`, 0) === 0;
  expect(isTitleStartWithCheese).to.equal(true);
});
```

## [behave/behave](https://github.com/behave/behave)

BDD, Python style

## 问题

* BDD与TDD/ATDD:TDD是测试驱动开发，ATDD是验收测试驱动开发，都是关于测试的，是与所开发的系统紧密联系的。而BDD则不同，前面提到过BDD不是关于测试的，着重关注需求、关注客户的业务价值，所描述的需求用例是可以独立于软件系统存在的，因为客户的业务是始终存在的，不取决于是否有软件系统来支撑。
* BDD与SBE: SBE(Specification By Example，实例化需求)是在BDD之后由Gojko提出来的，也是关于需求的，主要强调通过列举实例发现需求中的缺失概念。BDD也是关注需求的，同样会使用实例来描述行为。两者的本质没有区别，只是概念的差异。

## 课程

* [Learn BDD from the Cucumber team](https://school.cucumber.io/)

## 工具

* [Cucumber](https://cucumber.io/) 背后是一个名为 Gherkin 的 DSL，它用于描述需求及测试
* Twist
* Concordion

## 参考

* [说起BDD，你会想到什么？](https://mp.weixin.qq.com/s?__biz=MjM5MjY3OTgwMA==&mid=208047785&idx=1&sn=30ee6ee6e64a480c26c8c9ad02b07d4e)
