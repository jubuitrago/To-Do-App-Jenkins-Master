Vagrant.configure("2") do |config|
  #Select VM Box
  config.vm.box = "ubuntu/jammy64"
  
  #Select provision script
  config.vm.provision "shell", path: "provision.sh"

  #Select provider
  config.vm.provider "virtualbox"

  #Configure ports, host ip
  config.vm.network "forwarded_port", guest: 8080, host: 1234, host_ip: "127.0.0.1"
end
