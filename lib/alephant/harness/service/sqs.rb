require 'aws-sdk'

module Alephant
  module Harness
    module Service
      module SQS

        def self.client
          @@client ||= ::AWS::SQS.new
        end

        def self.create(queue_name)
          client.queues.create queue_name
        end

        def self.get(queue_name)
          client.queues.named(queue_name)
        end

        def self.delete(queue_name)
          client.queues.named(queue_name).delete
        end

      end
    end
  end
end
