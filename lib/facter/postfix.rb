Facter.add(:postfix_present) do
  setcode do
    !!Facter::Util::Resolution.which('postfix')
  end
end
