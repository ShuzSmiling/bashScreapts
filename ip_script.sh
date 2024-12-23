#!/bin/bash

# Переменные
read -p "Введите название домена: " domain
declare ip_list=$(dig +short $domain)
declare flag=0
declare -r step=2
echo 
echo "Проверяем что домен резолвится"

# 1. Проверьте, что доменные имена успешно резолвятся в IP-адреса.
if [ -z "$ip_list" ]; then
    echo "Домен: $domain не резолвится в IP-адрес"
    exit 1
else
    echo "IP-адреса $domain: $ip_list"
    let "flag += 1"
fi

echo "Этап $flag/$step завершен. Домен $domain резолвится."
echo "______________________________"

# 2. Проверьте, что какой-нибудь популярный интернет-ресурс пингуется.
# 3. Выведите только результат работы ping без вывода каждого отправленного запроса и строки с запуском ping
echo "Проверяем что домен пингуется и выводим результат команды Ping"
echo
if ping -c3 $domain | tail -n3; then
    let "flag += 1"
else
    echo "Сайт $domain не пингуется"
    exit 1
fi

echo
echo "Этап $flag/$step завершен. Домен $domain пингуется"
echo "______________________________"
