class profile::base::monit (

  $fw_enable     = false,
  $fw_http_port  = '2812',
  $fw_source     = '0.0.0.0/0',

) {

  # This class is for configuring the monit checks thatc ome with the base profile and common.eyaml

  monit::check { 'ntp':
    content => 'check process ntpd
    matching "ntpd"
    start program = "/usr/bin/systemctl start ntpd"
    stop  program = "/usr/bin/systemctl stop ntpd"
    if failed host 127.0.0.1 port 123 type udp then restart
    if 5 restarts within 5 cycles then timeout',
  } 

  monit::check { 'sshd':
    content => 'check process sshd with pidfile /var/run/sshd.pid
    start program = "/usr/bin/systemctl start sshd"
    stop  program = "/usr/bin/systemctl stop sshd"
    if failed port 22 protocol ssh then restart
    if 5 restarts within 5 cycles then timeout',
  }

  monit::check { 'vmware-tools':
    content => 'check process vmtoolsd
    matching "vmtoolsd"
    start program = "/usr/bin/systemctl start vmtoolsd"
    stop  program = "/usr/bin/systemctl stop vmtoolsd"
    if 5 restarts within 5 cycles then timeout',
  }

  monit::check { 'sensu-client':
    content => 'check process sensu-client with pidfile /var/run/sensu/sensu-client.pid
    start program = "/usr/bin/systemctl start sensu-client"
    stop  program = "/usr/bin/systemctl stop sensu-client"
    if 5 restarts within 5 cycles then timeout',
  }

  monit::check { 'crond':
    content => 'check process crond with pidfile /var/run/crond.pid
    start program = "/usr/bin/systemctl start crond"
    stop  program = "/usr/bin/systemctl stop crond"
    if 5 restarts within 5 cycles then timeout',
  }


  # Configure firewall if enabled
  if $fw_enable {
    firewall { '100 allow monit http to be accessed':
      dport   => $fw_http_port,
      proto  => 'tcp',
      source => $fw_source,
      action => 'accept',
    }
  }


}
