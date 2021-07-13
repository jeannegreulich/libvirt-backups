# libvirt-backups
This puppet module contains scripts to do backups of libvirt vms.
(These scripts are in the templates directories)

The main puppet module will install these scripts and create a config file from a provide hash of vms,
and install a cron job to run the backups at a scheduled time.


To use libvirt backups add something like the following to hiera for the hypervisor:

libvirt_backups::client::backups:
  myvm1:
  myvm2:
    number: 5

simp::classes:
  - libvirt_backups::client


This will do backups for myvm1, using ll the defaults and myvm2 keeping 5 backups instead of the default 3.
