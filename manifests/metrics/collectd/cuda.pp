# Class: monitoring::metrics::collectd::cuda
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
class monitoring::metrics::collectd::cuda {
    class { '::collectd::plugin::cuda': }
}
