#
class monitoring::install {
  if !empty($::monitoring::collectd_network_server_hostname) {
    class { '::monitoring::metrics::collectd':
      network_server_hostname => $::monitoring::collectd_network_server_hostname,
      network_server_port     => $::monitoring::collectd_network_server_port,
    }
  }

  if (!empty($::monitoring::sensu_rabbitmq_hostname)) {
    class { '::monitoring::monitoring::sensu':
      rabbitmq_hostname => $::monitoring::sensu_rabbitmq_hostname,
      rabbitmq_password => $::monitoring::sensu_rabbitmq_password,
    }
  }
}
