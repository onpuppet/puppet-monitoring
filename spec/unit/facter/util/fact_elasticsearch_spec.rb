require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'elasticsearch present' do
    context 'with elasticsearch present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('/usr/share/elasticsearch/bin/elasticsearch').returns(true)
        expect(Facter.value(:elasticsearch_present)).to eq(true)
      end
    end

    context 'with elasticsearch absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with('/usr/share/elasticsearch/bin/elasticsearch').returns(false)
        expect(Facter.value(:elasticsearch_present)).to eq(false)
      end
    end
  end
end
