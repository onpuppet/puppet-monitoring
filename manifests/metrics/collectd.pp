# Class: monitoring::collectd::metrics
#===========================
#
# Collect metrics using collectd. Will attempt to collectd metrics from all supported types by default
#
class monitoring::metrics::collectd (
  $network_server_hostname = $::monitoring::collectd_network_server_hostname,
  $network_server_port     = $::monitoring::collectd_network_server_port,) {
  class { '::collectd':
    purge           => true,
    recurse         => true,
    purge_config    => false,
    minimum_version => '5.4',
  }

  collectd::plugin::network::server { $network_server_hostname: port => $network_server_port, }

  class { '::collectd::plugin::logfile':
    log_level => 'info',
    log_file  => '/var/log/collectd.log',
  }

  include ::monitoring::metrics::collectd::base

  if ($::apache_present) {
    include ::monitoring::metrics::collectd::apache
  }

  if ($::ntpd_present) {
    include ::monitoring::metrics::collectd::ntpd
  }

  if ($::redis_present) {
    include ::monitoring::metrics::collectd::redis
  }

  if ($::rabbitmq_present) {
    include ::monitoring::metrics::collectd::rabbitmq
  }

}
