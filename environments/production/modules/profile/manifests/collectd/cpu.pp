class profile::collectd::cpu ( 

  $enabled    = true,

) {

  if $enabled {
    include collectd::plugin::cpu
  }

}

