# Class: monitoring::monitoring::postfix
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::postfix (
  String $plugins_location,
) {

  package { 'sensu-plugins-postfix':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'mailq':
    command => "${plugins_location}check-mailq.rb --warnnum 10 --critnum 20",
  }
  sensu::check { 'mail-delay':
    command => "${plugins_location}check-mail-delay.rb --warnnum 10 --critnum 20",
  }
}
