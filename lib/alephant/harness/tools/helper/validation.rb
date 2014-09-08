module Alephant
  module Harness
    module Tools
      module Helper
        module Validation
          def self.base_exist?(path)
            Dir.exist? path
          end

          def self.fixture_exist?(component, base)
             File.exist? "#{base}/src/components/#{component}/fixtures/responsive.json"
          end

          def self.json_exist?(path)
            File.exist? path
          end

          def self.component_exist?(id, base)
            Dir.exist? "#{base}/src/components/#{id}"
          end
        end
      end
    end
  end
end
