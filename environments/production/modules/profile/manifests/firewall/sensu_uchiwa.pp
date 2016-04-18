class profile::firewall::sensu_uchiwa (

  $enabled           = true,
  $rule_number       = '100',
  $port              = $uchiwa::port,
  $source            = '0.0.0.0/0',   

){

  if $enabled {

    firewall { "${rule_number} permit sensu uchiwa port":
      dport  => $port,
      proto  => 'tcp',
      source => $source,
      action => 'accept',
    }

  }

}
