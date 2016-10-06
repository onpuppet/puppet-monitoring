class lysaker_monitored::apache {
  class { 'apache::mod::status':
    allow_from      => ['127.0.0.1', '::1'],
    extended_status => 'On',
  }

  class { 'collectd::plugin::apache':
    instances => {
      'apache80' => {
        'url' => 'http://localhost/mod_status?auto',
      }
    },
  }
}
