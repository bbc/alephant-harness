require "aws-sdk-s3"

module Alephant
  module Harness
    module Service
      module S3
        def self.create(id)
          client.create_bucket(bucket: id)
        end

        def self.delete(id)
          s3 = Aws::S3::Resource.new(client: client)
          s3.bucket(id).delete
        end

        def self.add_object(id, object_id, data)
          client.put_object(
            body: data,
            bucket: id,
            key: object_id
          )
        end

        def self.get_object(id, object_id)
          client.get_object(
            bucket: id,
            key: object_id
          )
        end

        def self.bucket_exists?(bucket_id)
          begin
            client.head_bucket(
              bucket: bucket_id
            )
            yield if block_given?
            true
          rescue => e
            false
          end
        end

        private

        def self.client
          @client ||= ::Aws::S3::Client.new(AWS.s3_config)
        end
      end
    end
  end
end
