# libvirt-backups
This puppet module contains scripts to do backups of libvirt vms.
(These scripts are in the templates directories)

The main puppet module will install these scripts and create a config file from a provide hash of vms,
and install a cron job to run the backups at a scheduled time.



