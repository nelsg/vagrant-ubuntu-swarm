# -*- mode: ruby -*-
# # vi: set ft=ruby :
# Ensure yaml module is loaded
# Ensure yaml module is loaded
require 'yaml'

# Read yaml node definitions to create
# **Update nodes.yml to reflect any changes
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'ansible/nodes.yml'))

Vagrant.configure(2) do |config|

    # Iterate over nodes
    nodes['my_hosts'].each do |node_id|
        config.vm.define node_id['name'] do |node|
            #s.ssh.forward_agent = true
            node.vm.box = "ubuntu/xenial64"
            node.vm.hostname = node_id['name']
            node.vm.provision :shell, \
                              path: "scripts/bootstrap_ansible.sh"
            if node_id['swarm_master'].nil?
              # Default value is false
              node_id['swarm_master'] = false
            end
            if node_id['swarm_master']
              node.vm.provision :shell, \
                                inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/master.yml"
            else
              node.vm.provision :shell, \
                                inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/worker.yml"
            end
            node.vm.network :private_network, \
                            ip: node_id['ip'], \
                            netmask: node_id['netmask'], \
                            auto_config: true
            node.vm.provider "virtualbox" do |vb|
                vb.name = node_id['name']
                vb.memory = node_id['memory']
                vb.cpus= 1
                vb.gui = false
            end
        end
    end
end
