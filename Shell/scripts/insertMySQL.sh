#!/bin/bash

# 以Get请求为例
reqUrl="yourapi"
echo "request url is : $reqUrl"

resData=$(curl $reqUrl)
echo "get data : <$resData>"

parseJson(){
  echo $1 | sed 's/.*'$2':\([^,}]*\).*/\1/'
}

# 假设返回的json数据有两个字段，分别为total和fail
total=$(parseJson $resData '"total"')
fail=$(parseJson $resData '"fail"')

# 对数据进行入mysql库
insertSql="INSERT INTO your_mysql_table(total,fail) values($total, $fail)"
echo "general sql: <$insertSql>"

cnt=$(mysql -hxxxxxx -P3306 -uxxxxxx -pxxxxx your_db_name -e "$insertSql")
if($cnt>0);then
  echo 'insert record successfully!'
else
  echo 'no insert!'
fi
