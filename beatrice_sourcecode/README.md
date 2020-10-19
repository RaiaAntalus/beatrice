# How to use this tool ?

Run local_script.sh.
It will query sites.json for all needed information such as the site's address.
Then it'll execute backup_script.sh via ssh on remote sites according to sites.json

Edit sites.json to your needs.

Edit $conf_file in local_script.sh to use another JSON. But other JSON structures must follow sites.json structure.
Due to how local_script.sh is built, having too much keys for each site will increase the size of $site_keys, and so on the "for" loop duration.
