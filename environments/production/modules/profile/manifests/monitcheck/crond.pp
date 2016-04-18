class profile::monitcheck::crond (

  $process    = 'crond',
  $pid        = '/var/run/crond.pid',
  $port       = false,
  $proc_match = false,
  $start      = '/usr/bin/systemctl start crond',
  $stop       = '/usr/bin/systemctl stop crond',
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
