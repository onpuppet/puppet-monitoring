#
class monitoring::metrics::collectd::redis {
  class { '::collectd::plugin::redis':
    nodes => {
      'localhost' => {
        'host' => 'localhost',
      },
    },
  }
}
