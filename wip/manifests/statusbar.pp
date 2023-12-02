class i3::statusbar {

 file {"/etc/i3status.conf":
    owner   => pi,
    group   => pi,
    mode    => "775",
    ensure  => present,
    source  => "puppet:///modules/i3/i3status.conf"
  }

}

