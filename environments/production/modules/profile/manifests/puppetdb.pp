class profile::puppetdb (
  $fw_enable     = true, 
  $fw_http_port  = '8080',
  $fw_https_port = '8081',
  $fw_source     = '0.0.0.0/0',
) {

  contain ::puppetdb
  contain ::puppetdb::database::postgresql
  #contain ::puppetexplorer 

  # Configure firewall if enabled
  if $fw_enable {
    firewall { '100 allow puppetdb to be accessed':
      dport   => [$fw_http_port, $fw_https_port],
      proto  => 'tcp',
      source => $fw_source,
      action => 'accept',
    }
  }

}
