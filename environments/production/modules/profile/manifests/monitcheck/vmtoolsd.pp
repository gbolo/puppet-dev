class profile::monitcheck::vmtoolsd (

  $enabled    = true,
  $process    = 'vmtoolsd',
  $pid        = false,
  $port       = false,
  $proc_match = '/usr/bin/vmtoolsd',
  $start      = '/usr/bin/systemctl start vmtoolsd',
  $stop       = '/usr/bin/systemctl stop vmtoolsd',
  $template   = 'profile/monitcheck/basic_process.conf.epp',

) {

  if $virtual == 'vmware' {

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
