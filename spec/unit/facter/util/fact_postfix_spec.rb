require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'postfix present' do
    context 'with postfix present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('postfix').returns(true)
        expect(Facter.value(:postfix_present)).to eq(true)
      end
    end

    context 'with postfix absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('postfix').returns(false)
        expect(Facter.value(:postfix_present)).to eq(false)
      end
    end
  end
end
