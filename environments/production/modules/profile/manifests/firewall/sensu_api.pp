class profile::firewall::sensu_api (

  $enabled           = true,
  $rule_number       = '100',
  $port              = $sensu::api_port,
  $source            = '0.0.0.0/0',   

){

  if $enabled {

    firewall { "${rule_number} permit sensu api port":
      dport  => $port,
      proto  => 'tcp',
      source => $source,
      action => 'accept',
    }

  }

}
