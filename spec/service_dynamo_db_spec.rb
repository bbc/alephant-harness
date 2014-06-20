require 'spec_helper'

describe Alephant::Harness::Service::DynamoDB do

  describe ".create" do

    it "creates a table based off a schema" do

      table_name = 'test_lookup'
      schema_name = 'lookup'

      expected_schema = YAML::load_file(File.join(File.dirname(__FILE__), '..', 'schema', "#{schema_name}.yaml"))
      expected_schema[:table_name] = table_name

      expect_any_instance_of(AWS::DynamoDB::Client::V20120810).to receive(:create_table).with(expected_schema)
      subject.create(table_name, schema_name)

    end

  end
end

