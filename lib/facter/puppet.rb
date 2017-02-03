Facter.add(:puppet_present) do
  setcode do
    !!Facter::Util::Resolution.which('puppet')
  end
end

Facter.add(:puppet_running) do
  confine puppet_present: true
  setcode do
    Puppet::Type.type(:service).newservice(name: 'puppet').provider.status == :running
  end
end
