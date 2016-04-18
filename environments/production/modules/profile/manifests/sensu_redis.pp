class profile::sensu_redis (

#  $bind_ip  = "${ipaddress}",

) {

  contain ::redis
  include ::profile::sensucheck::redis
  include ::profile::monitcheck::redis
  include ::profile::firewall::redis


}
