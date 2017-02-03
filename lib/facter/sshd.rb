Facter.add(:sshd_present) do
  setcode do
    !!Facter::Util::Resolution.which('sshd')
  end
end

Facter.add(:sshd_running) do
  confine puppet_present: true
  setcode do
    os = Facter.value(:osfamily)
    service_name = os =~ %r{RedHat|CentOS|Fedora} ? 'sshd' : 'ssh'
    Puppet::Type.type(:service).newservice(name: service_name).provider.status == :running
  end
end
