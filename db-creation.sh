# replace "-" with "_" for database username
MAINDB=${USER//-/_}
echo "User name autoselected: $MAINDB"
# prompt for password to mysql user
echo "Enter a secure password"
read -s passwddb

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf  ]; then

    mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
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
    read -s rootpasswd
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

