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

}
