require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'cuda present' do
    context 'with cuda-server present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        expect(Facter.value(:cuda_present)).to eq(true)
      end
    end
  end
end
