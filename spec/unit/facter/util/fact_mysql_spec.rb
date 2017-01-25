require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'mysql present' do
    context 'with mysql present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('mysqld').returns(true)
        expect(Facter.value(:mysql_present)).to eq(true)
      end
    end

    context 'with mysql absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('mysqld').returns(false)
        expect(Facter.value(:mysql_present)).to eq(false)
      end
    end
  end
end
