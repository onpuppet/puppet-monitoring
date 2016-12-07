#
class monitoring::metrics::collectd::rabbitmq {
  if ($::rabbitmq_management_port) {
    $config = {
      'Username' => 'guest',
      'Password' => 'guest',
      'Scheme'   => 'http',
      'Port'     => $::rabbitmq_management_port,
      'Host'     => $::fqdn,
      'Realm'    => '"RabbitMQ Management"',
    }

    class { '::collectd::plugin::rabbitmq':
      config => $config,
    }
  }
}
