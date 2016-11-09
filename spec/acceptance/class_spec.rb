require 'spec_helper_acceptance'

describe 'redis installed' do
  context 'during same run' do
    it 'works with no errors' do
      pp = <<-EOS
        package { 'redis-server': ensure => 'present' }

        class { 'monitoring': }

        notice("Apache present: ${::apache_present}")
        notice("Apache statuspage present: ${::apache_statuspage_present}")
        notice("Redis present: ${::redis_present}")
        notice("Rabbitmq present: ${::rabbitmq_present}")
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true, :debug => true)
      #apply_manifest(pp, :catch_changes  => true)
      # Idempotency check blocked by: https://github.com/voxpupuli/puppet-collectd/issues/554
    end

    describe package('redis-server') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/collectd/conf.d/10-redis.conf') do
      it { is_expected.to be_file }
    it { is_expected.to contain '<LoadPlugin redis>' }
    end
  end
end