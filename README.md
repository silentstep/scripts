# Scripts
Scripting and Automation class code resource

## Make sure to edit the hard-coded Username and Password lines in fetch-hook.sh to match your system.
Run sequence for manual setup and download of data (no vagrant provisioning):
1) initialize.sh (this creates a cronjob for the main script to run as asked in the assignment)
2) db-creation.sh (creates a database -> interactive)
3) fetch-hook.sh (fetches the files and passes arguments to PHP for db entries)

## Vagrant file
The Vagrant file has to be placed in your ~/vagrant folder. Any existing Vagrantfile should be deleted.
The commands to initialize and provision a VM are:
1) vagrant box add {title} {url}
2) vagrant init {title}
3) vagrant up
Suitable vagrant boxes can be found at http://www.vagrantbox.es/
