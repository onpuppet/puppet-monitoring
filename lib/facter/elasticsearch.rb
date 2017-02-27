Facter.add(:elasticsearch_present) do
  setcode do
    !!Facter::Util::Resolution.which('/usr/share/elasticsearch/bin/elasticsearch')
  end
end
