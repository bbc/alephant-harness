require 'spec_helper'

describe Alephant::Harness::Tools::Helper::AddMessage do

  subject { Alephant::Harness::Tools::Helper::AddMessage.new }

  let(:base_path) { "#{Dir.pwd}/spec/fixtures" }
  let(:opts) {
    {
      options: {
        base: base_path
      },
      component: 'test'
    }
  }

  before(:each) do
    allow(Spurious::Ruby::Awssdk::Helper).to receive(:configure).once
  end

  describe '.run' do

    context 'when setting up AWS config' do
      let(:env_config) { YAML.load_file "#{base_path}/src/config/development/env.yaml" }

      before do
        allow(subject).to receive(:send_message).once
      end

      it 'reads AWS credentials from env.yml' do
        expect(AWS).to receive(:config).once.with(
          access_key_id: env_config['AWS_ACCESS_KEY_ID'],
          secret_access_key: env_config['AWS_SECRET_ACCESS_KEY']
        )
        subject.run opts
      end
    end

    context 'when setting up AWS queue' do
      let(:app_json) { JSON.parse File.read "#{base_path}/src/config/development/app.json" }

      before do
        allow(subject).to receive(:configure_aws).once
      end

      it 'reads queue name from app.json' do
        queue_double = double('AWS::SQS:Queue')
        qc_double    = double('AWS::SQS::QueueCollection', :named => queue_double)
        allow_any_instance_of(AWS::SQS).to receive(:queues).and_return(qc_double)
        allow(queue_double).to receive(:send_message).once

        expect(qc_double).to receive(:named).once.with(app_json['configuration']['sqs_queue_name'])
        subject.run opts
      end
    end

  end

end
