# Wordpress на Ubuntu 20.04 LAMP - автоматическое разворачивание на двух виртуальных машинах с авторизацией LDAP на ldap.forumsys.com.

Предварительные требования: Linux, Git, Virtualbox (+ модуль ядра), Vagrant, Ansible.

Этот сценарий устанавливает веб-сайт WordPress поверх среды LAMP (**L**inux, **A**pache, **M**ySQL и **P**HP) на двух виртуальных машинах, работающих под управлением Ubuntu 20.04.
Основа плейбука взята из [https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-wordpress-with-lamp-on-ubuntu-18-04]. Плагин **authLdap** взят с [https://github.com/heiglandreas/authLdap.git] и очищен от необязательных файлов. Будут созданы виртуальные хосты с параметрами, указанными в файле переменных `provisioning/vars/common.yml`, настройки WP берутся из `provisioning/vars/wp_init.yml`.

## Настройки

-`php_modules`: массив, содержащий расширения PHP, которые должны быть установлены для функционирования WordPress. Не нужно удалять эти модули, но можно включить в список новые расширения, если того требует ваша конкретная инсталляция.
-`mysql_root_password`: желаемый пароль для **root** учетной записи MySQL. Пользователь может подключиться к базе данных только с локального хоста.
-`mysql_db`: имя базы данных MySQL, которая должна быть создана для WordPress.
-`mysql_user`: имя пользователя MySQL, который будет создан для WordPress.
-`mysql_password`: пароль пользователя WordPress MySQL.
-`http_host`: имя вашего хоста WP.
-`http_conf`: имя файла конфигурации, который будет создан в Apache.
-`http_port`: HTTP-порт для этого виртуального хоста, по умолчанию `80`.

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
#System Settings (service systemctl user)
serv_user: "serviceuser"
serv_pass: "service"

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

php_modules: [ 'php-curl', 'php-gd', 'php-mbstring', 'php-xml', 'php-xmlrpc', 'php-soap', 'php-intl', 'php-zip', 'php-ldap' ]
```

### 3. Запуск развёртывания

```shell 
vagrant up
```

## Проверка

Зайти на домашнюю страницу [http://192.168.100.3] (default WP IP). Учётные данные для входа можно взять на [https://www.forumsys.com/tutorials/integration-how-to/ldap/online-ldap-test-server/].
Данные для входа локального администратора WordPress - _luser:supermario_.
