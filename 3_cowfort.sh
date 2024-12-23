#!/bin/bash

while true; do
	echo "Какую картинку вы хотите увидеть?"
	cat << options 
bunny
tux
daemon
kitty
vader-koala
quit # Для выхода
options
	echo
	read -p "Make you choice: " option
	echo

	if [ "$option" = "quit" ]; then
		echo "Выход из программы"
		break
	fi
	

	fortune | cowsay -f $option
done
