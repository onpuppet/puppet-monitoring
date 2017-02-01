# Class: monitoring::install
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
# @see https://www.github.com/onpuppet/puppet-monitoring Github
# @see https://forge.puppet.com/onpuppet/puppet-monitoring Puppet Forge
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
class monitoring::install {
  if !empty($::monitoring::collectd_network_server_hostname) {
    include ::monitoring::metrics::collectd
  }

  if (!empty($::monitoring::sensu_rabbitmq_hostname)) {
    include ::monitoring::monitoring::sensu
  }
}
