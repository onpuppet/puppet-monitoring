# Class: monitoring::collectd::metrics
#===========================
#
# Collect metrics using collectd. Will attempt to collectd metrics from all supported types by default
#
class monitoring::metrics::collectd (
  $collectd_network_server_hostname = $::monitoring::params::collectd_network_server_hostname,
  $collectd_network_server_port     = $::monitoring::params::collectd_network_server_port,) {
  class { '::collectd':
    purge           => true,
    recurse         => true,
    purge_config    => false,
    minimum_version => '5.4',
  }

  collectd::plugin::network::server {
    $collectd_network_server_hostname:
    port => $collectd_network_server_port,
  }

  class { '::collectd::plugin::logfile':
    log_level => 'info',
    log_file  => '/var/log/collectd.log',
  }

  include ::monitoring::metrics::collectd::base

  include ::monitoring::metrics::collectd::apache

  if ($::redis_present) {
    include ::monitoring::metrics::collectd::redis
  }

  if ($::rabbitmq_present) {
    include ::monitoring::metrics::collectd::rabbitmq
  }

}
