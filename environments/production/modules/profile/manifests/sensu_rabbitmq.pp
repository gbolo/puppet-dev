class profile::sensu_rabbitmq (
  $erlang_source      = 'puppet:///modules/nmap/nmap-6.45-1.x86_64.rpm',
  $require_ssl        = false,
  $sensu_rmq_user     = 'sensu',
  $sensu_rmq_pass     = 'sensu',
  $sensu_rmq_vhost    = '/sensu',
  $cacert_path,
  $cacert_source,
  $cert_path,
  $cert_source,
  $key_path,
  $key_content,
) {

   contain ::rabbitmq
   include ::profile::sensucheck::rabbitmq
   include ::profile::monitcheck::rabbitmq
   include ::profile::firewall::rabbitmq

   rabbitmq_vhost { $sensu_rmq_vhost:
     ensure => present,
   }

   rabbitmq_user { $sensu_rmq_user:
     password => $sensu_rmq_pass,
   }

   rabbitmq_user { 'gbolo':
     admin    => true,
     password => 'pass',
     tags     => ['monitoring'],
   }

   rabbitmq_user_permissions { "${sensu_rmq_user}@${sensu_rmq_vhost}":
     configure_permission => '.*',
     read_permission      => '.*',
     write_permission     => '.*',
   }

   # Install erlang rpm from file

   file { '/tmp/erlang-18.3-1.el7.centos.x86_64.rpm': 
     source => 'puppet:///modules/profile/erlang-18.3-1.el7.centos.x86_64.rpm',
   }

   package { 'erlang.x86_64':
     provider => 'rpm',
     source => "/tmp/erlang-18.3-1.el7.centos.x86_64.rpm",
     require => File["/tmp/erlang-18.3-1.el7.centos.x86_64.rpm"],
     ensure => 'installed',
   }

   # Install SSL Certs

   if $require_ssl {

     file { 'rmq_cacert':
       ensure    => 'present',
       path      => $cacert_path,
       source    => $cacert_source,
       owner     => 'rabbitmq',
       group     => 'rabbitmq',
       mode      => '0400',
     }

     file { 'rmq_cert':
       ensure    => 'present',
       path      => $cert_path,
       source    => $cert_source,
       owner     => 'rabbitmq',
       group     => 'rabbitmq',
       mode      => '0400',
     }

     file { 'rmq_key':
       ensure    => 'present',
       path      => $key_path,
       content   => $key_content,
       owner     => 'rabbitmq',
       group     => 'rabbitmq',
       mode      => '0400',
     }

   }

   # Ordering

   File['/tmp/erlang-18.3-1.el7.centos.x86_64.rpm'] -> Package['erlang.x86_64'] -> Class['rabbitmq']

}
