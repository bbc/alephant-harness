require 'aws-sdk'

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

        def self.bucket_exists?(bucket_id)
          begin
            exists = client.buckets[bucket_id].exists?
          rescue ::AWS::S3::Errors::NoSuchKey => e
            exists = false
          end

          exists.tap do |e|
            yield if e && block_given?
          end
        end

        def self.exists?(id, object_id)
          if get_object(id, object_id)
            yield
          end
        end

      end
    end
  end
end
