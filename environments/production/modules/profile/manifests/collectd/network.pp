class profile::collectd::network (

  $enabled    = true,
  $server     = '127.0.0.1',
  $port       = '25826',

) {

  if $enabled {

    include collectd
    collectd::plugin::network::server { $server:
      port => $port,
    }

  }
}
