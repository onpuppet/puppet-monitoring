require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'puppet_present' do
    context 'with puppet present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('puppet').returns(true)
        expect(Facter.value(:puppet_present)).to be true
      end
    end

    context 'with puppet absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('puppet').returns(false)
        expect(Facter.value(:puppet_present)).to eq(false)
      end
    end
  end
end
