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

#MAINDB=${USER//-/_}
MAINDB='ssh_server'
PASSDB='lexi'

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
cd $HOME && mkdir $folder
cd $HOME/$folder
#Download the information
curl -o $filename $filelock
#Tranverse to the php script
cd $HOME/scripting
#Call out php that writes to database and pass it parameters
php parse.php $MAINDB $PASSDB $folder $filename
