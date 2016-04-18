class profile::monitcheck::sensu_client (

  $process    = 'sensu_client',
  $pid        = '/var/run/sensu/sensu-client.pid',
  $port       = false,
  $proc_match = false,
  $start      = '/usr/bin/systemctl start sensu-client',
  $stop       = '/usr/bin/systemctl stop sensu-client',
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
