require 'spec_helper'

describe Alephant::Harness::Service::DynamoDB do

  let(:fake_client) { Aws::DynamoDB::Client.new(stub_responses: true) }

  before do
    allow(subject).to receive(:client).and_return(fake_client)
  end

  describe ".create" do
    it "creates a table based off a schema" do

      table_name = 'test_lookup'
      schema_name = 'lookup'
      schema = subject.load_schema(schema_name)

      expected_schema = YAML::load_file(File.join(File.dirname(__FILE__), *[%w'..' * 2], 'schema', "#{schema_name}.yaml"))
      expected_schema[:table_name] = table_name

      expect(subject.create(table_name, schema).data).to be_a(Aws::DynamoDB::Types::CreateTableOutput)
    end
  end

  describe ".delete" do
    let(:tables) { %w(foo bar) }

    context "When tables exist" do
      it "removes specified tables" do
        tables.each do |table|
          expect(subject.remove(table).data).to be_a(Aws::DynamoDB::Types::DeleteTableOutput)
        end
      end
    end

    context "When tables don't exist" do
      it "Fails silently" do
        fake_client.stub_responses(:delete_table, 'ResourceNotFoundException')
        expect { subject.remove('blah') }.to_not raise_error(Exception)
      end
    end
  end
end

