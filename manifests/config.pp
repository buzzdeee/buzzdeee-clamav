class clamav::config (
  $listen_host,
  $listen_port,
) {
  file { '/etc/clamd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('clamav/clamd.conf.erb')
  }
  file { '/etc/clamav-unofficial-sigs.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('clamav/clamav-unofficial-sigs.conf.erb')
  }
  file { '/etc/freshclam.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0644',
    content => template('clamav/freshclam.conf.erb')
  }
  file { '/var/log/freshclam.log':
    ensure  => 'present',
    owner   => '_clamav',
    group   => '_clamav',
    mode    => '0644',
  }
  file { '/var/log/clamd.log':
    ensure  => 'present',
    owner   => '_clamav',
    group   => '_clamav',
    mode    => '0644',
  }
}
