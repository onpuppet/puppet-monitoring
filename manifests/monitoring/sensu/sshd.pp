# Class: monitoring::monitoring::sshd
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://onpuppet.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
#
class monitoring::monitoring::sensu::sshd (String $plugins_location,) {

  if ($::sshd_running) {
    sensu::check { 'sshd-process': command => "${plugins_location}check-process.rb --pattern ssh --warn-under 1", }

    sensu::check { 'port-ssh-tcp-22': command => "${plugins_location}check-ports.rb --ports 22", }
  }
}
