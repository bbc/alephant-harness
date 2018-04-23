require 'spec_helper'

describe Alephant::Harness::AWS do
  describe '.environment' do
    it 'returns environment variables' do
      ENV['AWS_FOO'] = 'BAR'

      expect(subject.environment[:foo]).to eq('BAR')
    end

    it 'sanitises boolean values when false' do
      subject.config = {'AWS_USE_SSL' => 'false'}

      expect(subject.environment[:use_ssl]).to eq(false)
    end

    it 'sanitises boolean values when true' do
      subject.config = {'AWS_USE_SSL' => 'true'}

      expect(subject.environment[:use_ssl]).to eq(true)
    end

    it 'ignores keys not starting with AWS' do
      subject.config = {'CONFIG_KEY' => 'value'}

      expect(subject.environment).to_not have_key(:config_key)
      expect(subject.environment).to_not have_key(:aws_config_key)
      expect(subject.environment).to_not have_key(:AWS_CONFIG_KEY)
      expect(subject.environment).to_not have_key('AWS_CONFIG_KEY')
    end

    it 'kepps boolean values when true' do
      subject.config = {'AWS_USE_SSL' => true}

      expect(subject.environment[:use_ssl]).to eq(true)
    end

    it 'kepps boolean values when false' do
      subject.config = {'AWS_USE_SSL' => false}

      expect(subject.environment[:use_ssl]).to eq(false)
    end
  end

  describe '.config' do
    it 'sets config overriding environment variables' do
      subject.config = {'AWS_FOO': 'BAR2'}

      expect(subject.environment).to include(foo: 'BAR2')
    end

    it 'sets config overriding existing environment variables' do
      ENV['FOO'] = 'BAR3'
      subject.config = {'AWS_FOO': 'BAZ'}

      expect(subject.environment).to include(foo: 'BAZ')
    end
  end

  describe '.s3_config' do
    before do
      subject.config = {
        'AWS_S3_ENDPOINT'         => 'localhost',
        'AWS_S3_PORT'             => '4569',
        'AWS_SQS_ENDPOINT'        => 'localhost',
        'AWS_SQS_PORT'            => '4568',
        'AWS_DYNAMO_DB_ENDPOINT'  => 'localhost',
        'AWS_DYNAMO_DB_PORT'      => '4570',
        'AWS_USE_SSL'             => false,
        'AWS_S3_FORCE_PATH_STYLE' => true,
        'AWS_ACCESS_KEY_ID'       => 'access',
        'AWS_SECRET_ACCESS_KEY'   => 'secret',
        'AWS_REGION'              => 'eu-west-1'
      }
    end

    it 'should filter to necessary S3 keys' do
      expect(subject.s3_config.keys).to eq([:endpoint, :force_path_style, :access_key_id, :secret_access_key, :region])
    end
  end

  describe '.sqs_config' do
    before do
      subject.config = {
        'AWS_S3_ENDPOINT'         => 'localhost',
        'AWS_S3_PORT'             => '4569',
        'AWS_SQS_ENDPOINT'        => 'localhost',
        'AWS_SQS_PORT'            => '4568',
        'AWS_DYNAMO_DB_ENDPOINT'  => 'localhost',
        'AWS_DYNAMO_DB_PORT'      => '4570',
        'AWS_USE_SSL'             => false,
        'AWS_S3_FORCE_PATH_STYLE' => true,
        'AWS_ACCESS_KEY_ID'       => 'access',
        'AWS_SECRET_ACCESS_KEY'   => 'secret',
        'AWS_REGION'              => 'eu-west-1'
      }
    end

    it 'should filter to necessary SQS keys' do
      expect(subject.sqs_config.keys).to eq([:endpoint, :access_key_id, :secret_access_key, :region])
    end
  end

  describe '.dynamo_config' do
    before do
      subject.config = {
        'AWS_S3_ENDPOINT'         => 'localhost',
        'AWS_S3_PORT'             => '4569',
        'AWS_SQS_ENDPOINT'        => 'localhost',
        'AWS_SQS_PORT'            => '4568',
        'AWS_DYNAMO_DB_ENDPOINT'  => 'localhost',
        'AWS_DYNAMO_DB_PORT'      => '4570',
        'AWS_USE_SSL'             => false,
        'AWS_S3_FORCE_PATH_STYLE' => true,
        'AWS_ACCESS_KEY_ID'       => 'access',
        'AWS_SECRET_ACCESS_KEY'   => 'secret',
        'AWS_REGION'              => 'eu-west-1'
      }
    end

    it 'should filter to necessary DynamoDB keys' do
      expect(subject.dynamo_config.keys).to eq([:endpoint, :access_key_id, :secret_access_key, :region])
    end
  end
end
