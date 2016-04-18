class profile::sensucheck::ntp_external (

   $file_name     = 'check-ntp-external.sh',
   $file_path     = "/opt/sensu/embedded/bin/${file_name}",
   $file_source   = 'puppet:///modules/profile/sensucheck/check_ntp_external.sh',
   $interval      = '300',
   $subscribers   = undef,
   $handlers      = undef,
   $ntp_server    = 'ca.pool.ntp.org',
   $check_cmd     = "${file_name} ${ntp_server}",

) {

   # Install the custom script file
   file { $file_path:
     ensure   => 'present',
     source   => $file_source,
     mode     => '0555',
     owner    => 'sensu',
     group    => 'sensu',
   }

   # Add the sensu checks
   sensu::check { 'ntp-external':
      command      => $check_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }


}
