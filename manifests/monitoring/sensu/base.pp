# Class: lysaker_sensu::checks::base
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
# @param disk_usage_magic_factor [String] Magic factor for Sensu used for disk plugin. Default value: 0.9
#
class monitoring::monitoring::sensu::base (
  String $plugins_location,
  String $disk_usage_magic_factor,) {

  package { [
    'sensu-plugins-cpu-checks',
    'sensu-plugins-memory-checks',
    'sensu-plugins-disk-checks',
    'sensu-plugins-load-checks',
    'sensu-plugins-filesystem-checks',
    'sensu-plugins-process-checks',
    'sensu-plugins-network-checks',
    ]:
    provider => sensu_gem,
  }

  sensu::check { 'memory': command => "${plugins_location}check-memory.rb", }

  sensu::check { 'memory-percent': command => "${plugins_location}check-memory-percent.rb -w 85 -c 95", }

  sensu::check { 'swap-percent': command => "${plugins_location}check-swap-percent.rb", }

  $ignore_fs_types = 'nfs,nfs4,cifs,devtmpfs,tmpfs,aufs,proc'
  $ignore_mnt = '"^/run/|^/sys/|^/var/lib/docker/|^/snap/"'

  sensu::check { 'disk-usage':
    command => "${plugins_location}check-disk-usage.rb -x ${ignore_fs_types} -p ${ignore_mnt} -m ${disk_usage_magic_factor}",
  }

  sensu::check { 'load': command => "${plugins_location}check-load.rb --per-core --warn 4,8,12 --crit 8,12,16", }

  sensu::check { 'root-fs-writable': command => "${plugins_location}check-fs-writable.rb --directory /etc/sensu/", }

  sensu::check { 'process-zombie-state':
    command => "${plugins_location}check-process.rb --state Z --warn-over 20 --critical-over 40 --warn-under 0 --critical-under 0",
  }

}
