# == Class lysaker_monitored::install
#
# This class is called from lysaker_monitored for install.
#
class lysaker_monitored::install {

  class { 'collectd': }
}
