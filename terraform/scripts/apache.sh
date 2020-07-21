#!/bin/bash
sudo yum -y update
sudo yum install -y wget vim tar ksh git telnet curl bind-utils
sudo amazon-linux-extras install ansible2
sudo mkdir /apps
sudo chmod 777 /apps
cd /apps && git clone https://bitbucket.org/cloudndevops/ansible-ps.git
cd /apps/ansible-ps/playbooks && ansible-playbook apache.yml
