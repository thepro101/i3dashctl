class i3::dashboard::setup (
#  $enable_i3dash = false,
  $owner = 'ckendall',
  $group = 'ckendall',
  $bin = 'i3dashctl',
  $service_ensure = 'running',
  $service_enable = true,
  $dashboard_urls = [ 'http://gauges.stage.local/PickList.php?dark=true', 'https://espn.com' ],
#  $display_num = 0,
  ){

  file { "/usr/local/bin/${bin}":
    ensure  => file,
    content => template('i3/i3dashctl.erb'),
    owner   => $owner,
    group   => $group,
    mode    => '0777'
  }

  file { '/etc/systemd/system/i3dash.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('i3/i3dash.systemd.erb'),
  }~>

  service { 'i3dash':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => File["/etc/systemd/system/i3dash.service"],
    restart => 'always',
  }


#if $enable_i3dash == true {

#  exec { 'i3dashctl':
#    command     => "/usr/local/bin/${bin}",
#    refreshonly => true,
#    environment => [ 'DISPLAY=:0' ],
#    user        => $owner,
#    subscribe   => [File["/usr/local/bin/${bin}"]],
#  }

#}

}

