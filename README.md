# docker-tools
A collection of tools to work with docker


# backup.sh
This script purpose is to backup data-volumes and log files.
The script can be executed with:
```
./backup.sh <ContainerId> "<Exclude path>"
```
Ex. if We would like to make a backup of container sdu81292 and exclude all log files we would execute the following statement: 
```
./backup.sh sdu81292 "*.log"
```

The backup script would then start rsyncing to a remote backup server (keep in mind that a ssh-key should be copied before usage), and then afterwards archived into tar.gz file with timestamp of the date and name of the container.

The script itself has a few variables in it, which are listed below:
```
backupServerUser="backup"
backupServer="backup01.giraf.cs.aau.dk"
```
The backupServerUser is used for logging into the remote server, and should be the account which has an ssh-key copied into it.
The backupServer variable is the remote server.

Be noted that all backups are saved within /srv/backup/jenkins/<containername> at the moment, and can easyly be changed with a little change in the rsync command.
