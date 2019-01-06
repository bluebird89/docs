# Crontab

Linux下的后台进程，用来定期的执行一些任务

## install

```sh
# ubunutu
sudo apt-get update
sudo apt-get install cron

# centos
sudo yum update
sudo yum install vixie-cron crontabs

# runs in the background
sudo /sbin/chkconfig crond on
sudo /sbin/service crond start
```

## use

* parameter
    - m:minute 0-59
    - h:hour 0-23
    - dom:day of month 1-31
    - mon:month 1-12
    - dow:day of work 0-6
* action
    - 星号:表示任意值，比如在小时部分填写 * 代表任意小时（每小时）
    - 逗号:可以允许在一个部分中填写多个值，比如在分钟部分填写 1,3 表示一分钟或三分钟 and
    - 斜线:一般配合 * 使用，代表每隔多长时间，比如在小时部分填写 */2 代表每隔两分钟。所以 */1 和 * 没有区别 */2 可以看成是能被2整除的任意值。 cycle

```sh
crontab -l
crontab -e
crontab -u <user> -e # edit another user’s by specifying
m h  dom mon dow   command

* * * * *                  # 每隔一分钟执行一次任务
0 * * * *                  # 每小时的0点执行一次任务，比如6:00，10:00
6,10 * 2 * *            # 每个月2号，每小时的6分和10分执行一次任务
*/3,*/5 * * * *          # 每隔3分钟或5分钟执行一次任务，比如10:03，10:05，10:06
*/4 2-6 * * * # run the command between the hours of 2:00am and 6:00am
* * * * * /usr/bin/php /var/www/domain.com/backup.php > /dev/null 2>&1

@hourly - Shorthand for 0 * * * *
@daily - Shorthand for 0 0 * * *
@weekly - Shorthand for 0 0 * * 0
@monthly - Shorthand for 0 0 1 * *
@yearly - Shorthand for 0 0 1 1 *

sudo service cron restart

crontab -r # erase your crontab

echo ALL >>/etc/cron.deny # we lock out all users by appending "ALL" to the deny file
echo tdurden >>/etc/cron.allow # To deny access to all users and give access to the user tdurden
```

## users

crontab文件对每个用户是独立分开

## process

* nohub:通过忽略 HUP 信号来使我们的进程避免中途被中断
* setsid:进程不属于接受 HUP 信号的终端的子进程
* 如果我们未加任何处理就已经提交了命令，该如何补救才能让它避免 HUP 信号的影响
    - 用disown -h jobspec来使某个作业忽略HUP信号。
    - 用disown -ah 来使所有的作业都忽略HUP信号。
    - 用disown -rh 来使正在运行的作业忽略HUP信号

```sh
nohup ping www.ibm.com &
nohup /usr/local/bin/php /mnt/cdrom/ppcbin/htdocs/crmd/yii  process/sync&
setsid ping www.ibm.com

jobs
```

## 工具

* [ouqiang/gocron](https://github.com/ouqiang/gocron):定时任务管理系统
* [bruceye777/cronmon](https://github.com/bruceye777/cronmon):定时任务执行状态监控

## reference

* [CronHowto](https://help.ubuntu.com/community/CronHowto)
