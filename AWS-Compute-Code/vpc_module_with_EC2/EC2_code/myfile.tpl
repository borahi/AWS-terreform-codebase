#!/bin/bash

yum -y install httpd
echo "Hello World!! This is terraform AWS Test page" >> /var/www/html/index.html
service httpd start
chkconfig httpd on