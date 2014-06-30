require 'aws-sdk'

module Alephant
  module Harness
    module AWS

      def self.configure(environment = nil)

        environment ||= ENV

        ::AWS.config(aws_properties_from(environment))
      end

      def self.aws_properties_from(env)
        env.inject({}) do |hash, (key, value)|
          hash.tap do |h|
            h[config_key(key)] = sanitise_value(value) if key =~ /^AWS_/
          end
        end
      end

      def self.config_key(original_key)
        original_key[/AWS_(.*)/,1].downcase.to_sym
      end

      def self.sanitise_value(value)
        if %w[ true false ].include?(value)
          value == 'true'
        else
          value
        end
      end

    end
  end
end
