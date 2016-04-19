class profile::base {

  # Base services/packages
  contain ::ntp
  contain ::ssh::server
  include ::sensu
  contain ::openvmtools
  contain ::monit
  contain ::epel
  contain ::sudo

  # Monitoring of base services
  contain ::profile::base::firewall
  include ::profile::firewall::monit
  include ::profile::monitcheck::ntpd
  include ::profile::monitcheck::crond
  include ::profile::monitcheck::sensu_client
# include ::profile::monitcheck::puppet_agent
  include ::profile::monitcheck::sshd
  include ::profile::monitcheck::vmtoolsd
  include ::profile::sensucheck::puppet_agent
  include ::profile::sensucheck::load
  include ::profile::sensucheck::cpu
  include ::profile::sensucheck::swap
  include ::profile::sensucheck::memory
  include ::profile::sensucheck::disk
  include ::profile::sensucheck::proc_crond
  include ::profile::sensucheck::proc_sshd
  include ::profile::sensucheck::proc_monit
  include ::profile::sensucheck::proc_vmtoolsd
  include ::profile::sensucheck::proc_ntpd
  include ::profile::sensucheck::ntp_external
  include ::profile::sensucheck::ntpd

  # Ordering 
  Class['sudo'] -> 
  Class['epel'] -> 
  Class['openvmtools'] -> 
  Class['monit']

  Class['ssh::server'] ->
  Class['firewall']

}