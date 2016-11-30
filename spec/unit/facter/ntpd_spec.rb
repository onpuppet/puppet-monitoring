require "spec_helper"

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe "ntpd present" do
    context 'with ntpd present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('ntpd').returns(true)
        expect(Facter.value(:ntpd_present)).to eq(true)
      end
    end

    context 'with ntpd absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('ntpd').returns(false)
        expect(Facter.value(:ntpd_present)).to eq(false)
      end
    end
  end
end