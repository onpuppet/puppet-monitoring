#
class monitoring::install () {

  case $::monitoring::metric_collector {
    'collectd' : {
      class { '::monitoring::metrics::collectd':
        collectd_network_server_hostname => $::monitoring::collectd_network_server_hostname,
        collectd_network_server_port     => $::monitoring::collectd_network_server_port,
      }
    }
    default    : {
      fail("Unsupported metric collector: ${::monitoring::metric_collector}")
    }
  }
}
