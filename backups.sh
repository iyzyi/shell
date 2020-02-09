#!/bin/bash

blog_mysql_backups () {
    backup_dir=/root/sh/blogDBbackup
    oss_dir=oss://iyzyi-oss/blog/mysql
    username=root
    password=密码
    database_name=blog

    tool=mysqldump
    date=`date +%Y-%m-%d-%H-%M-%S`

    if [ ! -d $backup_dir ]; 
    then     
        mkdir -p $backup_dir; 
    fi

    $tool -u $username -p$password $database_name > $backup_dir/$database_name-$date.sql
    echo "create $backup_dir/$database_name-$date.sql"

    ossutil64 cp $backup_dir $oss_dir -r --update
}

blog_uploads_backups () {
    ossutil64 cp /www/wwwroot/blog/usr/uploads oss://iyzyi-oss/img/uploads -r --update
}

blog_mysql_backups
blog_uploads_backups