require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'colletd present' do
    context 'with collectd present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('collectd').returns(true)
        expect(Facter.value(:collectd_present)).to eq(true)
      end
    end

    context 'with collectd absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('collectd').returns(false)
        expect(Facter.value(:collectd_present)).to eq(false)
      end
    end
  end
end
