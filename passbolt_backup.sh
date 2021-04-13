#!/bin/bash

### GLERE'S SCRIPT ####
# A simple script to perform Passbolt backup (DB and configuration files).

exec > >(tee /opt/passbolt_backup/scripts/log__backup_mariadb.log) 2>&1

# Backup all MariaDB/MySQL DBs
mysqldump --all-databases -v | gzip > /opt/passbolt_backup/bckp_all_db_`date +\%Y\%m\%d_\%H\%M`.sql.gz

# Cleanup backups older than 7 days. 
find /opt/passbolt_backup -name "bckp_all_db_*.gz" -mtime +7 -type f -delete

# Backup Passbolt config files.
sudo tar cvfz /opt/passbolt_backup/passbolt-config_`date +\%Y\%m\%d_\%H\%M`.tar.gz /etc/passbolt

# Cleanup backups older than 7 days.
find /opt/passbolt_backup -name "passbolt-config_*.gz" -mtime +7 -type f -delete
