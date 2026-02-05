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
f kinit user@REALM; then
    echo "Kerberos ticket obtained successfully"
else
    echo "Failed to obtain Kerberos ticket" >&2
    exit 1
fi

# Очистка временных файлов
rm -f /tmp/kinit_error.log
# Проверка
