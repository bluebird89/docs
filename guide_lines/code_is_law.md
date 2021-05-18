# Code is Law

* 所有的改动必须有 pre commit hook —— 代码的风格和静态检查，代码编译，单元测试，文档的自动生成都必须通过，才能 commit
* 所有的改动必须发 pull request，要 up to date，CI 通过，有至少一个 review 才能 merge
* 每个 PR 的 merge 必须是 squash merge，不能是 rebase 或者 merge
* 每个 PR 必须 bump version，在 merge 到 master 之后，必须要有相关的 changelog，并且创建一个 github release
* 如果是编译型的语言，编译后的结果要放在对应的 github release 上
* 如果是 static web site，生成的结果要放在对应的 S3 bucket 上，可以直接访问
