# [istanbul](link)

```sh
npm install -g istanbul

istanbul cover simple.js
# 用来设置门槛，同时检查当前代码是否达标 百分比
istanbul check-coverage --statement 90

# 设置绝对值门槛，比如只允许有一个语句没有被覆盖到
# istanbul check-coverage --statement -1
```
