Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.box_check_update = true 
  config.vm.hostname = "kali"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Kali" 
    vb.memory = 4096
    vb.cpus = 2 
    vb.gui = true
  end

  config.vm.provision "shell", path: "provision.sh"
end
