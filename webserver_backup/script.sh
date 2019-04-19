#!/usr/bin/env bash

# $1 = $backup_path
# $2 = $mysql_pwd
# $3 = $mysql_user
# $4 = $path_to_website
# $5 = $local_user
# $6 = $local_ip
# $7 = $site_name

# Si le dossier backup est créé, le vide. Sinon le crée
if [ ! -d $1 ]; then
	mkdir $1
else
	rm -rf $1/*
fi

# Dump la db
MYSQL_PWD="$2" mysqldump -u $3 --all-databases > $1/base.sql

# Récupérer le dossier du webserver
mkdir $1/apache
cp -r $4 $1/apache

# Ajouter à une archive, et envoyer ça en SCP. Indiquer le directory empêche la création de toute l'arborescence (correspond à effectuer un cd)
tar jcvf $7.backup.bz2 --directory=$1 .
# scp -B = scp en batch, scp -i = interactif, avec la clé devant être spécifiée
scp -B $7.backup.bz2 $5@$6:~
