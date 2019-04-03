
class libvirt_backups::client (
Stdlib::Absolutepath           $installdir     = '/usr/local/bin/libvirt_backups',
Stdlib::Absolutepath           $configfile     = '/etc/libvirt_backups.conf',
Stdlib::Absolutepath           $backup_dir     = '/var/backup',
Integer[1,10]                  $defnum_backups = 3,
Enum['yes', 'no']              $def_quiesce    = 'no',
Optional[Hash]                 $backups        = undef
)
{

  $default_options = {
    'backup_dir' => $backup_dir,
    'quiesce'    => $def_quiesce,
    'number'     => $defnum_backups
  }

  file { $backup_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'administrators',
    mode   => '0660'
  }

  file { $installdir :
    ensure => 'directory',
    owner  => 'root',
    group  => 'administrators',
    mode   => '0750',
  }

  file { "${installdir}/libvirt_backup.sh":
    ensure  => 'file',
    owner   => 'root',
    group   => 'administrators',
    mode    => '0750',
    content => epp("${module_name}/scripts/libvirt_backup.sh.epp")
  }

  file { "${installdir}/libvirt_backup_cron.rb":
    ensure  => 'file',
    owner   => 'root',
    group   => 'administrators',
    mode    => '0750',
    content => epp("${module_name}/scripts/libvirt_backup_cron.rb.epp")
  }

  if $backups {
    $_backup_list = $backups.map | String $vm_name, Optional[Hash] $options | {
      $_options = defined('$options') ? {
        true    =>  merge($default_options,$options),
        default =>  $default_options
        }
      join([$vm_name,$_options['number'],$_options['backup_dir'],$_options['quiesce']],',')
    }

    file { $configfile:
      owner   => 'root',
      mode    => '0600',
      group   => 'root',
      content =>  epp( "${module_name}/libvirt_backups.conf", 'backup_list' => $_backup_list)
    }

    cron { 'Libvirt backups':
      command     => "${installdir}/libvirt_backup_cron.rb",
      user        => 'root',
      weekday     => 'Saturday',
      hour        => 1,
      environment => "PATH=${installdir}:/bin:/sbin",
    }
  }
}
