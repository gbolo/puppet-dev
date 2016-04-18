class role::puppetserver {
  
  include profile::base
  include profile::puppetserver

  Class['profile::base'] -> Class['profile::puppetserver']

}

