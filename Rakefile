require 'bundler/gem_tasks'

class Tasks < Bundler::GemHelper
  def install
    desc "Initiate a new release for version #{version}"
    task "release:initiate" => ["release:guard_clean", "release:source_control_push"] do
    end
  end
end

Tasks.new.install
