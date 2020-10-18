# Wordpress on Ubuntu 20.04 LAMP - two machines auto provision with LDAP authentication against ldap.forumsys.com.

Prerequestions: Linux, Git, Virtualbox (+ kernel module), Vagrant, Ansible. And bash for run DoIt.

This scenario will install a WordPress website on top of a LAMP environment (**L**inux, **A**pache, **M**ySQL and **P**HP) on a two virtualbox machines, running Ubuntu 20.04. 
Playbook derived basicly from [https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-wordpress-with-lamp-on-ubuntu-18-04]. **authLdap** plugin taked from [https://github.com/heiglandreas/authLdap.git] and cleaned from unnesessary files. A virtualhosts will be created with the options specified in the `vars/common.yml` variable file. 

## Settings

- `php_modules`:  An array containing PHP extensions that should be installed to support your WordPress setup. You don't need to change this variable, but you might want to include new extensions to the list if your specific setup requires it.
- `mysql_root_password`: The desired password for the **root** MySQL account.
- `mysql_db`: The name of the MySQL database that should be created for WordPress.
- `mysql_user`: The name of the MySQL user that should be created for WordPress.
- `mysql_password`: The password for the new MySQL user.
- `http_host`: Your domain name.
- `http_conf`: The name of the configuration file that will be created within Apache.
- `http_port`: HTTP port for this virtual host, where `80` is the default. 

## Running this setup

### 1. Obtain the needed files 
```shell
git clone https://github.com/abahcha/testrepo.git
```

### 2. Customize Options

```shell
nano Vagrantfile
nano provision/vars/common.yml
```
**Attention! If you want to change the IP addresses of the hosts, you must:
1.place the IP addresses of the hosts in the same network range (\ 24)
2.change the host IP values in two mentioned above files (_mysql: db.vm.network ip_ = mysql_host ) and (_wp.vm.network ip = wp_host_) accordingly.
It is best not to change these values unnecessarily. : -) **

```yml
---
#System Settings
php_modules: [ 'php-curl', 'php-gd', 'php-mbstring', 'php-xml', 'php-xmlrpc', 'php-soap', 'php-intl', 'php-zip', 'php-ldap' ]

#MySQL Settings (default)
mysql_db: "wordpress"
mysql_user: "luser"
mysql_password: "parole"

#HTTP Settings (default)
http_host: "test"
http_conf: "test.conf"
http_port: "80"
```

### 3. Run the setup

```shell 
vagrant up
cd provision 
ansible-playbook -i hosts playbook.yml
```
or simply run
```shell
DoIt.sh
```

## Check

Login to wordpress homepage [http://192.168.100.3] (default IP). You can get the required login credentials at [https://www.forumsys.com/tutorials/integration-how-to/ldap/online-ldap-test-server/].
Login for local WordPress administrator - _luser:supermario_.
