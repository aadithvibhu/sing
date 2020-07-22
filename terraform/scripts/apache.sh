#!/bin/bash
yum update -y
yum install -y httpd
chkconfig httpd on
echo Jaasritha > /var/www/html/index.html
chown apache /var/www/html/index.html
service httpd start