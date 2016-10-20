require "spec_helper"
require 'webmock/rspec'

include WebMock::API

WebMock.disable_net_connect!(allow_localhost: true)

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe "apache_present" do
    context 'with apachectl present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(true)
        expect(Facter.value(:apache_present)).to be true
      end
    end

    context 'with apachectl absent and apache2ctl absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(false)
        Facter::Util::Resolution.expects(:which).with("apache2ctl").returns(false)
        expect(Facter.value(:apache_present)).to be false
      end
    end

    context 'with apachectl absent and apache2ctl present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(false)
        Facter::Util::Resolution.expects(:which).with("apache2ctl").returns(true)
        expect(Facter.value(:apache_present)).to be true
      end
    end
  end

  describe "apache server-status page present" do
    before do
      Facter.fact(:apache_present).stubs(:value).returns true
    end
    context 'with status page present' do
      it do
        stub_request(:get, "http://localhost/server-status").
          with(:headers => {'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "<title>Apache Status</title>\nfoo", :headers => {})

        expect(Facter.value(:apache_statuspage_present)).to be true
      end
    end

    context 'with status page absent' do
      it do
        stub_request(:get, "http://localhost/server-status").
          with(:headers => {'User-Agent'=>'Ruby'}).
          to_return(:status => 202, :body => "<title>Not Found</title>", :headers => {})

        expect(Facter.value(:apache_statuspage_present)).to be false
      end
    end

    context 'no listening webserver resulting in timeout' do
      it do
        stub_request(:get, "http://localhost/server-status").
          with(:headers => {'User-Agent'=>'Ruby'}).
          to_timeout

        expect(Facter.value(:apache_statuspage_present)).to be false
      end
    end

    context 'no listening webserver resulting in connection refused' do
      it do
        stub_request(:get, "http://localhost/server-status").
          with(:headers => {'User-Agent'=>'Ruby'}).
          to_raise(Errno::ECONNREFUSED)

        expect(Facter.value(:apache_statuspage_present)).to be false
      end
    end
  end
end