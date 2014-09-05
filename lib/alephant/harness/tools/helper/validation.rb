module Alephant
  module Harness
    module Tools
      module Helper
        module Validation
          def self.correct_dir?
            Dir.pwd.split("/").last === 'alephant-harness'
          end

          def self.fixture_exists?(component)
            File.exist? parent + "/alephant-renderer/src/components/#{component}/fixtures/responsive.json" or \
            File.exist? parent + "/election-data-renderer/src/components/#{component}/fixtures/responsive.json"
          end

          def self.found_renderer?(base)
            if base
              Dir.exist? base
            else
              Dir.exist? parent + '/alephant-renderer' or \
              Dir.exist? parent + '/election-data-renderer'
            end
          end

          def self.json_exists?(path)
            File.exist? path
          end

          def self.valid_component?(id)
            Dir.exist? parent + "/alephant-renderer/src/components/#{id}" or \
            Dir.exist? parent + "/election-data-renderer/src/components/#{id}"
          end

          private

          def self.parent
            File.expand_path "..", Dir.pwd
          end
        end
      end
    end
  end
end
