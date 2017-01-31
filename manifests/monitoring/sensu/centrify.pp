# Class: monitoring::monitoring::centrify
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
# @param homedir_path [String] Path to check for home folders of deleted users. Default value: /home
# @param monitor_void_homedirs [Boolean] Enable or disable check for obsoleted home folders. Default value: true
#
class monitoring::monitoring::sensu::centrify (
  String $plugins_location = '/opt/sensu/embedded/bin/',
  String $homedir_path = '/home',
  Boolean $monitor_void_homedirs = true
) {

  package { 'sensu-plugins-centrify':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'centrify-process':
    command => "${plugins_location}check-process.rb --pattern adclient --warn-under 1",
  }

  if $monitor_void_homedirs {
    sensu::check { 'void-homedirs':
      command  => "${plugins_location}check-void-homedirs.rb --path ${homedir_path}",
      interval => 3600,
    }
  }
}
