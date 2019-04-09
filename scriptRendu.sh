#!/usr/bin/env bash

if [ ! -d /root/backup ]; then
    mkdir /root/backup
else
    rm -rf /root/backup/*
fi

MYSQL_PWD="toucacer" mysqldump -u root --all-databases > /root/backup/base.sql

cp -r /var/www/html/ /root/backup/apache
scp -i /root/.ssh/id_rsa.pub script.sh sasabe@10.1.1.2:~
