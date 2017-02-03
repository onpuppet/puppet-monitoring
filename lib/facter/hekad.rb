Facter.add(:hekad_present) do
  setcode do
    !!Facter::Util::Resolution.which('hekad')
  end
end

Facter.add(:hekad_running) do
  confine hekad_present: true
  setcode do
    service_name = 'hekad'
    Puppet::Type.type(:service).newservice(name: service_name).provider.status == :running
  end
end
