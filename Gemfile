# ------------------------------------------------------------------------------
# NOTE: SIMP Puppet rake tasks support ruby 2.1.9
# ------------------------------------------------------------------------------
gem_sources = ENV.fetch('GEM_SERVERS','https://rubygems.org').split(/[, ]+/)
ENV['PDK_DISABLE_ANALYTICS'] ||= 'true'

gem_sources.each { |gem_source| source gem_source }

group :test do
  gem 'rake'
  gem 'puppet', ENV.fetch('PUPPET_VERSION',  '~> 5.5')
  gem 'rspec'
  gem 'rspec-puppet'
  gem 'hiera-puppet-helper'
  gem 'puppetlabs_spec_helper'
  gem 'metadata-json-lint'
  gem 'puppet-strings'
  gem 'puppet-lint-empty_string-check',   :require => false
  gem 'puppet-lint-trailing_comma-check', :require => false
  gem 'simp-rspec-puppet-facts', ENV['SIMP_RSPEC_PUPPET_FACTS_VERSION'] || '~> 3.1'
  gem 'simp-rake-helpers', ENV['SIMP_RAKE_HELPERS_VERSION'] || ['>= 5.12.1', '< 6']
  gem( 'pdk', ENV['PDK_VERSION'] || '~> 2.0', :require => false)
  gem 'pathspec', '~> 0.2' if Gem::Requirement.create('< 2.6').satisfied_by?(Gem::Version.new(RUBY_VERSION.dup))
end

group :development do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :system_tests do
  gem 'beaker'
  gem 'beaker-rspec'
  gem 'simp-beaker-helpers', ENV['SIMP_BEAKER_HELPERS_VERSION'] || ['>= 1.23.2', '< 2']
end
