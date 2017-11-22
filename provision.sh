#! /bin/bash

#Install required software
echo "Installing LAMP stack"
apt-get update
apt-get install -y apache2 mysql-server libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5 php5-mcrypt

echo "Initializing ..."
echo "Creating a cronjob for the script"
echo "Creating new cronfile to install"
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "10 * * * * SHELL=/bin/sh PATH=/bin:/sbin:/usr/bin:/usr/sbin $HOME/scripts/fetch-hook.sh" >> mycron
#install new cron file
echo "Installing new cronfile"
crontab mycron
echo "Cleanup ..."
rm mycron
# replace "-" with "_" for database username
MAINDB=vagrant
echo "User name autoselected: $MAINDB"
# prompt for password to mysql user
echo "Enter a secure password"
passwddb=vagrant

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf  ]; then

    mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${passwddb}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"
    echo "Done!"
    echo "Setting up table"
    sleep 2
    mysql -uroot -p${rootpasswd} -e "CREATE TABLE ${MAINDB}.scripting (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, ICAO VARCHAR(30) NOT NULL, time VARCHAR(30) NOT NULL, report VARCHAR(60) NOT NULL);"
    mysql -uroot -p${rootpasswd} -e "SHOW COLUMNS FROM ${MAINDB}.scripting;"
        
# If /root/.my.cnf doesn't exist then it'll ask for root password   
else
    echo "Please enter MySQL root user password!"
    rootpasswd=bashguard
    echo "Setting up user account and privileges"
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${passwddb}';"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
    echo "Done!"
    echo "Setting up table"
    sleep 2
    mysql -uroot -p${rootpasswd} -e "CREATE TABLE ${MAINDB}.scripting (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY, ICAO VARCHAR(30) NOT NULL, time VARCHAR(30) NOT NULL, report VARCHAR(500) NOT NULL);"
    mysql -uroot -p${rootpasswd} -e "SHOW COLUMNS FROM ${MAINDB}.scripting;"
fi

now=$(date +"%T")
folder=$(date +"%d""%h""%Y")
echo "======================="
#Get the current hour
time=$(echo $now | cut -f1 -d:)
#Define a string to append
suffix='Z.TXT'
#Form the file name by appending suffix and the current time
filename=$time$suffix
#URL to the server
url='http://tgftp.nws.noaa.gov/data/observations/metar/cycles/'
#Form the URL for the correct file corresponding to current time
filelock=$url$filename
#Create the daily directory and traverse to it
cd /home/vagrant && mkdir $folder
cd /home/vagrant/$folder
#Download the information
curl -s -o $filename $filelock > /dev/null
#Tranverse to the php script
pwd
cd /home/vagrant/scripting
pwd
php parse.php $MAINDB $passwddb $folder $filename
