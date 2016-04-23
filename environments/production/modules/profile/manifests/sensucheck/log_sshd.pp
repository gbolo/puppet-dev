class profile::sensucheck::log_sshd (

  $check_name     = 'log_sshd',
  $enabled        = true,
  $sensu_plugin   = ['sensu-plugins-logs'],
  $pkg_dependancy = false,
  $interval       = '120',
  $subscribers    = undef,
  $handlers       = undef,
  $time_frame     = '-30min',
  $check_warn     = '1',
  $check_crit     = '3',
  $check_cmd      = "/opt/sensu/embedded/bin/check-journal.rb -j '-u sshd.service' -q '.*Stopped.*|.*Failed.*' --since ${time_frame} -v -w ${check_warn} -c ${check_crit}",

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

    # Viewing logs/journalctl requires sensu user to be added to adm group
    # https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/s1-Using_the_Journal.html
    # !! the sensu puppetforge has declared sensu user already. Let's use Plusignment to add this user to group
    User<| title == sensu |> { groups +> [ "adm" ] }

  }


}
