#!/usr/bin/env bash

if [ ! -d /home/$USER/backup ]; then
	mkdir /home/$USER/backup
else
	rm -rf /home/$USER/backup/*
fi

MYSQL_PWD="toucacer" mysqldump -u root --all-databases > /home/$USER/backup/base.sql

mkdir /home/$USER/backup/apache

cp -r /var/www/html /home/$USER/backup/apache
tar jcvf /home/$USER/backup_site.bz2 /home/$USER/backup
scp -i ~/.ssh/id_rsa.pub /home/$USER/backup_site.bz2 sasabe@10.1.1.2:~
