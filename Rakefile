require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

class Tasks < Bundler::GemHelper
  def install
    desc "Initiate a new release for version #{version}"
    task "release:initiate" => ["release:guard_clean", "release:source_control_push"] do
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Tasks.new.install
