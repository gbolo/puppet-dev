class profile::base::firewall::pre (

  $ssh_port = $ssh::server::options['Port'],

){

  # Test if ssh port is assigned
  if $ssh_port {
    $ssh_port = $fw_ssh_port
  }
  else {
    $fw_ssh_port = '22'
  }

  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 accept all icmp':
    proto  => 'icmp',
    action => 'accept',
  }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
  }->
  firewall { '003 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }->
  firewall { '004 accept ssh':
    dport  => $fw_ssh_port,
    proto  => 'tcp',
    action => 'accept',
  }

}