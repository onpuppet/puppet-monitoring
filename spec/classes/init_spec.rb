require 'spec_helper'

stub_request(:get, "http://169.254.169.254/latest/meta-data/").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

describe 'monitoring' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "monitoring class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('monitoring::params') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'monitoring class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('monitoring') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
