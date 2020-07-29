# Oracle

## 查询

* 过滤条件放置于where后，为在结果树生成完成后裁剪叶子节点
* 过滤条件放置于connect by后，为在生成树的过程中裁剪子树
* CBO估算返回结果集偏差，引起执行计划不准确
* 层次查询的SQL直接使用parallel的hint，会遭遇并行串行化的问题，也就是不能真正并行。对于一些重要且耗时长的层次查询，可以考虑PIPELINED TABLE FUNCTION改写SQL的方式来实现。
