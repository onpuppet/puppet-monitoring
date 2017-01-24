# Class: monitoring::monitoring::sensu::redis
# ===========================================
#
class monitoring::monitoring::sensu::redis (
  $plugins_location = $::monitoring::sensu_plugins_location,
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
