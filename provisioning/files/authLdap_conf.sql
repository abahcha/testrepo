update wp_options set option_value='a:1:{i:0;s:21:"authLdap/authLdap.php";}' where option_name='active_plugins';
insert into wp_options (option_name, option_value, autoload) values ('authLDAPOptions', 'a:22:{s:7:"Enabled";s:1:"1";s:7:"CachePW";b:0;s:3:"URI";s:88:"ldap://cn=read-only-admin,dc=example,dc=com:password@ldap.forumsys.com/DC=example,DC=com";s:12:"URISeparator";s:1:" ";s:6:"Filter";s:0:"";s:8:"NameAttr";s:0:"";s:7:"SecName";s:0:"";s:7:"UidAttr";s:0:"";s:8:"MailAttr";s:0:"";s:7:"WebAttr";s:0:"";s:6:"Groups";a:5:{s:13:"administrator";s:0:"";s:6:"editor";s:0:"";s:6:"author";s:0:"";s:11:"contributor";s:0:"";s:10:"subscriber";s:0:"";}s:5:"Debug";b:0;s:9:"GroupAttr";s:0:"";s:11:"GroupFilter";s:0:"";s:11:"DefaultRole";s:6:"author";s:11:"GroupEnable";b:0;s:13:"GroupOverUser";s:1:"1";s:7:"Version";i:1;s:26:"DoNotOverwriteNonLdapUsers";b:0;s:8:"StartTLS";b:0;s:14:"GroupSeparator";s:0:"";s:9:"GroupBase";s:0:"";}', 'yes');

insert into wp_users (user_login, user_pass, user_nicename, user_email, display_name) values ('luser', '$P$BU2yFOiDjp1xjuB7BCuQVAtdGKgmU.1', 'luser', 'luser@local.host', 'luzer');
insert into wp_usermeta (nickname, show_admin_bar_front, wp_capabilities) values ('luser', 'true', 'a:1:{s:13:"administrator";b:1;}');


mysqldump --add-drop-table --no-tablespaces -h 192.168.50.2 -u luser -parole wordpress > wordpress.sql

mysql -u luser -pparole wordpress < wordpress.sql

update wp_options set option_value='http://192.168.100.3' where option_name in ('siteurl', 'home');

