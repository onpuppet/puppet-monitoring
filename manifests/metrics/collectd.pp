# Class: monitoring::collectd::metrics
#
# Collect metrics using collectd. Will attempt to collectd metrics from all supported types by default
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param network_server_hostname [String] Hostname of CollectD network server (E.G InfluxDB). Leaving this parameter empty skips CollectD entirely. Default value: ''
# @param network_server_port Optional[Integer[0, 65535]] Port used by CollectD network server. Valid options: unsigned shortint digit. Default value: undef
#
class monitoring::metrics::collectd (
  String $network_server_hostname,
  String $network_server_port,) {
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

  if ($::cuda_present) {
    include ::monitoring::metrics::collectd::cuda
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
