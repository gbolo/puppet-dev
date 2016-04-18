class profile::sensucheck::disk (

  $check_name     = 'disk',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-disk-checks'],
  $pkg_dependancy = false,
  $interval       = '120',
  $subscribers    = undef,
  $handlers       = undef,
  $check_warn     = '80',
  $check_crit     = '90',
  $check_cmd      = "check-disk-usage.rb -w ${check_warn} -c ${check_crit}",

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
