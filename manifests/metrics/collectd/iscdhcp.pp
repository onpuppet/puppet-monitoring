# Class: monitoring::metrics::collectd::iscdhcp
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
class monitoring::metrics::collectd::iscdhcp {
    class { '::collectd::plugin::iscdhcp': }
}
