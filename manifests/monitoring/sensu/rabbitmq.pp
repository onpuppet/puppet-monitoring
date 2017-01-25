# Class: monitoring::monitoring::rabbitmq
# ======================================
#
class monitoring::monitoring::sensu::rabbitmq (
  $plugins_location = '/opt/sensu/embedded/bin/',
) {

  package { ['make', 'g++']:
    ensure   => 'present',
  } ->
  package { 'sensu-plugins-rabbitmq':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'rabbitmq-alive':
    command => "${plugins_location}check-rabbitmq-alive.rb",
  }
  sensu::check { 'rabbitmq-amqp-alive':
    command => "${plugins_location}check-rabbitmq-amqp-alive.rb",
  }
  sensu::check { 'rabbitmq-cluster-health':
    command => "${plugins_location}check-rabbitmq-cluster-health.rb",
  }
  sensu::check { 'rabbitmq-messages':
    command => "${plugins_location}check-rabbitmq-messages.rb",
  }
  sensu::check { 'rabbitmq-network-partitions':
    command => "${plugins_location}check-rabbitmq-network-partitions.rb",
  }
  sensu::check { 'rabbitmq-node-health':
    command => "${plugins_location}check-rabbitmq-node-health.rb",
  }

  ## https://github.com/sensu-plugins/sensu-plugins-rabbitmq/pull/34
  #sensu::check { 'rabbitmq-queue-drain-time':
  #  command => "${plugins_location}check-rabbitmq-queue-drain-time.rb",
  #}
}
