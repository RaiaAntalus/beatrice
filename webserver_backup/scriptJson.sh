#!/usr/bin/env bash

# Fonction qui récupère toutes les infos du site$i
function variables_ssh() {
  #
  site_address=$(jq --raw-output .site$1.site_address sites.json)
  distant_user=$(jq --raw-output .site$1.distant_user sites.json)
  backup_path=$(jq --raw-output .site$1.backup_path sites.json)
  mysql_pwd=$(jq --raw-output .site$1.mysql_pwd sites.json)
  mysql_user=$(jq --raw-output .site$1.mysql_user sites.json)
  path_to_website=$(jq --raw-output .site$1.path_to_website sites.json)
  site_name=$(jq --raw-output .site$1.site_name sites.json)
}


# Setup les variables hôtes
local_ip=$(hostname -I)
local_user=$(whoami)

for i in `seq 1 2`
do
  variables_ssh $i
  ssh $distant_user@$site_address "bash -s" < ./script.sh $backup_path $mysql_pwd $mysql_user $path_to_website $local_user $local_ip $site_name
done
