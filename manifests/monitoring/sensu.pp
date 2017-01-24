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

  if ($::redis_present) {
    include ::monitoring::monitoring::sensu::redis
  }

  #  $services = [
  #    'collectd',
  #    'centrify',
  #    'elasticsearch',
  #    'influxdb',
  #    'mysql',
  #    'postfix',
  #    'rabbitmq',
  #    'redis',
  #  ]
  #
  #  $services.each |$service| {
  #    if defined(Class[$service]) {
  #      class { "::lysaker_sensu::checks::${service}": }
  #    }
  #  }
}
