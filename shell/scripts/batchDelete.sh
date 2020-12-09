#!/bin/bash

cat wait_deleted_redis_keys | while read member_key
do
  `redis-cli -h your_redis_host -p your_redis_password srem your_redis_set_key $member_key`
  echo "success:["$member_key"]" >> result_deleted_redis_keys.log
done
echo ">>>>>>>>>>>>>>DONE<<<<<<<<<<<<<" >> result_deleted_redis_keys.log
