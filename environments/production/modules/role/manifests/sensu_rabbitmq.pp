class role::sensu_rabbitmq {

  include ::profile::base
  include ::profile::sensu_rabbitmq

  Class['profile::base'] -> 
  Class['profile::sensu_rabbitmq']

}

