#!/usr/bin/env bash

source variables.sh

if [ ! -d $backup_path ]; then
	mkdir $backup_path
else
	rm -rf $backup_path/*
fi

MYSQL_PWD="$mysql_pwd" mysqldump -u $mysql_user --all-databases > $backup_path/base.sql

mkdir $backup_path/apache

cp -r $path_to_website $backup_path/apache
tar jcvf ~/backup.bz2 $backup_path
scp -i ~/.ssh/id_rsa.pub backup.bz2 sasabe@10.1.1.2:~
