require 'aws-sdk'
require 'yaml'

module Alephant
  module Harness
    module Service
      module DynamoDB

        def self.client
          ::AWS::DynamoDB::Client::V20120810.new
        end

        def self.create(table_name, schema_name)
          schema = load_schema(schema_name).tap { |s| s[:table_name] = table_name }
          client.create_table schema
        end

        def self.load_schema(schema_name)
          YAML::load_file(File.join([File.dirname(__FILE__), *(%w'..' * 4), 'schema', "#{schema_name}.yaml"]))
        end

      end
    end
  end
end
