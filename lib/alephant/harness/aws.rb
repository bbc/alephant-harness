require 'aws-sdk'

module Alephant
  module Harness
    module AWS

      def self.configure(environment = nil)

        #environment = environment.nil? ? ENV : environment
        environment ||= ENV

        #use_ssl = (environment['AWS_USE_SSL'] && environment['AWS_USE_SSL'] == 'true')
        #environment['AWS_USE_SSL'] = use_ssl.nil? ? ::AWS.config.use_ssl : use_ssl

        environment['AWS_USE_SSL'] = 'false'#::AWS.config.use_ssl.to_s unless environment['AWS_USE_SSL'] == 'true'


        ::AWS.config(aws_properties_from(environment))

        ::AWS.config(:use_ssl => false)

        require "pry"
        binding.pry
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
        require "pry"

        value.tap do |v|
          if %w[ true false ].include?(v)
            v = v == 'true' ? true : false
          end
        end
      end

    end
  end
end
