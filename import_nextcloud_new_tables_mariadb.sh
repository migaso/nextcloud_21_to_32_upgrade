#!/bin/bash
# mariadb 11.4
# Run in the new nextcloud DBMS

dir="/var/lib/mysql/bkp"
pass=""
db="nextcloud"
alias mysql=mariadb

echo "[INFO]: cleaning tables"
mysql -p$pass --database $db < ${dir}/DB_nextcloud_20251117_no_data_new_schema.sql

echo "[INFO]: applying new inserts "
mysql -p$pass --database $db < ${dir}/DB_nextcloud_inserts_required_tables.sql
echo "[INFO]: applying appconfig "
mysql -p$pass --database $db < ${dir}/DB_nextcloud_20251117_table_oc_appconfig.sql

echo "[INFO]: Importing new tables, this process will take a minute.. "
for i in $(cat table_sql_list.txt)
do
 echo "== $i =="
 mysql -p$pass --database $db < ${dir}/${i}
 echo "== OK =="
done

echo "[DONE] "
