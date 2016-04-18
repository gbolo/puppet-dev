class profile::sensucheck::puppet_agent (

  $check_name     = 'puppet_agent',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-puppet'],
  $pkg_dependancy = false,
  $interval       = '600',
  $subscribers    = undef,
  $handlers       = undef,
  # Check units are in seconds
  $check_warn     = '7200',
  $check_crit     = '21600',
  $check_cmd      = "sudo /opt/sensu/embedded/bin/check-puppet-last-run.rb --warn-age ${check_warn} --crit-age ${check_crit}",

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
