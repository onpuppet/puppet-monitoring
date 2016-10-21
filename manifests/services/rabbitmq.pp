#
class lysaker_monitored::services::rabbitmq {
  class { '::collectd::plugin::rabbitmq': }
}
