Facter.add(:centrify_present) do
  setcode do
    !!Facter::Util::Resolution.which('adinfo')
  end
end
