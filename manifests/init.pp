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
  $package_name = $::lysaker_monitored::params::package_name,
  $service_name = $::lysaker_monitored::params::service_name,
) inherits ::lysaker_monitored::params {

  # validate parameters here

  class { '::lysaker_monitored::install': } ->
  class { '::lysaker_monitored::config': } ~>
  class { '::lysaker_monitored::service': } ->
  Class['::lysaker_monitored']
}
