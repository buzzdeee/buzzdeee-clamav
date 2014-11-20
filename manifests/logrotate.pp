class clamav::logrotate (
  $clamd_service_ensure,
  $freshclam_service_ensure,
  $unofficial_sigs_cron_ensure,
){
  $clamd_syslog_ensure = $clamd_service_ensure ? {
    /running/ => 'present',
    default => 'absent',
  }
  $unofficial_sigs_syslog_ensure = $unofficial_sigs_cron_ensure ? {
    /present/ => 'present',
    default => 'absent',
  }
  $freshclam_syslog_ensure = $freshclam_service_ensure ? {
    /running/ => 'present',
    default => 'absent',
  }

  newsyslog { '/var/log/clamav-unofficial-sigs.log':
    ensure  => $unofficial_sigs_syslog_ensure,
    owner   => 'root',
    group   => 'wheel',
    mode    => '640',
    keep    => '7',
    size    => '1024',
    when    => '*',
    flags   => 'Z',
  }

  newsyslog { '/var/log/freshclam.log':
    ensure  => $freshclam_syslog_ensure,
    owner   => '_clamav',
    group   => '_clamav',
    mode    => '640',
    keep    => '7',
    size    => '1024',
    when    => '*',
    flags   => 'Z',
  }

  newsyslog { '/var/log/clamd.log':
    ensure  => $clamd_syslog_ensure,
    owner   => '_clamav',
    group   => '_clamav',
    mode    => '640',
    keep    => '7',
    size    => '1024',
    when    => '*',
    flags   => 'Z',
  }
}
