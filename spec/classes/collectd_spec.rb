require 'spec_helper'

describe 'monitoring' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        context 'rabbitmq present' do
          let(:facts) do
            facts.merge(rabbitmq_present: true, rabbitmq_management_present: true, rabbitmq_management_port: '15672')
          end

          let(:params) do
            {
              collectd_network_server_hostname: 'influxdb'
            }
          end

          it { is_expected.to contain_class('monitoring::metrics::collectd') }

          it { is_expected.to contain_class('monitoring::metrics::collectd::rabbitmq') }

          it { is_expected.to contain_class('collectd::plugin::rabbitmq') }

          it 'Load collectd_rabbitmq in python-config' do
            is_expected.to contain_concat_fragment('collectd_plugin_python_conf_collectd_rabbitmq.collectd_plugin').with_content(%r{Module "collectd_rabbitmq.collectd_plugin"})
          end
        end
      end
    end
  end
end
