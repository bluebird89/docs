## BA Business Analyst

* Produce and explore requirements in collaboration with users, at a different level of detail to what is required following the traditional blue process methodology
* Facilitate and participate in discovery workshops aimed at engaging with potential and existing users to understand their needs and pains
* Facilitate and participate in inception workshops to create a shared understanding of user needs and the potential technology solution required to deliver to these needs
* Identify user journeys which map out how a user will go through the system
* Identify features, epics and user stories
* Write stories that adhere to the quality and standards of INVEST principles; break down larger stories into smaller, manageable chunks if necessary
* Identify missing requirements in collaboration with Product Owner
* Work with the Product Owner and QAs to develop acceptance criteria or test cases for the system
* Mentor developers, testers and user experience team on how things work in the business domain
* Work ahead of the team to get clarity on requirements before the next iteration
* Wear different hats: UX designer, tester, facilitator, product owner, etc., as needed
* Work very closely with user experience (UX) team to ensure that processes, wireframes/rough sketches and content are optimally intuitive to end-users
* Help the UX analysts in conducting user testing and feed in the feedback items to the backlog
* Create a shared understanding of what the product is supposed to do, within the team
* Lead and facilitate story estimation sessions with the technical team members
* Manage the stories (in the electronic tool), ensuring that all requirements are loaded as stories, ensuring the stories are assigned to epics and ensure that stories are addressed in the correct iterations
* Liaise continuously with business, product owner and the developers to ensure that the prioritisation of stories is correct and that if stories are blocked, these stories are assigned to other iterations and new stories identified to replace them in the current iteration
* Facilitate story kick offs when the story is picked up by developers - do a kick off with the PO, UX, Devs, and the QA to have a shared understanding of the acceptance criteria and the kind of testing to be done for that story
* Facilitate story desk checks on Dev machine when the story is done by developers – do a desk check with the PO, UX, Devs, and the QA to check if al the acceptance criteria of the story are developed and the functionality is working as expected to reduce the feedback loop/ping pong between developers, QAs and PO
* Facilitate informal story showcases to PO when a story has been QA-tested
* Showcase stories that are QA-tested at the end of an iteration to stakeholders 6
* Facilitate discussions between members of the team and product owner and other stakeholders for requirements clarity and understanding
* Perform UAT on completed stories
* Maintain a constant line of communication with the PO and IM: when stories needed to be prioritised, or when defects are found, to raise potential risks that may affect a story
* Constantly help the PO to re-prioritise the backlog along with the IM as and when there are changes in requirements or bugs arise or any issues surface

## [汉堡法拆分用户故事](https://mp.weixin.qq.com/s/lim4x3ClVuqkKg0lUPu-9w)

* 确定汉堡包的层次:对该用户故事进行实现过程抽象
  - 查询数据库
  - 输入界面
  - 数据处理
  - 邮件通知
  - 推送通知
* 为步骤1定义的层次确定替代方案
  - 查询数据库：可以批量或实时查询数据库。
  - 输入界面：可以单独输入或批量输入。
  - 数据处理：直接发送DB保存或优化处理保存。
  - 邮件通知：手工或者自动通知、个性化配置通知。
  - 推送通知：简单推送、用户行为推送
* 删除重复的不必要的任务，并根据需要组合任务
  - 不需要导入操作，因为导入功能将通过批量上传来覆盖。另外，在此阶段，无需从其他格式导入食谱
* 根据最终用户的业务价值对任务进行排序
  - 查询数据库：批量查询是由实时查询功能组成的，因此优先实现实时查询。
  - 输入画面：批量输入是由单独输入功能组合而成，因此优先实现单独输入。
  - 数据处理：直接将数据保存数据库是优化保存的基础，因此先实现直接保存数据库。
  - 邮件通知：自动发送 > 个性化发送 > 手工发送（基于社群需要单独实现界面）。
  - 推送通知：简单推送是基于食谱上传触发的，而用户行为推送则是基于社群的，因此优先实现简单推送。
* 第一口: 从上往下选择一些任务成为你的“第一口”。有时，可以在同一个层中选取多个任务，也可以在一层中不选择任何任务
  - 第一口将是第一个将被实现的用户故事
* 一次只咬一口:根据实际情况来确定下一口（用户故事），直至全部吃完
* 优势
  - 每次选择或者思考都聚焦于最有价值的内容

- 这种方法十分灵活，根据实际条件的变化可以对实现内容进行灵活组合
