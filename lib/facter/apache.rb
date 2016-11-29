require 'puppet/type'
require 'puppet/type/service'
require 'net/http'
require 'uri'

def fetch(uri_str, limit = 10)
  raise ArgumentError, 'HTTP redirect too deep' if limit.zero?

  url = URI.parse(uri_str)
  req = Net::HTTP::Get.new(url.path)
  response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
  # Follow redirect
  case response
  when Net::HTTPSuccess     then response
  when Net::HTTPRedirection then fetch(response['location'], limit - 1)
  else
    response.error!
  end
end

Facter.add(:apache_present) do
  setcode do
    present = Facter::Util::Resolution.which('apachectl')
    if not present
      present = Facter::Util::Resolution.which('apache2ctl')
    end
    !!present
  end
end

Facter.add(:apache_running) do
  confine :apache_present => true
  setcode do
    Puppet::Type.type(:service).newservice(:name => 'apache2').provider.status == :running
  end
end

Facter.add(:apache_statuspage_present) do
  confine :apache_present => true
  setcode do
    uri = 'http://localhost/server-status'
    begin
      response = fetch(uri)
      !!(response.body =~ /<title>Apache Status<\/title>/i)
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, Errno::ECONNREFUSED
      false
    end
  end
end

# TODO: use a full apache conf parser like https://github.com/bmatzelle/apache_config
# and look for "SetHandler server-status"