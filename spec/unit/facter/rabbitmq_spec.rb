require "spec_helper"

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe "rabbitmq present" do
    context 'with rabbitmq-server present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("rabbitmq-server").returns(true)
        expect(Facter.value(:rabbitmq_present)).to eq(true)
      end
    end

    context 'with rabbitmq-server absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("rabbitmq-server").returns(false)
        expect(Facter.value(:rabbitmq_present)).to eq(false)
      end
    end
  end
end