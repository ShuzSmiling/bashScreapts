#/bin/bash

declare -r DIR=/etc

find $DIR -maxdepth 1 -type f | while read line
do
    echo $(wc -l "$line")
done