Facter.add(:influxdb_present) do
  setcode do
    !!Facter::Util::Resolution.which('influxdb')
  end
end
