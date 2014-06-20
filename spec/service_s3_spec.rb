require 'spec_helper'

describe Alephant::Harness::Service::S3 do
  let(:id) { 'my-bucket' }
  let(:buckets) { double('AWS::S3::BucketCollection') }

  describe ".create" do
    it "creates a bucket" do
      allow(buckets).to receive(:create).with(id)
      expect_any_instance_of(AWS::S3).to receive(:buckets).and_return(buckets)
      subject.create id
    end
  end

  describe ".delete(id)" do
    it "deletes a bucket" do
      bucket = double('AWS::S3::Bucket', :delete => nil)
      s3_object = double('AWS::S3::S3Object', :delete => nil)

      allow(buckets).to receive(:[]).with(id).and_return(bucket)
      allow(bucket).to receive(:objects).and_return([s3_object])

      expect_any_instance_of(AWS::S3).to receive(:buckets).and_return(buckets)
      subject.delete id

    end
  end

  describe ".add_object(bucket_id, object_id, data)" do
    it "adds an object to the bucket" do
      object_id = 'foo/bar'
      data = { :some => 'data' }

      bucket = double('AWS::S3::Bucket')
      s3_object = double('AWS::S3::S3Object')
      s3_object_collection = double('AWS::S3::ObjectCollection')

      allow(buckets).to receive(:[]).with(id).and_return(bucket)
      allow(bucket).to receive(:objects).and_return(s3_object_collection)
      allow(s3_object_collection).to receive(:[]).with(object_id).and_return(s3_object)
      allow(s3_object).to receive(:write).with(data)

      expect_any_instance_of(AWS::S3).to receive(:buckets).and_return(buckets)
      subject.add_object(id, object_id, data)

    end

    describe ".get_object(bucket_id, object_id)" do
      it "gets an object from the specified bucket" do
        object_id = 'foo/bar'

        bucket = double('AWS::S3::Bucket')
        s3_object = double('AWS::S3::S3Object')
        s3_object_collection = double('AWS::S3::ObjectCollection')

        allow(buckets).to receive(:[]).with(id).and_return(bucket)
        allow(bucket).to receive(:objects).and_return(s3_object_collection)
        allow(s3_object_collection).to receive(:[]).with(object_id).and_return(s3_object)

        expect_any_instance_of(AWS::S3).to receive(:buckets).and_return(buckets)
        expect(subject.get_object(id, object_id)).to eq(s3_object)

      end
    end

    describe ".delete_object(bucket_id, object_id)" do
      it "deletes an object from the specified bucket" do
        object_id = 'foo/bar'

        bucket = double('AWS::S3::Bucket')
        s3_object = double('AWS::S3::S3Object')
        s3_object_collection = double('AWS::S3::ObjectCollection')

        allow(buckets).to receive(:[]).with(id).and_return(bucket)
        allow(bucket).to receive(:objects).and_return(s3_object_collection)
        allow(s3_object_collection).to receive(:[]).with(object_id).and_return(s3_object)
        allow(s3_object).to receive(:delete)

        expect_any_instance_of(AWS::S3).to receive(:buckets).and_return(buckets)
        subject.delete_object(id, object_id)

      end
    end




  end


end