#!/bin/bash

date_now=$(date "+%Y%m%d-%H%M%S")
backUpFolder=/home/db/backup/mysql
username="root"
password="123456"
db_name="zone"

fileName="${db_name}_${date_now}.sql"
backUpFileName="${backUpFolder}/${fileName}"

echo "starting backup mysql ${db_name} at ${date_now}."
/usr/bin/mysqldump -u${username} -p${password}  --lock-all-tables --flush-logs ${db_name} > ${backUpFileName}

cd ${backUpFolder}
tar zcvf ${fileName}.tar.gz ${fileName}
​
# use nodejs to upload backup file other place
#NODE_ENV=$backUpFolder@$backUpFileName node /home/tasks/upload.js
date_end=$(date "+%Y%m%d-%H%M%S")
echo "finish backup mysql database ${db_name} at ${date_end}."

#NODE_ENV=$backUpFolder@$backUpFileName /root/.nvm/versions/node/v8.11.3/bin/node /usr/local/work/script/upload.js
