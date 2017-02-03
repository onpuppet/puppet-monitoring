require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'hekad_present' do
    context 'with hekad present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('hekad').returns(true)
        expect(Facter.value(:hekad_present)).to be true
      end
    end

    context 'with hekad absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('hekad').returns(false)
        expect(Facter.value(:hekad_present)).to eq(false)
      end
    end
  end
end
