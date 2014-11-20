class clamav::cron (
  $unofficial_sigs_cron_ensure,
) {
  cron { 'update unofficial clamav signatures':
    ensure  => $unofficial_sigs_cron_ensure,
    command => '/usr/local/bin/clamav-unofficial-sigs.sh 2>&1 > /dev/null',
    user    => 'root',
    minute  => '24',
  }
}
