
require 'spec_helper'

describe 'libvirt_backups::client' do
  context 'on supported operating systems' do
    on_supported_os.each do |os, facts|
      let(:facts) do
        facts
      end

      context "on #{os}" do

        context 'with default params' do
          let(:params) {{
            :backupserver =>  'myhost.here.there',
            :backups => {
              'myvm' => {
                'backup_dir' => '/etc/backup',
                'quiesce'    => 'yes',
                'number'     => '5'
               },
              'myvm2' => {
                'backup_dir' => '/etc/backup',
                'number'     => '5'
               },
              'myvm3' => {
               },
             }
            }}
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to create_file('/etc/libvirt_backups.conf').with_content(<<-EOM.gsub(/^\s+/,''))
            # This file created by puppet, changes will be over written at the next
            # puppet run, which is probably real soon
            # This file is a list of libvirt virtual machines to backup on this
            # server.
            # VM Name, # of backups to keep, backup directory,quiesce
            myvm,5,/etc/backup,yes
            myvm2,5,/etc/backup,
            myvm3,,/var/backups,
          EOM
          }
        end
      end
    end
  end
end
