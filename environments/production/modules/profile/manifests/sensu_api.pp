class profile::sensu_api (

) {

  #include ::profile::sensucheck::sensu_api
  include ::profile::monitcheck::sensu_api
  include ::profile::firewall::sensu_api

}
