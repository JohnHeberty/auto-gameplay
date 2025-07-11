docker exec -u root -it auto-gameplay-db bash
chmod -R 777 /backups
exit
docker exec -it auto-gameplay-db bash
psql -U usergameplay -d autogameplay -f /backups/backup-2025-07-11.sql