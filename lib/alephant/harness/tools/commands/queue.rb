require 'thor'

module Alephant
  module Harness
    module Tools
      module Commands
        class Queue < Thor
          include Thor::Actions

          class_option :base, :type => :string, :desc => "The base path to your alephant-renderer repo."

          desc 'stub <string>', 'Test output method.'
          def stub(str)
            puts str # method will be removed
          end
        end
      end
    end
  end
end
