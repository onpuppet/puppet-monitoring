# Class: monitoring::monitoring::sensu
#===================================
#
class monitoring::monitoring::sensu (
  $rabbitmq_hostname     = $::monitoring::sensu_rabbitmq_hostname,
  $rabbitmq_password     = $::monitoring::sensu_rabbitmq_password,
) {

  # Don't override sensu install on sensu server node
  if !defined(Class['::sensu']) {
    class { '::sensu':
      server            => false,
      api               => false,
      rabbitmq_host     => $rabbitmq_hostname,
      rabbitmq_password => $rabbitmq_password,
      purge             => true,
      use_embedded_ruby => true,
      safe_mode         => true,
    }
  }

  include ::monitoring::monitoring::sensu::base

  if ($::centrify_present) {
    include ::monitoring::monitoring::sensu::centrify
  }

  # Special case collectd, as it may be installed during last stage by this module
  if (defined(Package['collectd']) or $::collectd_present) {
    include ::monitoring::monitoring::sensu::collectd
  }

  if ($::elasticsearch_present) {
    include ::monitoring::monitoring::sensu::elasticsearch
  }

  if ($::influxdb_present) {
    include ::monitoring::monitoring::sensu::influxdb
  }

  if ($::mysql_present) {
    include ::monitoring::monitoring::sensu::mysql
  }

  if ($::postfix_present) {
    include ::monitoring::monitoring::sensu::postfix
  }

  if ($::rabbitmq_present) {
    include ::monitoring::monitoring::sensu::rabbitmq
  }

  if ($::redis_present) {
    include ::monitoring::monitoring::sensu::redis
  }

}
