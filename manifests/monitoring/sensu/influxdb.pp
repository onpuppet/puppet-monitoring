# Class: monitoring::monitoring::influxdb
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::influxdb (
  String $plugins_location,
) {

  package { 'sensu-plugins-influxdb':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'influxdb':
    command => "${plugins_location}check-influxdb.rb --use_ssl",
  }
}
