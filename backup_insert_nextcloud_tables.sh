#!/bin/bash
# Run in the nextcloud DBMS old version

dir="/var/lib/mysql/bkp"
pass=""
db="nextcloud_old"

echo "[INFO]: create new directory 'orig' in $dir "
mkdir -p ${dir}/orig/

echo "[INFO]: Taking backups... "
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db --ignore_table=$db.oc_addressbookchanges --ignore_table=$db.oc_appconfig --ignore_table=$db.oc_authtoken --ignore_table=$db.oc_calendarchanges --ignore_table=$db.oc_calendars --ignore_table=$db.oc_files_trash --ignore_table=$db.oc_jobs --ignore_table=$db.oc_mounts --ignore_table=$db.oc_notifications_pushtokens --ignore_table=$db.oc_officeonline_locks --ignore_table=$db.oc_officeonline_wopi --ignore_table=$db.oc_preferences --ignore_table=$db.oc_richdocuments_assets --ignore_table=$db.oc_richdocuments_direct --ignore_table=$db.oc_richdocuments_wopi --ignore_table=$db.oc_share --ignore_table=$db.oc_text_documents --ignore_table=$db.oc_text_sessions --ignore_table=$db.oc_user_status --ignore_table=$db.oc_wopi_assets --ignore_table=$db.oc_wopi_direct --ignore_table=$db.oc_wopi_locks --ignore_table=$db.oc_wopi_tokens --ignore_table=$db.oc_wopi_wopi > ${dir}/DB_nextcloud_inserts_required_tables.sql

mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_addressbookchanges > ${dir}/nextcloud_table_oc_addressbookchanges.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_authtoken > ${dir}/nextcloud_table_oc_authtoken.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_calendarchanges > ${dir}/nextcloud_table_oc_calendarchanges.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_calendars > ${dir}/nextcloud_table_oc_calendars.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_files_trash > ${dir}/nextcloud_table_oc_files_trash.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_jobs > ${dir}/nextcloud_table_oc_jobs.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_mounts > ${dir}/nextcloud_table_oc_mounts.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_preferences > ${dir}/nextcloud_table_oc_preferences.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_share > ${dir}/nextcloud_table_oc_share.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_text_documents > ${dir}/nextcloud_table_oc_text_documents.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_text_sessions > ${dir}/nextcloud_table_oc_text_sessions.sql
mysqldump -p$pass --triggers --skip-add-drop-table --no-create-info --single-transaction $db oc_user_status > ${dir}/nextcloud_table_oc_user_status.sql

echo "[INFO]: create a copy of sql files into 'orig' directory "
cp -p ${dir}/*.sql ${dir}/orig/

echo "[INFO]: modyfing tables for the new app version "
sed -i "s/),/,0),/g" ${dir}/nextcloud_table_oc_addressbookchanges.sql
sed -i "s/);/,0);/g" ${dir}/nextcloud_table_oc_addressbookchanges.sql

sed -i "s/),/,NULL),/g" ${dir}/nextcloud_table_oc_authtoken.sql
sed -i "s/);/,NULL);/g" ${dir}/nextcloud_table_oc_authtoken.sql

sed -i "s/),/,0),/g" ${dir}/nextcloud_table_oc_calendarchanges.sql
sed -i "s/);/,0);/g" ${dir}/nextcloud_table_oc_calendarchanges.sql

sed -i "s/),/,NULL),/g" ${dir}/nextcloud_table_oc_calendars.sql
sed -i "s/);/,NULL);/g" ${dir}/nextcloud_table_oc_calendars.sql

sed -i "s/),/,NULL),/g" ${dir}/nextcloud_table_oc_files_trash.sql
sed -i "s/);/,NULL);/g" ${dir}/nextcloud_table_oc_files_trash.sql

sed -i "s/),/,NULL,1),/g" ${dir}/nextcloud_table_oc_jobs.sql
sed -i "s/);/,NULL,1);/g" ${dir}/nextcloud_table_oc_jobs.sql

sed -i "s/),/,NULL),/g" ${dir}/nextcloud_table_oc_mounts.sql
sed -i "s/);/,NULL);/g" ${dir}/nextcloud_table_oc_mounts.sql

sed -i "s/),/,0,0,0,''),/g" ${dir}/nextcloud_table_oc_preferences.sql
sed -i "s/);/,0,0,0,'');/g" ${dir}/nextcloud_table_oc_preferences.sql

sed -i "s/),/,NULL,NULL,0),/g" ${dir}/nextcloud_table_oc_share.sql
sed -i "s/);/,NULL,NULL,0);/g" ${dir}/nextcloud_table_oc_share.sql

sed -i "s/),/,NULL),/g" ${dir}/nextcloud_table_oc_text_documents.sql
sed -i "s/);/,NULL);/g" ${dir}/nextcloud_table_oc_text_documents.sql

sed -i "s/),/,''),/g" ${dir}/nextcloud_table_oc_text_sessions.sql
sed -i "s/);/,'');/g" ${dir}/nextcloud_table_oc_text_sessions.sql

sed -i "s/),/,0,0),/g" ${dir}/nextcloud_table_oc_user_status.sql
sed -i "s/);/,0,0);/g" ${dir}/nextcloud_table_oc_user_status.sql

echo "[DONE] "
