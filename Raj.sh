#!/bin/bash

# Update system packages
sudo apt-get update

# Install Apache web server
sudo apt-get install apache2 -y

# Install MySQL database server
sudo apt-get install mysql-server -y

# Secure the MySQL installation
sudo mysql_secure_installation

# Install PHP and required extensions
sudo apt-get install php libapache2-mod-php php-mysql -y

# Restart Apache web server
sudo systemctl restart apache2

# Download and extract WordPress
sudo apt-get install wget -y
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
sudo mv wordpress /var/www/html/

# Set appropriate permissions
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Configure Apache virtual host
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wordpress.conf
sudo sed -i 's/\/var\/www\/html/\/var\/www\/html\/wordpress/g' /etc/apache2/sites-available/wordpress.conf
sudo a2ensite wordpress.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Configure MySQL database
sudo mysql -u root -p <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT

# Clean up
rm /tmp/latest.tar.gz

# Display instructions to finish the installation
echo "WordPress installed successfully!"
echo "Please navigate to your server's IP address or domain name to complete the installation."

