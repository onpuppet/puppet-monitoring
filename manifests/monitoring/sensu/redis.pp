# Class: monitoring::monitoring::sensu::redis
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::redis (
  String $plugins_location,
) {

  package { 'sensu-plugins-redis':
    provider => sensu_gem,
  }

  sensu::check { 'redis-process':
    command => "${plugins_location}check-process.rb --pattern redis-server --warn-under 1",
  }
  sensu::check { 'redis-info':
    command => "${plugins_location}check-redis-info.rb",
  }
  sensu::check { 'redis-ping':
    command => "${plugins_location}check-redis-ping.rb",
  }
  sensu::check { 'redis-memory-percentage':
    command => "${plugins_location}check-redis-memory-percentage.rb --warnmem 50 --critmem 75",
  }
}
