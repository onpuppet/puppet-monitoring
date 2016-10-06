# Class: lysaker_monitored
#===========================
#
# Full description of class lysaker_monitored here.
#
# Parameters
#----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class lysaker_monitored (
  $influxdb_hostname = $::lysaker_monitored::params::influxdb_hostname,
  $influxdb_port     = $::lysaker_monitored::params::influxdb_port,) inherits ::lysaker_monitored::params {
  # validate parameters here

  class { '::collectd':
    purge           => true,
    recurse         => true,
    purge_config    => true,
    minimum_version => '5.4',
  }

  collectd::plugin::network::server { $lysaker_monitored::influxdb_hostname: port => $lysaker_monitored::influxdb_port, }

  class { '::collectd::plugin::cpu':
    reportbystate    => true,
    reportbycpu      => true,
    valuespercentage => true,
  }

  class { '::collectd::plugin::disk':
    disks          => ['/^dm/'],
    ignoreselected => true,
    manage_package => false,
  }

  class { '::collectd::plugin::df':
    fstypes        => ['nfs', 'tmpfs', 'autofs', 'gpfs', 'proc', 'devpts'],
    ignoreselected => true,
  }

  class { '::collectd::plugin::fhcount':
    valuesabsolute   => true,
    valuespercentage => false,
  }

  class { '::collectd::plugin::interface':
    interfaces     => ['lo'],
    ignoreselected => true,
  }

  class { '::collectd::plugin::load':
  }

  class { '::collectd::plugin::logfile':
    log_level => 'info',
    log_file  => '/var/log/collectd.log',
  }

  class { '::collectd::plugin::memory':
  }

  class { '::collectd::plugin::uptime':
  }

}
