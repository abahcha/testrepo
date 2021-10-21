# Wordpress on Ubuntu 20.04 LAMP - two machines auto provision with LDAP authentication plugin. php-fpm module used.

Prerequestions: Linux, Git, Virtualbox (+ kernel module), Vagrant, Ansible.

This scenario will install a WordPress website on the top of a LAMP environment (**L**inux, **A**pache, **M**ySQL and **P**HP) on a two virtualbox machines, running Ubuntu 20.04. 

Playbook derived basically from [https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-wordpress-with-lamp-on-ubuntu-18-04]. 

**php-fpm** module installation and settings - https://www.digitalocean.com/community/tutorials/how-to-configure-apache-http-with-mpm-event-and-php-fpm-on-ubuntu-18-04. 

Settings for more stable server work are pointed in https://hika.su/blog/nastrojka-servera-apache-mpm-event-php-fpm-http-2#ustanovka-apache. Config files - */etc/php/7.4/fpm/php-fpm.conf* and */etc/php/7.4/apache2/php.ini*. Only limits for memory and files will be changed in *php.ini*.


**authLdap** plugin taken from [https://github.com/heiglandreas/authLdap.git] and cleaned of unnecessary files. A virtualhosts will be created with the options specified in the *provisioning/vars/common.yml* variable file, the WP settings are taken from the *provisioning/vars/wp_init.yml*.

## Settings

- `php_modules`:  An array containing PHP extensions that should be installed to support your WordPress setup. You don't need to change this variable, but you might want to include new extensions to the list if your specific setup requires it.
- `mysql_root_password`: The desired password for the **root** MySQL account. The user is limited to connecting from the local database machine.
- `mysql_db`: The name of the MySQL database that should be created for WordPress.
- `mysql_user`: The name of the MySQL user that should be created for WordPress.
- `mysql_password`: The password for the WordPress MySQL user.
- `http_host`: Your WP host name.
- `http_conf`: The name of the configuration file that will be created within Apache.
- `http_port`: HTTP port for this virtual host, where `80` is the default. 
- `wp_blog_title`: WordPress blog title.
- `wp_lang`: defaul language settings.


## Running this setup

### 1. Obtain the needed files 
```shell
git clone https://github.com/abahcha/testrepo.git
cd testrepo
```

### 2. Customize Options

```shell
nano Vagrantfile
nano provision/vars/common.yml
nano provision/vars/wp_init.yml
```
**Attention! If you want to change the IP addresses of the hosts, you must:
1.place the IP addresses of the hosts in the same network range (\ 24)
2.change the host IP values in two mentioned above files (_mysql: db.vm.network ip_ = mysql_host ) and (_wp.vm.network ip = wp_host_) accordingly.
It is best not to change these values unnecessarily. : -) **

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
```

```yml
---
wp_blog_title: "Ёжик_в_тумане"
wp_lang: "ru_RU"
```

### 3. Run the setup

```shell 
vagrant up
```

## Check

Login to wordpress homepage [http://192.168.100.3] (default WP IP). It is nesessary to activate AuthLDAP plugin and set up connection parametres for using LDAP autorization.

Login for local WordPress administrator - _luser:supermario_ (http://192.168.100.3/admin).
