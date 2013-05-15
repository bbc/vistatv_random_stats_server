require 'rubygems'
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'yard'

task :default => :test

RSpec::Core::RakeTask.new(:test) do |t|
  t.rspec_opts = ["--color"]
end

desc "Run tests with code coverage"
task :coverage do
  ENV['COVERAGE'] = "true"
  Rake::Task["test"].execute
end

desc "Open an irb session"
task :console do
  sh "irb -rubygems -r'bundler/setup' -I lib"
end

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb']
  t.options = [
    '--output-dir', 'docs',
    '--default-return', 'void',
    '--readme', 'README.md'
  ]
end
