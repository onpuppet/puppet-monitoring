# Class: monitoring::monitoring::influxdb
# ======================================
#
class monitoring::monitoring::sensu::influxdb (
  $plugins_location = '/opt/sensu/embedded/bin/',
) {

  package { 'sensu-plugins-influxdb':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'influxdb':
    command => "${plugins_location}check-influxdb.rb --use_ssl",
  }
}
