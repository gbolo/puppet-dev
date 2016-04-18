class profile::firewall::redis (

  $enabled           = true,
  $rule_number       = '100',
  $port              = $redis::port,
  $source            = '0.0.0.0/0',   

){

  if $enabled {

    firewall { "${rule_number} allow redis port for clients":
      dport  => $port,
      proto  => 'tcp',
      source => $source,
      action => 'accept',
    }

  }

}
