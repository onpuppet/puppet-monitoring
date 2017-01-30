# Class: monitoring::monitoring::centrify
#======================================
#
class monitoring::monitoring::sensu::centrify (
  $plugins_location = '/opt/sensu/embedded/bin/',
  $homedir_path = '/home',
  $monitor_void_homedirs = true
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
