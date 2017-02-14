Facter.add(:cuda_present) do
  setcode do
    if Facter::Util::Resolution.which('nvidia-smi')
      Facter::Util::Resolution.exec('nvidia-smi -L | grep GPU')
      $?.exitstatus.zero?
    else
      false
    end
  end
end
