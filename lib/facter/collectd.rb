Facter.add(:collectd_present) do
  setcode do
    !!Facter::Util::Resolution.which('collectd')
  end
end
