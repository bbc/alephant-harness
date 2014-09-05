require 'alephant/harness/tools/commands/base'
require 'alephant/harness/tools/helper/component'
require 'alephant/harness/tools/helper/validation'

module Alephant
  module Harness
    module Tools
      module Commands
        class Queue < Base
          include Thor::Actions
          include Alephant::Harness::Tools::Helper

          class_option :base, :type => :string, :default => nil, :desc => "The base path to your alephant-renderer repo."

          def initialize(args = [], local_options = {}, thor_config = {})
            super(args, local_options, thor_config)
            validate_config
          end

          method_option :seq_num, :type => :numeric, :default => nil, :desc => 'Sequence number for message.'
          method_option :json_path, :type => :string, :default => nil, :desc => 'Path to JSON file containing message.'
          desc 'add_message', 'Adds a message to renderer queue.'
          def add_message
            component = Component.new.id
            validate_before_add_message component
            # TODO: do_something_cool!
          end

          private

          def validate_before_add_message(component)
            if options[:json_path]
              error 'Cannot find JSON file specified.' unless Validation.json_exists? options[:json_path]
            else
              error "Can't find component '#{component}' in alephant-renderer repo." unless Validation.valid_component? component
              error "Can't find 'responsive.json' fixture for component." unless Helper::Validation.fixture_exists? component
            end
          end

          def validate_config
            error 'Run from alephant-harness repo or set --base.' unless Validation.correct_dir? or options[:base]
            error 'Can\'t find alephant-renderer repo, please set using --base.' unless Validation.found_renderer? options[:base]
          end
        end
      end
    end
  end
end
