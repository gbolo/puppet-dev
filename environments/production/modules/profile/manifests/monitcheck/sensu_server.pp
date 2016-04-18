class profile::monitcheck::sensu_server (

  $process    = 'sensu_server',
  $pid        = '/var/run/sensu/sensu-server.pid',
  $port       = false,
  $proc_match = false,
  $start      = '/usr/bin/systemctl start sensu-server',
  $stop       = '/usr/bin/systemctl stop sensu-server',
  $template   = 'profile/monitcheck/basic_process.conf.epp',

) {

  monit::check { $process:
    content  => epp($template, {
                  process    => $process,
                  pid        => $pid,
                  proc_match => $proc_match,
                  port       => $port,
                  start      => $start,
                  stop       => $stop,
                }),
  } 

}
