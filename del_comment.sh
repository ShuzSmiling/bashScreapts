#!/bin/bash

# Проверяем, что указан входной файл
if [ "$#" -ne 1 ]; then
    echo "Не выбран файл"
    exit 1
fi

# Входной файл
declare input_file="$1"

# Проверяем, существует ли файл
if [ ! -f "$input_file" ]; then
    echo "Файл $input_file не найден."
    exit 1
fi

# Имя нового файла
declare output_file="${input_file%.*}_no_comments.${input_file##*.}"

# Удаление комментариев (кроме шебанга)
sed -E '/^#!/! s/#.*//' "$input_file" > "$output_file"

# Уведомление пользователя
echo "Файл без комментариев сохранён как: $output_file"

