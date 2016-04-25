class profile::collectd::network (

  $enabled    = true,
  $server     = '127.0.0.1',
  $port       = '25826',

) {

  if $enabled {
    collectd::plugin::network::server { $server:
      port => $port,
    }
  }
}
