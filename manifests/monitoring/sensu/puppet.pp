# Class: monitoring::monitoring::puppet
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::puppet (String $plugins_location,) {

  if ($::puppet_running) {
    sensu::check { 'puppet-process': command => "${plugins_location}check-process.rb --pattern puppet --warn-under 1", }
  }
}
