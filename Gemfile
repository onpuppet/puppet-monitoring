source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :test do
  gem "ci_reporter_rspec"
  gem "metadata-json-lint"
  gem "puppet", ENV['PUPPET_GEM_VERSION'] || '~> 4.7.0'
  gem "puppet-lint-absolute_classname-check"
  gem "puppet-lint-classes_and_types_beginning_with_digits-check"
  gem "puppet-lint-leading_zero-check"
  gem "puppet-lint-resource_reference_syntax"
  gem "puppet-lint-trailing_comma-check"
  gem "puppet-lint-unquoted_string-check"
  gem "puppet-lint-version_comparison-check"
  gem "puppetlabs_spec_helper"
  gem "rake"
  gem "rspec"
  gem "rspec-puppet"
  gem "rspec-puppet-facts"
  gem "rubocop"
  gem "simplecov"
  gem "simplecov-console"
  gem "webmock"
end

group :development do
  gem "puppet-blacksmith"
  gem "travis"
  gem "travis-lint"
  gem "vagrant-wrapper"
end

group :system_tests do
  gem "beaker", '~> 2'
  gem "beaker-puppet_install_helper"
  gem "beaker-rspec"
end
