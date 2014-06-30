require 'aws-sdk'

module Alephant
  module Harness
    module Service
      module SQS

        def self.client
          @@client ||= ::AWS::SQS.new
        end

        def self.create(queue)
          client.queues.create queue_name(queue)
        end

        def self.get(queue)
          client.queues.named(queue_name(queue))
        rescue ::AWS::SQS::Errors::NonExistentQueue
          false
        end

        def self.exists?(queue_name)
          if get(queue_name)
            yield
          end
        end

        def self.delete(queue_name)
          get(queue_name).delete
        end

        def self.queue_name(queue)
          /(?<name>[^\/]+)$/.match(queue)[:name]
        end

      end
    end
  end
end
