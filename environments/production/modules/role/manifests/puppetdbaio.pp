class role::puppetdbaio {

  # puppetdb all-in-one includes:
  # puppedb, postgres, puppetexplorer

  include profile::base
  include profile::puppetdb
  include profile::puppetexplorer

  Class['profile::base'] -> 
  Class['profile::puppetdb'] ->
  Class['profile::puppetexplorer']

}

