require 'aws-sdk'

module Alephant
  module Harness
    module Service
      module SQS

        def self.client
          @@client ||= ::AWS::SQS.new
        end

        def self.create(queue)
          client.queues.create /(?<name>[^\/]+)$/.match(queue)[:name]
        end

        def self.get(queue_name)
          client.queues.named(queue_name)
        rescue ::AWS::SQS::Errors::NonExistentQueue
          false
        end

        def self.exists?(queue_name)
          if get(queue_name)
            yield
          end
        end

        def self.delete(queue_name)
          client.queues.named(queue_name).delete
        end

      end
    end
  end
end
