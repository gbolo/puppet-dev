class profile::sensucheck::ntpd (

   $plugins       = ['sensu-plugins-ntp'],
   $interval      = '120',
   $subscribers   = undef,
   $handlers      = undef,
   $offset_warn   = '500',
   $offset_crit   = '2000',
   $ntp_cmd       = "check-ntp.rb -w ${offset_warn} -c ${offset_crit}",

) {

   # Install the sensu plugin now using embedded ruby gem
   package { $plugins:
     ensure   => 'present',
     provider => 'sensu_gem',
   }

   # Add the sensu checks
   sensu::check { 'ntp-offset':
      command      => $ntp_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }

}
