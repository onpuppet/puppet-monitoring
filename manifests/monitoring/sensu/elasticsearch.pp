# Class: monitoring::monitoring::elasticsearch
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::elasticsearch (
  String $plugins_location,
) {

  if !defined(Package['gcc']) {
    package { 'gcc':
      ensure => 'present',
    }
  }

  if !defined(Package['g++']) {
    package { 'g++':
      ensure => 'present',
    }
  }

  if !defined(Package['make']) {
    package { 'make':
      ensure => 'present',
    }
  }

  package { 'sensu-plugins-elasticsearch':
    ensure   => 'present',
    provider => sensu_gem,
    require  => [Package['gcc'], Package['g++'], Package['make']],
  }

  sensu::check { 'es-circuit-breakers':
    command => "${plugins_location}check-es-circuit-breakers.rb",
  }
  sensu::check { 'es-cluster-health':
    command => "${plugins_location}check-es-cluster-health.rb",
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
  sensu::check { 'es-indices-sizes':
    command => "${plugins_location}check-es-indices-sizes.rb",
  }
  sensu::check { 'es-node-status':
    command => "${plugins_location}check-es-node-status.rb",
  }
  sensu::check { 'es-shard-allocation-status':
    command => "${plugins_location}check-es-shard-allocation-status.rb",
  }
}
