#!/bin/bash

num=0
while [ $num -lt 10 ]; do

	num=$(expr $num + 1)
	
	if (( $num % 2 == 0)); then
		echo $num $(fortune)
	fi
done