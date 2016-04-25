class profile::base::logrotate (

  $create          = true,
  $rotate_every    = 'weekly',
  $rotate          = '4',
  $compress        = false,
  $dateext         = true,

) {

  class { '::logrotate':
    ensure => 'latest',
	config => {
	  create        => $create,
	  rotate_every  => $rotate_every,
      rotate        => $rotate,
	  compress      => $compress,
	  dateext       => $dateext,
	}
  }

  # no packages own wtmp and btmp. rotate here

  logrotate::rule { 'wtmp':
    path         => '/var/log/wtmp',
    rotate       => 1,
    rotate_every => 'monthly',
    minsize      => '1M',
    create       => true,
    create_owner => 'root',
    create_group => 'utmp',
    create_mode  => '0664',
  }

  logrotate::rule { 'btmp':
    path         => '/var/log/btmp',
    rotate       => 1,
    rotate_every => 'monthly',
    missingok    => true,
    create       => true,
    create_owner => 'root',
    create_group => 'utmp',
    create_mode  => '0664',
  }

}