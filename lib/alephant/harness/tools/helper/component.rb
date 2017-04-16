module Alephant
  module Harness
    module Tools
      module Helper
        class Component
          include Thor::Shell

          attr_accessor :id

          def initialize(base)
            @base = base
            @id   = read['configuration']['component_id']
          end

          def change(id)
            write set_id read, id
            say "Success: remember to restart your renderer.", :green
          end

          private

          def path
            "#{@base}/src/config/development/app.json"
          end

          def read
            JSON.parse File.read path
          end

          def set_id(hash, id)
            hash.tap do |h|
              h['configuration']['component_id'] = id
              h['configuration']['renderer_id'] = id
            end
          end

          def write(hash)
            File.open(path, 'w') { |f| f.write hash.to_json }
          end
        end
      end
    end
  end
end
