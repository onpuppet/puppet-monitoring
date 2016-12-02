Facter.add(:rabbitmq_present) do
  setcode do
    !!Facter::Util::Resolution.which('rabbitmq-server')
  end
end

Facter.add(:rabbitmq_management_present) do
  setcode do
    !!Facter::Util::Resolution.exec('/usr/sbin/rabbitmqctl status | grep rabbitmq_management')
  end
end

Facter.add(:rabbitmq_management_port) do
  setcode do
    Facter::Util::Resolution.exec('/usr/sbin/rabbitmqctl environment | /bin/grep -A 10 rabbitmq_management | /bin/grep "listener,\[{port" | /bin/grep -o -E "[0-9]+"')
  end
end


# TODO parse /etc/rabbitmq/rabbitmq.config to get user/pass/port exposed as facts
