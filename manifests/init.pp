# Class: monitoring
#
# Autodetects installed services supported for monitoring,
# and roll out checks for these services
#
# @see https://www.github.com/Yuav/puppet-monitoring Github
# @see https://forge.puppet.com/Yuav/puppet-monitoring Puppet Forge
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# === Parameters
#
# [*collectd_network_server_hostname*]
#   Hostname of CollectD network server (E.G InfluxDB)
#   Leaving this parameter empty skips CollectD entirely
#
# [*collectd_network_server_port*]
#   Port used by CollectD network server
#
# [*sensu_rabbitmq_hostname*]
#   Hostname of RabbitMQ used by Sensu server
#   Leaving this parameter skips Sensu entirely
#
# [*sensu_rabbitmq_password*]
#   Password used for Sensu RabbitMQ queue
#
class monitoring (
  $collectd_network_server_hostname = $::monitoring::params::collectd_network_server_hostname,
  $collectd_network_server_port     = $::monitoring::params::collectd_network_server_port,
  $sensu_rabbitmq_hostname          = $::monitoring::params::sensu_rabbitmq_hostname,
  $sensu_rabbitmq_password          = $::monitoring::params::sensu_rabbitmq_password,) inherits ::monitoring::params {
  validate_string($collectd_network_server_hostname)
  validate_numeric($collectd_network_server_port)
  validate_string($sensu_rabbitmq_hostname)
  validate_string($sensu_rabbitmq_password)

  # Ensure facts refresh monitoring tools are applied last
  # Would rather use custom stages instead, but stages doesn't support subclasses
  # https://tickets.puppetlabs.com/browse/PUP-1108
  refacter { 'monitoring':
    patterns => [
      '^apache_',
      '^centrify_',
      '^collectd_',
      '^elasticsearch_',
      '^influxdb_',
      '^mysql_',
      '^ntpd_',
      '^postfix_',
      '^rabbitmq_',
      '^redis_',
    ],
  }

  Package <| title != 'collectd' and title != 'sensu' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['monitoring']
  }

  Service <| title != 'collectd' and title != 'sensu' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['monitoring']
  }

  class { '::monitoring::install':
  }

}
