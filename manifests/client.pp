
class libvirt_backups::client (
Stdlib::Absolutepath           $installdir    = '/usr/local/bin/libvirt_backups',
Stdlib::Absolutepath           $configfile    = '/etc/libvirt_backups.conf',
Stdlib::Absolutepath           $backup_dir    = '/var/backups',
String                         $vmbackupuser  = 'lvbackup',
Integer                        $backupuid     = 832,
Optional[Simplib::Hostname ]   $backupserver  = undef,
Boolean                        $isserver      = false,
Optional[Hash]                 $backups       = undef
)
{

  file { $backup_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'administrators',
    mode   => '0660'
  }


  file { $installdir :
    ensure  => 'directory',
    owner   => 'root',
    group   => 'administrators',
    source  => 'puppet:///modules/libvirt_backups/scripts/',
    recurse => true,
    mode    => '0750',
  } 

  if $backups {
    $_backup_list = $backups.map | String $vm_name, Hash $options | {
      $_backup_dir = has_key($options,'backup_dir') ? {
        true    => $options['backup_dir'],
        default => $backup_dir }
      $_quiesce = has_key($options,'quiesce') ? {
        true    => $options['quiesce'],
        default => '' }
      $_num = has_key($options,'number') ? {
        true    => $options['number'],
        default => '' }
      join([$vm_name,$_num,$_backup_dir,$_quiesce],',')
    }

    file { $configfile:
      owner   => 'root',
      mode    => '0600',
      group   => 'root',
      content =>  epp( "${module_name}/libvirt_backups.conf", 'backup_list' => $_backup_list)
    }

    cron { "Libvirt backups":
      command     => "${installdir}/libvirt_backup_cron.rb",
      user        => 'root',
      weekday     => 'Saturday',
      hour        => 1,
      environment => "PATH=${installdir}:/bin:/sbin",
    }
  }
}
