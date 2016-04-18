class role::puppetdb {

  include profile::base
  include profile::puppetdb

  Class['profile::base'] -> Class['profile::puppetdb']

}

