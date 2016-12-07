require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'webmock/rspec'

include RspecPuppetFacts

require 'simplecov'
require 'simplecov-console'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
end

RSpec.configure do |c|
  c.before(:each) do
    stub_request(:get, /.*/).
      with(:headers => {'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})
  end

  default_facts = {
    puppetversion: Puppet.version,
    facterversion: Facter.version
  }
  default_facts.merge!(YAML.load(File.read(File.expand_path('../default_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_facts.yml', __FILE__))
  default_facts.merge!(YAML.load(File.read(File.expand_path('../default_module_facts.yml', __FILE__)))) if File.exist?(File.expand_path('../default_module_facts.yml', __FILE__))
  c.default_facts = default_facts
end