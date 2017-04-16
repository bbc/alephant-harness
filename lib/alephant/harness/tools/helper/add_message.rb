require 'spurious/ruby/awssdk/helper'
require 'alephant/harness/tools/helper/sequence'

module Alephant
  module Harness
    module Tools
      module Helper
        class AddMessage
          def run(options = {})
            options.each { |k, v| instance_variable_set "@#{k}", v }
            configure_aws
            send_message
          end

          private

          def configure_aws
            ::AWS.config(
              access_key_id: read_env_config['AWS_ACCESS_KEY_ID'],
              secret_access_key: read_env_config['AWS_SECRET_ACCESS_KEY']
            )
            Spurious::Ruby::Awssdk::Helper.configure
          end

          def json
            json = JSON.parse File.read(path)
            set_sequence json
          end

          def path
            fixture_path = "#{@options[:base]}/src/components/#{@component}/fixtures/responsive.json"
            @options[:json_path] ? @options[:json_path] : fixture_path
          end

          def queue
            ::AWS::SQS.new.queues.named read_app_config['configuration']['sqs_queue_name']
          end

          def read_app_config
            JSON.parse File.read "#{@options[:base]}/src/config/development/app.json"
          end

          def read_env_config
            YAML.load_file "#{@options[:base]}/src/config/development/env.yaml"
          end

          def send_message
            queue.send_message JSON.generate(json)
          end

          def set_sequence(json)
            json.tap { |j| j['headers']['ndpSeqNo'] = seq_num }
          end

          def seq_num
            seq = Sequence.new @component
            if @options[:seq_num]
              seq.reset @options[:seq_num]
              @options[:seq_num]
            else
              seq.update
              seq.number
            end
          end
        end
      end
    end
  end
end
