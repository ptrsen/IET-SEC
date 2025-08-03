Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.box_check_update = true 
  config.vm.hostname = "kali"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "Kali" 
    vb.memory = 4096
    vb.cpus = 2 
    vb.gui = true
    vb.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
  end

  # First provisioning stage
  config.vm.provision "shell", path: "setup.sh",
    env: { "VAGRANT_PROVISION_STAGE" => "setup" },
    run: "once"

  # Second provisioning stage (after reboot)
  config.vm.provision  "shell", path: "utils.sh",
    env: { "VAGRANT_PROVISION_STAGE" => "utils" },
    run: "once"

end
