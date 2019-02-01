
class libvirt_backups (
Simplib::Hostname     $backupserver,
Stdlib::Absolutepath  $installdir    = '/usr/local/bin/libvirt_backups',
Stdlib::Absolutepath  $configfile    = '/etc/libvirt_backps.conf',
Stdlib::Absolutepath  $backup_dir    = '/var/backups',
String                $vmbackupuser  = 'lvbackup',
Integer               $backupuid     = '832',
Boolean               $isclient      = true,
Boolean               $isserver      = false,
Optional[Hash]        $backups       = undef
)
{
  if $isclient {
    include  "libvirt_backups::client"
  }
}
