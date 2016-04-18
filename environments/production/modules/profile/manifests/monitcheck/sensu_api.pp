class profile::monitcheck::sensu_api (

  $process    = 'sensu_api',
  $pid        = '/var/run/sensu/sensu-api.pid',
  $port       = false,
  $proc_match = false,
  $start      = '/usr/bin/systemctl start sensu-api',
  $stop       = '/usr/bin/systemctl stop sensu-api',
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
