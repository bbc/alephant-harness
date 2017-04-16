require 'thor'

module Alephant
  module Harness
    module Tools
      module Commands
        class Base < Thor
          include Thor::Actions

          protected

          def error(msg, die = true)
            say "Error: #{msg}", :red
            exit 1 if die
          end
        end
      end
    end
  end
end
