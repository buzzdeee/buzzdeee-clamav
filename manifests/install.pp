class clamav::install (
  $clamav_package_name,
  $clamav_package_ensure,
  $unofficial_sigs_package_name,
  $unofficial_sigs_package_ensure,
) {
  package { "$clamav_package_name":
    ensure => $clamav_package_ensure,
  }
  package { "$unofficial_sigs_package_name":
    ensure => $unofficial_sigs_package_ensure,
  }
}
