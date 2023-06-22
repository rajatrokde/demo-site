#!/bin/bash

# Step 1: Download the WordPress installation package
wget https://wordpress.org/latest.tar.gz

# Step 2: Extract the downloaded package
tar -xvzf latest.tar.gz

# Step 3: Move the WordPress files to the desired location
sudo mv wordpress/ /var/www/html/

# Step 4: Create a MySQL database for WordPress
sudo mysql -u root -p -e "CREATE DATABASE wordpress;"
sudo mysql -u root -p -e "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"

# Step 5: Configure the WordPress installation
cd /var/www/html/wordpress
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/wordpress/" wp-config.php
sudo sed -i "s/username_here/wordpressuser/" wp-config.php
sudo sed -i "s/password_here/password/" wp-config.php

# Step 6: Adjust file permissions
sudo chown -R www-data:www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress

# Step 7: Restart Apache web server (optional, if you have it installed)
sudo service apache2 restart

echo "WordPress installation completed. Open your browser and navigate to your server's domain or IP address to complete the installation."
