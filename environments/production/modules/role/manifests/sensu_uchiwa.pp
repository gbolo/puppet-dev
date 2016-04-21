class role::sensu_uchiwa {

  include ::profile::base
  include ::profile::sensu_uchiwa

  Class['sensu'] ->
  Class['profile::sensu_uchiwa']

}
