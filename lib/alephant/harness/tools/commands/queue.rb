require 'alephant/harness/tools/commands/base'
require 'alephant/harness/tools/helper/component'
require 'alephant/harness/tools/helper/validation'
require 'alephant/harness/tools/helper/add_message'

module Alephant
  module Harness
    module Tools
      module Commands
        class Queue < Base
          include Thor::Actions
          include Alephant::Harness::Tools::Helper

          class_option :base, :type => :string, :default => ENV['ALPHANT_HARNESS_RENDERER_PATH'], :required => true, :desc => "The base path to your alephant-renderer repo."

          def initialize(args = [], local_options = {}, thor_config = {})
            super args, local_options, thor_config
            error '--base directory set does not exist.' unless Validation.base_exist? options[:base]
          end

          method_option :seq_num, :type => :numeric, :default => nil, :aliases => '-s', :desc => 'Sequence number for message.'
          method_option :json_path, :type => :string, :default => nil, :aliases => '-j', :desc => 'Path to JSON file containing message.'
          desc 'add_message', 'Adds a message to renderer queue.'
          def add_message
            component = Component.new(options[:base]).id
            validate_before_add_message component

            AddMessage.new.run({
              options: options,
              component: component
            })
          end

          method_option :component, :type => :string, :required => true, :aliases => '-c', :desc => 'Switch renderer to this component.'
          desc 'change_component', 'Changes the component currently being used by a local renderer.'
          def change_component
            validate_before_change_component
            Component.new(options[:base]).change options[:component]
          end

          private

          def validate_before_add_message(component)
            if options[:json_path]
              error 'Cannot find JSON file specified.' unless Validation.json_exist? options[:json_path]
            else
              error "Can't find component '#{component}' in renderer repo." unless Validation.component_exist? component, options[:base]
              error "Can't find 'responsive.json' fixture for component." unless Validation.fixture_exist? component, options[:base]
            end
          end

          def validate_before_change_component
            error "Can't find component '#{options[:component]}' in renderer repo." unless Validation.component_exist? options[:component], options[:base]
          end
        end
      end
    end
  end
end
