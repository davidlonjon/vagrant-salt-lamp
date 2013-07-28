# -*- mode: ruby -*-
# vi: set ft=ruby :

# Inspired from http://vstone.eu/my-improved-vagrantfile/
# and https://github.com/elasticdog/puppet-sandbox/blob/master/Vagrantfile
# and https://github.com/Mayflower/puppet-dev-env/blob/master/Vagrantfile

require 'yaml'


# The following function is taken from:
# IT makes sure that we can symbolize recursively the keys
# http://devblog.avdi.org/2009/07/14/recursively-symbolize-keys/
def symbolize_keys(hash)
  hash.inject({}){|result, (key, value)|
    new_key = case key
              when String then key.to_sym
              else key
              end
    new_value = case value
                when Hash then symbolize_keys(value)
                else value
                end
    result[new_key] = new_value
    result
  }
end

# read the settings from the file
# The idea is from :
# http://stackoverflow.com/questions/3903376/how-do-i-save-settings-as-a-hash-in-a-external-file
settings = YAML::load_file "settings.yml"
settings = symbolize_keys(settings)

Vagrant.configure("2") do |config|
  settings.each do |name, cfg|
    config.vm.define name do |vm_config|
      vm_config.vm.box = cfg[:box] if cfg[:box]
      vm_config.vm.box_url = cfg[:url] if cfg[:url]

      vm_config.hostmanager.enabled = true
      vm_config.hostmanager.manage_host = true
      vm_config.hostmanager.ignore_private_ip = false
      vm_config.hostmanager.include_offline = true

      vm_config.vm.hostname = cfg[:hostname] if cfg[:hostname]
      vm_config.ssh.max_tries = 10

      # Make this VM reachable on the host network as well, so that other
     # VM's running other browsers can access our dev server
      vm_config.vm.network :private_network, ip: cfg[:ip] if cfg[:ip]

      if cfg[:host_aliases]
        vm_config.hostmanager.aliases = cfg[:host_aliases]
      end

      # Make it so that network access from the vagrant guest is able to
      # use SSH private keys that are present on the host without copying
      # them into the VM.
      # vm_config.ssh.forward_agent = true

      vm_config.vm.provider :virtualbox do |v|
        # This setting gives the VM 1024MB of RAM instead of the default 384.
        if cfg[:ram]
          v.customize ["modifyvm", :id, "--memory", cfg[:ram] ]
        end
        # v.customize ["modifyvm", :id, "--name", cfg[:name] if cfg[:name]]

        # This setting makes it so that network access from inside the vagrant guest
        # is able to resolve DNS using the hosts VPN connection.
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

        # This option lets the real-time clock (RTC) operate in UTC time (see the section called “"Motherboard" tab”).
         v.customize ["modifyvm", :id, "--rtcuseutc", "on"]
      end


       if cfg[:forwards]
        cfg[:forwards].each do |fname, forward|
          vm_config.vm.network :forwarded_port, guest: forward[:from], host: forward[:to]
        end
      end

      nfs_setting = RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/

      if cfg[:provisioner] == 'salt'
        #Salt Share
        vm_config.vm.synced_folder "shares/srv/", "/srv/" , :nfs => nfs_setting
      end

      if cfg[:share_folders]
        cfg[:share_folders].each do |sf_name, sf|
          vm_config.vm.synced_folder sf[:host_path], sf[:guest_path] , :nfs => nfs_setting
        end
      end

      if cfg[:timezone]
          vm_config.vm.provision :shell, :inline => "echo \"" + cfg[:timezone] + "\" | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata | export TZ=" + cfg[:timezone]
      end

      if cfg[:provisioner] == 'salt'
        # Use all the defaults:
        vm_config.vm.provision :salt do |salt|
          salt.minion_config = "shares/srv/minion"
          salt.run_highstate = true
            salt.verbose = (cfg[:salt_verbose] ? cfg[:salt_verbose] : false)
        end
      end

      vm_config.vm.provision :hostmanager
    end
  end
end