require 'beaker-rspec'

install_puppet_agent_on hosts, {} unless ENV['BEAKER_provision'] == 'no'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'monitoring')
    hosts.each do |host|
      on host, puppet('module', 'install', 'puppetlabs-stdlib'), { :acceptable_exit_codes => [0] }
      on host, puppet('module', 'install', 'puppetlabs-concat'), { :acceptable_exit_codes => [0] }
      on host, puppet('module', 'install', 'puppetlabs-apt'), { :acceptable_exit_codes => [0] }
      on host, puppet('module', 'install', 'puppet-yum'), { :acceptable_exit_codes => [0] }
      on host, puppet('module', 'install', 'yuav-refacter'), { :acceptable_exit_codes => [0] }
      #on host, puppet('module', 'install', 'puppet-collectd'), { :acceptable_exit_codes => [0] }
      install_package host, 'git'
      modulepath = host.puppet['modulepath']
      modulepath = modulepath.split(':').first if modulepath
      on host, "git clone https://github.com/voxpupuli/puppet-collectd.git #{modulepath}/collectd"
    end
  end
end
