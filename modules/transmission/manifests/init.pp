class transmission {
  $config = hiera("transmission")

  package { "transmission-daemon":
    ensure => "latest",
  }

  file { "/etc/transmission-daemon/settings.json":
    ensure => "file",
    owner => "root",
    group => "debian-transmission",
    mode => "0640",
    content => template("transmission/settings.json.erb"),
    require => File["/etc/transmission-daemon"],
  }

  file {[
    "/etc/transmission-daemon",
    "/home/debian-transmission",
    "/home/debian-transmission/.config",
    "/home/debian-transmission/.config/transmission-daemon",
    $config["download_dir"],
    "${config['download_dir']}/incomplete"
  ]:
    ensure => "directory",
    owner => "debian-transmission",
    group => "staff",
    mode => "0570",
    require => Package["transmission-daemon"],
  }

  file { "/etc/default/transmission-daemon":
    ensure => "file",
    source => "puppet:///modules/transmission/defaults",
    require => Package["transmission-daemon"],
  }

  file { "${config['config-dir']}/settings.json":
    mode => "0660",
    owner => "root",
    group => "debian-transmission",
  }

  service { "transmission-daemon":
    ensure => "running",
    enable => true,
    subscribe => File["/etc/transmission-daemon/settings.json"],
    require => File[
      "/etc/default/transmission-daemon",
      "/etc/transmission-daemon/settings.json"
    ],
  }

}
