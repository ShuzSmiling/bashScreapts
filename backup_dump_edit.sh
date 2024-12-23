#!/bin/bash

declare -r BACKUP_DIR="/var/lib/mysql_backups"
declare -r MYSQL_USER="backup_user"
declare -r MYSQL_PASS='p@$sw0rd'
declare -r TIMESTAMP=$(date +%Y%m%d_%H%M)


if systemctl is-active --quiet mysql; then

    mkdir -p "$BACKUP_DIR"

    mysqldump -u $MYSQL_USER -p$MYSQL_PASS --all-databases | gzip > "$BACKUP_DIR/dumps_$TIMESTAMP.sql.gz"
    echo "Бекап успешно создан: $BACKUP_DIR/dumps_$TIMESTAMP.sql.gz"
else
    echo "Ошибка. Проверь работоспособность процесса"
fi