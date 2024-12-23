#!/bin/bash


# Функция сжимает файлы > $HOME/TRASH
# удаляет оригинальный файлы
function del_files {
    if gzip -c "$1"  > "$HOME/TRASH/$1.gz"; then
        rm -f $1 &&
        echo "Файл $1 перемещен в корзину"
    fi
}

# Функция сжимает директорию > $HOME/TRASH
# удаляет оригинальные директории
function del_dir {
    if tar -czvf "$HOME/TRASH/r$file.tar.gz" "./$file" &> /dev/null; then
        rm -rf $file 
        echo "Каталог $file перемещен в корзину"
    fi
}

# Поиск файлов
function search_files {
    find "$HOME/TRASH" \
        -mindepth 1 \
            \( \
                -type f -mtime +2 \
                -o \
                -type d -mtime +2 \
            \)
}

# удаляем файлы, срок хранения которых больше 48 часов
echo "Проверяем наличие файлов старше 48 часов"
echo
if [[ -n "$(search_files)" ]]; then
    echo "Найденный файлы: "

    search_files

    read -p "Удалить Y/N: " input_user

    if [[ $input_user == 'Y' ]]; then
        search_files | while read line; do
            
            if [ -d $line ]; then
                rm -rf $line
            elif [ -f $line ]; then
                rm -f $line
            fi

        done
        echo "Файлы и директории удалены"
    else
        echo "Пропускаем удаление"
    fi
    
else
    echo "Файлы не найдены, удаление не требуется"
fi
echo 


# проверяем, ввел ли пользователь хоть что-то
if [ $# -le 0 ]; then
    echo "Ошибка: Введите название файла или директории"
    exit 1
fi

# если директории TRASH нет, то создаем
if [ ! -d "$HOME/TRASH" ]; then
    mkdir "$HOME/TRASH"
fi

for file in "$@"; do

    if [ -f $file ]; then
        del_files $file   
    elif [ -d $file ]; then
        del_dir $file
    else
        echo "Ошибка: файла или директории $file не существует"
    fi
done
