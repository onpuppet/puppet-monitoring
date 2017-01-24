# Class: monitoring
#===========================
#
# Will autodetect installed services supported for monitoring,
# and roll out checks for these services
#
# Parameters
#----------
#
# * `metric_collector`
#   What tool to use for metrics collection. Defaults to collectd
#   Supported tools: collectd
#
class monitoring (
  $metrics_tool                     = $::monitoring::params::metrics_tool,
  $collectd_network_server_hostname = $::monitoring::params::collectd_network_server_hostname,
  $collectd_network_server_port     = $::monitoring::params::collectd_network_server_port,
  $monitoring_tool                  = $::monitoring::params::monitoring_tool,
  $sensu_disk_usage_magic_factor    = $::monitoring::params::sensu_disk_usage_magic_factor,
  $sensu_rabbitmq_hostname          = $::monitoring::params::sensu_rabbitmq_hostname,
  $sensu_rabbitmq_password          = $::monitoring::params::sensu_rabbitmq_password,
) inherits ::monitoring::params {

  validate_numeric($sensu_disk_usage_magic_factor)

  # Ensure facts refresh monitoring tools are applied last
  # Would rather use custom stages instead, but stages doesn't support subclasses
  # https://tickets.puppetlabs.com/browse/PUP-1108
  refacter { 'monitoring': patterns => ['^apache_', '^rabbitmq_', '^redis_'] }

  Package <| title != 'collectd' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['monitoring']
  }

  Service <| title != 'collectd' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['monitoring']
  }

  class { '::monitoring::install': }

}
