class role::sensu_redis {

  include ::profile::base
  include ::profile::sensu_redis

  Class['profile::base'] ->
  Class['profile::sensu_redis']

}
