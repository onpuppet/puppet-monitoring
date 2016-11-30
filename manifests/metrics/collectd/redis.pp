#
class monitoring::metrics::collectd::ntpd {
  class { '::collectd::plugin::ntpd': }
}
