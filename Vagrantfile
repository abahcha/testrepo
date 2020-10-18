Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
  end

#  config.vm.network "public_network", use_dhcp_assigned_default_route: true
#  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "base" do |db|
    db.vm.hostname = "mysql"
    db.vm.network "private_network", ip: "192.168.100.2", auto_config: true
    db.vm.provider "virtualbox" do |v|
#          v.name = "db"
          v.memory = 2048
          v.cpus = 1
    end
  end

  config.vm.define "web" do |wp|
    wp.vm.hostname = "wordpress"
    wp.vm.network "private_network", ip: "192.168.100.3", auto_config: true
    wp.vm.provider "virtualbox" do |v|
#          v.name = "wp"
          v.memory = 1024
          v.cpus = 2
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
#    ansible.inventory_path = "provisioning/hosts.yml"
  end

end
