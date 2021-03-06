#!/bin/bash
if [ $# -ne 2 ]; then
    echo $0: usage: ./backup.sh containerId excludepath
    exit 1
fi

time=$(date +"%m-%d-%Y-%H:%M:%S")
#backupName="$1.$time"
backupServerUser="backup"
backupServer="backup01.giraf.cs.aau.dk"
name=$(docker inspect -f '{{.Name}}' $1)
backupName="$name.$time"
volume=$(docker inspect -f '{{ (index .Mounts 0).Source }}' $1)
backupPath="$volume/"

ssh "$backupServerUser"@"$backupServer" 'mkdir /srv/backup/jenkins'"$name"'';
rsync -avzP --exclude "$2" "$backupPath" "$backupServerUser"@"$backupServer":/srv/backup/jenkins"$name""$backupName";
ssh "$backupServerUser"@"$backupServer" 'tar cvfz /srv/backup/jenkins'"$name""$backupName"'.tar.gz /srv/backup/jenkins'"$name"'/*; rm -rf /srv/backup/jenkins'"$name"''"$backupName"$

docker logs "$1" > /home/backup/stdout.log 2>/home/backup/stderr.log
scp /home/backup/stdout.log "$backupServerUser"@"$backupServer":/srv/backup/jenkins"$name""$backupName".stdout.log
scp /home/backup/stderr.log "$backupServerUser"@"$backupServer":/srv/backup/jenkins"$name""$backupName".stderr.log
rm /home/backup/stderr.log;
rm /home/backup/stdout.log;
