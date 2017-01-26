# == Class monitoring::params
#
# This class is meant to be called from monitoring.
# It sets variables according to platform.
#
class monitoring::params {
  $collectd_network_server_hostname = ''
  $collectd_network_server_port = 25826

  $sensu_rabbitmq_hostname = ''
  $sensu_rabbitmq_password = 'guest'

  case $::osfamily {
    'Debian', 'RedHat', 'Amazon' : { }
    default : { fail("${::operatingsystem} not supported") }
  }
}
