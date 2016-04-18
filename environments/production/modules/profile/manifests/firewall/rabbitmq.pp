class profile::firewall::rabbitmq (

  $enabled           = true,
  $rule_number       = '100',
  $port_ssl          = $rabbitmq::ssl_port,
  $port_mgmt         = $rabbitmq::ssl_management_port,
  $port_cluster      = '4369',
  $port_epmd_cluster = '25672',
  $source_ssl        = '0.0.0.0/0',
  $source_cluster    = '0.0.0.0/0',
  $source_mgmt       = '0.0.0.0/0',

){

  if $enabled {

    firewall { "${rule_number} allow rabbitmq ssl port for clients":
      dport  => $port_ssl,
      proto  => 'tcp',
      source => $source_ssl,
      action => 'accept',
    }

    firewall { "${rule_number} allow rabbitmq cluster port for cluster members":
      dport  => $port_cluster,
      proto  => 'tcp',
      source => $source_cluster,
      action => 'accept',
    }

    firewall { "${rule_number} allow rabbitmq epmd port for cluster members":
      dport  => $port_epmd_cluster,
      proto  => 'tcp',
      source => $source_cluster,
      action => 'accept',
    }

    firewall { "${rule_number} allow rabbitmq mgmt port for admins":
      dport  => $port_mgmt,
      proto  => 'tcp',
      source => $source_mgmt,
      action => 'accept',
    }


  }

}
