Facter.add(:elasticsearch_present) do
  setcode do
    !!Facter::Util::Resolution.which('curator')
  end
end
