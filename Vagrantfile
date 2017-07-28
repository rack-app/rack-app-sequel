# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|

  config.vm.provider "virtualbox" do |v|
    v.name = File.basename(__dir__)
  end

  config.vm.box = 'jnetocurti/postgresql-9.6_wildfly-10'
  config.vm.network :forwarded_port, guest: 5432, host: 5432
  config.vm.network :private_network, ip: '192.168.1.78'

  config.vm.provision 'shell', privileged: true, inline: <<-SHELL
    set -euo pipefail
    IFS=$'\n\t'

    sh /vagrant/script/vagrant/init.sh
    sh /vagrant/script/vagrant/make.sh
    sh /vagrant/script/vagrant/git.sh
    sh /vagrant/script/vagrant/pg.sh
  SHELL

end
