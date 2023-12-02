class i3::vnc (
  $owner = 'ckendall',
  $group = 'ckendall',
  $display_num = 0,
  $service_ensure = 'stopped',
  $service_enable = false,
){

### export DISPLAY=:0 && x11vnc -bg -reopen -forever -display :0

  file { '/etc/systemd/system/vncserver.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('i3/vnc.systemd.erb'),
  }~>

  service { 'vncserver':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => File["/etc/systemd/system/vncserver.service"],
    restart => 'always',
  }

}

