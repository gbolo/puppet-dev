class profile::monitcheck::puppet_agent (

  $enabled    = true,
  $process    = 'puppet_agent',
  $pid        = '/var/run/puppetlabs/agent.pid',
  $port       = undef,
  $proc_match = undef,
  $start      = '/usr/bin/systemctl start puppet',
  $stop       = '/usr/bin/systemctl stop puppet',
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
