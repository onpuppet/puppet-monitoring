# Class: lysaker_monitored
# ===========================
#
# Full description of class lysaker_monitored here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class lysaker_monitored (
  $influxdb_hostname = $::lysaker_monitored::params::influxdb_hostname,
  $influxdb_port = $::lysaker_monitored::params::influxdb_port,
) inherits ::lysaker_monitored::params {

  # validate parameters here

  class { '::collectd':
    purge           => true,
    recurse         => true,
    purge_config    => true,
    minimum_version => '5.4',
  }

  collectd::plugin::network::server { $lysaker_monitored::influxdb_hostname: port => $lysaker_monitored::influxdb_port, }

  class { '::collectd::plugin::conntrack': }

#  class { '::collectd::plugin::cpu':
#    reportbystate    => true,
#    reportbycpu      => true,
#    valuespercentage => true,
#  }

  #class { '::collectd::plugin::memory':
  #}

  class { '::collectd::plugin::interface':
    interfaces     => ['eth0', 'lo'],
    ignoreselected => true,
  }
}
