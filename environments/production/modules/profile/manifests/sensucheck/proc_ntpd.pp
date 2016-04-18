class profile::sensucheck::proc_ntpd (

  $check_name     = 'proc_ntpd',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-process-checks'],
  $pkg_dependancy = false,
  $interval       = '120',
  $subscribers    = undef,
  $handlers       = undef,
  $check_warn     = undef,
  $check_crit     = undef,
  $check_cmd      = "check-process.rb -p /usr/sbin/ntpd",

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
