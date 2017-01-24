require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'redis present' do
    context 'with redis-server present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('redis-server').returns(true)
        expect(Facter.value(:redis_present)).to eq(true)
      end
    end

    context 'with redis-server absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('redis-server').returns(false)
        expect(Facter.value(:redis_present)).to eq(false)
      end
    end
  end
end
