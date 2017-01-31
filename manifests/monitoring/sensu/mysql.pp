# Class: monitoring::monitoring::mysql
#
# @author Jon Skarpeteig <jon.skarpeteig@gmail.com>
#
# @see https://yuav.github.io/puppet-monitoring Monitoring
#
# @param plugins_location [String] Location of sensu plugins. Default value: /opt/sensu/embedded/bin/
# @param username [String] Username for Sensu checks of mysql internals. Default value: undef
# @param password [String] Password for Sensu checks of mysql internals. Default value: undef
#
class monitoring::monitoring::sensu::mysql (
  String $plugins_location,
  String $username,
  String $password,
  ) {

  # TODO; dynamically create mysql credentials if mysql is present

  sensu::check { 'mysql-process': command => "${plugins_location}check-process.rb --pattern mysqld --warn-under 1", }

  if ($username) {
    package { 'sensu-plugins-mysql':
      ensure   => 'present',
      provider => sensu_gem,
    }

    $check_args = "-h localhost -u ${username} -p ${password} -s /run/mysqld/mysqld.sock"

    sensu::check { 'mysql-alive': command => "${plugins_location}check-mysql-alive.rb ${check_args}", }

    sensu::check { 'mysql-connections': command => "${plugins_location}check-mysql-connections.rb ${check_args}", }

    sensu::check { 'mysql-innodb-lock': command => "${plugins_location}check-mysql-innodb-lock.rb ${check_args}", }

    sensu::check { 'mysql-threads': command => "${plugins_location}check-mysql-threads.rb ${check_args}", }

  }
}
