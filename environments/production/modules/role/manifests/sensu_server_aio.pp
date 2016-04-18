class role::sensu_server_aio {

  include ::profile::base
  include ::profile::sensu_server
  include ::profile::sensu_api
  include ::profile::sensu_uchiwa
#  include ::profile::sensu_redis

  Class['sensu'] ->
  Class['profile::sensu_uchiwa']

}
