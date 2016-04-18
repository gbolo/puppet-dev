class profile::monitcheck::rabbitmq (

  $process  = 'rabbitmq-server',
  $pid      = '/var/run/rabbitmq/pid',
  $port     = $rabbitmq::ssl_port,
  $start    = '/usr/bin/systemctl start rabbitmq-server',
  $stop     = '/usr/bin/systemctl stop rabbitmq-server',
  $template = 'profile/monitcheck/rabbitmq-server.conf.epp',

) {

  monit::check { $process:
    content  => epp('profile/monitcheck/rabbitmq-server.conf.epp'),
  } 

}
