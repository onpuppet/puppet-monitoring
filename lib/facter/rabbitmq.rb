Facter.add(:rabbitmq_present) do
  setcode do
    !!Facter::Util::Resolution.which('rabbitmq-server')
  end
end

# TODO parse /etc/rabbitmq/rabbitmq.config to get user/pass/port exposed as facts
