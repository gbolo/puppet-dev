class profile::collectd::cpu ( 

  $enabled    = true,

) {

  if $enabled {
    include collectd
    include collectd::plugin::cpu
  }

}

