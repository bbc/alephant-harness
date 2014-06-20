require 'spec_helper'

describe Alephant::Harness::AWS do

  describe ".configure" do

    it "Configures the AWS global config based on environment variables" do
      environment = {
        'AWS_S3_ENDPOINT'         => 'localhost',
        'AWS_S3_PORT'             => '4569',
        'AWS_SQS_ENDPOINT'        => 'localhost',
        'AWS_SQS_PORT'            => '4568',
        'AWS_DYNAMO_DB_ENDPOINT'  => 'localhost',
        'AWS_DYNAMO_DB_PORT'      => '4570',
        'AWS_USE_SSL'             => 'false',
        'AWS_S3_FORCE_PATH_STYLE' => 'true',
        'AWS_ACCESS_KEY_ID'       => 'access',
        'AWS_SECRET_ACCESS_KEY'   => 'secret'
      }

      Alephant::Harness::AWS.configure(environment)

      environment.each do |key, value|
        key = key[/AWS_(.*)/,1].downcase.to_sym
        config_value = AWS.config.send(key.to_sym)
        expect(config_value).to eq(value)
      end

    end

    it "Sanitises boolean values" do
      environment = {
        'AWS_USE_SSL'             => 'false',
        'AWS_S3_FORCE_PATH_STYLE' => 'true'
      }

      Alephant::Harness::AWS.configure(environment)

      expect(AWS.config.use_ssl).to be_falsy
      expect(AWS.config.s3_force_path_style).to be_truthy
    end

  end
end


