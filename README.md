# Scripts
Scripting and Automation class code resource

## Make sure to edit the hard-coded Username and Password lines in fetch-hook.sh to match your system.
Run sequence for manual setup and download of data (no vagrant provisioning):
1) initialize.sh (this creates a cronjob for the main script to run as asked in the assignment)
2) db-creation.sh (creates a database -> interactive)
3) fetch-hook.sh (fetches the files and passes arguments to PHP for db entries)

## Vagrant
The Vagrant file has to be placed in your ~/vagrant folder. Any existing Vagrantfile should be deleted.
Suitable vagrant boxes can be found at -> http://www.vagrantbox.es/.
Additional info on running scripts at vagrant up can be found here -> https://www.vagrantup.com/docs/provisioning/shell.html.
The commands to initialize and provision a VM are:
1) vagrant box add {title} {url}
2) vagrant init {title}
3) vagrant up
## provision.sh
This script must be placed in the ~/vagrant folder together with the Vagrantfile. This is the provision script which will install custom software on the VM when it is first booted.
