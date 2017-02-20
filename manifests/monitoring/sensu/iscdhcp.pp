# Class: monitoring::monitoring::iscdhcp
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::iscdhcp (String $plugins_location,) {
  if $::iscdhcp_running {
    sensu::check { 'iscdhcp-process': command => "${plugins_location}check-process.rb --pattern dhcpd --warn-under 1", }
  }
}
