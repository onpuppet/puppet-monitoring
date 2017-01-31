# Class: monitoring::monitoring::mysql
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
# @param mysql_username [String] Username for Sensu checks. Default value: undef
# @param mysql_password [String] Password for Sensu checks. Default value: undef
#
class monitoring::monitoring::sensu::mysql (
  $plugins_location = '/opt/sensu/embedded/bin/',
  $mysql_username   = undef,
  $mysql_password   = undef,) {

  # TODO; dynamically create mysql credentials if mysql is present

  sensu::check { 'mysql-process': command => "${plugins_location}check-process.rb --pattern mysqld --warn-under 1", }

  if ($mysql_username) {
    package { 'sensu-plugins-mysql':
      ensure   => 'present',
      provider => sensu_gem,
    }

    $check_args = "-h localhost -u ${mysql_username} -p ${mysql_password} -s /run/mysqld/mysqld.sock"

    sensu::check { 'mysql-alive': command => "${plugins_location}check-mysql-alive.rb ${check_args}", }

    sensu::check { 'mysql-connections': command => "${plugins_location}check-mysql-connections.rb ${check_args}", }

    sensu::check { 'mysql-innodb-lock': command => "${plugins_location}check-mysql-innodb-lock.rb ${check_args}", }

    sensu::check { 'mysql-threads': command => "${plugins_location}check-mysql-threads.rb ${check_args}", }

  }
}
