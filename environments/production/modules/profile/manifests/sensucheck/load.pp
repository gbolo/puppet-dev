class profile::sensucheck::load (

  $check_name     = 'load',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-load-checks'],
  $pkg_dependancy = false,
  $interval       = '120',
  $subscribers    = undef,
  $handlers       = undef,
  $check_warn     = '0.5,1.0,2.0',
  $check_crit     = '0.9,3.0,5.0',
  $check_cmd      = "check-load.rb -w ${check_warn} -c ${check_crit} -p",

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
