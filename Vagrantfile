# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provision :file, source: '~/.sandbox.conf.sh', destination: '/tmp/.sandbox.conf.sh'

  config.vm.provision "shell" do |shell|
    shell.inline = <<-SHELL
      apt-get update
      apt-get install -y puppet
      puppet module install datadog-datadog_agent
      source /tmp/.sandbox.conf.sh
      echo "export DD_API_KEY=${DD_API_KEY}" >> ~/.bashrc
    SHELL
  end

  config.vm.provision "puppet" do |puppet|
    puppet.options = "--verbose --debug"
  end

  config.vm.provision "shell" do |shell|
    shell.inline = <<-SHELL
      source /tmp/.sandbox.conf.sh
      sed -i -e "s/api_key.*/api_key: ${DD_API_KEY}/" /etc/dd-agent/datadog.conf
    SHELL
  end

end
