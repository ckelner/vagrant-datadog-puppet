# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Image to use
  config.vm.box = "ubuntu/xenial64"
  # Pull in our credentials
  # The expectation is that creds.sh will contain a variable such that:
  # DD_API_KEY="<your-api-key-here>"
  config.vm.provision :file, source: '~/.creds.sh', destination: '/tmp/.creds.sh'
  # Run aptitude update and install puppet and puppet modules
  config.vm.provision "shell" do |shell|
    shell.inline = <<-SHELL
      apt-get update
      apt-get install -y puppet
      # NOTE: Two ways of doing this, we can use the shell and puppet to install
      # the module as seen here; or the module could be installed locally in
      # the repository and referenced in the puppet provisioner using the
      # `puppet.module_path` option to telling the puppet provisioner where to
      # locate the module. I (@ckelner) personally think this method is cleaner.
      puppet module install datadog-datadog_agent
      # NOTE: While this works, it doesn't seem to make the API key available
      # for puppet (which makes sense); Probably can remove this code, but if
      # someone wanted to work this so we don't need to modify the datadog.conf
      # by hand, it may prove useful
      # source /tmp/.sandbox.conf.sh
      # echo "export DD_API_KEY=$DD_API_KEY" >> ~/.bashrc
    SHELL
  end
  # Run puppet; We're using a default manifest in `./manifests/default.pp`
  config.vm.provision "puppet" do |puppet|
    puppet.options = "--verbose --debug"
    # NOTE: @ckelner => This doesn't seem to work -- at least I couldn't find
    # a way to make it happy. I'd prefer to pull the API key from the host
    # machine environment variables and then set the API key in the puppet
    # manifest versus touching the datadog.conf using the shell provisioner
    #puppet.facter = {
    #  "dd_api_key": ENV['DD_API_KEY'] # also tried "#{ENV['DD_API_KEY']}"
    #}
  end

  config.vm.provision "shell" do |shell|
    shell.inline = <<-SHELL
      source /tmp/.creds.sh
      sed -i -e "s/api_key.*/api_key: ${DD_API_KEY}/" /etc/dd-agent/datadog.conf
    SHELL
  end

end
