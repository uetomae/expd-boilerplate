# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dry-configurable'
gem 'enum_help'
gem 'foreman'
gem 'haml-rails', '~> 1.0'
gem 'health_check'
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2'
gem 'rollbar'
gem 'seed-fu', '~> 2.3'
gem 'simple_form'
gem 'tzinfo-data'

group :development, :test do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rails_best_practices', require: false
  gem 'rubocop', require: false
  gem 'rubocop-inflector'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'traceroute'
end

group :development do
  gem 'bullet'
  gem 'flamegraph'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'memory_profiler'
  gem 'rack-mini-profiler', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'stackprof'
  gem 'web-console', '>= 3.3.0'
end

group :test do
end
