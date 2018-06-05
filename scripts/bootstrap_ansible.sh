#!/bin/bash
#
# Copyright 2012 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

echo "Installing Ansible..."
echo "COMMAND: apt-get update -y"
apt-get update -y
echo "COMMAND: apt-get install -y software-properties-common"
apt-get install -y software-properties-common
echo "COMMAND: apt-add-repository ppa:ansible/ansible-2.4"
apt-add-repository ppa:ansible/ansible-2.4
echo "COMMAND: apt-get update"
apt-get update
echo "COMMAND: apt-cache policy ansible"
apt-cache policy ansible
echo "COMMAND: apt-get install -y ansible apt-transport-https"
apt-get install -y ansible apt-transport-https
echo "COMMAND: ansible-playbook --version"
ansible-playbook --version
