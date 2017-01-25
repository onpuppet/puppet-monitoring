# Class: monitoring::monitoring::collectd
# ======================================
#
class monitoring::monitoring::sensu::collectd (
  $plugins_location    = '/opt/sensu/embedded/bin/',
) {

  sensu::check { 'collectd-process':
    command => "${plugins_location}check-process.rb --pattern collectd --warn-under 1",
  }

}
