#!/bin/bash

declare -r first_num=10
declare -r last_num=20

for num in $(seq $first_num $last_num); do
    echo "$num ^ 2" | bc -l
done