# MaxiOracleTask

## Установка необходимых программ

### Установка Docker

```sh
$ sudo pacman -S docker
$ sudo systemctl enable docker.service
$ sudo systemctl start docker.service
$ sudo gpasswd -a <*user*> docker
```

### Образ Oracle Database XE

TODO: переписать на использование своего `Dockerfile`-а.

```sh
$ git clone https://github.com/oracle/docker-images.git
$ cd docker-images/OracleDatabase/SingleInstance/dockerfiles/
$ ./buildContainerImage.sh -v 21.3.0 -x (нужен vpn)
```

### Создание и запуск контейнера

```sh
$ docker run \
    --name oracle-db \
    -p 1522:1521 \
    -p 5501:5500 \
    -e ORACLE_PWD=<*password*> \
    -v ~/oracle-db-files:/opt/oracle/oradata \
    oracle/database:21.3.0-xe
```

### Установка InstantClient-basic

```sh
$ git clone https://aur.archlinux.org/oracle-instantclient-sqlplus.git
$ cd oracle-instantclient-sqlplus
# Нужно отредактировать PKGBUILD:
# - source=("https://download.oracle.com/otn_software/linux/instantclient/217000/instantclient-basic-linux.x64-21.7.0.0.0dbru.zip")
$ makepkg -si
```

### Установка InstantClient-SQlplus

```sh
$ git clone https://aur.archlinux.org/oracle-instantclient-sqlplus.git
$ cd oracle-instantclient-sqlplus
# Нужно отредактировать PKGBUILD:
# - source=("https://download.oracle.com/otn_software/linux/instantclient/217000/instantclient-sqlplus-linux.x64-21.7.0.0.0dbru.zip")
$ makepkg -si
```

### Установка SQL-Developer

```sh
$ git clone https://aur.archlinux.org/oracle-sqldeveloper.git
$ cd oracle-sqldeveloper
# качаем архив Other platforms: https://www.oracle.com/tools/downloads/sqldev-downloads-22.2.html и сохраняем в склонированном репозитории (нужен vpn)
# комментируем 'url'
$ makepkg -si
```

## Режим ValkoVesi

`ValkoVesi` это режим при котором `instantclient` не установлен через пакет
а [скачен][1] и разархивирован вручную. Предполагается что архив распакован в корень папки
`/opt`. Для сборки проекта вам будет необходимо указать режим, как описано ниже.
При запуске, вам также будет необходимо установить переменную `LD_LIBRARY_PATH`.

```
#---------------------------
# Use:
# export LD_LIBRARY_PATH=/opt/instantclient_21_5/
# Before run the target in ValkoVesi mode
#---------------------------
```

## Сборка и очистка

```sh
$ make clean
$ make
```

Для сборки в режиме `ValkoVesi` передайте соответствующий параметр.

```sh
$ make mode=VV clean
$ make mode=VV
```

[1]: https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
