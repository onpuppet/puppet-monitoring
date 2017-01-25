# Class: monitoring::monitoring::elasticsearch
# ===========================================
#
class monitoring::monitoring::sensu::elasticsearch (
  $plugins_location = '/opt/sensu/embedded/bin/',
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
    command => "${plugins_location}check-es-heap.rb --percentage --warn 70 --crit 80",
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
}
