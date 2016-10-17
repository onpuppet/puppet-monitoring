#
class lysaker_monitored::services::redis {
  class { 'collectd::plugin::redis':
    nodes => {
      'localhost' => {
        'host' => 'localhost',
      },
    }
  }
}
