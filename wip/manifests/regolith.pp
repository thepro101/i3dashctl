class i3::regolith (
  $apt_key = 'https://regolith-linux.github.io/regolith-linux/KEY.gpg',
  $repo_url = 'deb https://regolith-linux.github.io/regolith-repo/ bionic main',
  $regolith_ensure = 'installed'
){

  # Register Regolith public key to the local apt
  apt::key { 'regolith':
    id     => $apt_key,
    ensure => 'present',
    source => $apt_key,
  }

  # Add Regolith repository URL to apt sources
  apt::source { 'regolith':
    location => $repo_url,
    repos    => 'main',
    key      => 'regolith',
    before   => Package['regolith-desktop'],
  }

  # Update apt and install Regolith desktop
  package { 'regolith-desktop':
    ensure  => $regolith_ensure,
    require => Apt::Source['regolith'],
  }

}

