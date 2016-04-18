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
  include ::profile::sensucheck::ntpd

  # Install Sensu packages defined
   $pkg_list = hiera_array('sensu::packages')
   package {$pkg_list:
     # ensure   => 'latest',
     ensure   => 'present',
     provider => 'sensu_gem',
   }


  Class['sudo'] -> 
  Class['epel'] -> 
  Class['openvmtools'] -> 
  Class['monit'] 

}
