class profile::sensu_server (

) {

  #include ::profile::sensucheck::sensu_server
  include ::profile::monitcheck::sensu_server
  include ::profile::sensucheck::ntp_external

}
