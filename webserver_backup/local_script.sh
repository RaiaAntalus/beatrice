#!/usr/bin/env bash

function getSiteList() {
  # Paramètre : $1 = le fichier json global
  # Retourne : $site_list = liste de tous les sites référencés dans le json
  site_list=$(jq --raw-output '.[].site_name' $conf_file)
}

function getSiteConf() {
  # Paramètre : $1 = un site de la liste site_list
  # Retourne : $site_keys = une liste des clés attribuées au site
  site_keys=$(jq --raw-output --arg site "$site" '.[] | select(.site_name==$site) | keys[]' $conf_file)
}


# Setup les variables hôtes
local_user=$(whoami)
local_ip=$(hostname -I)

# Récupérer les noms depuis sites.json et les envoyer dans une liste $site_list
conf_file="sites.json"
getSiteList

# Lire les noms de sites dans la liste site_list
for site in $site_list
do
  # Récupérer la liste des keys du site souhaité dans la liste $site_keys
  getSiteConf

  # Pour chaque clé, créer une variable et lui attribuer le nom souhaité
  for key in $site_keys
  do
    #  Récupère chaque key et lui associe sa valeur (backup_path="/home/$USER/backup" par ex)
    declare "${key}=$(jq --raw-output --arg site "$site" --arg key "$key" '.[] | select(.site_name==$site) | .[$key]' $conf_file)"
  done
  ssh $distant_user@$site_address "bash -s" < ./backup_script.sh $backup_path $mysql_pwd $mysql_user $path_to_website $local_user $local_ip $site_name
done