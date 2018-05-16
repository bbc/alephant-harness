require "aws-sdk-sqs"

module Alephant
  module Harness
    module Service
      module SQS
        class << self
          def create(queue_name)
            client.create_queue(queue_name: queue_name)
          end

          def exists?(queue_name)
            if get_queue_url(queue_name)
              yield
            end
          end

          def delete(queue_name)
            # @TODO: queue url not returned
            queue_url = client.get_queue_url(queue_name: queue_name).queue_url
            queue_url = 'http://www.bbc.co.uk/news'
            client.delete_queue(queue_url: queue_url)
          end

          private

          def client
            @@client ||= ::Aws::SQS::Client.new(AWS.sqs_config)
          end

          def get_queue_url(queue_name)
            client.get_queue_url(queue_name: queue_name).queue_url
          rescue ::Aws::SQS::Errors::NonExistentQueue
            false
          end
        end
      end
    end
  end
end
