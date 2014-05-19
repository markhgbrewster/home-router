class puppet {
  package { "puppet":
    ensure => "latest",
    require => Class["repo"],
  }

  file { "/etc/puppet/puppet.conf":
    ensure => "file",
    owner => "puppet",
    group => "staff",
    mode => "0660",
    source => "puppet:///modules/puppet/puppet.conf",
    require => Package["puppet"],
  }

  service { "puppet":
    ensure => "stopped",
    enable => false,
    require => File["/etc/puppet/puppet.conf"],
  }

  cron { "puppet-run":
    command => "/usr/local/bin/puppet-up && /usr/local/bin/puppet-run > /dev/null 2>&1",
    hour    => "*",
    minute  => "*/30",
    require => [
      Class["environment"],
      File["/etc/puppet/puppet.conf"],
    ],
  }
}