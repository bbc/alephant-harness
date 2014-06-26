require "alephant/harness/service/dynamo_db"
require "alephant/harness/service/s3"
require "alephant/harness/service/sqs"
require "alephant/harness/aws"

module Alephant
  module Harness
    module Setup

      def self.configure(opts = {}, env = nil)
        AWS.configure(env)

        queue_name = opts[:sqs_queue_url]
        bucket     = opts[:bucket_id]
        tables     = {
          :lookup    => opts[:lookup_table_name],
          :sequencer => opts[:sequencer_table_name],
        }

        recreate_sqs queue_name

        recreate_s3 bucket

        recreate_dynamo_db tables
      end

      def self.recreate_sqs(queue_name)
        Service::SQS.exists?(queue_name) do
          Service::SQS.delete(queue_name)
        end

        Service::SQS.create(queue_name)
      end

      def self.recreate_s3(bucket)
        Service::S3.exists?(bucket) do
          Service::S3.delete(bucket)
        end

        Service::S3.create(queue_name)
      end

      def self.recreate_dynamo_db(tables)
        Service::DynamoDB.remove(tables.values)

        tables.each do |schema_name, table_name|
          Service::DynamoDB.create(table_name, schema_name)
        end
      end

    end
  end
end

binding.pry
