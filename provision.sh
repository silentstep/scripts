#! /bin/bash

apt-get install -y apache2 php7.0 mysql-common

./initialize.sh
./db-creation.sh
./fetch-hook.sh
