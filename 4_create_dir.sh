#!/bin/bash

declare step=0
declare -r count_file=7

while [ $step -lt $count_file ]; do

    if mkdir /tmp/directory-$(date +%Y%m%d_%H%M); then
        echo "Каталог directory-$(date +%Y%m%d_%H%M) создался"
        ((step++))
        sleep 420
    fi

done;
