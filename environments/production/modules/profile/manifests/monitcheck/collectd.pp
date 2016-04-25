class profile::monitcheck::collectd (

  $enabled    = true,
  $process    = 'collectd',
  $pid        = false,
  $port       = false,
  $proc_match = '/usr/sbin/collectd',
  $start      = '/usr/bin/systemctl start collectd',
  $stop       = '/usr/bin/systemctl stop collectd',
  $template   = 'profile/monitcheck/basic_process.conf.epp',

) {

  if $enabled {

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

}
