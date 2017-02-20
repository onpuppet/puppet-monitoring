Facter.add(:iscdhcp_present) do
  setcode do
    !!Facter::Util::Resolution.which('dhcpd')
  end
end

Facter.add(:iscdhcp_running) do
  confine iscdhcp_present: true
  setcode do
    Puppet::Type.type(:service).newservice(name: 'isc-dhcp-server').provider.status == :running
  end
end
