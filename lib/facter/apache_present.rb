Facter.add("apache_present") do
  setcode do
    present = Facter::Util::Resolution.which('apachectl')
    if not present
      present = Facter::Util::Resolution.which('apache2ctl')
    end
    !!present
  end
end
