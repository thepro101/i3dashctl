class i3::dashboard::dual (
  $owner = 'ckendall',
  $group = 'ckendall',
  $browserleft_url = 'http://gauges.stage.local/PickList.php?dark=true',
  $browserright_url = 'http://gauges.stage.local/gauges.php?dark=true'
  ){


 file { '/home/pi/dashstart.sh':
    ensure  => file,
    content => template('i3/start-dual.sh.erb'),
    owner   => $owner,
    group   => $group,
    mode    => "777"
 }

 file { '/usr/bin/refreshdash':
    ensure  => file,
    content => template('i3/start-dual.sh.erb'),
    owner   => $owner,
    group   => $group,
    mode    => "777"
 }


}

