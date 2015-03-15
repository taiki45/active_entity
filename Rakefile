require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['-c', '-fd']
end

task :test do
  require File.expand_path('../test/active_mdoel_lint_test.rb', __FILE__)
end

task default: %i(spec test)
