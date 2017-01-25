# Class: monitoring::monitoring::elasticsearch
# ===========================================
#
class monitoring::monitoring::sensu::elasticsearch (
  $plugins_location = '/opt/sensu/embedded/bin/',
) {

  package { 'sensu-plugins-elasticsearch':
    ensure   => 'present',
    provider => sensu_gem,
  }

  sensu::check { 'es-circuit-breakers':
    command => "${plugins_location}check-es-circuit-breakers.rb",
  }
  sensu::check { 'es-cluster-status':
    command => "${plugins_location}check-es-cluster-status.rb",
  }
  sensu::check { 'es-file-descriptors':
    command => "${plugins_location}check-es-file-descriptors.rb",
  }
  sensu::check { 'es-heap':
    command => "${plugins_location}check-es-heap.rb --percentage --warn 80 --crit 90",
  }
  sensu::check { 'es-indexes':
    command => "${plugins_location}check-es-indexes.rb --cluster elasticsearch",
  }
  sensu::check { 'es-node-status':
    command => "${plugins_location}check-es-node-status.rb",
  }
  sensu::check { 'es-shard-allocation-status':
    command => "${plugins_location}check-es-shard-allocation-status.rb",
  }
}
