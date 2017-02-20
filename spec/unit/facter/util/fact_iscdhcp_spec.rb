require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'iscdhcp_present' do
    context 'with iscdhcp present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('dhcpd').returns(true)
        expect(Facter.value(:iscdhcp_present)).to be true
      end
    end

    context 'with iscdhcp absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('dhcpd').returns(false)
        expect(Facter.value(:iscdhcp_present)).to eq(false)
      end
    end
  end
end
