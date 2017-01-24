require 'spec_helper_acceptance'

describe 'configure server side' do
  context 'minimal config to enable client tests' do
    it 'should install a working server side' do
      pp_master = <<-EOS
        class { '::rabbitmq':
          ssl               => false,
          delete_guest_user => false,
        } ->
        rabbitmq_vhost { 'sensu': } ->
        rabbitmq_user  { 'sensu':
          password => 'guest',
        } ->
        rabbitmq_user_permissions { 'sensu@sensu':
          configure_permission => '.*',
          read_permission      => '.*',
          write_permission     => '.*',
        }

        class { 'influxdb':
          collectd => {
            enabled => true,
          }
        }

        #class { '::sensu':
        #  server                   => true,
        #  api                      => true,
        #  rabbitmq_password        => 'guest',
        #}
      EOS

      # Run it twice and test for idempotency
      apply_manifest_on(master, pp_master, :catch_failures => true)
      apply_manifest_on(master, pp_master, :catch_changes => true)
    end
  end
end

hosts.each do |host|
  describe 'redis installed', :if => host['roles'].include?('client') do
    context 'during same run' do
      it 'works with no errors' do
        master_hostname = on(master, facter('hostname')).stdout.strip

        pp = <<-EOS
          package { 'redis-server': ensure => 'present' }

          class { 'monitoring':
            sensu_rabbitmq_hostname => "#{master_hostname}",
          }

          notice("Apache present: ${::apache_present}")
          notice("Redis present: ${::redis_present}")
          notice("Rabbitmq present: ${::rabbitmq_present}")
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end

      describe package('redis-server') do
        it { is_expected.to be_installed }
      end

      describe file('/etc/collectd/conf.d/10-redis.conf') do
        it { is_expected.to be_file }
        it { is_expected.to contain '<LoadPlugin redis>' }
      end

      describe service('collectd') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end

      describe service('sensu-client') do
        it { is_expected.to be_running }
        it { is_expected.to be_enabled }
      end
    end
  end
end
