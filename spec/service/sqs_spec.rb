require 'spec_helper'

describe Alephant::Harness::Service::SQS do

  let(:queue_name) { "queue" }
  let(:fake_client) { Aws::SQS::Client.new(stub_responses: true) }

  before do
    allow(subject).to receive(:client).and_return(fake_client)
  end

  describe ".create" do
    it "creates a Aws::SQS::Types::CreateQueueResult" do
      fake_client.stub_data(:create_queue)

      expect(subject.create(queue_name).data).to be_a(Aws::SQS::Types::CreateQueueResult)
    end
  end

  describe ".delete" do
    it "deletes a queue" do
      fake_client.stub_data(:get_queue_url, { queue_url: 'http://sqs.aws.myqueue/id' })
      fake_client.stub_data(:delete_queue)

      expect(subject.delete(queue_name).data).to be_a(Aws::EmptyStructure)
    end
  end

  describe ".exists?" do
    context "when queue exists" do
      it "yields control" do
        fake_client.stub_data(:get_queue_url, { queue_url: 'http://sqs.aws.myqueue/id' })

        expect { |b| subject.exists?(queue_name, &b) }.to yield_control
      end
    end

    context "when queue does not exist" do
      it "does not yield control" do
        fake_client.stub_responses(:get_queue_url, 'NonExistentQueue')

        expect { |b| subject.exists?(queue_name, &b) }.to_not yield_control
      end
    end
  end
end
