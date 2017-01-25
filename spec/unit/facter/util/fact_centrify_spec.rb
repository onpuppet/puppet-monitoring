require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'centrify present' do
    context 'with centrify present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('adinfo').returns(true)
        expect(Facter.value(:centrify_present)).to eq(true)
      end
    end

    context 'with centrify absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('adinfo').returns(false)
        expect(Facter.value(:centrify_present)).to eq(false)
      end
    end
  end
end
