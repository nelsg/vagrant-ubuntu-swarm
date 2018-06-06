# -*- mode: ruby -*-
# # vi: set ft=ruby :
# Ensure yaml module is loaded
# Ensure yaml module is loaded
require 'yaml'

# Read yaml node definitions to create
# **Update nodes.yml to reflect any changes
nodes = YAML.load_file(File.join(File.dirname(__FILE__), 'ansible/nodes.yml'))
file_to_disk = "data_disk.vdi"
data_disk_size = 10 * 1024

Vagrant.configure(2) do |config|

    # Iterate over nodes
    nodes['my_hosts'].each do |node_id|
        config.vm.define node_id['name'] do |node|
            #s.ssh.forward_agent = true
            node.vm.box = "ubuntu/xenial64"
            node.vm.hostname = node_id['name']

            node.vm.network :private_network, \
                            ip: node_id['ip'], \
                            netmask: node_id['netmask'], \
                            auto_config: true

            if node_id['master'].nil?
              # Default value is false
              node_id['master'] = false
            end

            node.vm.provider "virtualbox" do |vb|
                vb.name = node_id['name']
                vb.memory = node_id['memory']
                vb.cpus= 1
                vb.gui = false
                # Ca bloque le démarrage de la VM
                # unless File.exist?(file_to_disk)
                #   # Create data disk if not exists
                #   vb.customize ['createhd', '--filename', file_to_disk, '--size', data_disk_size]
                # end
                # if node_id['master']
                #   # Mount data disk on master
                #   vb.customize ['storageattach', :id, '--storagectl', 'SCSI', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
                # end
            end

            ### Provision
            node.vm.provision :shell, \
                              path: "scripts/bootstrap_ansible.sh", \
                              keep_color: "true"
            if node_id['master']
              # Mount data disk on master
              node.vm.provision :shell, \
                                inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/master.yml", \
                                keep_color: "true"
            else
              node.vm.provision :shell, \
                                inline: "PYTHONUNBUFFERED=1 ansible-playbook /vagrant/ansible/worker.yml", \
                                keep_color: "true"
            end
        end
    end
end
