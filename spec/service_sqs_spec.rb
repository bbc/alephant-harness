require 'spec_helper'

describe Alephant::Harness::Service::SQS do
  let(:name) { 'queue' }

  describe ".create(name)" do
    it "creates a new queue" do
      queues = double('AWS::SQS::Queue')
      allow(queues).to receive(:create).with(name)
      expect_any_instance_of(AWS::SQS).to receive(:queues).and_return(buckets)
      subject.create id
    end
  end

end
