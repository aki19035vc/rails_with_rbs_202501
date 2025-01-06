require "rbs_rails/rake_task"

require "rbs/inline"
require "rbs/inline/cli"

require "steep"
require "steep/cli"

RbsRails::RakeTask.new

namespace :rbs_inline do
  desc "Generate rbs by rbs-inline"
  task generate: :environment do
    RBS::Inline::CLI.new.run([ "app", "--output=sig/rbs_inline/app", "--opt-out" ])
  end
end

namespace :steep do
  desc "Generate rbs by rbs-inline"
  task check: :environment do
    Steep::CLI.new(argv: [ "check", "-j2" ], stdout: $stdout, stderr: $stderr, stdin: $stdin).run.zero? ||
      exit(1)
  end
end

desc "Typecheck by Steep"
task typecheck: %i[rbs_rails:all rbs_inline:generate steep:check]
