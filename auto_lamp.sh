#!/bin/bash
echo "
_____________________.____       _____      _____ __________      
\_   _____/\____    /|    |     /  _  \    /     \\______   \     
 |    __)_   /     / |    |    /  /_\  \  /  \ /  \|     ___/     
 |        \ /     /_ |    |___/    |    \/    Y    \    |         
/_______  //_______ \|_______ \____|__  /\____|__  /____|         
        \/         \/        \/       \/         \/               
                                                                  
  /\|\/\     /\|\/\     /\|\/\     /\|\/\     /\|\/\     /\|\/\   
 _)    (__  _)    (__  _)    (__  _)    (__  _)    (__  _)    (__ 
 \_     _/  \_     _/  \_     _/  \_     _/  \_     _/  \_     _/ 
   )    \     )    \     )    \     )    \     )    \     )    \  
   \/\|\/     \/\|\/     \/\|\/     \/\|\/     \/\|\/     \/\|\/ 

"

read -p "Do you want to install and enable LAMP STACK?  [e]enable or [a]abort" -n 1 -r
echo 
if [[ $REPLY =~ ^[Ee]$ ]]
then
echo "START"

sudo pacman -Syu

#sudo pacman -Rsc xf86-video-intel

#sudo pacman -R systemd-guest-user

sudo pacman -S mysql php apache phpmyadmin php-apache nodejs npm nvm

sudo cp ./source/php.ini /etc/php/php.ini

sudo cp ./source/httpd.conf /etc/httpd/conf/httpd.conf

sudo cp ./source/phpmyadmin.conf /etc/httpd/conf/extra/phpmyadmin.conf

sudo systemctl enable httpd 

sudo systemctl enable cups

sudo systemctl start httpd

sudo systemctl start cups

sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

sudo systemctl enable mariadb

sudo systemctl start mariadb

sudo mysql_secure_installation

echo "MySQL installation"

sudo npm install -g @vue/cli

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

php composer-setup.php

php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer

sudo pacman -Syu

echo "DONE! THE LAMP STACK IS NOW ENABLED!"
exit 1

elif [[ $REPLY =~ ^[Aa]$ ]]
then
echo "OK, ABORTED"
exit 1
fi
