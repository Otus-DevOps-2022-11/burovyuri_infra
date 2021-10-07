# Лекция 5 / ДЗ

Для того, чтобы подключиться на целевой сервер (`someinternalhost`),
необходимо воспользоваться bastion сервером использую SSH Agent.

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
