# Class: monitoring::monitoring::centrify
#======================================
#
class monitoring::monitoring::sensu::centrify (
  $plugins_location = '/opt/sensu/embedded/bin/',
  $homedir_path = '/home'
) {

  package { 'sensu-plugins-centrify':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'centrify-process':
    command => "${plugins_location}check-process.rb --pattern adclient --warn-under 1",
  }

  sensu::check { 'void-homedirs':
    command  => "${plugins_location}check-void-homedirs.rb --path ${homedir_path}",
    interval => 3600,
  }
}
