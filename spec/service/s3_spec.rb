require 'spec_helper'

describe Alephant::Harness::Service::S3 do
  let(:id) { 'my-bucket' }
  let(:fake_client) { Aws::S3::Client.new(stub_responses: true) }

  before do
    allow(subject).to receive(:client).and_return(fake_client)
  end

  describe ".create" do
    it "creates a bucket" do
      expect(subject.create(id).data).to be_a(Aws::S3::Types::CreateBucketOutput)
    end
  end

  describe ".delete(id)" do
    it "deletes a bucket" do
      expect(subject.delete(id)).to be_a(Aws::EmptyStructure)
    end
  end

  describe ".add_object(bucket_id, object_id, data)" do
    it "adds an object to the bucket" do
      object_id = 'foo/bar'
      data = 'Some data'

      expect(subject.add_object(id, object_id, data).data).to be_a(Aws::S3::Types::PutObjectOutput)
    end
  end

  describe ".get_object(bucket_id, object_id)" do
    it "gets an object from the specified bucket" do
      object_id = 'foo/bar'

      expect(subject.get_object(id, object_id).data).to be_a(Aws::S3::Types::GetObjectOutput)
    end
  end

  describe ".bucket_exists?" do
    context "when bucket exists" do
      context 'with block' do
        it 'should call block' do
          expect { |b| subject.bucket_exists?(id, &b) }.to yield_control
        end
      end

      context 'with no block' do
        it 'should return true' do
          fake_client.stub_data(:head_bucket, {})
          expect(subject.bucket_exists?(id)).to eq(true)
        end
      end
    end

    context "when bucket does not exist" do
      context 'with block' do
        it 'should not call block' do
          fake_client.stub_responses(:head_bucket, Aws::EmptyStructure)
          expect { |b| subject.bucket_exists?(id, &b) }.to_not yield_control
        end
      end

      context 'with no block' do
        it 'should return false' do
          fake_client.stub_responses(:head_bucket, Aws::EmptyStructure)
          expect(subject.bucket_exists?(id)).to eq(false)
        end
      end
    end
  end
end
