# == Class lysaker_monitored::params
#
# This class is meant to be called from lysaker_monitored.
# It sets variables according to platform.
#
class lysaker_monitored::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'lysaker_monitored'
      $service_name = 'lysaker_monitored'
    }
    'RedHat', 'Amazon': {
      $package_name = 'lysaker_monitored'
      $service_name = 'lysaker_monitored'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
