class i3::dashboard::single (
	$enable_dashboard = false,
  $owner = 'ckendall',
  $group = 'ckendall',
  $bin = 'refresh_dashboard',
#  $script = 'dashstart.sh',
  $url_one = 'http://gauges.stage.local/PickList.php?dark=true',
  ){


  file { "/usr/local/bin/${bin}":
    ensure  => file,
    content => template('i3/start-single.sh.erb'),
    owner   => $owner,
    group   => $group,
    mode    => '0777'
  }

if $enable_dashboard == true {

  exec { 'refresh_dashboard':
    command     => "/usr/local/bin/${bin}",
    refreshonly => true,
    environment => [ 'DISPLAY=:0' ],
    user        => $owner,
    subscribe   => [File["/usr/local/bin/${bin}"]],
  }

}

}

