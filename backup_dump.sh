#!/bin/bash

declare -r BACKUP_DIR="/var/lib/mysql_backups"
declare -r MYSQL_USER="root"
declare -r TIMESTAMP=$(date +%Y%m%d_%H%M)


if systemctl is-active --quiet mysql; then

    mkdir -p "$BACKUP_DIR"

    mysqldump -u $MYSQL_USER --all-databases | gzip > "$BACKUP_DIR/dumps_$TIMESTAMP.sql.gz"
    echo "Бекап успешно создан: $BACKUP_DIR/dumps_$TIMESTAMP.sql.gz"
else
    echo "Ошибка. Проверь работоспособность процесса"
fi