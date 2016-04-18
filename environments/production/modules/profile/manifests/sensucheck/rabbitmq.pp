class profile::sensucheck::rabbitmq (

   $plugins       = ['sensu-plugins-rabbitmq'],
   $rmq_user      = 'gbolo',
   $rmq_passwd    = 'pass',
   $rmq_ip        = $rabbitmq::node_ip_address,
   $rmq_port      = $rabbitmq::ssl_management_port,
   $interval      = '120',
   $subscribers   = undef,
   $handlers      = undef,
   $vhost         = '%2Fsensu',
   $alive_cmd     = "check-rabbitmq-alive.rb -u '${rmq_user}' -p '${rmq_passwd}' -w ${rmq_ip} -P ${rmq_port} --ssl --vhost ${vhost} --verify_ssl_off",
   $messages_crit = '100',
   $messages_warn = '60',
   $messages_cmd  = "check-rabbitmq-messages.rb --user '${rmq_user}' --password '${rmq_passwd}' --host ${rmq_ip} --port ${rmq_port} --ssl -c ${messages_crit} -w ${messages_warn}",   
   $cluster_cmd   = "check-rabbitmq-cluster-health.rb -u '${rmq_user}' -p '${rmq_passwd}' -w ${rmq_ip} -P ${rmq_port} --ssl --verify_ssl_off",

) {

   # This plugin requires gcc-c++ to be installed
   package { 'gcc-c++':
     ensure    => 'present',
     name      => 'gcc-c++',
   }

   # Install the sensu plugin now using embedded ruby gem
   package { $plugins:
     ensure   => 'present',
     provider => 'sensu_gem',
     require  => Package['gcc-c++'],
   }

   # Add the sensu checks
   sensu::check { 'rabbitmq-node-alive':
      command      => $alive_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }

   sensu::check { 'rabbitmq-cluster-health':
      command      => $cluster_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }

   sensu::check { 'rabbitmq-messages':
      command      => $messages_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
   }


}
