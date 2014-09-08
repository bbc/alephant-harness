module Alephant
  module Harness
    module Tools
      module Helper
        class Component
          attr_accessor :id

          def initialize(base)
            @base = base
            @id   = read['configuration']['component_id']
          end

          private

          def path
            "#{@base}/src/config/development/app.json"
          end

          def read
            JSON.parse File.read(path)
          end
        end
      end
    end
  end
end
