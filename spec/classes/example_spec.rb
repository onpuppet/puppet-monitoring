require 'spec_helper'

describe 'lysaker_monitored' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge(
          {
            :collectd_version => '5.0',
            :redis_present => false,
          }
          )
        end

        context "lysaker_monitored class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('lysaker_monitored::params') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'lysaker_monitored class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('lysaker_monitored') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
