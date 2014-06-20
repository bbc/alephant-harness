require 'aws-sdk'
require 'yaml'

module Alephant
  module Harness
    module Service
      module S3

        def self.client
          @@client ||= ::AWS::S3.new
        end

        def self.create(id)
          client.buckets.create id
        end

        def self.delete(id)
          client.buckets[id].tap do |bucket|
            bucket.objects.each do |object|
              object.delete
            end
            bucket.delete
          end
        end

        def self.add_object(id, object_id, data)
          client.buckets[id]
                .objects[object_id]
                .write(data)
        end

        def self.get_object(id, object_id)
          client.buckets[id]
                .objects[object_id]
        end

        def self.delete_object(id, object_id)
          get_object(id, object_id).delete
        end

      end
    end
  end
end
