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

      end
    end
  end
end
