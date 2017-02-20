require 'spec_helper'

describe 'monitoring' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        context 'rabbitmq present' do
          let(:facts) do
            facts.merge(
              apache_present: true,
              apache_statuspage_present: true,
              cuda_present: true,
              iscdhcp_present: true,
              rabbitmq_management_present: true,
              rabbitmq_management_port: '15672',
              rabbitmq_present: true,
              redis_present: true
            )
          end

          let(:params) do
            {
              collectd_network_server_hostname: 'influxdb'
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('monitoring::metrics::collectd') }
          it { is_expected.to contain_class('monitoring::metrics::collectd::rabbitmq') }
          it { is_expected.to contain_class('collectd::plugin::apache') }
          it { is_expected.to contain_class('collectd::plugin::cuda') }
          it { is_expected.to contain_class('collectd::plugin::iscdhcp') }
          it { is_expected.to contain_class('collectd::plugin::redis') }
          it { is_expected.to contain_class('collectd::plugin::rabbitmq') }
          it 'Load collectd_rabbitmq in python-config' do
            is_expected.to contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(%r{Module "collectd_rabbitmq.collectd_plugin"})
          end
        end
      end
    end
  end
end
