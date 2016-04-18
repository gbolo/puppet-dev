class profile::sensucheck::swap (

  $check_name     = 'swap',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-memory-checks'],
  $pkg_dependancy = false,
  $interval       = '120',
  $subscribers    = undef,
  $handlers       = undef,
  # checks units are in MB
  $check_warn     = '50',
  $check_crit     = '200',
  $check_cmd      = "check-swap.rb -w ${check_warn} -c ${check_crit}",

) {

  if $enabled {
  
    # Install the sensu plugin now using embedded ruby gem
    if $sensu_plugin {
	  ensure_resource (
	    'package', 
		$sensu_plugin, 
		{
		  ensure   => 'present',
          provider => 'sensu_gem',		  
		}
	  )
	}

	# Install required dependancy for the sensu plugin
	if $pkg_dependancy {
	  ensure_resource (
	    'package', 
		$pkg_dependancy, 
		{
		  ensure   => 'present',		  
		}
	  )	
	}
   
    # Add the sensu checks
    sensu::check { $check_name:
      command      => $check_cmd,
      interval     => $interval,
      subscribers  => $subscribers,
      handlers     => $handlers,
    }
  }


}
