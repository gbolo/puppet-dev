class profile::monitcheck::sensu_uchiwa (

  $process    = 'sensu_uchiwa',
  $pid        = '/var/run/uchiwa.pid',
  $port       = false,
  $proc_match = false,
  $start      = '/usr/bin/systemctl start uchiwa',
  $stop       = '/usr/bin/systemctl stop uchiwa',
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
