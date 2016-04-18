class profile::base::firewall {

  contain ::firewall
  contain ::profile::base::firewall::pre
  contain ::profile::base::firewall::post

  resources { 'firewall':
    purge => true,
  } 

  Firewall {
    before  => Class['::profile::base::firewall::post'],
    require => Class['::profile::base::firewall::pre'],
  }


}
