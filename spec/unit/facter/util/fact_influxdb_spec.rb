require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'influxdb present' do
    context 'with influxdb present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('influxdb').returns(true)
        expect(Facter.value(:influxdb_present)).to eq(true)
      end
    end

    context 'with influxdb absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('influxdb').returns(false)
        expect(Facter.value(:influxdb_present)).to eq(false)
      end
    end
  end
end
