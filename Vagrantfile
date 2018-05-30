# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/bionic64'
  config.vm.define 'amber-apps-devbox'

  # Port forwarding
  [
    3000 # Amber
  ].each do |port|
    config.vm.network "forwarded_port", guest: port, host: port
  end

  # Provider-specific configuration
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  # If you are using Windows o Linux with an encrypted volume
  config.vm.synced_folder '.', '/vagrant', type: 'virtualbox'

  # Main scripts for installing software and configuration
  config.vm.provision "shell", privileged: false, run: "once",
    path: "provision/box_setup.sh",
    env: {
      "LC_ALL"   => "en_US.UTF-8",
      "LANG"     => "en_US.UTF-8",
      "LANGUAGE" => "en_US.UTF-8",
  }
end
