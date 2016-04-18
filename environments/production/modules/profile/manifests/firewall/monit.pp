class profile::firewall::monit (

  $enabled           = true,
  $rule_number       = '100',
  $port              = $monit::httpd_port,
  $source            = '0.0.0.0/0',   

){

  if $enabled {

    firewall { "${rule_number} permit monit access for admins":
      dport  => $port,
      proto  => 'tcp',
      source => $source,
      action => 'accept',
    }

  }

}
