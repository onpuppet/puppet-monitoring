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
      end
    end
  end
end
