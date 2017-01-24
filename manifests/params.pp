# == Class monitoring::params
#
# This class is meant to be called from monitoring.
# It sets variables according to platform.
#
class monitoring::params {
  $metrics_tool = 'collectd'
  $collectd_network_server_hostname = 'influxdb'
  $collectd_network_server_port = 25826

  $monitoring_tool = 'sensu'
  $sensu_rabbitmq_hostname = 'rabbitmq'
  $sensu_rabbitmq_password = 'guest'
  $sensu_plugins_location = '/opt/sensu/embedded/bin/'
  $sensu_disk_usage_magic_factor = 0.9

  case $::osfamily {
    'Debian', 'RedHat', 'Amazon' : { }
    default : { fail("${::operatingsystem} not supported") }
  }
}
