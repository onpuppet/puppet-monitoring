Facter.add(:mysql_present) do
  setcode do
    !!Facter::Util::Resolution.which('mysqld')
  end
end
