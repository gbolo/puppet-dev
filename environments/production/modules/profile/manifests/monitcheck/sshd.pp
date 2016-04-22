class profile::monitcheck::sshd (

  $process        = 'sshd',
  $pid            = '/var/run/sshd.pid',
  $port           = $ssh::server::options['Port'],
  $bind_ip        = $::ipaddress,
  $proc_match     = false,
  $start          = '/usr/bin/systemctl start sshd',
  $stop           = '/usr/bin/systemctl stop sshd',
  $secondary_fail = "if failed host ${bind_ip} port ${port} protocol ssh then restart",
  $restart_count  = '3',
  $cycle_count    = '3',
  $template       = 'profile/monitcheck/basic_process.conf-new.epp',

) {

  # Test if port is assigned
  if $port {
    $restart_cond = $secondary_fail
  }
  else {
    $restart_cond = 'if failed port 22 protocol ssh then restart'
  }

  monit::check { $process:
    content  => epp($template, {
                  process        => $process,
                  pid            => $pid,
                  proc_match     => $proc_match,
                  port           => $port,
                  start          => $start,
                  stop           => $stop,
                  secondary_fail => $restart_cond,
                  restart_count  => $restart_count,
                  cycle_count    => $cycle_count,
                }),
  } 

}
