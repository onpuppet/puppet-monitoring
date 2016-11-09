#
class monitoring::metrics::collectd::rabbitmq {
  class { '::collectd::plugin::rabbitmq': }
}
