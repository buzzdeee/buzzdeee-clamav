# == Class: clamav
#
# Full description of class clamav here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'clamav':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class clamav (
  $clamav_package_name            = $clamav::params::clamav_package_name,
  $clamav_package_ensure          = $clamav::params::clamav_package_ensure,
  $clamd_service_name             = $clamav::params::clamd_service_name,
  $clamd_service_ensure           = $clamav::params::clamd_service_ensure,
  $clamd_service_flags            = $clamav::params::clamd_service_flags,
  $freshclam_service_name         = $clamav::params::freshclam_service_name,
  $freshclam_service_ensure       = $clamav::params::freshclam_service_ensure,
  $freshclam_service_flags        = $clamav::params::freshclam_service_flags,
  $unofficial_sigs_package_name   = $clamav::params::unofficial_sigs_package_name,
  $unofficial_sigs_package_ensure = $clamav::params::unofficial_sigs_package_ensure,
  $unofficial_sigs_cron_ensure    = $clamav::params::unofficial_sigs_cron_ensure,
) inherits clamav::params {

  class { 'clamav::logrotate':
    clamd_service_ensure        => $clamd_service_ensure,
    freshclam_service_ensure    => $freshclam_service_ensure,
    unofficial_sigs_cron_ensure => $unofficial_sigs_cron_ensure,
  }
  class { 'clamav::cron':
    unofficial_sigs_cron_ensure => $unofficial_sigs_cron_ensure,
  }
  class { 'clamav::config': }

  class { 'clamav::install':
    clamav_package_name            => $clamav_package_name,
    clamav_package_ensure          => $clamav_package_ensure,
    unofficial_sigs_package_name   => $unofficial_sigs_package_name,
    unofficial_sigs_package_ensure => $unofficial_sigs_package_ensure,
  }

  class { 'clamav::service':
    clamd_service_name       => $clamd_service_name,
    clamd_service_ensure     => $clamd_service_ensure,
    clamd_service_flags      => $clamd_service_flags,
    freshclam_service_name   => $freshclam_service_name,
    freshclam_service_ensure => $freshclam_service_ensure,
    freshclam_service_flags  => $freshclam_service_flags,
  }

  Class['clamav::install'] ->
  Class['clamav::logrotate'] ->
  Class['clamav::config'] ~>
  Class['clamav::service'] ->
  Class['clamav::cron']

}
