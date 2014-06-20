$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'pry'
require 'alephant/harness'
require 'alephant/harness/aws'
require 'alephant/harness/service/dynamo_db'
require 'alephant/harness/service/s3'
require 'aws-sdk'
