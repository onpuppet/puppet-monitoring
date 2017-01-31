# Class: monitoring::metrics::collectd::apache
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
class monitoring::metrics::collectd::apache {
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
