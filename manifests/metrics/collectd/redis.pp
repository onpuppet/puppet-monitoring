# Class: monitoring::metrics::collectd::apache
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
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
