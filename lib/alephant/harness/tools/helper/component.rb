module Alephant
  module Harness
    module Tools
      module Helper
        class Component
          attr_accessor :id

          def initialize
            @id = 'scot_ref_summary' # TODO: Replace with app.json value
          end
        end
      end
    end
  end
end
