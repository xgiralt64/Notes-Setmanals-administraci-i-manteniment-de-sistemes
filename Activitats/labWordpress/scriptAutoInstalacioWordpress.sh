#!/bin/bash

#variables
WP_VERSION="latest"
WP_URL="https://wordpress.org/${WP_VERSION}.tar.gz"
WP_DIR="/var/www/html"

echo "Instalant Apache"
sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

echo "Instalant PHP i extensions"
sudo dnf install php -y
sudo dnf install php-curl php-zip php-gd php-soap php-intl php-mysqlnd php-pdo -y

echo "Reiniciant Apache"
sudo systemctl restart httpd

echo "Descarregant WordPress"
cd /tmp
wget -q $WP_URL -O wordpress.tar.gz

echo "Descomprimint WordPress"
tar -xzf wordpress.tar.gz

echo "Copiant fitxers a $WP_DIR "
sudo mv wordpress/* "$WP_DIR/"

echo "Eliminant arxius temporals"
rm -rf wordpress wordpress.tar.gz

echo "Assignant permisos"
sudo chown -R apache:apache "$WP_DIR"

echo "Instalació completada!"
