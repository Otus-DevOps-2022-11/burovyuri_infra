# Выполнение ДЗ по Ansible 2

Научились ставить ПО с помощью ansible, последовательно от выполнения одного
сценария научились деплоить приложением комплексно с помощью набора плейбуков.

Пересобрали образы через packer, заменив bash скрипты на ansible.

# Выполнение ДЗ по Ansible 1

Установлен ansible и пройдены базовые команды ansible.

Поднята инфраструктура из 2 машин, на них проведены тесты.

Для понимания работы ansible использована команда git и повторные выполнения.
В случае когда состояние на хосте уже такое как описано, изменений не происходит.

# Выполнение ДЗ по Packer

Пройдено и разработано создание baked образа с помощью Packer и yc-cli.

## Сборка образа с приложением

### 1. Готовим config файл с переменными

Копируем `/packer/variables.json.examples` в `/packer/variables.json`
Вносим свои значения для работы с yc-cli.

### 2. Собираем baked образ

Переходим в папку `/packer` и выполняем:
```shell
packer build -var-file=variables.json immutable.json
```

Образ должен успешно собраться и разместиться в YC.

## Запуск приложения

Переходим в папку `/config-scripts` и выполняем:
```shell
sh create-reddit.sh
```

## Проверка работы приложения

Запуск машины с приложением происходит несколько минут,
после чего можно проверить работоспособность, зайдя в браузере:

`http://<ваш-ip-машины-в-yc>:9292`


# Выполнение ДЗ по деплою приложения в yc

Создаем машину с запущенным приложением:
(запуск из папки репозитория)
```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-b,nat-ip-version=ipv4 \
  --metadata-from-file user-data=metadata.yaml \
  --metadata serial-port-enable=1
```

testapp_IP = 62.84.121.185
testapp_port = 9292

# Выполнение ДЗ по серверу colud-bastion

Для того, чтобы подключиться на целевой сервер (`someinternalhost`),
необходимо воспользоваться bastion сервером используя SSH Agent.

Открыть ваш `~/.ssh/config` и внести туда настройки:

```
Host server1
    IdentityFile ~/.ssh/id_rsa
    ProxyCommand ssh -A appuser@server2 nc %h 22
```

Где:

`server1` — целевой сервер, без внешнего IP \
`server2` — проксирующий `bastion` сервер \
`~/.ssh/id_rsa` — ваш private ssh key, ответная часть должна быть на обоих серверах

В моем варианте это так:

```
Host 10.129.0.33
    IdentityFile ~/.ssh/id_rsa
    ProxyCommand ssh -A appuser@84.201.165.246 nc %h 22
```

Подключаетесь на сервер по адресу целевого хоста: `ssh appuser@10.129.0.33`

Если хотите идти быстрым алиасом, дополните ваш конфиг: \
(дайте алиас, и укажите целевой хост внутри)
```
Host someinternalhost
    HostName 10.129.0.33
    User appuser
    IdentityFile ~/.ssh/id_rsa
    ProxyCommand ssh -A appuser@84.201.165.246 nc %h 22
```

Далее подключиться можно с помощью команды:

`ssh someinternalhost`

bastion_IP = 178.154.198.218
someinternalhost_IP = 10.129.0.33
