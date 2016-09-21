# == Class lysaker_monitored::service
#
# This class is meant to be called from lysaker_monitored.
# It ensure the service is running.
#
class lysaker_monitored::service {

  service { $::lysaker_monitored::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
