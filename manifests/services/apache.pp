#
class lysaker_monitored::services::apache {
  if defined(Class['apache']) {
    class { '::apache::mod::status':
      allow_from      => ['127.0.0.1', '::1'],
      extended_status => 'On',
    }
  }

  if ($::apache_statuspage_present) {
    class { '::collectd::plugin::apache':
      instances => {
        'apache80' => {
          'url' => 'http://localhost/server-status?auto',
        },
      },
    }
  }
}
