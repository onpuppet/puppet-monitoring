# Class: monitoring::monitoring::collectd
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::collectd (
  String $plugins_location,
) {

  sensu::check { 'collectd-process':
    command => "${plugins_location}check-process.rb --pattern collectd --warn-under 1",
  }

}
