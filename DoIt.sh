#!/usr/bin/bash
vbox_vers=`virtualbox --help | head -n 1 | awk '{print $NF}'`; 
if [ -z $vbox_vers ];
then 
	echo "Install virtualbox before continue!";
	return 1
else 
	echo "OK. VBox installed. V=$vbox_vers"
fi

vbox_user=`groups | grep vboxusers`;
if [ -z "$vbox_user" ];
then 
	echo "You must be in vboxusers group before continue!";
	return 1
else 
	echo "OK, you are in group vboxusers"
fi

vagrant_vers=`vagrant -v | head -n 1 | awk '{print $NF}'`;
if [ -z $vargant_vers ];
then 
	echo "Install vagrant before continue!";
	return 1
else 
	echo "OK. Vagrant installed. V=$vbox_vers"
fi

vagrant up;

cd provisioning;
ansible-playbook playbook.yml -i hosts;
