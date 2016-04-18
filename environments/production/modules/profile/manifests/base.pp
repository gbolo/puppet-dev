class profile::base {

  contain ::ntp
  contain ::ssh::server
  include ::sensu
  contain ::openvmtools
  contain ::monit
  contain ::epel
  contain ::sudo
  contain ::profile::base::monit
  contain ::profile::base::firewall
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

  Class['sudo'] -> 
  Class['epel'] -> 
  Class['openvmtools'] -> 
  Class['monit'] 

}