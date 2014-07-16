require "alephant/harness/service/dynamo_db"
require "alephant/harness/service/s3"
require "alephant/harness/service/sqs"
require "alephant/harness/aws"
require "logger"

module Alephant
  module Harness
    module Setup

      def self.logger
        @@logger ||= ::Logger.new(STDOUT)
      end

      def self.configure(opts = {}, env = nil)
        AWS.configure(env)

        unless opts[:queues].nil?
          logger.info "Adding #{opts[:queues].length} queue(s)"
          opts[:queues].each do |queue_name|
            recreate_sqs queue_name
          end
        end

        unless opts[:buckets].nil?
          logger.info "Adding #{opts[:buckets].length} bucket(s)"
          opts[:buckets].each do |bucket|
            recreate_s3 bucket
          end
        end

        unless opts[:tables].nil?
          logger.info "Adding #{opts[:tables].length} table(s)"
          opts[:tables].each do |data|
            recreate_dynamo_db(data[:name], data[:schema])
          end
        end
      end

      def self.recreate_sqs(queue_name)
        Service::SQS.exists?(queue_name) do
          logger.warn "SQS queue #{queue_name} exists, removing"
          Service::SQS.delete(queue_name)
        end

        logger.info "Adding SQS queue #{queue_name}"
        Service::SQS.create(queue_name)
      end

      def self.recreate_s3(bucket)
        Service::S3.bucket_exists?(bucket) do
          logger.warn "S3 bucket #{bucket} exists, removing"
          Service::S3.delete(bucket)
        end

        logger.info "Adding S3 bucket #{bucket}"
        Service::S3.create(bucket)
      end

      def self.recreate_dynamo_db(table_name, schema)
        logger.info "Adding DynamoDB table #{table_name}"
        Service::DynamoDB.remove(table_name)
        schema = schema.is_a?(Hash) ? schema : Service::DynamoDB.load_schema(schema)
        Service::DynamoDB.create(table_name, schema)
      end
    end
  end
end
