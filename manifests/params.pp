# == Class monitoring::params
#
# This class is meant to be called from monitoring.
# It sets variables according to platform.
#
class monitoring::params {
  $metric_collector = 'collectd'
  $collectd_network_server_hostname = 'influxdb'
  $collectd_network_server_port = 25826

  case $::osfamily {
    'Debian', 'RedHat', 'Amazon' : { }
    default : { fail("${::operatingsystem} not supported") }
  }
}
