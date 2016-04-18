class profile::monitcheck::redis (

  $process    = 'redis',
  $pid        = false,
  $port       = $redis::port,
  $proc_match = '/usr/bin/redis-server',
  $start      = '/usr/bin/systemctl start redis',
  $stop       = '/usr/bin/systemctl stop redis',
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
