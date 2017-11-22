#!/bin/bash - 
#===============================================================================
#
#          FILE: initialize.sh
# 
#         USAGE: ./initialize.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2017-11-20 16:11:09
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

echo "Initializing ..."
echo "Creating a cronjob for the script"
echo "Creating new cronfile to install"
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "10 * * * * SHELL=/bin/sh PATH=/bin:/sbin:/usr/bin:/usr/sbin $HOME/scripting/fetch-hook.sh" >> mycron
#install new cron file
echo "Installing new cronfile"
crontab mycron
echo "Cleanup ..."
rm mycron
