class i3::config (
  $dashboard_user = 'ckendall',
  $owner = 'ckendall',
  $group = 'ckendall',
  $xresources_hash = undef,
  $configure_i3  =  false,
  $configd_path = '/usr/share/regolith/i3',
  $confd_path = '/usr/share/i3xrocks',
  $configure_i3_additional = false,
  $configure_i3_additional_content = undef,
  $i3bar_content = undef,
  ){

    file { "/home/${dashboard_user}/.config/regolith3/Xresources":
      ensure  => file,
      owner   => $owner,
      group   => $group,
      content => template('i3/xresources.erb'),
#      notify  => Exec['reload_xresources'],
#      require => Package['regolith-desktop'],
    }

if $configure_i3 == true {


    file { "/home/${dashboard_user}/.config/regolith3/i3xrocks/conf.d/20_i3bar":
      ensure  => file,
      owner   => $owner,
      group   => $group,
      content => $i3bar_content,
      replace => true,
#      purge   => true,
##      notify  => Exec['reload_i3'],
# This should require the parent directory
##      require => Package['regolith-desktop'],
    }

  file { "${configd_path}/config.d":
    ensure  => directory,
    source  => 'puppet:///modules/i3/i3-regolith/config.d/',
    recurse => true,
    purge   => true,
## Subscribe used, no need for notify
###    notify  => Exec['reload_i3'],
  }

  file { "${confd_path}/conf.d":
    ensure  => directory,
    source  => 'puppet:///modules/i3/i3xrocks/conf.d/',
    recurse => true,
    purge   => true,
  }

  exec { 'reload_i3':
    command     => '/usr/bin/i3-msg reload',
    refreshonly => true,
    environment => [ 'DISPLAY=:0' ],
    user        => $dashboard_user,
    #subscribe	 => [File['/home/ckendall/.config/regolith3/i3xrocks/conf.d/20_i3bar'], File["${configd_path}/config.d"]],
    subscribe	 => [File["/home/${dashboard_user}/.config/regolith3/i3xrocks/conf.d/20_i3bar"], File["${configd_path}/config.d"], File["${confd_path}/conf.d"]],
  }

}

if $configure_i3_additonal == true {

  file { "/home/${dashboard_user}/.config/regolith3/i3/config.d":
    ensure => directory,
  }


    file { "/home/${dashboard_user}/.config/regolith3/i3/config.d/20_additional_config":
      ensure  => file,
      owner   => $owner,
      group   => $group,
      content => $configure_i3_additional_content,
#      require => Package['regolith-desktop'],
      require => File["/home/${dashboard_user}/.config/regolith3/i3/config.d"],
    }

  exec { 'reload_i3_p2':
    command     => '/usr/bin/i3-msg reload',
    refreshonly => true,
    environment => [ 'DISPLAY=:0' ],
    user        => $dashboard_user,
    subscribe	 => [File["/home/${dashboard_user}/.config/regolith3/i3/config.d/20_additional_config"]],

  }


}


}









