#!/bin/bash

declare input_archiv=$1

# функция скорее просто для удобства, что бы видеть какой 
# файл выбран
function show_file {
    echo "Выбран файл: $1"
}

# функция разархвивирует .tar.[gz, bz2, lzma]
function unarch {

    declare name_file=$1 # название файла до расширения
    declare all_name_file=$2 # полное название архива
    declare param_unzip=$3 # параметры для разарзивации

    # покажем файл, который распаковывается
    show_file "$all_name_file"

    # Удалим папку и содержимое, если такая уже есть
    if [ -d "unpack_$name_file" ]; then
        rm -rf "./unpack_$name_file"
    fi

    # cоздадим директорию
    mkdir ./unpack_$name_file && \
    # распакуем архив в созданную директорию
    tar -"$param_unzip"xvf ./$all_name_file \
        -C ./unpack_$name_file

}

# Функция для разохривирования tar.zip
function unzp {

    # Проверяем, если unzip не установлен, завершает скрипт
    if ! command -v unzip &> /dev/null; then
        echo "Утилита unzip не установлена. Для установки
        наберите 'sudo apt-get install unzip'"
        exit 1
    fi

    declare name_file=$1 # название файла до расширения
    declare all_name_file=$2 # полное название архива

    # покажем файл, который распаковывается
    show_file "$all_name_file"

    if [ -d "unpack_$name_file" ]; then
        rm -rf "./unpack_$name_file"
    fi

    # создаем директорию
    mkdir "./unpack_$name_file" && 
    # распаковывем zip архив
    if unzip "$all_name_file" -d "./unpack_$name_file/" &> /dev/null; then
        # распаковываем все tar, кладем в папку и удаляем
        tar -xvf ./unpack_$name_file/*.tar -C "./unpack_$name_file/"
        rm -f ./unpack_$name_file/*.tar
    fi
}

if [ -f "$input_archiv" ]; then 
    
    # получаем расширение архива
    declare type_file=${input_archiv##*.}
    
    # получаем наименование файла без .tar.gz
    declare name_file=${input_archiv%%.*}

    case $type_file in

        "gz" ) unarch $name_file $input_archiv "z";;

        "bz2" ) unarch $name_file $input_archiv "j";;
        
        "lzma" ) unarch $name_file $input_archiv "J";;

        "zip" ) unzp $name_file $input_archiv;;

        *) echo "Ошибка: Неверный формат";;

    esac

else
    echo "Ошибка: не выбран файл"
fi