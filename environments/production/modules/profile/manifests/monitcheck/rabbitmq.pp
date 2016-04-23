class profile::monitcheck::rabbitmq (

  $enabled    = true,
  $process    = 'rabbitmq-server',
  $pid        = '/var/run/rabbitmq/pid',
  $port       = undef,
  $proc_match = undef,
  $start      = '/usr/bin/systemctl start rabbitmq-server',
  $stop       = '/usr/bin/systemctl stop rabbitmq-server',
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
