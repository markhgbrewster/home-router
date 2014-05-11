# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "OTB-Debian70-v3"
  config.vm.box_url = "http://mirror.otbeach.com/vagrant_vms/OTB_Debian70-v3.box"
  config.vm.synced_folder ".", "/etc/puppet"

  config.vm.define "router1" do |c|
    c.vm.hostname = "router1.lan"
    c.vm.network "private_network",
      ip: "10.10.1.1",
      netmask: "255.255.255.252",
      virtualbox__intnet: "int1"
    c.vm.network "private_network",
      ip: "10.10.2.1",
      network: "255.255.255.252",
      virtualbox__intnet: "int2"

    c.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.working_directory = "/etc/puppet"
      puppet.options = ['--environment production --parser future --show_diff']
      puppet.hiera_config_path = "hiera.yaml"
      puppet.facter = {
        "role" => "shorewall",
        "datacenter" => "home",
      }
    end
  end

  config.vm.define "router2" do |c|
    c.vm.hostname = "router2.lan"
    c.vm.network "private_network",
      ip: "10.10.1.2",
      netmask: "255.255.255.252",
      virtualbox__intnet: "int1"
    c.vm.network "private_network",
      ip: "10.10.2.2",
      network: "255.255.255.252",
      virtualbox__intnet: "int2"

    c.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.working_directory = "/etc/puppet"
      puppet.options = ['--environment production --parser future --show_diff']
      puppet.hiera_config_path = "hiera.yaml"
      puppet.facter = {
        "role" => "shorewall",
        "datacenter" => "home",
      }
    end
  end

  config.vm.define "pvz01" do |c|
    c.vm.hostname = "pvz01.swcnet.net"
    c.vm.network "private_network",
      ip: "10.10.1.3",
      netmask: "255.255.255.252",
      virtualbox__intnet: "int1"

    c.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.working_directory = "/etc/puppet"
      puppet.options = ['--environment production --parser future --show_diff']
      puppet.hiera_config_path = "hiera.yaml"
      puppet.facter = {
        "role" => "proxmox",
        "datacenter" => "home",
      }
    end
  end

  config.vm.define "download" do |c|
    c.vm.box = "Ubuntu-1204-swc"
    c.vm.hostname = "download.swcnet.net"
    c.vm.network "private_network",
      ip: "10.10.1.3",
      netmask: "255.255.255.252",
      virtualbox__intnet: "int1"
    c.vm.network "forwarded_port", guest: 80, host: 8000
    c.vm.network "forwarded_port", guest: 9092, host: 9092
    c.vm.network "forwarded_port", guest: 9091, host: 9091
    c.vm.network "forwarded_port", guest: 9090, host: 9090

    c.vm.provision "shell", inline: "[[ ! -d /data ]] && sudo mkdir /data ||true"
    c.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.working_directory = "/etc/puppet"
      puppet.options = ['--environment production --parser future --show_diff']
      puppet.hiera_config_path = "hiera.yaml"
      puppet.facter = {
        "role" => "download",
        "datacenter" => "home",
      }
    end
  end

  config.vm.define "fileserver" do |c|
    c.vm.box = "Ubuntu-1204-swc"
    c.vm.hostname = "fileserver.swcnet.net"
    c.vm.network "private_network",
      ip: "10.10.1.4",
      netmask: "255.255.255.252",
      virtualbox__intnet: "int1"
    c.vm.network "forwarded_port", guest: 139, host: 139
    c.vm.network "forwarded_port", guest: 548, host: 548

    c.vm.provision "shell", inline: "[[ ! -d /data ]] && sudo mkdir /data ||true"
    c.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path = "modules"
      puppet.working_directory = "/etc/puppet"
      puppet.options = ['--environment production --parser future --show_diff']
      puppet.hiera_config_path = "hiera.yaml"
      puppet.facter = {
        "role" => "fileserver",
        "datacenter" => "home",
      }
    end
  end
  # Create a public network, which generally matched to bridged network.  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision "puppet" do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
