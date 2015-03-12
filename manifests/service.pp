class clamav::service (
  $clamd_service_name,
  $clamd_service_ensure,
  $clamd_service_flags,
  $freshclam_service_name,
  $freshclam_service_ensure,
  $freshclam_service_flags,
) {
  service { "$clamd_service_name":
    ensure  => $clamd_service_ensure,
    flags   => $clamd_service_flags,
    require => Exec['fetch clamav databases'],
  }
  service { "$freshclam_service_name":
    ensure => $freshclam_service_ensure,
    flags  => $freshclam_service_flags,
  }

  Exec { 'fetch clamav databases':
    command => '/usr/local/bin/freshclam',
    creates  => '/var/db/clamav/main.cvd',
  }

  Service[$freshclam_service_name] ->
  Service[$clamd_service_name]
}
