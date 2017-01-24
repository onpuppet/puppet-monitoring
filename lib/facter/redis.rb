Facter.add(:redis_present) do
  setcode do
    !!Facter::Util::Resolution.which('redis-server')
  end
end
