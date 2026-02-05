#!/bin/bash

# Получаем имя текущего пользователя
username=$(whoami)

# Показываем окно для ввода пароля (в скрытом виде)
password=$(zenity --password --title="Kerberos Login" --text="Введите пароль для $username")

# Если пользователь нажал "Отмена" или не ввел пароль — выходим
if [ -z "$password" ]; then
    exit 1
fi

# Выполняем kinit с введённым паролем
echo "$password" | kinit "$username" 2>/tmp/kinit_error.log

# Проверка результата
if [ $? -eq 0 ]; then
    zenity --info --text="Kerberos-аутентификация прошла успешно"
else
    zenity --error --text="Ошибка Kerberos:\n$(cat /tmp/kinit_error.log)"
fi

# Очистка временных файлов
rm -f /tmp/kinit_error.log
# Проверка
