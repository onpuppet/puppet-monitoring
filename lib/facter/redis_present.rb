Facter.add("apache_present") do
  setcode do
    Facter::Util::Resolution.which('redis-server')
  end
end
