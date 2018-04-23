require "aws-sdk-dynamodb"
require "aws-sdk-s3"
require "aws-sdk-sqs"

module Alephant
  module Harness
    module AWS
      class << self
        def environment
          aws_properties_from(@environment || ENV)
        end

        def config=(environment)
          @environment = environment
        end

        def s3_config
          environment.select do |key, _|
            (ACCESS_CONFIG_KEYS + S3_CONFIG_KEYS).include?(key)
          end.map do |key, value|
            [key.to_s.gsub('s3_', '').to_sym, value]
          end.to_h
        end

        def sqs_config
          environment.select do |key, _|
            (ACCESS_CONFIG_KEYS + SQS_CONFIG_KEYS).include?(key)
          end.map do |key, value|
            [key.to_s.gsub('sqs_', '').to_sym, value]
          end.to_h
        end

        def dynamo_config
          environment.select do |key, _|
            (ACCESS_CONFIG_KEYS + DYNAMO_CONFIG_KEYS).include?(key)
          end.map do |key, value|
            [key.to_s.gsub('dynamo_db_', '').to_sym, value]
          end.to_h
        end

        private

        ACCESS_CONFIG_KEYS = [:access_key_id, :secret_access_key, :region]
        DYNAMO_CONFIG_KEYS = [:dynamo_db_endpoint]
        S3_CONFIG_KEYS = [:s3_endpoint, :s3_force_path_style]
        SQS_CONFIG_KEYS = [:sqs_endpoint]

        def aws_properties_from(env)
          env.inject({}) do |hash, (key, value)|
            hash.tap do |h|
              h[config_key(key)] = sanitise_value(value) if key =~ /^AWS_/
            end
          end
        end

        def config_key(original_key)
          original_key[/AWS_(.*)/,1].downcase.to_sym
        end

        def sanitise_value(value)
          if %w[ true false ].include?(value)
            value == 'true'
          else
            value
          end
        end
      end
    end
  end
end
