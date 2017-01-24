require 'spec_helper'

management_port_command = '/usr/sbin/rabbitmqctl environment | /bin/grep -A 10 rabbitmq_management | /bin/grep "listener,\[{port" | /bin/grep -o -E "[0-9]+"'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'rabbitmq present' do
    context 'with rabbitmq-server present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('rabbitmq-server').returns(true)
        expect(Facter.value(:rabbitmq_present)).to eq(true)
      end
    end

    context 'with rabbitmq-server absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('rabbitmq-server').returns(false)
        expect(Facter.value(:rabbitmq_present)).to eq(false)
      end
    end
  end

  describe 'rabbitmq management port' do
    before do
      Facter.fact(:rabbitmq_present).stubs(:value).returns true
    end
    context 'with rabbitmq-server and management present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:exec).with(management_port_command).returns('15672')
        expect(Facter.value(:rabbitmq_management_port)).to eq('15672')
      end
    end

    context 'with rabbitmq-server present without management enabled' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:exec).with(management_port_command).returns(nil)
        expect(Facter.value(:rabbitmq_management_port)).to eq(nil)
      end
    end

    context 'without rabbitmq-server installed' do
      it do
        Facter::Util::Resolution.stubs(:exec).with(management_port_command).returns(nil)
        expect(Facter.value(:rabbitmq_management_port)).to eq(nil)
      end
    end
  end
end
