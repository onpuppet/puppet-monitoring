Facter.add(:ntpd_present) do
  setcode do
    !!Facter::Util::Resolution.which('ntpd')
  end
end
