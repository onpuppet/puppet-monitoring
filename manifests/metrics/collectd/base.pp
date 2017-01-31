# Class: monitoring::metrics::collectd::base
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
class monitoring::metrics::collectd::base {
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

  # Not available until collectd 5.5 (Ubuntu 14.04 has 5.4)
  class { '::collectd::plugin::fhcount':
    valuesabsolute   => true,
    valuespercentage => false,
  }

  class { '::collectd::plugin::interface':
    interfaces     => ['lo'],
    ignoreselected => true,
  }

  class { '::collectd::plugin::load': }

  class { '::collectd::plugin::memory': }

  class { '::collectd::plugin::uptime': }

}
