# Class: monitoring::metrics::collectd::ntpd
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
class monitoring::metrics::collectd::ntpd {
  class { '::collectd::plugin::ntpd': }
}
