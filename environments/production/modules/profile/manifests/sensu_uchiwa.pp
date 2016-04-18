class profile::sensu_uchiwa (

) {

  contain ::uchiwa
#  include ::profile::sensucheck::sensu_uchiwa
  include ::profile::monitcheck::sensu_uchiwa
  include ::profile::firewall::sensu_uchiwa


}
