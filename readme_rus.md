# Wordpress на Ubuntu 20.04 LAMP - автоматическое разворачивание на двух виртуальных машинах с плагином авторизации LDAP. Используется модуль php-fpm.

Предварительные требования: Linux, Git, Virtualbox (+ модуль ядра), Vagrant, Ansible.

Данный сценарий устанавливает веб-сайт WordPress поверх среды LAMP (**L**inux, **A**pache, **M**ySQL и **P**HP) на двух виртуальных машинах, работающих под управлением Ubuntu 20.04.

Основа плейбука взята из https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-wordpress-with-lamp-on-ubuntu-18-04. 

Установка и настройка модуля **php-fpm** - https://www.digitalocean.com/community/tutorials/how-to-configure-apache-http-with-mpm-event-and-php-fpm-on-ubuntu-18-04. 

Настройки для более стабильной работы приведены в https://hika.su/blog/nastrojka-servera-apache-mpm-event-php-fpm-http-2#ustanovka-apache. Файлы конфигурации - */etc/php/7.4/fpm/php-fpm.conf* и */etc/php/7.4/apache2/php.ini*. Подкрутил только лимиты для памяти и файлов в *php.ini*.

Плагин **authLdap** скачивается с сайта WordPress: https://downloads.wordpress.org/plugin/authldap.zip. 

Будут созданы виртуальные хосты с параметрами, указанными в файле переменных *provisioning/vars/common.yml*, настройки WP берутся из *provisioning/vars/wp_init.yml*.

## Настройки

-`php_modules`: массив, содержащий расширения PHP, которые должны быть установлены для функционирования WordPress. Не нужно удалять эти модули, но можно включить в список новые расширения, если того требует ваша конкретная инсталляция.

-`mysql_root_password`: желаемый пароль для **root** учетной записи MySQL. Пользователь может подключиться к базе данных только с локального хоста.

-`mysql_db`: имя базы данных MySQL, которая должна быть создана для WordPress.

-`mysql_user`: имя пользователя MySQL, который будет создан для WordPress.

-`mysql_password`: пароль пользователя WordPress в MySQL.

-`http_host`: имя вашего хоста WP.

-`http_conf`: имя файла конфигурации, который будет создан в Apache.

-`http_port`: HTTP-порт для этого виртуального хоста, по умолчанию *80*.

-`wp_blog_title`: заголовок блога WordPress.

-`wp_lang`: язык блога.

## Запуск установки

### 1. Склонируйте репозиторий 
```shell
git clone https://github.com/abahcha/testrepo.git
cd testrepo
```

### 2. Настройте параметры

```shell
nano Vagrantfile
nano provision/vars/common.yml
nano provision/vars/wp_init.yml
```
**Внимание! Если вы хотите изменить IP-адреса хостов, вы должны:
1.поместите IP-адреса хостов в один и тот же сетевой диапазон (\24)
2.измените значения IP-адреса хоста в первых двух упомянутых выше файлах (_mysql: db.vm.network ip_ = mysql_host) и (_wp.vm.network ip = wp_host_) соответственно.
Лучше не изменять эти значения без необходимости. : -)**

```yml
---
#MySQL Settings
mysql_root_password: "yapass"
mysql_db: "wordpress"
mysql_user: "luser"
mysql_password: "parole"
mysql_port: "3306"
mysql_host: "192.168.100.2"

#WP Settings
http_host: "test_wp"
http_conf: "test_wp.conf"
http_port: "80"
wp_host: "192.168.100.3"
```

```yml
---
wp_blog_title: "Ёжик_в_тумане"
wp_lang: "ru_RU"

```

### 3. Запуск развёртывания

```shell 
vagrant up
```

## Проверка

Зайти на домашнюю страницу [http://192.168.100.3] (default WP IP). Для входа пользователей по LDAP необходимо активироать плагин AuthLDAP и настроить параметры подключения к серверу LDAP.

Данные для входа локального администратора WordPress - _luser:supermario_ (http://192.168.100.3/admin).
