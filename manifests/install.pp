#
class monitoring::install () {
  case $::monitoring::metrics_tool {
    'collectd' : {
      class { '::monitoring::metrics::collectd':
        network_server_hostname => $::monitoring::collectd_network_server_hostname,
        network_server_port     => $::monitoring::collectd_network_server_port,
      }
    }
    default    : {
      fail("Unsupported metrics tool: ${::monitoring::metrics_tool}")
    }
  }

  case $::monitoring::monitoring_tool {
    'sensu' : {
      class { '::monitoring::monitoring::sensu':
        rabbitmq_hostname => $::monitoring::sensu_rabbitmq_hostname,
        rabbitmq_password => $::monitoring::sensu_rabbitmq_password,
      }
    }
    default    : {
      fail("Unsupported monitoring tool: ${::monitoring::monitoring_tool}")
    }
  }
}
