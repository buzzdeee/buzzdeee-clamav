class clamav::params {
  $clamav_package_name = 'clamav'
  $clamav_package_ensure = 'installed'
  $clamd_service_name = 'clamd'
  $clamd_service_ensure = 'running'
  $clamd_service_flags = undef
  $freshclam_service_name = 'freshclam'
  $freshclam_service_ensure = 'running'
  $freshclam_service_flags = undef
  $unofficial_sigs_package_name = 'clamav-unofficial-sigs'
  $unofficial_sigs_package_ensure = 'installed'
  $unofficial_sigs_cron_ensure = 'present'

  $listen_host = '127.0.0.1'
  $listen_port = '3310'
}
