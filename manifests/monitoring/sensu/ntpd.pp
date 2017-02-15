# Class: monitoring::monitoring::ntpd
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::ntpd (String $plugins_location,) {

  package { 'sensu-plugins-ntp':
    provider => sensu_gem,
  }

  sensu::check { 'ntpd-process':
    command => "${plugins_location}check-process.rb --pattern ntpd --warn-under 1",
  }
  sensu::check { 'ntp-offset':
    command => "${plugins_location}check-ntp.rb -w 150 -c 300",
  }
}
