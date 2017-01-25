# Class: monitoring::monitoring::postfix
# =====================================
#
class monitoring::monitoring::sensu::postfix (
  $plugins_location = '/opt/sensu/embedded/bin/',
) {

  package { 'sensu-plugins-postfix':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'mailq':
    command => "${plugins_location}check-mailq.rb --warnnum 10 --critnum 20",
  }
  sensu::check { 'mail-delay':
    command => "${plugins_location}check-mail-delay.rb --warnnum 10 -critnum 20",
  }
}
