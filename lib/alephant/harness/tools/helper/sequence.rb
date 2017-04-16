module Alephant
  module Harness
    module Tools
      module Helper
        class Sequence
          attr_accessor :number

          def initialize(component)
            @component = component
          end

          def update
            exists? ? read_from_file : create_file
          end

          def reset(int)
            set_number int
          end

          private

          def create_file
            @number = 1
            File.open(path, 'w') do |f|
              f.write({
                number: @number,
                component: @component
              }.to_yaml)
            end
          end

          def exists?
            File.exists? path
          end

          def path
            '/tmp/renderer_sequence.yml'
          end

          def read
            YAML.load_file path
          end

          def read_from_file
            if @component == read[:component]
              set_number (read[:number] + 1)
            else
              set_component @component
              set_number 1
            end
          end

          def set_component(id)
            write(:component, id)
          end

          def set_number(int)
            write(:number, int)
            @number = int
          end

          def write(key, value)
            data = read
            data[key] = value
            File.open(path, 'w') { |f| YAML.dump(data, f) }
          end
        end
      end
    end
  end
end
