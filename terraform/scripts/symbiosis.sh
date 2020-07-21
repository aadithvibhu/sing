#!/bin/bash
sudo yum -y update
sudo yum install -y wget vim tar ksh git
sudo amazon-linux-extras install -y ansible2
sudo yum install -y mysql
sleep 5
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sleep 5
sudo yum install -y nodejs
sudo mkdir /apps
sudo chmod 777 /apps
cd /apps && git clone https://github.com/chapagain/nodejs-mysql-crud.git && mv nodejs-mysql-crud symbiosis
