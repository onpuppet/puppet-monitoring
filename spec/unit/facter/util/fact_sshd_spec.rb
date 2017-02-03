require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'sshd_present' do
    context 'with sshd present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('sshd').returns(true)
        expect(Facter.value(:sshd_present)).to be true
      end
    end

    context 'with sshd absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('sshd').returns(false)
        expect(Facter.value(:sshd_present)).to eq(false)
      end
    end
  end
end
