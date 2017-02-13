Facter.add(:cuda_present) do
  setcode do
    Facter::Util::Resolution.exec('/usr/bin/nvidia-smi -L | /bin/grep GPU')
    $?.exitstatus.zero?
  end
end
