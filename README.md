# beatrice
A little program that backups distant webservers and their mySQL databases, written in bash.

Requires :
- jq (>=1.4)
- ssh with authorized keys

# Using this tool

## "dpkg -i beatrice_X.X.X_amd64.deb"
- Renames backup_script.sh as beatrice and moves it to /usr/bin,
- Moves local_script.sh and sites.json to /etc/beatrice
- Use it just by typing "beatrice" in bash

## With the sourcecode
- Just DL the 3 files (backup_script.sh, local_script.sh and sites.json)
- Run backup_script.sh
- All archives will land in the same dir as the script is run in.

# Why is it called Beatrice ?
Just because I'm playing Umineko no Naku koro ni, and I love 07th Expansion universe.
