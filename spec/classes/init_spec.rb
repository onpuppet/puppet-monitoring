require 'spec_helper'

describe 'monitoring' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'monitoring class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('monitoring::params') }
        end

        context 'rabbitmq present' do
          let(:facts) do
            facts.merge(rabbitmq_present: true, rabbitmq_management_present: true, rabbitmq_management_port: '15672')
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

  context 'unsupported operating system' do
    describe 'monitoring class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily:        'Solaris',
          operatingsystem: 'Nexenta'
        }
      end

      it { expect { is_expected.to contain_package('monitoring') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
