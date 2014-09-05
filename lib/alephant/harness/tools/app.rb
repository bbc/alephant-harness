require 'thor'
require 'alephant/harness/tools/commands/queue'

module Alephant
  module Harness
    module Tools
      class App < Thor
        include Thor::Actions

        desc 'queue', 'Local alephant-renderer subcommands.'
        subcommand 'queue', Commands::Queue
      end
    end
  end
end
