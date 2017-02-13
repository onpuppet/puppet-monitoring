Facter.add(:cuda_present) do
  setcode do
    Facter::Util::Resolution.exec('nvidia-smi -L | grep GPU')
    $?.exitstatus.zero?
  end
end
