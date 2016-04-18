class profile::puppetexplorer (
  $fw_enable     = true,
  $fw_http_port  = '1443',
  $fw_https_port = '1443',
  $fw_source     = '0.0.0.0/0',
) {

  contain ::puppetexplorer 

  # Configure firewall if enabled
  if $fw_enable {
    firewall { '100 allow puppetexplorer to be accessed':
      dport   => [$fw_http_port, $fw_https_port],
      proto  => 'tcp',
      source => $fw_source,
      action => 'accept',
    }
  }

}

