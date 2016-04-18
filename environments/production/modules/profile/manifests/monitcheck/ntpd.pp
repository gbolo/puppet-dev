class profile::monitcheck::ntpd (

  $process    = 'ntpd',
  $pid        = false,
  $port       = false,
  $proc_match = '/usr/sbin/ntpd',
  $start      = '/usr/bin/systemctl start ntpd',
  $stop       = '/usr/bin/systemctl stop ntpd',
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
