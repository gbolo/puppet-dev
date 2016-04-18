class profile::sensucheck::redis (

   $plugins       = ['sensu-plugins-redis'],
   $interval      = '120',
   $ip            = $redis::bind,
   $subscribers   = undef,
   $handlers      = undef,
   $info_cmd      = "check-redis-info.rb -h ${ip}",
   $ping_cmd      = "check-redis-ping.rb -h ${ip}",
   $mem_cmd       = "check-redis-memory-percentage.rb -h ${ip} -w 70 -c 90",

) {

   # Install the sensu plugin now using embedded ruby gem
   package { $plugins:
     ensure   => 'present',
     provider => 'sensu_gem',
   }

   # Add the sensu checks
   sensu::check { 'redis-info':
      command      => $info_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }

   sensu::check { 'redis-ping':
      command      => $ping_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }

   sensu::check { 'redis-memory':
      command      => $mem_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }


}
