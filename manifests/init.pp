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
  $metric_collector                 = $::monitoring::params::metric_collector,
  $collectd_network_server_hostname = $::monitoring::params::collectd_network_server_hostname,
  $collectd_network_server_port     = $::monitoring::params::collectd_network_server_port,) inherits ::monitoring::params {

  # Ensure facts refresh monitoring tools are applied last
  # Would rather use custom stages instead, but stages doesn't support subclasses
  # https://tickets.puppetlabs.com/browse/PUP-1108
  refacter { 'all': patterns => ['.*'] }

  Package <| title != 'collectd' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['all']
  }

  Service <| title != 'collectd' |> {
    before +> Class['monitoring::install'],
    notify +> Refacter['all']
  }

  class { '::monitoring::install': }

}
