class i3::dashboard::toggle (
  $owner = 'ckendall',
  $group = 'ckendall',
  $bin = 'i3toggle',
  $service_enable = true,
  $service_ensure = 'running',
  $log_to_file = true,
  $log_path = '/var/log/i3toggle.log',
  $display_num = 0,
  $interval = 5,
  ){

  file { "/usr/local/bin/${bin}":
    ensure  => file,
    content => template('i3/toggle.erb'),
    owner   => $owner,
    group   => $group,
### Add a notify here. This will trigger a service restart when the urls are changed in foreman
    mode    => '0777'
  }

  file { '/etc/systemd/system/i3toggle.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('i3/toggle.systemd.erb'),
  }~>

  service { 'i3toggle':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => File["/usr/local/bin/${bin}"],
#    start   => "/usr/local/bin/${bin} -o ${log_path} -d ${display_num} -i ${interval}",
#    stop    => '/bin/kill -SIGINT $MAINPID',
    restart => 'always',
  }

}

